<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - MobileAccessories</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
</head>
<body>
   <jsp:include page="/WEB-INF/includes/navbar.jsp">
    <jsp:param name="type" value="${sessionScope.userRole == 'admin' ? 'admin' : 'user'}"/>
</jsp:include>

    <main class="main-content">
        <div class="container">
            <h1 class="mb-2">My Profile</h1>

            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success">${sessionScope.success}</div>
                <c:set var="success" value="" scope="session" />
            </c:if>

            <div class="d-flex gap-2" style="flex-wrap:wrap">
                <div style="flex:1;min-width:300px">
                    <div class="card">
                        <div class="card-header flex-between">
                            <h3>Profile Information</h3>
                            <a href="${pageContext.request.contextPath}/profile?action=edit" class="btn btn-sm btn-primary">Edit</a>
                        </div>
                        <div class="card-body">
                            <p><strong>Username:</strong> ${profileUser.username}</p>
                            <p><strong>Full Name:</strong> ${profileUser.fullName}</p>
                            <p><strong>Email:</strong> ${profileUser.email}</p>
                            <p><strong>Phone:</strong> ${profileUser.phone}</p>
                            <p><strong>Address:</strong> ${profileUser.address}</p>
                            <p><strong>Role:</strong> <span class="badge badge-info">${profileUser.role}</span></p>
                            <p><strong>Member Since:</strong> ${profileUser.createdAt}</p>
                        </div>
                    </div>
                </div>
                <div style="flex:1;min-width:300px">
                    <div class="card">
                        <div class="card-header"><h3>Quick Links</h3></div>
                        <div class="card-body">
                            <c:if test="${sessionScope.userRole != 'admin'}">
    <a href="${pageContext.request.contextPath}/orders?action=history" class="btn btn-outline btn-block mb-1">My Orders</a>
</c:if>
                            <a href="${pageContext.request.contextPath}/profile?action=changePassword" class="btn btn-outline btn-block">Change Password</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

        <jsp:include page="/WEB-INF/includes/footer.jsp">
        <jsp:param name="type" value="${sessionScope.userRole == 'admin' ? 'admin' : 'public'}"/>
    </jsp:include>
    <script src="${pageContext.request.contextPath}/js/logout-confirm.js?v=4"></script>
</body>
</html>
