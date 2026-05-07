package com.mobileshop.controller;

import com.mobileshop.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;

/**
 * Admin reports controller.
 */
public class AdminReportServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BigDecimal totalRevenue = orderService.getTotalRevenue();
        int totalOrders = orderService.countOrders();
        int totalSales = orderService.countSales();

        Map<String, BigDecimal> monthlyRevenue = orderService.getMonthlyRevenue(12);
        Map<String, Integer> topProducts = orderService.getTopSellingProducts(10);
        Map<String, Integer> topOrderItems = orderService.getTopOrderItems(10);

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalSales", totalSales);
        request.setAttribute("monthlyRevenue", monthlyRevenue);
        request.setAttribute("topProducts", topProducts);
        request.setAttribute("topOrderItems", topOrderItems);

        request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
    }
}

