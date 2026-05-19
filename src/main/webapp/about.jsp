<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - MobileAccessories</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
</head>
<body>
    <jsp:include page="/WEB-INF/includes/navbar.jsp">
        <jsp:param name="type" value="public"/>
    </jsp:include>

    <main class="main-content">
        <div class="container">
            <h1 class="mb-2">About MobileAccessories</h1>

            <div class="card mb-3">
                <div class="card-body">
                    <h2>Who We Are</h2>
                    <p class="mt-1">MobileAccessories is a premier online destination for mobile accessories, committed to providing high-quality products at competitive prices. We believe that every mobile device deserves the best accessories to enhance its functionality and protect its value.</p>

                    <h2 class="mt-3">Our Mission</h2>
                    <p class="mt-1">Our mission is to make quality mobile accessories accessible to everyone. We carefully curate our product selection to ensure only genuine, high-quality items from trusted brands reach our customers.</p>

                    <h2 class="mt-3">What We Offer</h2>
                    <ul class="mt-1" style="padding-left:1.5rem">
                        <li>Wide range of mobile accessories including cases, chargers, earphones, screen protectors, and more</li>
                        <li>Products from top brands like Anker, Spigen, Samsung, Sony, and others</li>
                        <li>Competitive pricing with regular deals and discounts</li>
                        <li>Fast and reliable delivery across the country</li>
                        <li>Secure online shopping experience with encrypted transactions</li>
                        <li>24/7 customer support to assist with any queries</li>
                    </ul>

                    <h2 class="mt-3">Why Choose Us</h2>
                    <div class="stats-grid mt-2">
                        <div class="stat-card">
                            <div class="stat-icon blue">&#128230;</div>
                            <div class="stat-info">
                                <div class="stat-value">500+</div>
                                <div class="stat-label">Products Available</div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon green">&#128101;</div>
                            <div class="stat-info">
                                <div class="stat-value">1000+</div>
                                <div class="stat-label">Happy Customers</div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon yellow">&#9733;</div>
                            <div class="stat-info">
                                <div class="stat-value">4.8</div>
                                <div class="stat-label">Average Rating</div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon red">&#128666;</div>
                            <div class="stat-info">
                                <div class="stat-value">Fast</div>
                                <div class="stat-label">Delivery Speed</div>
                            </div>
                        </div>
                    </div>

                    <h2 class="mt-3">Our Commitment to Ethics</h2>
                    <p class="mt-1">As a responsible e-commerce platform, MobileAccessories is committed to ethical business practices. We ensure fair pricing, transparent product descriptions, and honest customer reviews. We do not engage in deceptive marketing practices and prioritize customer satisfaction above all.</p>
                </div>
            </div>
        </div>
    </main>

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

    <script>function toggleNav(){document.getElementById('navbarNav').classList.toggle('show');}</script>
    <script src="${pageContext.request.contextPath}/js/logout-confirm.js?v=4"></script>
</body>
</html>
