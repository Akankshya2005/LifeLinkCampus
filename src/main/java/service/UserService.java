
package service;

import dao.UserDAO;
import entity.Role;
import entity.User;
import org.mindrot.jbcrypt.BCrypt;

public class UserService {

    private final UserDAO userDAO = new UserDAO();


    public String registerUser(
            String fullName,
            String email,
            String password,
            String confirmPassword) {

        // Validate full name
        if (fullName == null || fullName.trim().isEmpty()) {
            return "Full name is required.";
        }

        if (fullName.trim().length() > 100) {
            return "Full name must not exceed 100 characters.";
        }

        // Validate email
        if (email == null || email.trim().isEmpty()) {
            return "Email is required.";
        }

        String normalizedEmail = email.trim().toLowerCase();

        if (!normalizedEmail.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            return "Please enter a valid email address.";
        }

        if (normalizedEmail.length() > 150) {
            return "Email must not exceed 150 characters.";
        }

        // Validate password
        if (password == null || password.isEmpty()) {
            return "Password is required.";
        }

        // BCrypt has a 72-byte password limit
        if (password.getBytes().length > 72) {
            return "Password must not exceed 72 bytes.";
        }
        // Confirm passwords match
        if (confirmPassword == null
                || !password.equals(confirmPassword)) {
            return "Passwords do not match.";
        }

        // Check whether email already exists
        if (userDAO.findByEmail(normalizedEmail) != null) {
            return "An account with this email already exists.";
        }

        // Create user
        User user = new User();
        user.setFullName(fullName.trim());
        user.setEmail(normalizedEmail);

        // Hash password before saving
        String hashedPassword = BCrypt.hashpw(
                password,
                BCrypt.gensalt(12)
        );

        user.setPassword(hashedPassword);

        // Public registration always creates a STUDENT.
        // Admin-controlled roles will be implemented separately.
        user.setRole(Role.STUDENT);

        // Save user
        boolean saved = userDAO.saveUser(user);

        if (saved) {
            return "Registration successful!";
        }

        return "Registration failed. Please try again.";
    }



    public User authenticateUser(String email, String password) {

        // Validate input
        if (email == null || email.trim().isEmpty()
                || password == null || password.isEmpty()) {
            return null;
        }

        // Find user by email
        User user = userDAO.findByEmail(
                email.trim().toLowerCase()
        );

        // Reject unknown email
        if (user == null) {
            return null;
        }

        // Verify entered password against stored BCrypt hash
        boolean passwordMatches = BCrypt.checkpw(
                password,
                user.getPassword()
        );

        if (passwordMatches) {
            return user;
        }

        return null;
    }


    public User getUserById(int userId) {

        if (userId <= 0) {
            return null;
        }

        return userDAO.findById(userId);
    }


    public String updateProfile(
            int userId,
            String fullName,
            String email) {

        // Validate user ID
        if (userId <= 0) {
            return "Invalid user account.";
        }

        // Validate full name
        if (fullName == null || fullName.trim().isEmpty()) {
            return "Full name is required.";
        }

        String normalizedName = fullName.trim();

        if (normalizedName.length() > 100) {
            return "Full name must not exceed 100 characters.";
        }

        // Validate email
        if (email == null || email.trim().isEmpty()) {
            return "Email is required.";
        }

        String normalizedEmail = email.trim().toLowerCase();

        if (!normalizedEmail.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            return "Please enter a valid email address.";
        }

        if (normalizedEmail.length() > 150) {
            return "Email must not exceed 150 characters.";
        }

        // Find existing user
        User existingUser = userDAO.findById(userId);

        if (existingUser == null) {
            return "User account not found.";
        }

        // Check whether another account uses this email
        User emailOwner = userDAO.findByEmail(normalizedEmail);

        if (emailOwner != null
                && emailOwner.getUserId() != userId) {
            return "This email is already registered to another account.";
        }

        // Update only editable profile fields
        existingUser.setFullName(normalizedName);
        existingUser.setEmail(normalizedEmail);

        // Save changes to database
        boolean updated = userDAO.updateUser(existingUser);

        if (updated) {
            return "Profile updated successfully!";
        }

        return "Unable to update your profile. Please try again.";
    }
}
