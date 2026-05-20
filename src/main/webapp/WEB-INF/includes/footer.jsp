<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="footerType" value="${param.type}" scope="page"/>

<footer class="footer ${footerType == 'admin' ? 'footer-admin' : ''}">
    <div class="container">
        <c:if test="${footerType != 'admin' && footerType != 'simple'}">
            <div class="footer-main">
                <div class="footer-column footer-brand">
                    <h2>Mobile Accessories</h2>
                    <p>Quality mobile accessories, useful gadgets, and everyday essentials for your devices.</p>
                </div>

                <div class="footer-column">
                    <h3>About Us</h3>
                    <p>MobileAccessories helps shoppers find reliable chargers, cables, speakers, cases, protectors, and smart accessories in one place.</p>
                </div>

                <div class="footer-column">
                    <h3>Quick Links</h3>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
                        <li><a href="${pageContext.request.contextPath}/about.jsp">About Us</a></li>
                    </ul>
                </div>

                <div class="footer-column footer-contact">
                    <h3>Contact Us</h3>
                    <p>Have a question about an order or product?</p>
                    <a href="${pageContext.request.contextPath}/contact" class="footer-contact-btn">Contact Us</a>
                </div>
            </div>
        </c:if>

        <div class="footer-bottom">
            <p>Copyright &copy; 2026 All Rights Reserved.</p>
        </div>
    </div>
</footer>

<script>
    function toggleNav() {
        var nav = document.getElementById('navbarNav');
        if (nav) {
            nav.classList.toggle('show');
        }
    }
</script>
<script src="${pageContext.request.contextPath}/js/logout-confirm.js?v=4"></script>
