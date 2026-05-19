package com.mobileshop.controller;

import com.mobileshop.model.User;
import com.mobileshop.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Profile controller - view and update user profile, change password.
 */
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "view";

        switch (action) {
            case "view":
                viewProfile(request, response);
                break;
            case "edit":
                editProfileForm(request, response);
                break;
            case "changePassword":
                request.getRequestDispatcher("/user/change-password.jsp").forward(request, response);
                break;
            default:
                viewProfile(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        String action = request.getParameter("action");
        if ("update".equals(action)) {
            updateProfile(request, response);
        } else if ("changePassword".equals(action)) {
            changePassword(request, response);
        } else {
            viewProfile(request, response);
        }
    }

    private void viewProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        try {
            int userId = (int) session.getAttribute("userId");
            User user = userService.getUserById(userId);
            if (user == null) {
                request.getSession().setAttribute("error", "User not found.");
                response.sendRedirect(request.getContextPath() + "/auth?action=login");
                return;
            }
            request.setAttribute("profileUser", user);
            request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error viewing profile: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error loading profile. Please try again.");
            response.sendRedirect(request.getContextPath() + "/");
        }
    }

    private void editProfileForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        try {
            int userId = (int) session.getAttribute("userId");
            User user = userService.getUserById(userId);
            if (user == null) {
                request.getSession().setAttribute("error", "User not found.");
                response.sendRedirect(request.getContextPath() + "/auth?action=login");
                return;
            }
            request.setAttribute("profileUser", user);
            request.getRequestDispatcher("/user/edit-profile.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error loading edit profile form: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error loading profile form. Please try again.");
            response.sendRedirect(request.getContextPath() + "/");
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        try {
            int userId = (int) session.getAttribute("userId");
            User user = userService.getUserById(userId);
            if (user == null) {
                request.getSession().setAttribute("error", "User not found.");
                response.sendRedirect(request.getContextPath() + "/auth?action=login");
                return;
            }

            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            if (email == null || email.trim().isEmpty() || fullName == null || fullName.trim().isEmpty() || phone == null || phone.trim().isEmpty()) {
                request.setAttribute("error", "Email, full name, and phone are required.");
                request.setAttribute("profileUser", user);
                request.getRequestDispatcher("/user/edit-profile.jsp").forward(request, response);
                return;
            }

            user.setEmail(email.trim());
            user.setFullName(fullName.trim());
            user.setPhone(phone.trim());
            user.setAddress(address != null ? address.trim() : "");

            if (userService.updateUser(user)) {
                session.setAttribute("userName", user.getFullName());
                session.setAttribute("user", user);
                request.getSession().setAttribute("success", "Profile updated successfully!");
                System.out.println("Profile updated successfully for user ID: " + userId);
                response.sendRedirect(request.getContextPath() + "/profile?action=view");
            } else {
                request.setAttribute("error", "Failed to update profile. Email or phone may already be in use.");
                request.setAttribute("profileUser", user);
                request.getRequestDispatcher("/user/edit-profile.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("Error updating profile: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error updating profile. Please try again.");
            response.sendRedirect(request.getContextPath() + "/profile?action=view");
        }
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        try {
            int userId = (int) session.getAttribute("userId");
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (currentPassword == null || currentPassword.trim().isEmpty() || newPassword == null || newPassword.trim().isEmpty() || confirmPassword == null || confirmPassword.trim().isEmpty()) {
                request.setAttribute("error", "All password fields are required.");
                request.getRequestDispatcher("/user/change-password.jsp").forward(request, response);
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "New passwords do not match.");
                request.getRequestDispatcher("/user/change-password.jsp").forward(request, response);
                return;
            }

            StringBuilder errorMsg = new StringBuilder();
            if (userService.updatePassword(userId, currentPassword, newPassword, errorMsg)) {
                request.getSession().setAttribute("success", "Password changed successfully!");
                System.out.println("Password changed successfully for user ID: " + userId);
                response.sendRedirect(request.getContextPath() + "/profile?action=view");
            } else {
                request.setAttribute("error", errorMsg.toString());
                request.getRequestDispatcher("/user/change-password.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("Error changing password: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error changing password. Please try again.");
            response.sendRedirect(request.getContextPath() + "/profile?action=view");
        }
    }
}
