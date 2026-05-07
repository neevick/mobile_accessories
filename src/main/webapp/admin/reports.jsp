<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Reports - Mobile Accessories Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
	<nav class="navbar">
        <div class="container">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand"><span class="brand-icon"></span> Mobile Accessories</a>
            <ul class="navbar-nav">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/products">Products</a></li>
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
                        <li><a href="${pageContext.request.contextPath}/admin/reports" class="active">Reports</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/analytics">Analytics</a></li>
                    </ul>
                </aside>
                <div class="admin-content">

					    <h1>Analytics & Reports</h1>
					
					    <!-- Summary Cards -->
					    <div class="stats">
					        <div class="card">
					            <div class="card-body">
					                <h3>Total Revenue</h3>
					                <p>Rs ${totalRevenue}</p>
					            </div>
					        </div>
					
					        <div class="card">
					            <div class="card-body">
					                <h3>Total Orders</h3>
					                <p>${totalOrders}</p>
					            </div>
					        </div>
					    </div>
					
					    <!-- Chart -->
					    <div class="card">
					        <div class="card-body">
					            <h3>Monthly Revenue</h3>
					            <canvas id="revenueChart"></canvas>
					        </div>
					    </div>
					
					    <!-- Top Products -->
					    <div class="card">
					        <div class="card-body">
					            <h3>Top Selling Products</h3>
					
					            <table>
					                <thead>
					                    <tr>
					                        <th>Product</th>
					                        <th>Sold</th>
					                    </tr>
					                </thead>
					                <tbody>
					                    <c:forEach var="p" items="${topProducts}">
					                        <tr>
					                            <td>${p.key}</td>
					                            <td>${p.value}</td>
					                        </tr>
					                    </c:forEach>
					                </tbody>
					            </table>
					
					        </div>
					    </div>
					
					</div>
					<script>
						    const labels = [
						        <c:forEach var="entry" items="${monthlyRevenue}">
						            "${entry.key}",
						        </c:forEach>
						    ];
						
						    const data = [
						        <c:forEach var="entry" items="${monthlyRevenue}">
						            ${entry.value},
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
