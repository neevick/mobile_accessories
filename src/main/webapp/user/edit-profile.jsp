<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - MobileAccessories</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
</head>
<body>
    <jsp:include page="/WEB-INF/includes/navbar.jsp">
        <jsp:param name="type" value="user"/>
    </jsp:include>

    <main class="main-content">
        <div class="container" style="max-width:600px">
            <h1 class="mb-2">Edit Profile</h1>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <div class="card">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/profile" method="post">
                        <input type="hidden" name="action" value="update">
                        <div class="form-group">
                            <label class="form-label">Username</label>
                            <input type="text" class="form-control" value="${profileUser.username}" readonly style="background:var(--bg)">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Full Name *</label>
                            <input type="text" name="fullName" class="form-control" value="${profileUser.fullName}" required minlength="2" maxlength="100" pattern="[A-Za-z\s]+">
                            <span class="form-text">Letters and spaces only (2-100 chars)</span>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Email *</label>
                            <input type="email" name="email" class="form-control" value="${profileUser.email}" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Phone *</label>
                            <input type="tel" name="phone" class="form-control" value="${profileUser.phone}" required minlength="10" maxlength="15" pattern="[0-9]{10,15}">
                            <span class="form-text">10-15 digits</span>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Address</label>
                            <textarea name="address" class="form-control" rows="2">${profileUser.address}</textarea>
                        </div>
                        <div class="d-flex gap-2 mt-2">
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                            <a href="${pageContext.request.contextPath}/profile?action=view" class="btn btn-outline">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

        <jsp:include page="/WEB-INF/includes/footer.jsp">
        <jsp:param name="type" value="simple"/>
    </jsp:include>
    <script src="${pageContext.request.contextPath}/js/logout-confirm.js?v=4"></script>
</body>
</html>
