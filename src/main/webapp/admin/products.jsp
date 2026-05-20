<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products - MobileAccessories Admin</title>
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

                <div class="admin-content">
                    <div class="flex-between mb-2">
                        <h1>Products</h1>
                        <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn btn-primary">+ Add Product</a>
                    </div>

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
                                <c:when test="${not empty products}">
                                    <div class="table-wrapper">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Image</th>
                                                    <th>Name</th>
                                                    <th>Category</th>
                                                    <th>Brand</th>
                                                    <th>Price</th>
                                                    <th>Stock</th>
                                                    <th>Status</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="product" items="${products}">
                                                    <tr>
                                                        <td>${product.productId}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty product.image}">
                                                                    <c:url var="productImageUrl" value="/resources/images/${product.image}" />
                                                                    <img src="${productImageUrl}"
                                                                         alt="${product.name}"
                                                                         class="admin-product-thumb admin-product-thumb--table">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">No image</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${product.name}</td>
                                                        <td>${product.categoryName}</td>
                                                        <td>${product.brand}</td>
                                                        <td>Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0"/></td>
                                                        <td>${product.stock}</td>
                                                        <td><span class="badge badge-${product.status == 'active' ? 'success' : 'danger'}">${product.status}</span></td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${product.productId}" class="btn btn-sm btn-primary">Edit</a>
                                                            <form action="${pageContext.request.contextPath}/admin/products" method="post" style="display:inline" onsubmit="return confirm('Are you sure you want to delete this product?')">
                                                                <input type="hidden" name="action" value="delete">
                                                                <input type="hidden" name="id" value="${product.productId}">
                                                                <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted text-center">No products found. <a href="${pageContext.request.contextPath}/admin/products?action=add">Add one now</a></p>
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

