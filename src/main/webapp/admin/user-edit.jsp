<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Edit User - MobileAccessories Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
</head>
<body>

 <nav class="navbar">
        <div class="container">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">MobileAccessories</a>
            <ul class="navbar-nav">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/auth?action=logout" class="logout-link">Logout</a></li>
            </ul>
        </div>
    </nav>


<main class="main-content">
    <div class="container">
        <div class="admin-layout">

            <aside class="admin-sidebar">
                <div class="sidebar-header">Admin Panel</div>
                <ul class="sidebar-nav">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/products">Products</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/categories">Categories</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/orders">Orders</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/users" class="active">Users</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/reports">Reports & Analytics</a></li>
                </ul>
            </aside>
            
			<form action="${pageContext.request.contextPath}/admin/users" method="post">

			    <input type="hidden" name="action" value="edit">
			    <input type="hidden" name="id" value="${user.userId}">
			
			    <div class="form-group">
			        <label>Username *</label>
			        <input type="text" name="username" class="form-control" value="${user.username}" required>
			    </div>
			
			    <div class="form-group">
			        <label>Full Name</label>
			        <input type="text" name="fullName" class="form-control" value="${user.fullName}">
			    </div>
			
			    <div class="form-group">
			        <label>Email *</label>
			        <input type="email" name="email" class="form-control" value="${user.email}" required>
			    </div>
			
			    <div class="form-group">
			        <label>Phone</label>
			        <input type="text" name="phone" class="form-control" value="${user.phone}">
			    </div>
			
			    <div class="form-group">
			        <label>Role</label>
			        <select name="role" class="form-control">
			            <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>Admin</option>
			            <option value="user" ${user.role == 'user' ? 'selected' : ''}>User</option>
			        </select>
			    </div>
			
			    <div class="d-flex gap-1">
			        <button type="submit" class="btn btn-primary">Update User</button>
			        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Cancel</a>
			    </div>
			</form>

        </div>
    </div>
</main>

<footer class="footer">
    <div class="container">
        <p>&copy; 2026 MobileAccessories Admin.</p>
    </div>
</footer>

    <script src="${pageContext.request.contextPath}/js/logout-confirm.js?v=4"></script>
</body>
</html>
