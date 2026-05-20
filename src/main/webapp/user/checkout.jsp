<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - MobileAccessories</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
</head>
<body>
    <jsp:include page="/WEB-INF/includes/navbar.jsp">
        <jsp:param name="type" value="user"/>
    </jsp:include>

    <main class="main-content">
        <div class="container">
            <h1 class="mb-2">Checkout</h1>

            <form action="${pageContext.request.contextPath}/orders" method="post">
                <input type="hidden" name="action" value="placeOrder">

                <div class="d-flex gap-2" style="flex-wrap:wrap">
                    <!-- Shipping Info -->
                    <div style="flex:1;min-width:300px">
                        <div class="card">
                            <div class="card-header"><h3>Shipping Information</h3></div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" class="form-control" value="${user.fullName}" readonly>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Phone Number *</label>
                                    <input type="tel" name="phone" class="form-control" value="${user.phone}" required pattern="[0-9]{10,15}">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Shipping Address *</label>
                                    <textarea name="shippingAddress" class="form-control" rows="3" required>${user.address}</textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Order Summary -->
                    <div style="flex:1;min-width:300px">
                        <div class="card">
                            <div class="card-header"><h3>Order Summary</h3></div>
                            <div class="card-body">
                                <c:forEach var="item" items="${cart}">
                                    <div class="flex-between mb-1">
                                        <span>${item.productName} x ${item.quantity}</span>
                                        <span>Rs. <fmt:formatNumber value="${item.subtotal}" pattern="#,##0"/></span>
                                    </div>
                                </c:forEach>
                                <hr style="margin:1rem 0;border-color:var(--border)">
                                <c:set var="total" value="0" />
                                <c:forEach var="item" items="${cart}">
                                    <c:set var="total" value="${total + item.subtotal}" />
                                </c:forEach>
                                <div class="flex-between">
                                    <strong style="font-size:1.25rem">Total</strong>
                                    <strong style="font-size:1.25rem;color:var(--primary)">Rs. <fmt:formatNumber value="${total}" pattern="#,##0"/></strong>
                                </div>
                                <button type="submit" class="btn btn-success btn-block btn-lg mt-2">Place Order</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </main>

        <jsp:include page="/WEB-INF/includes/footer.jsp">
        <jsp:param name="type" value="simple"/>
    </jsp:include>
    <script src="${pageContext.request.contextPath}/js/logout-confirm.js?v=4"></script>
</body>
</html>
