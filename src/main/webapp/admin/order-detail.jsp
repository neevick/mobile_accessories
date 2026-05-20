<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order #${order.orderId} - MobileAccessories Admin</title>
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
                        <li><a href="${pageContext.request.contextPath}/admin/orders" class="active">Orders</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/users">Users</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/reports">Reports & Analytics</a></li>
                    </ul>
                </aside>

                <div class="admin-content">
                    <div class="flex-between mb-2">
                        <h1>Order #${order.orderId}</h1>
                        <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline">&larr; Back to Orders</a>
                    </div>

                    <c:if test="${not empty sessionScope.success}">
                        <div class="alert alert-success">${sessionScope.success}</div>
                        <c:set var="success" value="" scope="session" />
                    </c:if>

                    <!-- Order Info -->
                    <div class="card mb-2">
                        <div class="card-header">
                            <h3>Order Information</h3>
                            <span class="badge badge-${order.status == 'pending' ? 'warning' : order.status == 'delivered' ? 'success' : order.status == 'cancelled' ? 'danger' : 'info'}">${order.status}</span>
                        </div>
                        <div class="card-body">
                            <div class="d-flex gap-2" style="flex-wrap:wrap">
                                <div style="flex:1;min-width:200px">
                                    <p><strong>Customer:</strong> ${order.userName}</p>
                                    <p><strong>Email:</strong> ${order.userEmail}</p>
                                    <p><strong>Phone:</strong> ${order.phone}</p>
                                </div>
                                <div style="flex:1;min-width:200px">
                                    <p><strong>Shipping Address:</strong> ${order.shippingAddress}</p>
                                    <p><strong>Order Date:</strong> ${order.orderDate}</p>
                                    <p><strong>Total:</strong> Rs. <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/></p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Update Status -->
                    <div class="card mb-2">
                        <div class="card-header"><h3>Update Status</h3></div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/admin/orders" method="post" class="d-flex gap-1">
                                <input type="hidden" name="action" value="updateStatus">
                                <input type="hidden" name="orderId" value="${order.orderId}">
                                <select name="status" class="form-control" style="max-width:200px">
                                    <option value="pending" ${order.status == 'pending' ? 'selected' : ''}>Pending</option>
                                    <option value="confirmed" ${order.status == 'confirmed' ? 'selected' : ''}>Confirmed</option>
                                    <option value="shipped" ${order.status == 'shipped' ? 'selected' : ''}>Shipped</option>
                                    <option value="delivered" ${order.status == 'delivered' ? 'selected' : ''}>Delivered</option>
                                    <option value="cancelled" ${order.status == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                                </select>
                                <button type="submit" class="btn btn-primary">Update</button>
                            </form>
                        </div>
                    </div>

                    <!-- Order Items -->
                    <div class="card">
                        <div class="card-header"><h3>Order Items</h3></div>
                        <div class="card-body">
                            <div class="table-wrapper">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Product</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Subtotal</th>
                                        </tr>
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
            </div>
        </div>
    </main>

        <jsp:include page="/WEB-INF/includes/footer.jsp">
        <jsp:param name="type" value="admin"/>
    </jsp:include>
    <script src="${pageContext.request.contextPath}/js/logout-confirm.js?v=4"></script>
</body>
</html>
