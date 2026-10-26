package servlet;



import entity.Donor;
import service.DonorService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/donor")
public class DonorServlet extends HttpServlet {

    private final DonorService donorService = new DonorService();

    // Display the donor registration form or existing profile
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");

        Donor donor = donorService.getDonorByUserId(userId);

        request.setAttribute("donor", donor);

        if (donor != null) {
            request.setAttribute("formMode", "update");
        } else {
            request.setAttribute("formMode", "register");
        }

        request.getRequestDispatcher("/donor-profile.jsp")
                .forward(request, response);
    }

    // Process donor registration or profile updates
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

        Integer userId = (Integer) session.getAttribute("userId");

        String bloodGroup = request.getParameter("bloodGroup");
        String phone = request.getParameter("phone");
        String college = request.getParameter("college");
        String consent = request.getParameter("consentToContact");

        String action = request.getParameter("action");
        String message;

        if ("update".equals(action)) {

            String availability =
                    request.getParameter("availabilityStatus");

            message = donorService.updateDonor(
                    userId,
                    bloodGroup,
                    phone,
                    college,
                    availability,
                    consent
            );

        } else {

            message = donorService.registerDonor(
                    userId,
                    bloodGroup,
                    phone,
                    college,
                    consent
            );
        }

        if ("SUCCESS".equals(message)) {
            response.sendRedirect(
                    request.getContextPath() + "/donor?success=1"
            );
            return;
        }

        request.setAttribute("message", message);
        request.setAttribute("messageType", "error");

        Donor donor = donorService.getDonorByUserId(userId);

        request.setAttribute("donor", donor);
        request.setAttribute(
                "formMode",
                donor == null ? "register" : "update"
        );

        request.getRequestDispatcher("/donor-profile.jsp")
                .forward(request, response);
    }
}

