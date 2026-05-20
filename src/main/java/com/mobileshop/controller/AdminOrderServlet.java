package com.mobileshop.controller;

import com.mobileshop.model.Order;
import com.mobileshop.model.OrderItem;
import com.mobileshop.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Admin Order controller - view and manage orders.
 */
@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/admin/orders"})
public class AdminOrderServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                listOrders(request, response);
                break;
            case "detail":
                showDetail(request, response);
                break;
            case "updateStatus":
                updateStatus(request, response);
                break;
            default:
                listOrders(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            updateStatus(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String statusFilter = request.getParameter("status");
        List<Order> orders;
        if (statusFilter != null && !statusFilter.isEmpty()) {
            List<Order> allOrders = orderService.getAllOrders();
            orders = new ArrayList<Order>();
            for (Order order : allOrders) {
                if (statusFilter.equals(order.getStatus())) {
                    orders.add(order);
                }
            }
        } else {
            orders = orderService.getAllOrders();
        }
        request.setAttribute("orders", orders);
        request.setAttribute("statusFilter", statusFilter);
        request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = parseInt(request.getParameter("id"));
        if (id == null) {
            request.getSession().setAttribute("error", "Invalid order ID.");
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }
        Order order = orderService.getOrderById(id);
        if (order == null) {
            request.getSession().setAttribute("error", "Order not found.");
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }
        List<OrderItem> items = orderService.getOrderItems(id);
        request.setAttribute("order", order);
        request.setAttribute("items", items);
        request.getRequestDispatcher("/admin/order-detail.jsp").forward(request, response);
    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer orderId = parseInt(request.getParameter("orderId"));
        if (orderId == null) {
            request.getSession().setAttribute("error", "Invalid order ID.");
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }
        String status = request.getParameter("status");
        if (orderService.updateOrderStatus(orderId, status)) {
            request.getSession().setAttribute("success", "Order status updated to: " + status);
        } else {
            request.getSession().setAttribute("error", "Failed to update order status.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + orderId);
    }

    private Integer parseInt(String value) {
        try {
            return value == null ? null : Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
