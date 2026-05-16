package com.mobileshop.dao;

import com.mobileshop.model.Order;
import com.mobileshop.model.OrderItem;
import com.mobileshop.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Data Access Object for Order and OrderItem entities.
 */
public class OrderDAO {

    /**
     * Creates a new order with its items in a transaction.
     * @param order the order to create
     * @param items the order items
     * @return the generated order ID, or -1 on failure
     */
    public int createOrder(Order order, List<OrderItem> items) {
        String orderSql = "INSERT INTO orders (user_id, total_amount, status, shipping_address, phone) VALUES (?, ?, ?, ?, ?)";
        String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        String stockSql = "UPDATE products SET stock = stock - ? WHERE product_id = ? AND stock >= ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);
            // Insert order
            ps = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getUserId());
            ps.setBigDecimal(2, order.getTotalAmount());
            ps.setString(3, order.getStatus());
            ps.setString(4, order.getShippingAddress());
            ps.setString(5, order.getPhone());
            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) { conn.rollback(); return -1; }
            rs = ps.getGeneratedKeys();
            if (!rs.next()) { conn.rollback(); return -1; }
            int orderId = rs.getInt(1);
            rs.close();
            ps.close();
            // Insert order items and update stock
            for (OrderItem item : items) {
                // Update stock
                ps = conn.prepareStatement(stockSql);
                ps.setInt(1, item.getQuantity());
                ps.setInt(2, item.getProductId());
                ps.setInt(3, item.getQuantity());
                int stockUpdated = ps.executeUpdate();
                if (stockUpdated == 0) { conn.rollback(); return -1; }
                ps.close();
                // Insert item
                ps = conn.prepareStatement(itemSql);
                ps.setInt(1, orderId);
                ps.setInt(2, item.getProductId());
                ps.setInt(3, item.getQuantity());
                ps.setBigDecimal(4, item.getPrice());
                ps.executeUpdate();
                ps.close();
            }
            conn.commit();
            return orderId;
        } catch (SQLException e) {
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) { System.err.println("Error rolling back: " + ex.getMessage()); }
            System.err.println("Error creating order: " + e.getMessage());
        } finally {
            try { if (conn != null) conn.setAutoCommit(true); } catch (SQLException e) { System.err.println("Error resetting autoCommit: " + e.getMessage()); }
            DBUtil.closeAll(rs, ps, conn);
        }
        return -1;
    }

    public Order getOrderById(int id) {
        String sql = "SELECT o.*, u.full_name AS user_name, u.email AS user_email FROM orders o LEFT JOIN users u ON o.user_id = u.user_id WHERE o.order_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) return mapResultSetToOrder(rs);
        } catch (SQLException e) {
            System.err.println("Error getting order by ID: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return null;
    }

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.full_name AS user_name, u.email AS user_email FROM orders o LEFT JOIN users u ON o.user_id = u.user_id WHERE o.user_id = ? ORDER BY o.order_date DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) orders.add(mapResultSetToOrder(rs));
        } catch (SQLException e) {
            System.err.println("Error getting orders by user: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return orders;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.full_name AS user_name, u.email AS user_email FROM orders o LEFT JOIN users u ON o.user_id = u.user_id ORDER BY o.order_date DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) orders.add(mapResultSetToOrder(rs));
        } catch (SQLException e) {
            System.err.println("Error getting all orders: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return orders;
    }

    public List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.*, p.name AS product_name, p.image AS product_image FROM order_items oi LEFT JOIN products p ON oi.product_id = p.product_id WHERE oi.order_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setProductName(rs.getString("product_name"));
                item.setProductImage(rs.getString("product_image"));
                items.add(item);
            }
        } catch (SQLException e) {
            System.err.println("Error getting order items: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return items;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating order status: " + e.getMessage());
        } finally {
            DBUtil.closeAll(null, ps, conn);
        }
        return false;
    }

    public int countOrders() {
        String sql = "SELECT COUNT(*) FROM orders";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("Error counting orders: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return 0;
    }

    public int countOrdersByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM orders WHERE status = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("Error counting orders by status: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return 0;
    }

    public int countOrdersToday() {
        String sql = "SELECT COUNT(*) FROM orders WHERE DATE(order_date) = CURDATE()";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("Error counting today's orders: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return 0;
    }

    public int countOrdersThisWeek() {
        String sql = "SELECT COUNT(*) FROM orders WHERE YEARWEEK(order_date, 1) = YEARWEEK(CURDATE(), 1)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("Error counting this week's orders: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return 0;
    }

    public java.math.BigDecimal getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) FROM orders WHERE status IN ('confirmed', 'shipped', 'delivered')";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (SQLException e) {
            System.err.println("Error getting total revenue: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return java.math.BigDecimal.ZERO;
    }

    /**
     * Counts orders considered "sales".
     */
    public int countSales() {
        String sql = "SELECT COUNT(*) FROM orders WHERE status IN ('confirmed', 'shipped', 'delivered')";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("Error counting sales: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return 0;
    }

    /**
     * Monthly revenue for delivered/confirmed/shipped orders.
     * Key is formatted as YYYY-MM.
     */
    public Map<String, java.math.BigDecimal> getMonthlyRevenue(int limitMonths) {
        Map<String, java.math.BigDecimal> out = new LinkedHashMap<>();
        String sql =
                "SELECT DATE_FORMAT(order_date, '%Y-%m') AS ym, COALESCE(SUM(total_amount),0) AS revenue " +
                "FROM orders " +
                "WHERE status IN ('confirmed','shipped','delivered') " +
                "GROUP BY ym " +
                "ORDER BY ym DESC " +
                "LIMIT ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, Math.max(1, limitMonths));
            rs = ps.executeQuery();
            while (rs.next()) {
                out.put(rs.getString("ym"), rs.getBigDecimal("revenue"));
            }
        } catch (SQLException e) {
            System.err.println("Error getting monthly revenue: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return out;
    }

    public Map<String, java.math.BigDecimal> getRevenueByPeriod(String period, int limit) {
        Map<String, java.math.BigDecimal> out = new LinkedHashMap<>();
        boolean weekly = "weekly".equalsIgnoreCase(period);
        String labelExpression = weekly ? "DATE_FORMAT(order_date, '%x-W%v')" : "DATE_FORMAT(order_date, '%Y-%m')";
        String sql =
                "SELECT " + labelExpression + " AS period_label, COALESCE(SUM(total_amount),0) AS revenue " +
                "FROM orders " +
                "WHERE status IN ('confirmed','shipped','delivered') " +
                "GROUP BY period_label " +
                "ORDER BY period_label DESC " +
                "LIMIT ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, Math.max(1, limit));
            rs = ps.executeQuery();
            while (rs.next()) {
                out.put(rs.getString("period_label"), rs.getBigDecimal("revenue"));
            }
        } catch (SQLException e) {
            System.err.println("Error getting revenue by period: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return out;
    }

    public Map<String, Integer> getOrderCountByPeriod(String period, int limit) {
        Map<String, Integer> out = new LinkedHashMap<>();
        boolean weekly = "weekly".equalsIgnoreCase(period);
        String labelExpression = weekly ? "DATE_FORMAT(order_date, '%x-W%v')" : "DATE_FORMAT(order_date, '%Y-%m')";
        String sql =
                "SELECT " + labelExpression + " AS period_label, COUNT(*) AS order_count " +
                "FROM orders " +
                "WHERE status IN ('confirmed','shipped','delivered') " +
                "GROUP BY period_label " +
                "ORDER BY period_label DESC " +
                "LIMIT ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, Math.max(1, limit));
            rs = ps.executeQuery();
            while (rs.next()) {
                out.put(rs.getString("period_label"), rs.getInt("order_count"));
            }
        } catch (SQLException e) {
            System.err.println("Error getting orders by period: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return out;
    }

    public Map<String, Integer> getLatestDailyOrderCounts(int days) {
        Map<String, Integer> out = new LinkedHashMap<>();
        String sql =
                "SELECT DATE(order_date) AS order_day, COUNT(*) AS order_count " +
                "FROM orders " +
                "WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL ? DAY) " +
                "GROUP BY DATE(order_date) " +
                "ORDER BY order_day DESC";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, Math.max(0, days - 1));
            rs = ps.executeQuery();
            while (rs.next()) {
                out.put(rs.getString("order_day"), rs.getInt("order_count"));
            }
        } catch (SQLException e) {
            System.err.println("Error getting latest daily order counts: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return out;
    }

    public Map<String, java.math.BigDecimal> getLatestDailyRevenue(int days) {
        Map<String, java.math.BigDecimal> out = new LinkedHashMap<>();
        String sql =
                "SELECT DATE(order_date) AS order_day, COALESCE(SUM(total_amount),0) AS revenue " +
                "FROM orders " +
                "WHERE status IN ('confirmed','shipped','delivered') " +
                "AND order_date >= DATE_SUB(CURDATE(), INTERVAL ? DAY) " +
                "GROUP BY DATE(order_date) " +
                "ORDER BY order_day DESC";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, Math.max(0, days - 1));
            rs = ps.executeQuery();
            while (rs.next()) {
                out.put(rs.getString("order_day"), rs.getBigDecimal("revenue"));
            }
        } catch (SQLException e) {
            System.err.println("Error getting latest daily revenue: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return out;
    }

    /**
     * Top-selling products by quantity, limited.
     */
    public Map<String, Integer> getTopSellingProducts(int limit) {
        Map<String, Integer> out = new LinkedHashMap<>();
        String sql =
                "SELECT p.name AS product_name, COALESCE(SUM(oi.quantity),0) AS qty " +
                "FROM order_items oi " +
                "JOIN orders o ON o.order_id = oi.order_id " +
                "JOIN products p ON p.product_id = oi.product_id " +
                "WHERE o.status IN ('confirmed','shipped','delivered') " +
                "GROUP BY p.product_id, p.name " +
                "ORDER BY qty DESC " +
                "LIMIT ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, Math.max(1, limit));
            rs = ps.executeQuery();
            while (rs.next()) {
                out.put(rs.getString("product_name"), rs.getInt("qty"));
            }
        } catch (SQLException e) {
            System.err.println("Error getting top selling products: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return out;
    }

    /**
     * Top order items (product -> qty sold), limited.
     * Kept separate from top products to match assignment wording.
     */
    public Map<String, Integer> getTopOrderItems(int limit) {
        return getTopSellingProducts(limit);
    }

    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setUserId(rs.getInt("user_id"));
        order.setTotalAmount(rs.getBigDecimal("total_amount"));
        order.setStatus(rs.getString("status"));
        order.setShippingAddress(rs.getString("shipping_address"));
        order.setPhone(rs.getString("phone"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setUpdatedAt(rs.getTimestamp("updated_at"));
        try {
            order.setUserName(rs.getString("user_name"));
            order.setUserEmail(rs.getString("user_email"));
        } catch (SQLException ignored) {}
        return order;
    }
}
