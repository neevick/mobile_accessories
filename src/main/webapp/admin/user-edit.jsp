<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Edit User - MobileAccessories Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
</head>
<body>

 <nav class="navbar">
        <div class="container">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">MobileAccessories</a>
            <ul class="navbar-nav">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/auth?action=logout" class="logout-link">Logout</a></li>
            </ul>
        </div>
    </nav>


<main class="main-content">
    <div class="container">
        <div class="admin-layout">

                            <jsp:include page="/WEB-INF/includes/admin-sidebar.jsp" />
            
                <div class="admin-content">
                    <h1 class="mb-2">Edit User</h1>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <div class="card">
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/admin/users" method="post">
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="id" value="${user.userId}">

                                <div class="form-group">
                                    <label class="form-label">Username *</label>
                                    <input type="text" name="username" class="form-control" value="${user.username}" required minlength="3" maxlength="50" pattern="[A-Za-z0-9_]+">
                                    <span class="form-text">Letters, numbers, underscores only (3-50 chars)</span>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Full Name *</label>
                                    <input type="text" name="fullName" class="form-control" value="${user.fullName}" required minlength="2" maxlength="100" pattern="[A-Za-z\s]+">
                                    <span class="form-text">Letters and spaces only (2-100 chars)</span>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Email *</label>
                                    <input type="email" name="email" class="form-control" value="${user.email}" required>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Phone *</label>
                                    <input type="tel" name="phone" class="form-control" value="${user.phone}" required minlength="10" maxlength="15" pattern="[0-9]{10,15}">
                                    <span class="form-text">10-15 digits</span>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Role</label>
                                    <select name="role" class="form-control">
                                        <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>Admin</option>
                                        <option value="user" ${user.role == 'user' ? 'selected' : ''}>User</option>
                                    </select>
                                </div>

                                <div class="d-flex gap-2 mt-2">
                                    <button type="submit" class="btn btn-primary">Update User</button>
                                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline">Cancel</a>
                                </div>
                            </form>
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

