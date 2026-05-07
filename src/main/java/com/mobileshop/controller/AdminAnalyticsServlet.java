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
 * Admin analytics controller.
 */
public class AdminAnalyticsServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BigDecimal totalRevenue = orderService.getTotalRevenue();
        int totalSales = orderService.countSales();
        Map<String, BigDecimal> monthlyRevenue = orderService.getMonthlyRevenue(12);

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalSales", totalSales);
        request.setAttribute("monthlyRevenue", monthlyRevenue);

        request.getRequestDispatcher("/admin/analytics.jsp").forward(request, response);
    }
}
