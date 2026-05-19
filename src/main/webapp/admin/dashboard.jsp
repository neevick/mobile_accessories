<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - MobileAccessories</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=6">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>
<body>
    <jsp:include page="/WEB-INF/includes/navbar.jsp">
        <jsp:param name="type" value="admin"/>
    </jsp:include>


    <main class="main-content">
        <div class="container">
            <div class="admin-layout">
                <!-- Sidebar -->
                <aside class="admin-sidebar">
                    <div class="sidebar-header">Admin Panel</div>
                    <ul class="sidebar-nav">
                        <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/products">Products</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/categories">Categories</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/orders">Orders</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/users">Users</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/reports">Reports & Analytics</a></li>
                    </ul>
                </aside>

                <!-- Content -->
                <div class="admin-content">
                    <h1 class="mb-2">Dashboard</h1>

                    <c:if test="${not empty sessionScope.success}">
                        <div class="alert alert-success">${sessionScope.success}</div>
                        <c:set var="success" value="" scope="session" />
                    </c:if>

                    <!-- Stats -->
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-info">
                                <div class="stat-value">${todayOrders}</div>
                                <div class="stat-label">Today Orders</div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-info">
                                <div class="stat-value">${thisWeekOrders}</div>
                                <div class="stat-label">This Week Order</div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-info">
                                <div class="stat-value">${totalOrders}</div>
                                <div class="stat-label">Total Order</div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-info">
                                <div class="stat-value">Rs. <fmt:formatNumber value="${revenue}" pattern="#,##0"/></div>
                                <div class="stat-label">Sale Revenue</div>
                            </div>
                        </div>
                    </div>

                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-info">
                                <div class="stat-value">${totalProducts}</div>
                                <div class="stat-label">Total Products</div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-info">
                                <div class="stat-value">${totalUsers}</div>
                                <div class="stat-label">Total Users</div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-info">
                                <div class="stat-value">${totalSales}</div>
                                <div class="stat-label">Completed Sales</div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-info">
                                <div class="stat-value">${pendingOrders}</div>
                                <div class="stat-label">Pending Orders</div>
                            </div>
                        </div>
                    </div>

                    <!-- Pending Orders Alert -->
                    <c:if test="${pendingOrders > 0}">
                        <div class="alert alert-warning">
                            You have <strong>${pendingOrders}</strong> pending order(s) to process.
                            <a href="${pageContext.request.contextPath}/admin/orders?status=pending">View Orders</a>
                        </div>
                    </c:if>

                    <div class="dashboard-chart-grid">
                        <div class="card analytics-section">
                            <div class="card-header">
                                <h3>Latest 7 Days Analysis</h3>
                                <a href="${pageContext.request.contextPath}/admin/reports?period=weekly" class="btn btn-sm btn-outline">Report</a>
                            </div>
                            <div class="card-body">
                                <div class="chart-area">
                                    <canvas id="activityChart"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="card analytics-section">
                            <div class="card-header">
                                <h3>Monthly Sales & Orders</h3>
                                <a href="${pageContext.request.contextPath}/admin/reports?period=monthly" class="btn btn-sm btn-outline">Full Report</a>
                            </div>
                            <div class="card-body">
                                <div class="chart-area">
                                    <canvas id="dashboardRevenueChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card analytics-section">
                        <div class="card-header">
                            <h3>Order Status</h3>
                            <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-sm btn-outline">Manage</a>
                        </div>
                        <div class="card-body">
                            <div class="chart-area chart-area-sm">
                                <canvas id="orderStatusChart"></canvas>
                            </div>
                        </div>
                    </div>

                    <div class="card analytics-section">
                        <div class="card-header">
                            <h3>Top Selling Products</h3>
                            <a href="${pageContext.request.contextPath}/admin/reports" class="btn btn-sm btn-outline">Analyze</a>
                        </div>
                        <div class="card-body">
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
                                                <c:forEach var="product" items="${topProducts}">
                                                    <tr>
                                                        <td>${product.key}</td>
                                                        <td>${product.value}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted text-center">No sales data yet.</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <!-- Recent Orders -->
                    <div class="card">
                        <div class="card-header">
                            <h3>Recent Orders</h3>
                            <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-sm btn-outline">View All</a>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${not empty recentOrders}">
                                    <div class="table-wrapper">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>Order ID</th>
                                                    <th>Customer</th>
                                                    <th>Amount</th>
                                                    <th>Status</th>
                                                    <th>Date</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="order" items="${recentOrders}">
                                                    <tr>
                                                        <td>#${order.orderId}</td>
                                                        <td>${order.userName}</td>
                                                        <td>Rs. <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/></td>
                                                        <td><span class="badge badge-${order.status == 'pending' ? 'warning' : order.status == 'confirmed' ? 'success' : order.status == 'delivered' ? 'success' : order.status == 'cancelled' ? 'danger' : 'info'}">${order.status}</span></td>
                                                        <td>${order.orderDate}</td>
                                                        <td><a href="${pageContext.request.contextPath}/admin/orders?action=detail&id=${order.orderId}" class="btn btn-sm btn-outline">View</a></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted text-center">No orders yet.</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2026 MobileAccessories Admin. All rights reserved.</p>
        </div>
    </footer>
    <script>
        const latestDailyLabels = [
            <c:forEach var="entry" items="${latestDailyOrders}" varStatus="st">
                "${entry.key}"<c:if test="${!st.last}">,</c:if>
            </c:forEach>
        ].reverse();

        const latestDailyOrderData = [
            <c:forEach var="entry" items="${latestDailyOrders}" varStatus="st">
                ${entry.value}<c:if test="${!st.last}">,</c:if>
            </c:forEach>
        ].reverse();

        const latestDailyRevenueMap = {
            <c:forEach var="entry" items="${latestDailyRevenue}" varStatus="st">
                "${entry.key}": ${entry.value}<c:if test="${!st.last}">,</c:if>
            </c:forEach>
        };

        const latestDailyRevenueData = latestDailyLabels.map((label) => latestDailyRevenueMap[label] || 0);

        const monthlyLabels = [
            <c:forEach var="entry" items="${monthlyRevenue}" varStatus="st">
                "${entry.key}"<c:if test="${!st.last}">,</c:if>
            </c:forEach>
        ].reverse();

        const monthlyRevenueData = [
            <c:forEach var="entry" items="${monthlyRevenue}" varStatus="st">
                ${entry.value}<c:if test="${!st.last}">,</c:if>
            </c:forEach>
        ].reverse();

        const monthlyOrderData = [
            <c:forEach var="entry" items="${monthlyOrders}" varStatus="st">
                ${entry.value}<c:if test="${!st.last}">,</c:if>
            </c:forEach>
        ].reverse();

        const weekdayLabels = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
        const toWeekdayTotals = (dateLabels, values) => {
            const totals = [0, 0, 0, 0, 0, 0, 0];
            dateLabels.forEach((label, index) => {
                const parsedDate = new Date(label + 'T00:00:00');
                if (!Number.isNaN(parsedDate.getTime())) {
                    totals[parsedDate.getDay()] += Number(values[index]) || 0;
                }
            });
            return totals;
        };
        const weeklyOrderTotals = toWeekdayTotals(latestDailyLabels, latestDailyOrderData);
        const weeklyRevenueTotals = toWeekdayTotals(latestDailyLabels, latestDailyRevenueData);

        const commonChartOptions = {
            responsive: true,
            maintainAspectRatio: false,
            interaction: {
                mode: 'index',
                intersect: false
            },
            plugins: {
                legend: {
                    position: 'top'
                }
            }
        };

        const orderAxisOptions = {
            type: 'linear',
            position: 'left',
            beginAtZero: true,
            title: {
                display: true,
                text: 'Orders'
            },
            ticks: {
                precision: 0,
                stepSize: 1
            }
        };

        const revenueAxisOptions = {
            type: 'linear',
            position: 'right',
            beginAtZero: true,
            title: {
                display: true,
                text: 'Sale Revenue'
            },
            ticks: {
                callback: (value) => 'Rs ' + value
            },
            grid: {
                drawOnChartArea: false
            }
        };

        new Chart(document.getElementById('activityChart'), {
            type: 'bar',
            data: {
                labels: weekdayLabels,
                datasets: [
                    {
                        label: 'Orders',
                        data: weeklyOrderTotals,
                        backgroundColor: '#2563eb',
                        borderColor: '#1d4ed8',
                        borderWidth: 1,
                        maxBarThickness: 36,
                        barPercentage: 0.55,
                        categoryPercentage: 0.6,
                        yAxisID: 'orderAxis'
                    },
                    {
                        label: 'Sale Revenue',
                        data: weeklyRevenueTotals,
                        backgroundColor: 'rgba(5, 150, 105, 0.72)',
                        borderColor: '#059669',
                        borderWidth: 1,
                        maxBarThickness: 36,
                        barPercentage: 0.55,
                        categoryPercentage: 0.6,
                        yAxisID: 'revenueAxis'
                    }
                ]
            },
            options: {
                ...commonChartOptions,
                scales: {
                    orderAxis: orderAxisOptions,
                    revenueAxis: revenueAxisOptions
                }
            }
        });

        new Chart(document.getElementById('dashboardRevenueChart'), {
            type: 'bar',
            data: {
                labels: monthlyLabels,
                datasets: [
                    {
                        label: 'Revenue',
                        data: monthlyRevenueData,
                        maxBarThickness: 34,
                        barPercentage: 0.55,
                        categoryPercentage: 0.6,
                        yAxisID: 'revenueAxis'
                    },
                    {
                        label: 'Orders',
                        data: monthlyOrderData,
                        maxBarThickness: 34,
                        barPercentage: 0.55,
                        categoryPercentage: 0.6,
                        yAxisID: 'orderAxis'
                    }
                ]
            },
            options: {
                ...commonChartOptions,
                scales: {
                    revenueAxis: {
                        ...revenueAxisOptions,
                        type: 'linear',
                        position: 'left',
                        grid: {
                            drawOnChartArea: true
                        }
                    },
                    orderAxis: {
                        ...orderAxisOptions,
                        position: 'right',
                        grid: {
                            drawOnChartArea: false
                        }
                    }
                }
            }
        });

        new Chart(document.getElementById('orderStatusChart'), {
            type: 'doughnut',
            data: {
                labels: ['Pending', 'Confirmed', 'Shipped', 'Delivered', 'Cancelled'],
                datasets: [{
                    data: [${pendingOrders}, ${confirmedOrders}, ${shippedOrders}, ${deliveredOrders}, ${cancelledOrders}],
                    backgroundColor: ['#f59e0b', '#10b981', '#3b82f6', '#059669', '#ef4444'],
                    borderColor: ['#d97706', '#059669', '#2563eb', '#047857', '#dc2626'],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
    </script>
    <script src="${pageContext.request.contextPath}/js/logout-confirm.js?v=4"></script>
</body>
</html>
