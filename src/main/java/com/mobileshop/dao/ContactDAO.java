package com.mobileshop.dao;

import com.mobileshop.model.Contact;
import com.mobileshop.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Contact entity.
 */
public class ContactDAO {

    public int createContact(Contact contact) {
        String sql = "INSERT INTO contacts (name, email, subject, message) VALUES (?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, contact.getName());
            ps.setString(2, contact.getEmail());
            ps.setString(3, contact.getSubject());
            ps.setString(4, contact.getMessage());
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error creating contact: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return -1;
    }

    public List<Contact> getAllContacts() {
        List<Contact> contacts = new ArrayList<>();
        String sql = "SELECT * FROM contacts ORDER BY created_at DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) contacts.add(mapResultSetToContact(rs));
        } catch (SQLException e) {
            System.err.println("Error getting all contacts: " + e.getMessage());
        } finally {
            DBUtil.closeAll(rs, ps, conn);
        }
        return contacts;
    }

    private Contact mapResultSetToContact(ResultSet rs) throws SQLException {
        Contact contact = new Contact();
        contact.setContactId(rs.getInt("contact_id"));
        contact.setName(rs.getString("name"));
        contact.setEmail(rs.getString("email"));
        contact.setSubject(rs.getString("subject"));
        contact.setMessage(rs.getString("message"));
        contact.setCreatedAt(rs.getTimestamp("created_at"));
        return contact;
    }
}
