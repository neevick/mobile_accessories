<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%-- 
    Reusable Navbar Component
    Usage: <jsp:include page="/WEB-INF/includes/navbar.jsp">
              <jsp:param name="type" value="public|user|admin|auth"/>
           </jsp:include>
--%>
<c:set var="navType" value="${param.type}" scope="page"/>
<c:if test="${empty navType}"><c:set var="navType" value="public"/></c:if>

<nav class="navbar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">MobileAccessories</a>
        <button class="navbar-toggle" onclick="toggleNav()">&#9776;</button>
        <ul class="navbar-nav" id="navbarNav">
            <c:choose>
                <c:when test="${navType == 'admin'}">
                    <li><a href="${pageContext.request.contextPath}/profile">${sessionScope.userName}</a></li>
                    <li><a href="${pageContext.request.contextPath}/auth?action=logout" class="logout-link">Logout</a></li>
                </c:when>
                <c:when test="${navType == 'user'}">
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
                    <li><a href="${pageContext.request.contextPath}/about.jsp">About</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                    <li><a href="${pageContext.request.contextPath}/orders?action=cart">Cart</a></li>
                    <li><a href="${pageContext.request.contextPath}/profile">${sessionScope.userName}</a></li>
                    <li><a href="${pageContext.request.contextPath}/auth?action=logout" class="logout-link">Logout</a></li>
                </c:when>
                <c:when test="${navType == 'auth'}">
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
                    <li><a href="${pageContext.request.contextPath}/about.jsp">About</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <c:if test="${sessionScope.userRole == 'admin'}">
                                <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                            </c:if>
                            <li><a href="${pageContext.request.contextPath}/orders?action=cart">Cart</a></li>
                            <li><a href="${pageContext.request.contextPath}/profile">${sessionScope.userName}</a></li>
                            <li><a href="${pageContext.request.contextPath}/auth?action=logout" class="logout-link">Logout</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${pageContext.request.contextPath}/auth?action=login">Login</a></li>
                            <li><a href="${pageContext.request.contextPath}/auth?action=register" class="btn btn-primary">Register</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>
