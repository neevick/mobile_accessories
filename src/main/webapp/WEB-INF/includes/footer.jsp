<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="footerType" value="${param.type}" scope="page"/>

<footer class="footer">
    <div class="container">
        <p>&copy; 2026 MobileAccessories. All rights reserved.</p>
        <c:if test="${footerType != 'simple'}">
            <ul class="footer-links">
                <li><a href="${pageContext.request.contextPath}/about.jsp">About</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
            </ul>
        </c:if>
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
