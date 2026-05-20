<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String currentURI = request.getRequestURI();
%>
<aside class="admin-sidebar">
    <div class="sidebar-header">Admin Panel</div>
    <ul class="sidebar-nav">
        <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="<%= currentURI.endsWith("/dashboard") || currentURI.endsWith("/dashboard.jsp") ? "active" : "" %>">Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/products" class="<%= currentURI.contains("/admin/product") ? "active" : "" %>">Products</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/categories" class="<%= currentURI.contains("/admin/categor") ? "active" : "" %>">Categories</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/orders" class="<%= currentURI.contains("/admin/order") ? "active" : "" %>">Orders</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/users" class="<%= currentURI.contains("/admin/user") ? "active" : "" %>">Users</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/contacts" class="<%= currentURI.contains("/admin/contact") ? "active" : "" %>">Contacts</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/reviews" class="<%= currentURI.contains("/admin/review") ? "active" : "" %>">Reviews</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/reports" class="<%= currentURI.contains("/admin/report") ? "active" : "" %>">Reports & Analytics</a></li>
    </ul>
</aside>
