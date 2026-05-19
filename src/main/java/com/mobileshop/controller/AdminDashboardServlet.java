package com.mobileshop.controller;

import com.mobileshop.model.Order;

import com.mobileshop.service.OrderService;
import com.mobileshop.service.ProductService;
import com.mobileshop.service.UserService;
import com.mobileshop.util.ImageUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Admin Dashboard controller.
 */
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

    private final ProductService productService = new ProductService();
    private final OrderService orderService = new OrderService();
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String contextPath = request.getServletContext().getRealPath("/");
        ImageUtil.syncImagesToRuntime(contextPath);
        productService.syncProductImages(contextPath);

        // Dashboard statistics
        int totalProducts = productService.countProducts();
        int totalOrders = orderService.countOrders();
        int todayOrders = orderService.countOrdersToday();
        int thisWeekOrders = orderService.countOrdersThisWeek();
        int totalUsers = userService.countUsers();
        int totalSales = orderService.countSales();
        int pendingOrders = orderService.countOrdersByStatus("pending");
        int confirmedOrders = orderService.countOrdersByStatus("confirmed");
        int shippedOrders = orderService.countOrdersByStatus("shipped");
        int deliveredOrders = orderService.countOrdersByStatus("delivered");
        int cancelledOrders = orderService.countOrdersByStatus("cancelled");
        java.math.BigDecimal revenue = orderService.getTotalRevenue();
        // Load all months so the chart always shows Jan to Dec.
        Map<String, java.math.BigDecimal> monthlyRevenue = orderService.getRevenueByPeriod("monthly", 12);
        Map<String, Integer> monthlyOrders = orderService.getOrderCountByPeriod("monthly", 12);
        Map<String, java.math.BigDecimal> latestDailyRevenue = orderService.getLatestDailyRevenue(7);
        Map<String, Integer> latestDailyOrders = orderService.getLatestDailyOrderCounts(7);
        Map<String, Integer> topProducts = orderService.getTopSellingProducts(5);
        List<Order> recentOrders = orderService.getAllOrders();
        if (recentOrders.size() > 5) recentOrders = recentOrders.subList(0, 5);

        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("todayOrders", todayOrders);
        request.setAttribute("thisWeekOrders", thisWeekOrders);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalSales", totalSales);
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("confirmedOrders", confirmedOrders);
        request.setAttribute("shippedOrders", shippedOrders);
        request.setAttribute("deliveredOrders", deliveredOrders);
        request.setAttribute("cancelledOrders", cancelledOrders);
        request.setAttribute("revenue", revenue);
        request.setAttribute("monthlyRevenue", monthlyRevenue);
        request.setAttribute("monthlyOrders", monthlyOrders);
        request.setAttribute("latestDailyRevenue", latestDailyRevenue);
        request.setAttribute("latestDailyOrders", latestDailyOrders);
        request.setAttribute("topProducts", topProducts);
        request.setAttribute("recentOrders", recentOrders);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
    
}
