<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - MobileAccessories</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">MobileAccessories</a>
            <ul class="navbar-nav">
                <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
            </ul>
        </div>
    </nav>

    <main class="main-content">
        <div class="container text-center" style="padding:4rem 1rem">
            <h1 style="font-size:3rem;color:var(--warning)">&#9888;</h1>
            <h2>Oops! Something Went Wrong</h2>
            <p class="text-muted mt-1 mb-2">An unexpected error occurred. Our team has been notified.</p>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg">Go to Homepage</a>
        </div>
    </main>

        <jsp:include page="/WEB-INF/includes/footer.jsp">
        <jsp:param name="type" value="simple"/>
    </jsp:include>
</body>
</html>
