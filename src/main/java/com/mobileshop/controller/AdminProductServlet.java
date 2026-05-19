package com.mobileshop.controller;

import com.mobileshop.model.Category;
import com.mobileshop.model.Product;
import com.mobileshop.service.ProductService;
import com.mobileshop.util.ImageUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.List;

/**
 * Admin Product controller - CRUD operations for products.
 */
@WebServlet(name = "AdminProductServlet", urlPatterns = {"/admin/products"})
@MultipartConfig(maxFileSize = 16177215)
public class AdminProductServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                listProducts(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            default:
                listProducts(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        switch (action) {
            case "add":
                addProduct(request, response);
                break;
            case "edit":
                editProduct(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/products");
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        syncProductImages(request);
        List<Product> products = productService.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = productService.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        syncProductImages(request);
        Integer id = parseInt(request.getParameter("id"));
        if (id == null) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        Product product = productService.getProductById(id);
        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        List<Category> categories = productService.getAllCategories();
        request.setAttribute("product", product);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        StringBuilder errorMsg = new StringBuilder();
        Product product = extractProductFromRequest(request, errorMsg, null);

        if (product != null && productService.addProduct(product)) {
            request.getSession().setAttribute("success", "Product added successfully!");
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } else {
            request.setAttribute("error", errorMsg.toString());
            request.setAttribute("product", product);
            showAddForm(request, response);
        }
    }

    private void editProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Integer id = parseInt(request.getParameter("id"));
        if (id == null) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        Product existingProduct = productService.getProductById(id);
        if (existingProduct == null) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        StringBuilder errorMsg = new StringBuilder();
        Product updatedProduct = extractProductFromRequest(request, errorMsg, existingProduct);

        if (updatedProduct != null && productService.updateProduct(updatedProduct)) {
            request.getSession().setAttribute("success", "Product updated successfully!");
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } else {
            request.setAttribute("error", errorMsg.toString());
            if (updatedProduct == null) {
                updatedProduct = existingProduct;
            }
            List<Category> categories = productService.getAllCategories();
            request.setAttribute("product", updatedProduct);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = parseInt(request.getParameter("id"));

        if (id != null) {
            try {
                Product product = productService.getProductById(id);
                if (product == null) {
                    request.getSession().setAttribute("error", "Product not found.");
                    response.sendRedirect(request.getContextPath() + "/admin/products");
                    return;
                }

                // Store image filename before deletion
                String imageFileName = product.getImage();

                // Delete from database first
                if (productService.deleteProduct(id)) {
                    // Delete image file if it exists
                    if (imageFileName != null && !imageFileName.isEmpty()) {
                        boolean imageDeleted = ImageUtil.deleteImage(imageFileName, request.getServletContext().getRealPath("/"));
                        if (!imageDeleted) {
                            System.err.println("Warning: Failed to delete image file: " + imageFileName);
                        }
                    }
                    request.getSession().setAttribute("success", "Product deleted successfully!");
                    System.out.println("Product deleted successfully: ID=" + id);
                } else {
                    request.getSession().setAttribute("error", "Failed to delete product from database.");
                    System.err.println("Failed to delete product from database: ID=" + id);
                }
            } catch (Exception e) {
                request.getSession().setAttribute("error", "Error deleting product: " + e.getMessage());
                System.err.println("Error deleting product: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            request.getSession().setAttribute("error", "Invalid product ID.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }

    private Product extractProductFromRequest(HttpServletRequest request, StringBuilder errorMsg, Product product)
            throws IOException, ServletException {

        String name = trim(request.getParameter("name"));
        String description = trim(request.getParameter("description"));
        String brand = trim(request.getParameter("brand"));
        String status = trim(request.getParameter("status"));

        BigDecimal price = parseBigDecimal(request.getParameter("price"));
        Integer stock = parseInt(request.getParameter("stock"));
        Integer categoryId = parseInt(request.getParameter("categoryId"));

        String contextPath = request.getServletContext().getRealPath("/");
        String existingImage = product != null ? product.getImage() : null;
        String imageFileName = existingImage;
        boolean removeImage = "on".equalsIgnoreCase(trim(request.getParameter("removeImage")));

        if (removeImage && existingImage != null && !existingImage.isEmpty()) {
            ImageUtil.deleteImage(existingImage, contextPath);
            imageFileName = null;
        }

        jakarta.servlet.http.Part imagePart = request.getPart("image");
        if (imagePart != null && imagePart.getSize() > 0) {
            String originalName = ImageUtil.getSubmittedFileName(imagePart);
            try (InputStream is = imagePart.getInputStream()) {
                // Store uploaded files with the product name so Git shows clear image names.
                String savedName = ImageUtil.updateImage(is, originalName, existingImage, contextPath, name, brand);
                if (savedName != null) {
                    imageFileName = savedName;
                } else {
                    errorMsg.append("Invalid image file. Use JPG, PNG, GIF, or WEBP. ");
                }
            }
        }

        if (name.isEmpty()) errorMsg.append("Product name is required. ");
        if (price == null || price.compareTo(BigDecimal.ZERO) < 0) errorMsg.append("Valid price is required. ");
        if (stock == null || stock < 0) errorMsg.append("Valid stock is required. ");
        if (categoryId == null) errorMsg.append("Valid category is required. ");

        if (errorMsg.length() > 0) return null;

        if (product == null) {
            product = new Product();
            product.setStatus("active");
        } else {
            Integer productId = parseInt(request.getParameter("id"));
            if (productId != null) {
                product.setProductId(productId);
            }
        }

        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setStock(stock);
        product.setCategoryId(categoryId);
        product.setBrand(brand);

        if (!status.isEmpty()) {
            product.setStatus(status);
        }

        if (imageFileName != null) {
            product.setImage(imageFileName);
        } else if (removeImage) {
            product.setImage(null);
        }

        return product;
    }

    private Integer parseInt(String value) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return null;
        }
    }

    private BigDecimal parseBigDecimal(String value) {
        try {
            return new BigDecimal(value);
        } catch (Exception e) {
            return null;
        }
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }

    private void syncProductImages(HttpServletRequest request) {
        String contextPath = request.getServletContext().getRealPath("/");
        ImageUtil.syncImagesToRuntime(contextPath);
        productService.syncProductImages(contextPath);
    }
}
