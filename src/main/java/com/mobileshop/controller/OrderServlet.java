package com.mobileshop.controller;

import com.mobileshop.model.Order;
import com.mobileshop.model.OrderItem;
import com.mobileshop.model.Product;
import com.mobileshop.model.User;
import com.mobileshop.service.CartService;
import com.mobileshop.service.OrderService;
import com.mobileshop.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

/**
 * User-facing Order controller - place orders, view order history.
 * Uses database to store cart items.
 */
@WebServlet(name = "OrderServlet", urlPatterns = {"/orders"})
public class OrderServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();
    private final ProductService productService = new ProductService();
    private final CartService cartService = new CartService();

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "history";

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        switch (action) {
            case "cart":
                showCart(request, response);
                break;
            case "addToCart":
                addToCart(request, response);
                break;
            case "removeFromCart":
                removeFromCart(request, response);
                break;
            case "updateCart":
                updateCart(request, response);
                break;
            case "checkout":
                showCheckout(request, response);
                break;
            case "history":
                orderHistory(request, response, userId);
                break;
            case "detail":
                orderDetail(request, response);
                break;
            default:
                orderHistory(request, response, userId);
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        if ("placeOrder".equals(action)) {
            placeOrder(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/orders?action=cart");
        }
    }

    private void showCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        List<OrderItem> cart = cartService.getCartByUserId(userId);

        BigDecimal total = BigDecimal.ZERO;
        for (OrderItem item : cart) {
            total = total.add(item.getSubtotal());
        }

        request.setAttribute("cart", cart);
        request.setAttribute("cartTotal", total);
        request.getRequestDispatcher("/user/cart.jsp").forward(request, response);
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = 1;
        try { quantity = Integer.parseInt(request.getParameter("quantity")); } catch (NumberFormatException e) { quantity = 1; }
        if (quantity < 1) quantity = 1;

        Product product = productService.getProductById(productId);
        if (product == null || !"active".equals(product.getStatus())) {
            request.getSession().setAttribute("error", "Product not available.");
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }
        if (product.getStock() < quantity) {
            request.getSession().setAttribute("error", "Not enough stock available.");
            response.sendRedirect(request.getContextPath() + "/products?action=detail&id=" + productId);
            return;
        }

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        
        boolean added = cartService.addToCart(userId, productId, quantity);
        if (added) {
            session.setAttribute("success", "Product added to cart!");
        } else {
            session.setAttribute("error", "Failed to add product to cart.");
        }
        response.sendRedirect(request.getContextPath() + "/products?action=detail&id=" + productId);
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        
        cartService.removeFromCart(userId, productId);
        response.sendRedirect(request.getContextPath() + "/orders?action=cart");
    }

    private void updateCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        
        cartService.updateCartItem(userId, productId, quantity);
        response.sendRedirect(request.getContextPath() + "/orders?action=cart");
    }

    private void showCheckout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        List<OrderItem> cart = cartService.getCartByUserId(userId);
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("error", "Your cart is empty.");
            showCart(request, response);
            return;
        }

        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);
        request.setAttribute("cart", cart);
        request.getRequestDispatcher("/user/checkout.jsp").forward(request, response);
    }

    private void placeOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        List<OrderItem> cart = cartService.getCartByUserId(userId);

        if (cart == null || cart.isEmpty()) {
            session.setAttribute("error", "Your cart is empty.");
            response.sendRedirect(request.getContextPath() + "/orders?action=cart");
            return;
        }

        String shippingAddress = request.getParameter("shippingAddress");
        String phone = request.getParameter("phone");

        StringBuilder errorMsg = new StringBuilder();
        int orderId = orderService.placeOrder(userId, shippingAddress, phone, cart, errorMsg);

        if (orderId > 0) {
            cartService.clearCart(userId);
            session.setAttribute("success", "Order placed successfully! Order ID: " + orderId);
            response.sendRedirect(request.getContextPath() + "/orders?action=detail&id=" + orderId);
        } else {
            session.setAttribute("error", errorMsg.toString());
            response.sendRedirect(request.getContextPath() + "/orders?action=checkout");
        }
    }

    private void orderHistory(HttpServletRequest request, HttpServletResponse response, int userId) throws ServletException, IOException {
        List<Order> orders = orderService.getOrdersByUserId(userId);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/user/order-history.jsp").forward(request, response);
    }

    private void orderDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Order order = orderService.getOrderById(id);
        if (order == null) {
            response.sendRedirect(request.getContextPath() + "/orders?action=history");
            return;
        }
        List<OrderItem> items = orderService.getOrderItems(id);
        request.setAttribute("order", order);
        request.setAttribute("items", items);
        request.getRequestDispatcher("/user/order-detail.jsp").forward(request, response);
    }
}
