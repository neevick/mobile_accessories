<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Contacts - Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">

</head>
<body>
    <jsp:include page="/WEB-INF/includes/navbar.jsp">
        <jsp:param name="type" value="admin"/>
    </jsp:include>

    <main class="main-content">
        <div class="container">
            <div class="admin-layout">
                <jsp:include page="/WEB-INF/includes/admin-sidebar.jsp" />

                <!-- Content -->
                <div class="admin-content">
                    <h1 class="mb-2">Manage Contacts</h1>

                    <c:if test="${not empty sessionScope.success}">
                        <div class="alert alert-success">${sessionScope.success}</div>
                        <c:remove var="success" scope="session"/>
                    </c:if>
                    <c:if test="${not empty sessionScope.error}">
                        <div class="alert alert-danger">${sessionScope.error}</div>
                        <c:remove var="error" scope="session"/>
                    </c:if>

                    <div class="card">
                        <div class="card-body">
                            <div class="table-wrapper">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Subject</th>
                                            <th>Message</th>
                                            <th>Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty contacts}">
                                                <c:forEach var="contact" items="${contacts}">
                                                    <tr>
                                                        <td>${contact.contactId}</td>
                                                        <td>${contact.name}</td>
                                                        <td>${contact.email}</td>
                                                        <td>${contact.subject}</td>
                                                        <td>${contact.message}</td>
                                                        <td>${contact.createdAt}</td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="6" style="text-align:center;">No contact messages found.</td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
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
