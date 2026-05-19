<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty category ? 'Add' : 'Edit'} Category - MobileAccessories Admin</title>
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
                        <li><a href="${pageContext.request.contextPath}/admin/categories" class="active">Categories</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/orders">Orders</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/users">Users</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/reports">Reports & Analytics</a></li>
                    </ul>
                </aside>

                <div class="admin-content">
                    <h1 class="mb-2">${empty category ? 'Add New Category' : 'Edit Category'}</h1>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <div class="card">
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/admin/categories" method="post">
                                <input type="hidden" name="action" value="${empty category ? 'add' : 'edit'}">
                                <c:if test="${not empty category}">
                                    <input type="hidden" name="id" value="${category.categoryId}">
                                </c:if>

                                <div class="form-group">
                                    <label class="form-label">Category Name *</label>
                                    <input type="text" name="name" class="form-control" value="${category.name}" required>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Description</label>
                                    <textarea name="description" class="form-control" rows="3">${category.description}</textarea>
                                </div>
                                <div class="d-flex gap-2 mt-2">
                                    <button type="submit" class="btn btn-primary">${empty category ? 'Add Category' : 'Update Category'}</button>
                                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-outline">Cancel</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="footer">
        <div class="container"><p>&copy; 2026 MobileAccessories Admin.</p></div>
    </footer>
    <script src="${pageContext.request.contextPath}/js/logout-confirm.js?v=4"></script>
</body>
</html>
