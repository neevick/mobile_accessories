<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - MobileAccessories</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
</head>
<body>
    <jsp:include page="/WEB-INF/includes/navbar.jsp">
        <jsp:param name="type" value="public"/>
    </jsp:include>

    <main class="main-content">
        <div class="container">
            <h1 class="mb-2">${not empty currentCategory ? currentCategory.name : not empty keyword ? 'Search Results' : 'All Products'}</h1>

            <!-- Search -->
            <form action="${pageContext.request.contextPath}/products" method="get" class="search-bar">
                <input type="hidden" name="action" value="search">
                <input type="text" name="keyword" placeholder="Search by name, brand..." value="${keyword}">
                <button type="submit">Search</button>
            </form>

            <!-- Category Filter -->
            <div class="category-filter">
                <a href="${pageContext.request.contextPath}/products" class="${empty currentCategory && empty keyword ? 'active' : ''}">All</a>
                <c:forEach var="cat" items="${categories}">
                    <a href="${pageContext.request.contextPath}/products?action=category&id=${cat.categoryId}" class="${not empty currentCategory && currentCategory.categoryId == cat.categoryId ? 'active' : ''}">${cat.name}</a>
                </c:forEach>
            </div>

            <c:if test="${not empty keyword}">
                <p class="mb-2 text-muted">Showing results for: <strong>${keyword}</strong></p>
            </c:if>

            <!-- Product Grid -->
            <c:choose>
                <c:when test="${not empty products}">
                    <div class="product-grid">
                        <c:forEach var="product" items="${products}">
                            <div class="product-card">
                                <div class="product-image">
                                    <c:choose>
                                        <c:when test="${not empty product.image}">
                                            <img src="${pageContext.request.contextPath}/resources/images/${product.image}" alt="${product.name}" style="width:100%;height:100%;object-fit:cover;">
                                        </c:when>
                                        <c:otherwise>&#128241;</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="product-info">
                                    <div class="product-name">${product.name}</div>
                                    <div class="product-brand">${product.brand}</div>
                                    <div class="product-price">Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0"/></div>
                                    <div class="product-stock ${product.stock > 0 ? 'in-stock' : 'out-of-stock'}">
                                        <c:choose>
                                            <c:when test="${product.stock > 0}">${product.stock} in stock</c:when>
                                            <c:otherwise>Out of stock</c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="product-actions">
                                        <a href="${pageContext.request.contextPath}/products?action=detail&id=${product.productId}" class="btn btn-sm btn-primary">View</a>
                                        <c:if test="${product.stock > 0 && not empty sessionScope.user}">
                                            <a href="${pageContext.request.contextPath}/orders?action=addToCart&productId=${product.productId}" class="btn btn-sm btn-success">Add to Cart</a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card">
                        <div class="card-body text-center">
                            <p class="text-muted">No products found.</p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2026 MobileAccessories. All rights reserved.</p>
            <ul class="footer-links">
                <li><a href="${pageContext.request.contextPath}/about.jsp">About</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
            </ul>
        </div>
    </footer>

    <script>function toggleNav(){document.getElementById('navbarNav').classList.toggle('show');}</script>
    <script src="${pageContext.request.contextPath}/js/logout-confirm.js?v=4"></script>
</body>
</html>
