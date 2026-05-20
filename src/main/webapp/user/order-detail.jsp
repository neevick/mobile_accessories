<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order #${order.orderId} - MobileAccessories</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
</head>
<body>
      <jsp:include page="/WEB-INF/includes/navbar.jsp">
        <jsp:param name="type" value="user"/>
    </jsp:include>

    <main class="main-content">
        <div class="container">
            <div class="flex-between mb-2">
                <h1>Order #${order.orderId}</h1>
                <a href="${pageContext.request.contextPath}/orders?action=history" class="btn btn-outline">&larr; My Orders</a>
            </div>

            <div class="card mb-2">
                <div class="card-header flex-between">
                    <h3>Order Details</h3>
                    <span class="badge badge-${order.status == 'pending' ? 'warning' : order.status == 'delivered' ? 'success' : order.status == 'cancelled' ? 'danger' : 'info'}">${order.status}</span>
                </div>
                <div class="card-body">
                    <p><strong>Date:</strong> ${order.orderDate}</p>
                    <p><strong>Shipping Address:</strong> ${order.shippingAddress}</p>
                    <p><strong>Phone:</strong> ${order.phone}</p>
                </div>
            </div>

            <div class="card">
                <div class="card-header"><h3>Items</h3></div>
                <div class="card-body">
                    <div class="table-wrapper">
                        <table>
                            <thead>
                                <tr><th>Product</th><th>Price</th><th>Qty</th><th>Subtotal</th></tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${items}">
                                    <tr>
                                        <td>${item.productName}</td>
                                        <td>Rs. <fmt:formatNumber value="${item.price}" pattern="#,##0"/></td>
                                        <td>${item.quantity}</td>
                                        <td>Rs. <fmt:formatNumber value="${item.subtotal}" pattern="#,##0"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="3" style="text-align:right;font-weight:600">Total</td>
                                    <td style="font-weight:700;color:var(--primary)">Rs. <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>

        <jsp:include page="/WEB-INF/includes/footer.jsp">
        <jsp:param name="type" value="simple"/>
    </jsp:include>
    <script src="${pageContext.request.contextPath}/js/logout-confirm.js?v=4"></script>
</body>
</html>
