<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports & Analytics - Mobile Accessories Admin</title>
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
                        <li><a href="${pageContext.request.contextPath}/admin/reports" class="active">Reports & Analytics</a></li>
                    </ul>
                </aside>

                <div class="admin-content">
                    <div class="flex-between mb-2">
                        <h1>Reports & Analytics</h1>
                        <form action="${pageContext.request.contextPath}/admin/reports" method="get" class="d-flex gap-2">
                            <select name="period" class="form-control">
                                <option value="monthly" ${period == 'monthly' ? 'selected' : ''}>Monthly</option>
                                <option value="weekly" ${period == 'weekly' ? 'selected' : ''}>Weekly</option>
                            </select>
                            <button type="submit" class="btn btn-primary">Generate Report</button>
                        </form>
                    </div>

                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-info">
                                <div class="stat-value">Rs <fmt:formatNumber value="${totalRevenue}" pattern="0.00"/></div>
                                <div class="stat-label">Total Sales</div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-info">
                                <div class="stat-value">${totalOrders}</div>
                                <div class="stat-label">Number of Orders</div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-info">
                                <div class="stat-value">${totalUsers}</div>
                                <div class="stat-label">Number of Users</div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-info">
                                <div class="stat-value">${totalProducts}</div>
                                <div class="stat-label">Active Products</div>
                            </div>
                        </div>
                    </div>

                    <div class="stats-grid">
                        <div class="card">
                            <div class="card-body">
                                <h3>Product Report</h3>
                                <p>Active Products: ${totalProducts}</p>
                                <p>Inactive Products: ${inactiveProducts}</p>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <h3>User Report</h3>
                                <p>Customers: ${customerUsers}</p>
                                <p>Admins: ${adminUsers}</p>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <h3>Order Report</h3>
                                <p>Pending: ${pendingOrders}</p>
                                <p>Confirmed: ${confirmedOrders}</p>
                                <p>Shipped: ${shippedOrders}</p>
                                <p>Delivered: ${deliveredOrders}</p>
                                <p>Cancelled: ${cancelledOrders}</p>
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <h3>Latest 7 Days Order Analysis</h3>
                            <canvas id="weeklyAnalysisChart"></canvas>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <h3>${period == 'weekly' ? 'Weekly' : 'Monthly'} Sales & Orders</h3>
                            <canvas id="analyticsChart"></canvas>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <h3>Top Selling Products</h3>
                            <c:choose>
                                <c:when test="${not empty topProducts}">
                                    <div class="table-wrapper">
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
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted text-center">No sales data available.</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script>
        const weeklyLabels = [
            <c:forEach var="entry" items="${latestDailyOrders}" varStatus="st">
                "${entry.key}"<c:if test="${!st.last}">,</c:if>
            </c:forEach>
        ].reverse();

        const weeklyOrderData = [
            <c:forEach var="entry" items="${latestDailyOrders}" varStatus="st">
                ${entry.value}<c:if test="${!st.last}">,</c:if>
            </c:forEach>
        ].reverse();

        const weeklyRevenueMap = {
            <c:forEach var="entry" items="${latestDailyRevenue}" varStatus="st">
                "${entry.key}": ${entry.value}<c:if test="${!st.last}">,</c:if>
            </c:forEach>
        };

        const weeklyRevenueData = weeklyLabels.map((label) => weeklyRevenueMap[label] || 0);

        const labels = [
            <c:forEach var="entry" items="${periodRevenue}" varStatus="st">
                "${entry.key}"<c:if test="${!st.last}">,</c:if>
            </c:forEach>
        ].reverse();

        const revenueData = [
            <c:forEach var="entry" items="${periodRevenue}" varStatus="st">
                ${entry.value}<c:if test="${!st.last}">,</c:if>
            </c:forEach>
        ].reverse();

        const orderData = [
            <c:forEach var="entry" items="${periodOrders}" varStatus="st">
                ${entry.value}<c:if test="${!st.last}">,</c:if>
            </c:forEach>
        ].reverse();

        new Chart(document.getElementById('weeklyAnalysisChart'), {
            type: 'bar',
            data: {
                labels: weeklyLabels,
                datasets: [
                    {
                        label: 'Orders Created',
                        data: weeklyOrderData,
                        backgroundColor: '#2563eb',
                        borderColor: '#1d4ed8',
                        borderWidth: 1,
                        yAxisID: 'orderAxis'
                    },
                    {
                        label: 'Sales Revenue',
                        data: weeklyRevenueData,
                        type: 'line',
                        borderColor: '#059669',
                        backgroundColor: 'rgba(5, 150, 105, 0.14)',
                        borderWidth: 2,
                        tension: 0.25,
                        fill: true,
                        yAxisID: 'revenueAxis'
                    }
                ]
            },
            options: {
                responsive: true,
                scales: {
                    orderAxis: {
                        type: 'linear',
                        position: 'left',
                        beginAtZero: true
                    },
                    revenueAxis: {
                        type: 'linear',
                        position: 'right',
                        beginAtZero: true,
                        grid: {
                            drawOnChartArea: false
                        }
                    }
                }
            }
        });

        new Chart(document.getElementById('analyticsChart'), {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [
                    {
                        label: 'Revenue',
                        data: revenueData,
                        yAxisID: 'revenueAxis'
                    },
                    {
                        label: 'Orders',
                        data: orderData,
                        yAxisID: 'orderAxis'
                    }
                ]
            },
            options: {
                responsive: true,
                scales: {
                    revenueAxis: {
                        type: 'linear',
                        position: 'left',
                        beginAtZero: true
                    },
                    orderAxis: {
                        type: 'linear',
                        position: 'right',
                        beginAtZero: true,
                        grid: {
                            drawOnChartArea: false
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>
