<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports & Analytics - Mobile Accessories Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=5">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">Mobile Accessories</a>
            <ul class="navbar-nav">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/products">Products</a></li>
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
                            <input type="hidden" name="generate" value="true">
                            <button type="submit" class="btn btn-primary">Generate Report</button>
                        </form>
                    </div>

                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-info">
                                <div class="stat-value">Rs <fmt:formatNumber value="${totalRevenue}" pattern="0.00"/></div>
                                <div class="stat-label">Sale Revenue</div>
                            </div>
                        </div>
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
                    </div>

                    <div class="report-summary-grid">
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

                    <div class="card analytics-section">
                        <div class="card-body">
                            <h3>Weekly Order Analysis</h3>
                            <div class="chart-area">
                                <canvas id="weeklyAnalysisChart"></canvas>
                            </div>
                        </div>
                    </div>

                    <div class="card analytics-section">
                        <div class="card-body">
                            <h3>${period == 'weekly' ? 'Weekly' : 'Monthly'} Sales & Orders</h3>
                            <div class="chart-area">
                                <canvas id="analyticsChart"></canvas>
                            </div>
                        </div>
                    </div>

                    <div class="card analytics-section">
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
        const weeklyOrderTotals = toWeekdayTotals(weeklyLabels, weeklyOrderData);
        const weeklyRevenueTotals = toWeekdayTotals(weeklyLabels, weeklyRevenueData);

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

        new Chart(document.getElementById('weeklyAnalysisChart'), {
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

        new Chart(document.getElementById('analyticsChart'), {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [
                    {
                        label: 'Revenue',
                        data: revenueData,
                        maxBarThickness: 34,
                        barPercentage: 0.55,
                        categoryPercentage: 0.6,
                        yAxisID: 'revenueAxis'
                    },
                    {
                        label: 'Orders',
                        data: orderData,
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

    </script>
    <script src="${pageContext.request.contextPath}/js/logout-confirm.js?v=4"></script>
</body>
</html>
