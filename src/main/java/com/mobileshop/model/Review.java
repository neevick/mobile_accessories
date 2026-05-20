package com.mobileshop.model;

import java.sql.Timestamp;

/**
 * Review model representing a product review by a user.
 */
public class Review {
    private int reviewId;
    private int userId;
    private int productId;
    private int rating;
    private String comment;
    private Timestamp createdAt;
    // Joined fields
    private String userName;

    public Review() {}

    public Review(int userId, int productId, int rating, String comment) {
        this.userId = userId;
        this.productId = productId;
        this.rating = rating;
        this.comment = comment;
    }

    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    private String productName;
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    @Override
    public String toString() {
        return "Review{reviewId=" + reviewId + ", userId=" + userId + ", productId=" + productId + ", rating=" + rating + "}";
    }
}
