<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generated Report - Mobile Accessories Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=6">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">Mobile Accessories</a>
            <ul class="navbar-nav">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/reports" class="active">Reports</a></li>
                <li><a href="${pageContext.request.contextPath}/auth?action=logout" class="logout-link">Logout</a></li>
            </ul>
        </div>
    </nav>

    <main class="main-content">
        <div class="container generated-report-container">
            <div class="flex-between mb-2">
                <h1>Generated Report</h1>
                <a href="${pageContext.request.contextPath}/admin/reports?period=${period}" class="btn btn-outline">Back</a>
            </div>

            <div class="card report-output-card">
                <div class="card-header">
                    <h3>${period == 'weekly' ? 'Weekly' : 'Monthly'} Report</h3>
                    <button type="button" class="btn btn-sm btn-primary" id="copyReportBtn">Copy Report</button>
                </div>
                <div class="card-body">
                    <textarea id="generatedReportText" class="form-control report-textarea" readonly>Mobile Accessories ${period == 'weekly' ? 'Weekly' : 'Monthly'} Report

					Sale Revenue: Rs <fmt:formatNumber value="${totalRevenue}" pattern="0.00"/>
					Today Orders: ${todayOrders}
					This Week Order: ${thisWeekOrders}
					Total Order: ${totalOrders}
					
					Order Status:
					Pending: ${pendingOrders}
					Confirmed: ${confirmedOrders}
					Shipped: ${shippedOrders}
					Delivered: ${deliveredOrders}
					Cancelled: ${cancelledOrders}
					
					Product Summary:
					Active Products: ${totalProducts}
					Inactive Products: ${inactiveProducts}
					
					User Summary:
					Customers: ${customerUsers}
					Admins: ${adminUsers}
					
					Top Selling Products
					<c:choose><c:when test="${not empty topProducts}"><c:forEach var="p" items="${topProducts}">- ${p.key}: ${p.value}
					</c:forEach></c:when><c:otherwise>No sales data available.
					</c:otherwise></c:choose></textarea>
                    <p class="text-muted mt-1" id="copyReportStatus">Report generated! You can copy the report using "Copy Report".</p>
                </div>
            </div>
        </div>
    </main>

    <script>
        const copyReportBtn = document.getElementById('copyReportBtn');
        copyReportBtn.addEventListener('click', async () => {
            const reportText = document.getElementById('generatedReportText');
            const status = document.getElementById('copyReportStatus');
            reportText.select();
            reportText.setSelectionRange(0, reportText.value.length);
            try {
                await navigator.clipboard.writeText(reportText.value);
                status.textContent = 'Report copied to clipboard.';
            } catch (error) {
                document.execCommand('copy');
                status.textContent = 'Report selected and copied.';
            }
        });
    </script>
    <script src="${pageContext.request.contextPath}/js/logout-confirm.js?v=4"></script>
</body>
</html>
