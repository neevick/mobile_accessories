package com.mobileshop.controller;

import com.mobileshop.model.Contact;
import com.mobileshop.service.ContactService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Admin controller to list contact submissions.
 */
@WebServlet(name = "AdminContactServlet", urlPatterns = {"/admin/contacts"})
public class AdminContactServlet extends HttpServlet {
    private final ContactService contactService = new ContactService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Contact> contacts = contactService.getAllContacts();
        request.setAttribute("contacts", contacts);
        request.getRequestDispatcher("/admin/contacts.jsp").forward(request, response);
    }
}
