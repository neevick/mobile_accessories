<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - MobileAccessories</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">MobileAccessories</a>
            <ul class="navbar-nav">
                <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
                <li><a href="${pageContext.request.contextPath}/orders?action=cart" class="active">Cart</a></li>
                <li><a href="${pageContext.request.contextPath}/profile">${sessionScope.userName}</a></li>
                <li><a href="${pageContext.request.contextPath}/auth?action=logout" class="logout-link">Logout</a></li>
            </ul>
        </div>
    </nav>

    <main class="main-content">
        <div class="container">
            <h1 class="mb-2">Shopping Cart</h1>

            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success">${sessionScope.success}</div>
                <c:set var="success" value="" scope="session" />
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <c:choose>
                <c:when test="${not empty cart}">
                    <c:forEach var="item" items="${cart}">
                        <div class="cart-item">
                            <div class="item-image">
                                <c:choose>
                                    <c:when test="${not empty item.productImage}">
                                        <img src="${pageContext.request.contextPath}/resources/images/${item.productImage}" alt="${item.productName}" style="width:100%;height:100%;object-fit:cover;">
                                    </c:when>
                                    <c:otherwise>&#128241;</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="item-info">
                                <div class="item-name">${item.productName}</div>
                                <div class="item-price">Rs. <fmt:formatNumber value="${item.price}" pattern="#,##0"/> x ${item.quantity} = Rs. <fmt:formatNumber value="${item.subtotal}" pattern="#,##0"/></div>
                            </div>
                            <div class="item-actions">
                                <form action="${pageContext.request.contextPath}/orders" method="get" class="d-flex gap-1">
                                    <input type="hidden" name="action" value="updateCart">
                                    <input type="hidden" name="productId" value="${item.productId}">
                                    <input type="number" name="quantity" value="${item.quantity}" min="1" style="width:60px;padding:0.4rem" class="form-control">
                                    <button type="submit" class="btn btn-sm btn-primary">Update</button>
                                </form>
                                <a href="${pageContext.request.contextPath}/orders?action=removeFromCart&productId=${item.productId}" class="btn btn-sm btn-danger">Remove</a>
                            </div>
                        </div>
                    </c:forEach>

                    <div class="card mt-2">
                        <div class="card-body flex-between">
                            <h2>Total: Rs. <fmt:formatNumber value="${cartTotal}" pattern="#,##0"/></h2>
                            <a href="${pageContext.request.contextPath}/orders?action=checkout" class="btn btn-success btn-lg">Proceed to Checkout</a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card">
                        <div class="card-body text-center">
                            <p class="text-muted mb-2">Your cart is empty.</p>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Browse Products</a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <footer class="footer">
        <div class="container"><p>&copy; 2026 MobileAccessories.</p></div>
    </footer>
    <script src="${pageContext.request.contextPath}/js/logout-confirm.js?v=4"></script>
</body>
</html>
