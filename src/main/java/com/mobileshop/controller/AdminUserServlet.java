package com.mobileshop.controller;

import com.mobileshop.model.User;
import com.mobileshop.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Admin User controller - manage users, approve registrations.
 */
public class AdminUserServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "delete":
                deleteUser(request, response);
                break;

            case "edit":
                showEditUserForm(request, response);
                break;

            default:
                listUsers(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        switch (action) {
            case "edit":
                editUser(request, response);
                break;

            case "delete":
                deleteUser(request, response);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    // List Users
    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> users = userService.getAllUsers();
        request.setAttribute("users", users);

        HttpSession session = request.getSession();
        User loggedUser = (User) session.getAttribute("loggedUser");

        if (loggedUser != null) {
            request.setAttribute("urole", loggedUser.getRole());
        }

        request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
    }

    // Show Edit Form
    private void showEditUserForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer id = parseInt(request.getParameter("id"));

        if (id == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        User user = userService.getUserById(id);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("/admin/user-edit.jsp").forward(request, response);
    }

    // Delete User
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        if (userService.deleteUser(id)) {
            request.getSession().setAttribute("success", "User deleted successfully!");
        } else {
            request.getSession().setAttribute("error", "Failed to delete user.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    // EDIT USER
    private void editUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer id = parseInt(request.getParameter("id"));

        if (id == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        User existingUser = userService.getUserById(id);

        if (existingUser == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        StringBuilder errorMsg = new StringBuilder();
        User updatedUser = extractUserFromRequest(request, errorMsg, existingUser);

        if (updatedUser != null && userService.updateUser(updatedUser)) {
            request.getSession().setAttribute("success", "User updated successfully!");
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } else {
            request.setAttribute("error", errorMsg.toString());
            request.setAttribute("user", existingUser);
            showEditUserForm(request, response);
        }
    }

    // HELPER METHODS
    private User extractUserFromRequest(HttpServletRequest request, StringBuilder errorMsg, User user) {

        String username = trim(request.getParameter("username"));
        String fullName = trim(request.getParameter("fullName"));
        String email = trim(request.getParameter("email"));
        String phone = trim(request.getParameter("phone"));
        String role = trim(request.getParameter("role"));

        if (username.isEmpty()) errorMsg.append("Username is required. ");
        if (email.isEmpty()) errorMsg.append("Email is required. ");

        if (errorMsg.length() > 0) return null;

        user.setUsername(username);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setRole(role);

        return user;
    }

    private Integer parseInt(String value) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return null;
        }
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}