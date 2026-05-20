<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Reviews - Admin Dashboard</title>
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
                    <h1 class="mb-2">Manage Reviews</h1>

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
                                            <th>User</th>
                                            <th>Product</th>
                                            <th>Rating</th>
                                            <th>Comment</th>
                                            <th>Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty reviews}">
                                                <c:forEach var="review" items="${reviews}">
                                                    <tr>
                                                        <td>${review.reviewId}</td>
                                                        <td>${review.userName}</td>
                                                        <td>${review.productName}</td>
                                                        <td>
                                                            <div class="star-rating">
                                                                <c:forEach begin="1" end="5" var="i">
                                                                    <span class="star ${i <= review.rating ? 'filled' : ''}">&#9733;</span>
                                                                </c:forEach>
                                                            </div>
                                                        </td>
                                                        <td>${review.comment}</td>
                                                        <td>${review.createdAt}</td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/admin/reviews?action=delete&id=${review.reviewId}" 
                                                               class="btn btn-sm btn-danger" 
                                                               onclick="return confirm('Are you sure you want to delete this review?');">Delete</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="7" style="text-align:center;">No product reviews found.</td>
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
