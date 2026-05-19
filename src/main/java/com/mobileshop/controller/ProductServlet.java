package com.mobileshop.controller;

import com.mobileshop.model.Category;
import com.mobileshop.model.Product;
import com.mobileshop.model.Review;
import com.mobileshop.service.ProductService;
import com.mobileshop.service.ReviewService;
import com.mobileshop.util.ImageUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * User-facing Product controller - browse, search, view products.
 */
@WebServlet(name = "ProductServlet", urlPatterns = {"/products"})
public class ProductServlet extends HttpServlet {

    private final ProductService productService = new ProductService();
    private final ReviewService reviewService = new ReviewService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                listProducts(request, response);
                break;
            case "detail":
                showDetail(request, response);
                break;
            case "search":
                searchProducts(request, response);
                break;
            case "category":
                listByCategory(request, response);
                break;
            default:
                listProducts(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("review".equals(action)) {
            submitReview(request, response);
        } else {
            listProducts(request, response);
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        syncProductImages(request);
        List<Product> products = productService.getActiveProducts();
        List<Category> categories = productService.getActiveCategories();
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/user/products.jsp").forward(request, response);
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        syncProductImages(request);
        Integer id = parseInt(request.getParameter("id"));
        if (id == null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }
        Product product = productService.getProductById(id);
        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }
        List<Review> reviews = reviewService.getReviewsByProductId(id);
        double avgRating = reviewService.getAverageRating(id);

        request.setAttribute("product", product);
        request.setAttribute("reviews", reviews);
        request.setAttribute("avgRating", avgRating);
        request.getRequestDispatcher("/user/product-detail.jsp").forward(request, response);
    }

    private void searchProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        syncProductImages(request);
        String keyword = request.getParameter("keyword");
        List<Product> products = productService.searchProducts(keyword);
        List<Category> categories = productService.getActiveCategories();
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/user/products.jsp").forward(request, response);
    }

    private void listByCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        syncProductImages(request);
        Integer categoryId = parseInt(request.getParameter("id"));
        if (categoryId == null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }
        List<Product> products = productService.getProductsByCategory(categoryId);
        List<Category> categories = productService.getActiveCategories();
        Category currentCategory = productService.getCategoryById(categoryId);
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("currentCategory", currentCategory);
        request.getRequestDispatcher("/user/products.jsp").forward(request, response);
    }

    private void submitReview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int productId = Integer.parseInt(request.getParameter("productId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        StringBuilder errorMsg = new StringBuilder();
        Review review = reviewService.createReview(userId, productId, rating, comment, errorMsg);

        if (review != null) {
            request.getSession().setAttribute("success", "Review submitted successfully!");
        } else {
            request.getSession().setAttribute("error", errorMsg.toString());
        }
        response.sendRedirect(request.getContextPath() + "/products?action=detail&id=" + productId);
    }

    private Integer parseInt(String value) {
        try {
            return value == null ? null : Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private void syncProductImages(HttpServletRequest request) {
        String contextPath = request.getServletContext().getRealPath("/");
        ImageUtil.syncImagesToRuntime(contextPath);
        productService.syncProductImages(contextPath);
    }
}
