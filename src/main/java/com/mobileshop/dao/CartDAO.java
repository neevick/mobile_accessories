package com.mobileshop.dao;

import com.mobileshop.model.OrderItem;
import com.mobileshop.util.DBUtil;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Cart entity.
 */
public class CartDAO {

    public List<OrderItem> getCartByUserId(int userId) {
        List<OrderItem> cartItems = new ArrayList<>();
        String sql = "SELECT c.*, p.name as product_name, p.image as product_image FROM carts c " +
                     "JOIN products p ON c.product_id = p.product_id WHERE c.user_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setProductName(rs.getString("product_name"));
                item.setProductImage(rs.getString("product_image"));
                cartItems.add(item);
            }
        } catch (SQLException e) {
            System.err.println("Error getting cart by user ID: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return cartItems;
    }

    public boolean addToCart(int userId, int productId, int quantity, BigDecimal price) {
        String sql = "INSERT INTO carts (user_id, product_id, quantity, price) VALUES (?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE quantity = quantity + ?, price = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);
            ps.setBigDecimal(4, price);
            ps.setInt(5, quantity);
            ps.setBigDecimal(6, price);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding to cart: " + e.getMessage());
        } finally {
            DBUtil.closeAll(null, ps, conn);
        }
        return false;
    }

    public boolean updateCartItem(int userId, int productId, int quantity) {
        String sql;
        if (quantity <= 0) {
            sql = "DELETE FROM carts WHERE user_id = ? AND product_id = ?";
        } else {
            sql = "UPDATE carts SET quantity = ? WHERE user_id = ? AND product_id = ?";
        }
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            if (quantity <= 0) {
                ps.setInt(1, userId);
                ps.setInt(2, productId);
            } else {
                ps.setInt(1, quantity);
                ps.setInt(2, userId);
                ps.setInt(3, productId);
            }
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating cart item: " + e.getMessage());
        } finally {
            DBUtil.closeAll(null, ps, conn);
        }
        return false;
    }

    public boolean removeFromCart(int userId, int productId) {
        String sql = "DELETE FROM carts WHERE user_id = ? AND product_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error removing from cart: " + e.getMessage());
        } finally {
            DBUtil.closeAll(null, ps, conn);
        }
        return false;
    }

    public boolean clearCart(int userId) {
        String sql = "DELETE FROM carts WHERE user_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error clearing cart: " + e.getMessage());
        } finally {
            DBUtil.closeAll(null, ps, conn);
        }
        return false;
    }

    public boolean cartItemExists(int userId, int productId) {
        String sql = "SELECT COUNT(*) FROM carts WHERE user_id = ? AND product_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (SQLException e) {
            System.err.println("Error checking cart item existence: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return false;
    }

    public int getCartQuantity(int userId, int productId) {
        String sql = "SELECT quantity FROM carts WHERE user_id = ? AND product_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("quantity");
        } catch (SQLException e) {
            System.err.println("Error getting cart quantity: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return 0;
    }
}
