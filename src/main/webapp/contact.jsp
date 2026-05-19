<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - MobileAccessories</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
</head>
<body>
    <jsp:include page="/WEB-INF/includes/navbar.jsp">
        <jsp:param name="type" value="public"/>
    </jsp:include>

    <main class="main-content">
        <div class="container" style="max-width:700px">
            <h1 class="mb-2">Contact Us</h1>

            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <div class="card mb-3">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/contact" method="post">
                        <div class="form-group">
                            <label class="form-label">Your Name *</label>
                            <input type="text" name="name" class="form-control" value="${contactName}" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Email Address *</label>
                            <input type="email" name="email" class="form-control" value="${contactEmail}" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Subject *</label>
                            <input type="text" name="subject" class="form-control" value="${contactSubject}" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Message *</label>
                            <textarea name="message" class="form-control" rows="5" required>${contactMessage}</textarea>
                        </div>
                        <button type="submit" class="btn btn-primary btn-lg">Send Message</button>
                    </form>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <h3>Other Ways to Reach Us</h3>
                    <div class="mt-1">
                        <p><strong>&#128231; Email:</strong> support@mobileaccessories.com</p>
                        <p><strong>&#128222; Phone:</strong> +977-1-4567890</p>
                        <p><strong>&#128205; Address:</strong> Pokhara, Nepal</p>
                        <p><strong>&#128337; Hours:</strong> Sunday - Friday, 10:00 AM - 6:00 PM</p>
                    </div>
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
