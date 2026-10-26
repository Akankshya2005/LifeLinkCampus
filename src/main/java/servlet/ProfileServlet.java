package servlet;




import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.UserService;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private final UserService userService = new UserService();

    // Load the logged-in user's profile
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Only logged-in users can access their profile
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        int userId = getSessionUserId(session);

        if (userId <= 0) {
            session.invalidate();
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        User user = userService.getUserById(userId);

        if (user == null) {
            session.invalidate();
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        request.setAttribute("profileUser", user);

        request.getRequestDispatcher("/profile.jsp")
                .forward(request, response);
    }

    // Save changes submitted from the profile form
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        int userId = getSessionUserId(session);

        if (userId <= 0) {
            session.invalidate();
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");

        String result = userService.updateProfile(
                userId,
                fullName,
                email
        );

        if ("Profile updated successfully!".equals(result)) {
            // Keep the displayed name synchronized with the database
            session.setAttribute("userName", fullName.trim());
        }

        // Use a redirect so refreshing the page does not resubmit the form

        response.sendRedirect(
                request.getContextPath()
                        + "/profile?message="
                        + java.net.URLEncoder.encode(
                        result,
                        java.nio.charset.StandardCharsets.UTF_8.name()
                )
        );

    }

    // Safely read the user ID from the existing login session
    private int getSessionUserId(HttpSession session) {
        Object value = session.getAttribute("userId");

        if (value instanceof Integer) {
            return (Integer) value;
        }

        return -1;
    }
}
