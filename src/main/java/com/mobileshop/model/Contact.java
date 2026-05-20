package com.mobileshop.model;

import java.sql.Timestamp;

/**
 * Contact model representing a contact form submission.
 */
public class Contact {
    private int contactId;
    private String name;
    private String email;
    private String subject;
    private String message;
    private String phone;
    private String address;
    private Timestamp createdAt;

    public Contact() {}

    public Contact(String name, String email, String subject, String message) {
        this.name = name;
        this.email = email;
        this.subject = subject;
        this.message = message;
    }

    public Contact(String name, String email, String subject, String message, String phone, String address) {
        this.name = name;
        this.email = email;
        this.subject = subject;
        this.message = message;
        this.phone = phone;
        this.address = address;
    }

    public int getContactId() { return contactId; }
    public void setContactId(int contactId) { this.contactId = contactId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    @Override
    public String toString() {
        return "Contact{contactId=" + contactId + ", name='" + name + "', email='" + email + "', subject='" + subject + "'}";
    }
}
