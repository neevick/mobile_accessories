package com.mobileshop.controller;

import com.mobileshop.service.OrderService;
import com.mobileshop.service.ProductService;
import com.mobileshop.service.UserService;

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
    private final ProductService productService = new ProductService();
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String period = request.getParameter("period");
        if (!"weekly".equalsIgnoreCase(period)) {
            period = "monthly";
        }

        int totalProducts = productService.countProducts();
        int inactiveProducts = productService.countProductsByStatus("inactive");
        int totalUsers = userService.countUsers();
        int adminUsers = userService.countUsersByRole("admin");
        int customerUsers = userService.countUsersByRole("user");
        BigDecimal totalRevenue = orderService.getTotalRevenue();
        int totalOrders = orderService.countOrders();
        int totalSales = orderService.countSales();
        int pendingOrders = orderService.countOrdersByStatus("pending");
        int confirmedOrders = orderService.countOrdersByStatus("confirmed");
        int shippedOrders = orderService.countOrdersByStatus("shipped");
        int deliveredOrders = orderService.countOrdersByStatus("delivered");
        int cancelledOrders = orderService.countOrdersByStatus("cancelled");

        Map<String, BigDecimal> periodRevenue = orderService.getRevenueByPeriod(period, 12);
        Map<String, Integer> periodOrders = orderService.getOrderCountByPeriod(period, 12);
        Map<String, BigDecimal> latestDailyRevenue = orderService.getLatestDailyRevenue(7);
        Map<String, Integer> latestDailyOrders = orderService.getLatestDailyOrderCounts(7);
        Map<String, Integer> topProducts = orderService.getTopSellingProducts(10);
        Map<String, Integer> topOrderItems = orderService.getTopOrderItems(10);

        request.setAttribute("period", period);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("inactiveProducts", inactiveProducts);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("adminUsers", adminUsers);
        request.setAttribute("customerUsers", customerUsers);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalSales", totalSales);
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("confirmedOrders", confirmedOrders);
        request.setAttribute("shippedOrders", shippedOrders);
        request.setAttribute("deliveredOrders", deliveredOrders);
        request.setAttribute("cancelledOrders", cancelledOrders);
        request.setAttribute("periodRevenue", periodRevenue);
        request.setAttribute("periodOrders", periodOrders);
        request.setAttribute("latestDailyRevenue", latestDailyRevenue);
        request.setAttribute("latestDailyOrders", latestDailyOrders);
        request.setAttribute("topProducts", topProducts);
        request.setAttribute("topOrderItems", topOrderItems);

        request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
    }
}

