package util;




import dao.UserDAO;
import entity.Role;
import entity.User;

public class UserDAOTest {

    public static void main(String[] args) {

        UserDAO userDAO = new UserDAO();

        // Create a sample user
        User user = new User();
        user.setFullName("Test Student");
        user.setEmail("teststudent@example.com");
        user.setPassword("temporary-test-password");
        user.setRole(Role.STUDENT);

        // Save the user
        boolean saved = userDAO.saveUser(user);

        if (saved) {
            System.out.println("User saved successfully!");

            // Retrieve the user
            User foundUser =
                    userDAO.findByEmail("teststudent@example.com");

            if (foundUser != null) {
                System.out.println("User retrieved successfully!");
                System.out.println("ID: " + foundUser.getUserId());
                System.out.println("Name: " + foundUser.getFullName());
                System.out.println("Email: " + foundUser.getEmail());
                System.out.println("Role: " + foundUser.getRole());
            }

        } else {
            System.out.println("Failed to save user.");
        }
    }
}

