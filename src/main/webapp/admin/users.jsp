<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - MobileAccessories Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
</head>
<body>
    <jsp:include page="/WEB-INF/includes/navbar.jsp">
        <jsp:param name="type" value="admin"/>
    </jsp:include>

<main class="main-content">
    <div class="container">
        <div class="admin-layout">

            <aside class="admin-sidebar">
                <div class="sidebar-header">Admin Panel</div>
                <ul class="sidebar-nav">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/products">Products</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/categories">Categories</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/orders">Orders</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/users" class="active">Users</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/reports">Reports & Analytics</a></li>
                </ul>
            </aside>

            <div class="admin-content">

                <h1>Users</h1>

                <!-- Messages -->
                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success">${sessionScope.success}</div>
                    <c:set var="success" value="" scope="session" />
                </c:if>

                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger">${sessionScope.error}</div>
                    <c:set var="error" value="" scope="session" />
                </c:if>

                <div class="card">
                    <div class="card-body">

                        <c:choose>
                            <c:when test="${not empty users}">
                                <div class="table-wrapper">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Username</th>
                                                <th>Full Name</th>
                                                <th>Email</th>
                                                <th>Phone</th>
                                                <th>Role</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <c:forEach var="u" items="${users}">
                                                <tr>
                                                    <td>${u.userId}</td>
                                                    <td>${u.username}</td>
                                                    <td>${u.fullName}</td>
                                                    <td>${u.email}</td>
                                                    <td>${u.phone}</td>

                                                    <td>
                                                        <span class="badge badge-${u.role == 'admin' ? 'primary' : 'info'}">
                                                            ${u.role}
                                                        </span>
                                                    </td>

                                                    <td>
                                                        <!-- ADMIN ONLY -->
                                                        <c:if test="${sessionScope.userRole == 'admin'}">

                                                            <a href="${pageContext.request.contextPath}/admin/users?action=edit&id=${u.userId}"
                                                               class="btn btn-sm btn-primary">Edit</a>

                                                            <a href="${pageContext.request.contextPath}/admin/users?action=delete&id=${u.userId}"
                                                               class="btn btn-sm btn-danger"
                                                               onclick="return confirm('Delete this user?')">
                                                               Delete
                                                            </a>

                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>

                                    </table>
                                </div>
                            </c:when>

                            <c:otherwise>
                                <p class="text-muted text-center">No users found.</p>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>

            </div>
        </div>
    </div>
</main>

    <jsp:include page="/WEB-INF/includes/footer.jsp">
        <jsp:param name="type" value="admin"/>
    </jsp:include>

    <script src="${pageContext.request.contextPath}/js/logout-confirm.js?v=4"></script>
</body>
</html>