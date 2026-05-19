<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - MobileAccessories</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
</head>
<body>
    <jsp:include page="/WEB-INF/includes/navbar.jsp">
        <jsp:param name="type" value="public"/>
    </jsp:include>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <h1>Premium Mobile Accessories</h1>
            <p>Discover the best accessories for your mobile devices. From cases to chargers, we have everything you need.</p>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary btn-lg">Shop Now</a>
        </div>
    </section>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success">${sessionScope.success}</div>
                <c:set var="success" value="" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger">${sessionScope.error}</div>
                <c:set var="error" value="" scope="session" />
            </c:if>

            <h2 class="mb-2">Featured Categories</h2>
            <div class="category-filter">
                <a href="${pageContext.request.contextPath}/products" class="active">All</a>
                <a href="${pageContext.request.contextPath}/products?action=category&id=1">Phone Cases</a>
                <a href="${pageContext.request.contextPath}/products?action=category&id=2">Screen Protectors</a>
                <a href="${pageContext.request.contextPath}/products?action=category&id=3">Chargers</a>
                <a href="${pageContext.request.contextPath}/products?action=category&id=4">Earphones</a>
                <a href="${pageContext.request.contextPath}/products?action=category&id=5">Power Banks</a>
            </div>

            <h2 class="mb-2">Featured Products</h2>
            <c:choose>
                <c:when test="${not empty featuredProducts}">
                    <div class="product-grid">
                        <c:forEach var="product" items="${featuredProducts}">
                            <div class="product-card">
                                <div class="product-image">
                                    <c:choose>
                                        <c:when test="${not empty product.image}">
                                            <img src="${pageContext.request.contextPath}/resources/images/${product.image}" alt="${product.name}" style="width:100%;height:100%;object-fit:cover;border-radius:var(--radius-lg) var(--radius-lg) 0 0">
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
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="text-center mt-2">
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">View All Products</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="text-muted text-center">No featured products available at the moment.</p>
                </c:otherwise>
            </c:choose>

            <h2 class="mb-2">Why Choose MobileAccessories?</h2>
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon blue">&#128230;</div>
                    <div class="stat-info">
                        <div class="stat-value">Fast Delivery</div>
                        <div class="stat-label">Quick shipping nationwide</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon green">&#9989;</div>
                    <div class="stat-info">
                        <div class="stat-value">Quality Products</div>
                        <div class="stat-label">Only genuine accessories</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon yellow">&#128176;</div>
                    <div class="stat-info">
                        <div class="stat-value">Best Prices</div>
                        <div class="stat-label">Competitive pricing guaranteed</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon red">&#128222;</div>
                    <div class="stat-info">
                        <div class="stat-value">24/7 Support</div>
                        <div class="stat-label">Always here to help</div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p>&copy; 2026 MobileAccessories. All rights reserved.</p>
            <ul class="footer-links">
                <li><a href="${pageContext.request.contextPath}/about.jsp">About</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
            </ul>
        </div>
    </footer>

    <script>
        function toggleNav() {
            document.getElementById('navbarNav').classList.toggle('show');
        }
    </script>
    <script src="${pageContext.request.contextPath}/js/logout-confirm.js?v=4"></script>
</body>
</html>
