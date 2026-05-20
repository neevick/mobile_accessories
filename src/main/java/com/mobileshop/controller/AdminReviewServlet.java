package com.mobileshop.controller;

import com.mobileshop.model.Review;
import com.mobileshop.service.ReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Admin controller to list product reviews.
 */
@WebServlet(name = "AdminReviewServlet", urlPatterns = {"/admin/reviews"})
public class AdminReviewServlet extends HttpServlet {
    private final ReviewService reviewService = new ReviewService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            Integer reviewId = null;
            try {
                String idParam = request.getParameter("id");
                if (idParam != null) {
                    reviewId = Integer.parseInt(idParam);
                }
            } catch (NumberFormatException e) {
                // Keep reviewId null to trigger the invalid ID logic below
            }

            if (reviewId == null) {
                request.getSession().setAttribute("error", "Invalid review ID.");
                response.sendRedirect(request.getContextPath() + "/admin/reviews");
                return;
            }

            if (reviewService.deleteReview(reviewId)) {
                request.getSession().setAttribute("success", "Review deleted successfully.");
            } else {
                request.getSession().setAttribute("error", "Failed to delete review.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/reviews");
            return;
        }

        List<Review> reviews = reviewService.getAllReviews();
        request.setAttribute("reviews", reviews);
        request.getRequestDispatcher("/admin/reviews.jsp").forward(request, response);
    }
}
