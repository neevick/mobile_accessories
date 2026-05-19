package com.mobileshop.service;

import com.mobileshop.dao.CartDAO;
import com.mobileshop.dao.ProductDAO;
import com.mobileshop.model.OrderItem;
import com.mobileshop.model.Product;

import java.util.List;

/**
 * Service layer for Cart operations.
 */
public class CartService {

    private final CartDAO cartDAO;
    private final ProductDAO productDAO;

    public CartService() {
        this.cartDAO = new CartDAO();
        this.productDAO = new ProductDAO();
    }

    /**
     * Get all cart items for a user.
     */
    public List<OrderItem> getCartByUserId(int userId) {
        return cartDAO.getCartByUserId(userId);
    }

    /**
     * Add a product to the user's cart.
     */
    public boolean addToCart(int userId, int productId, int quantity) {
        Product product = productDAO.getProductById(productId);
        if (product == null || !"active".equals(product.getStatus())) {
            return false;
        }
        
        // Check if product already in cart
        if (cartDAO.cartItemExists(userId, productId)) {
            int currentQty = cartDAO.getCartQuantity(userId, productId);
            int newQty = currentQty + quantity;
            if (newQty > product.getStock()) {
                newQty = product.getStock();
            }
            return cartDAO.updateCartItem(userId, productId, newQty);
        } else {
            if (quantity > product.getStock()) {
                quantity = product.getStock();
            }
            return cartDAO.addToCart(userId, productId, quantity, product.getPrice());
        }
    }

    /**
     * Update quantity of a cart item.
     */
    public boolean updateCartItem(int userId, int productId, int quantity) {
        Product product = productDAO.getProductById(productId);
        if (product == null) {
            return false;
        }
        
        if (quantity <= 0) {
            return cartDAO.removeFromCart(userId, productId);
        }
        
        if (quantity > product.getStock()) {
            quantity = product.getStock();
        }
        
        return cartDAO.updateCartItem(userId, productId, quantity);
    }

    /**
     * Remove a product from the user's cart.
     */
    public boolean removeFromCart(int userId, int productId) {
        return cartDAO.removeFromCart(userId, productId);
    }

    /**
     * Clear all items from the user's cart.
     */
    public boolean clearCart(int userId) {
        return cartDAO.clearCart(userId);
    }

    /**
     * Check if a product is in the user's cart.
     */
    public boolean cartItemExists(int userId, int productId) {
        return cartDAO.cartItemExists(userId, productId);
    }

    /**
     * Get the quantity of a product in the user's cart.
     */
    public int getCartQuantity(int userId, int productId) {
        return cartDAO.getCartQuantity(userId, productId);
    }
}
