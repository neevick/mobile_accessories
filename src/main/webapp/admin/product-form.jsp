<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty product ? 'Add' : 'Edit'} Product - MobileAccessories Admin</title>
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

            <aside class="admin-sidebar">
                <div class="sidebar-header">Admin Panel</div>
                <ul class="sidebar-nav">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/products" class="active">Products</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/categories">Categories</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/orders">Orders</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/users">Users</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/reports">Reports & Analytics</a></li>
                   
                </ul>
            </aside>

            <div class="admin-content">
                <h1 class="mb-2">${empty product ? 'Add New Product' : 'Edit Product'}</h1>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <div class="card">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/products"
                              method="post"
                              enctype="multipart/form-data">

                            <input type="hidden" name="action" value="${empty product ? 'add' : 'edit'}">

                            <c:if test="${not empty product}">
                                <input type="hidden" name="id" value="${product.productId}">
                            </c:if>

                            <div class="form-group">
                                <label class="form-label">Product Name *</label>
                                <input type="text" name="name" class="form-control" value="${product.name}" required>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Description</label>
                                <textarea name="description" class="form-control" rows="4">${product.description}</textarea>
                            </div>

                            <div class="d-flex gap-2">
                                <div class="form-group" style="flex:1">
                                    <label class="form-label">Price (Rs.) *</label>
                                    <input type="number" step="1" min="0" name="price" class="form-control" value="${product.price}" required>
                                </div>

                                <div class="form-group" style="flex:1">
                                    <label class="form-label">Stock *</label>
                                    <input type="number" min="0" name="stock" class="form-control" value="${product.stock}" required>
                                </div>
                            </div>

                            <div class="d-flex gap-2">
                                <div class="form-group" style="flex:1">
                                    <label class="form-label">Category *</label>
                                    <select name="categoryId" class="form-control" required>
                                        <option value="">-- Select Category --</option>
                                        <c:forEach var="cat" items="${categories}">
                                            <option value="${cat.categoryId}" <c:if test="${not empty product && product.categoryId == cat.categoryId}">selected</c:if>>
                                                ${cat.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="form-group" style="flex:1">
                                    <label class="form-label">Brand</label>
                                    <input type="text" name="brand" class="form-control" value="${product.brand}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Product Image</label>
                                <div class="admin-image-upload">
                                    <c:if test="${not empty product.image}">
                                        <c:url var="productImageUrl" value="/resources/images/${product.image}" />
                                        <div class="current-image-preview mb-2">
                                            <p class="form-label mb-1">Current image</p>
                                            <img id="currentProductImage"
                                                 src="${productImageUrl}"
                                                 alt="${product.name}"
                                                 class="admin-product-thumb">
                                            <label class="remove-image-label mt-1">
                                                <input type="checkbox" name="removeImage" id="removeImage">
                                                Remove current image
                                            </label>
                                        </div>
                                    </c:if>
                                    <div id="newImagePreview" class="new-image-preview mb-2 hidden">
                                        <p class="form-label mb-1">New image preview</p>
                                        <img id="newProductImagePreview" src="" alt="Preview" class="admin-product-thumb">
                                    </div>
                                    <input type="file" name="image" id="productImageInput" class="form-control" accept="image/jpeg,image/png,image/gif,image/webp">
                                    <small class="form-text">JPG, PNG, GIF, or WEBP. Shown on product listing and product detail pages.</small>
                                </div>
                            </div>

                            <c:if test="${not empty product}">
                                <div class="form-group">
                                    <label class="form-label">Status</label>
                                    <select name="status" class="form-control">
                                        <option value="active" <c:if test="${product.status == 'active'}">selected</c:if>>Active</option>
                                        <option value="inactive" <c:if test="${product.status == 'inactive'}">selected</c:if>>Inactive</option>
                                    </select>
                                </div>
                            </c:if>

                            <div class="d-flex gap-2 mt-2">
                                <button type="submit" class="btn btn-primary">
                                    ${empty product ? 'Add Product' : 'Update Product'}
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline">Cancel</a>
                            </div>

                        </form>
                    </div>
                </div>
            </div>

        </div>
    </div>
</main>

<footer class="footer">
    <div class="container">
        <p>&copy; 2026 MobileAccessories Admin.</p>
    </div>
</footer>

    <script src="${pageContext.request.contextPath}/js/logout-confirm.js?v=4"></script>
    <script>
        (function () {
            var fileInput = document.getElementById('productImageInput');
            var previewWrap = document.getElementById('newImagePreview');
            var previewImg = document.getElementById('newProductImagePreview');
            var removeCheckbox = document.getElementById('removeImage');
            var currentImg = document.getElementById('currentProductImage');

            if (!fileInput) return;

            fileInput.addEventListener('change', function () {
                var file = fileInput.files && fileInput.files[0];
                if (!file) {
                    previewWrap.classList.add('hidden');
                    previewImg.removeAttribute('src');
                    return;
                }
                previewImg.src = URL.createObjectURL(file);
                previewWrap.classList.remove('hidden');
                if (removeCheckbox) {
                    removeCheckbox.checked = false;
                }
            });

            if (removeCheckbox && currentImg) {
                removeCheckbox.addEventListener('change', function () {
                    currentImg.style.opacity = removeCheckbox.checked ? '0.35' : '1';
                });
            }
        })();
    </script>
</body>
</html>
