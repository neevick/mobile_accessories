<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Mobile Accessories</title>
    
    <!-- Include FontAwesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Style Sheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=4">


</head>
<body>

    <jsp:include page="/WEB-INF/includes/navbar.jsp">
        <jsp:param name="type" value="public"/>
    </jsp:include>

    <main class="main-content">
        <div class="container">
            <c:if test="${not empty success}">
                <div class="alert alert-success" style="margin-bottom: 20px; border-radius: 8px;">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger" style="margin-bottom: 20px; border-radius: 8px;">${error}</div>
            </c:if>

            <div class="contact-container">
                <!-- Left Side Panel -->
                <div class="left-panel">
                    <div class="left-panel-content">
                        <div>
                            <h1>Contact Us</h1>
                            <div class="decorative-lines">
                                <div></div>
                                <div></div>
                                <div></div>
                            </div>
                        </div>
                        <div class="contact-info-items">
                            <div class="contact-info-item">
                                <i class="fa-solid fa-envelope"></i>
                                <span>info@Mobileaccessories.com</span>
                            </div>
                            <div class="contact-info-item">
                                <i class="fa-solid fa-phone-volume"></i>
                                <span>Support: +977 9800000000</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Side Panel -->
                <div class="right-panel">
                    <h2>We'd love to hear from you!</h2>
                    <p class="subtitle">Let's get in touch</p>

                    <form action="${pageContext.request.contextPath}/contact" method="POST">

                        <div class="form-row">
                            <div class="form-group">
                                <label for="fullName">Full Name</label>
                                <input type="text" id="fullName" name="fullName" value="${contactName}" required class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="company">Company</label>
                                <input type="text" id="company" name="company" value="${contactCompany}" class="form-control">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" value="${contactEmail}" required class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone number</label>
                                <input type="tel" id="phone" name="phone" value="${contactPhone}" class="form-control">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="address">Address</label>
                            <input type="text" id="address" name="address" value="${contactAddress}" class="form-control">
                        </div>

                        <div class="form-group">
                            <label for="message">Your Message</label>
                            <textarea id="message" name="message" required class="form-control">${contactMessage}</textarea>
                        </div>

                        <button type="submit" class="btn-send-message">Send Message</button>
                    </form>
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