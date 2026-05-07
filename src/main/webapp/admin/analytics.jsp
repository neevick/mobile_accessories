<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics - Mobile Accessories Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<nav class="navbar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand"><span class="brand-icon">&#9881;</span> Mobile Accessories</a>
        <ul class="navbar-nav">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/auth?action=logout">Logout</a></li>
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
                    <li><a href="${pageContext.request.contextPath}/admin/users">Users</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/reports">Reports</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/analytics" class="active">Analytics</a></li>
                </ul>
            </aside>

            <div class="admin-content">
                <h1>Analytics</h1>

                <div class="stats">
                    <div class="card">
                        <div class="card-body">
                            <h3>Total Revenue</h3>
                            <p>Rs ${totalRevenue}</p>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <h3>Number of Sales</h3>
                            <p>${totalSales}</p>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-body">
                        <h3>Monthly Revenue</h3>
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    const labels = [
        <c:forEach var="entry" items="${monthlyRevenue}" varStatus="st">
            "${entry.key}"<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    const data = [
        <c:forEach var="entry" items="${monthlyRevenue}" varStatus="st">
            ${entry.value}<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    new Chart(document.getElementById('revenueChart'), {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Revenue',
                data: data
            }]
        }
    });
</script>
</body>
</html>

