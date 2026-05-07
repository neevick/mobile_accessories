package com.mobileshop.model;

import java.math.BigDecimal;

/**
 * OrderItem model representing a single item within an order.
 */
public class OrderItem {
    private int orderItemId;
    private int orderId;
    private int productId;
    private int quantity;
    private BigDecimal price;
    // Joined fields
    private String productName;
    private String productImage;

    public OrderItem() {}

    public OrderItem(int productId, int quantity, BigDecimal price) {
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
    }

    public int getOrderItemId() { return orderItemId; }
    public void setOrderItemId(int orderItemId) { this.orderItemId = orderItemId; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getProductImage() { return productImage; }
    public void setProductImage(String productImage) { this.productImage = productImage; }

    public BigDecimal getSubtotal() {
        return price.multiply(BigDecimal.valueOf(quantity));
    }

    @Override
    public String toString() {
        return "OrderItem{orderItemId=" + orderItemId + ", productId=" + productId + ", quantity=" + quantity + ", price=" + price + "}";
    }
}
