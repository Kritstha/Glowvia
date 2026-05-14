<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.glowvia.model.Brand" %>
<%@ page import="com.glowvia.model.Product" %>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin_products.css">

<%
    String error = (String) request.getAttribute("error");
    String message = (String) request.getAttribute("message");
    Product product = (Product) request.getAttribute("product");
    List<Brand> brands = (List<Brand>) request.getAttribute("brands");

    if (product == null) {
%>
    <div class="alert alert-error">
        Product not found. Please go back to the product list.
    </div>

    <div class="form-actions">
        <a href="<%= request.getContextPath() %>/admin/products" class="btn-primary">
            Back to Products
        </a>
    </div>
<%
        return;
    }
%>

<div class="product-form-card">

    <div class="form-header">
        <h3>Edit Product</h3>
        <p>Update the product details below</p>
    </div>

    <div class="form-container">

        <form action="<%= request.getContextPath() %>/admin/products/edit"
              method="post"
              enctype="multipart/form-data">

            <!-- FIXED: productId -->
            <input type="hidden" name="id" value="<%= product.getProductId() %>">

            <div class="form-grid">

                <div class="form-field">
                    <label class="form-label">Product Name <span>*</span></label>
                    <input type="text" name="productName" class="form-input" required
                           value="<%= product.getName() %>">
                </div>

                <div class="form-field">
                    <label class="form-label">Brand <span>*</span></label>
                    <select name="brandId" class="form-select" required>

                        <option value="">Select a brand</option>

                        <%
                            if (brands != null && !brands.isEmpty()) {
                                for (Brand brand : brands) {
                        %>

                        <!-- FIXED: brandId instead of id -->
                        <option value="<%= brand.getBrand_id() %>"
                            <%= (product.getBrandId() == brand.getBrand_id()) ? "selected" : "" %>>

                            <%= brand.getName() %>

                        </option>

                        <%
                                }
                            } else {
                        %>

                        <option value="" disabled>No brands available</option>

                        <%
                            }
                        %>

                    </select>
                </div>

                <div class="form-field">
                    <label class="form-label">Category <span>*</span></label>
                    <select name="category" class="form-select" required>

                        <option value="">Select category</option>

                        <option value="Cleanser" <%= "Cleanser".equals(product.getCategory()) ? "selected" : "" %>>Cleanser</option>
                        <option value="Toner" <%= "Toner".equals(product.getCategory()) ? "selected" : "" %>>Toner</option>
                        <option value="Serum" <%= "Serum".equals(product.getCategory()) ? "selected" : "" %>>Serum</option>
                        <option value="Moisturizer" <%= "Moisturizer".equals(product.getCategory()) ? "selected" : "" %>>Moisturizer</option>
                        <option value="Sunscreen" <%= "Sunscreen".equals(product.getCategory()) ? "selected" : "" %>>Sunscreen</option>
                        <option value="Mask" <%= "Mask".equals(product.getCategory()) ? "selected" : "" %>>Mask</option>
                        <option value="Exfoliator" <%= "Exfoliator".equals(product.getCategory()) ? "selected" : "" %>>Exfoliator</option>
                        <option value="Eye Cream" <%= "Eye Cream".equals(product.getCategory()) ? "selected" : "" %>>Eye Cream</option>
                        <option value="Oil" <%= "Oil".equals(product.getCategory()) ? "selected" : "" %>>Facial Oil</option>

                    </select>
                </div>

                <div class="form-field">
                    <label class="form-label">Skin Type</label>
                    <select name="skinType" class="form-select">

                        <option value="">All skin types</option>

                        <option value="All" <%= "All".equals(product.getSkinType()) ? "selected" : "" %>>All</option>
                        <option value="Dry" <%= "Dry".equals(product.getSkinType()) ? "selected" : "" %>>Dry</option>
                        <option value="Oily" <%= "Oily".equals(product.getSkinType()) ? "selected" : "" %>>Oily</option>
                        <option value="Combination" <%= "Combination".equals(product.getSkinType()) ? "selected" : "" %>>Combination</option>
                        <option value="Normal" <%= "Normal".equals(product.getSkinType()) ? "selected" : "" %>>Normal</option>
                        <option value="Sensitive" <%= "Sensitive".equals(product.getSkinType()) ? "selected" : "" %>>Sensitive</option>

                    </select>
                </div>

                <div class="form-field">
                    <label class="form-label">Price (NPR) <span>*</span></label>
                    <input type="number" name="price" class="form-input" step="0.01" min="0" required
                           value="<%= product.getPrice() %>">
                </div>

                <div class="form-field">
                    <label class="form-label">Stock Quantity <span>*</span></label>
                    <input type="number" name="stockQuantity" class="form-input" min="0" required
                           value="<%= product.getStockQuantity() %>">
                </div>

                <div class="form-field full-width">
                    <label class="form-label">Key Ingredients</label>
                    <input type="text" name="keyIngredients" class="form-input"
                           value="<%= product.getKeyIngredients() %>">
                </div>

                <div class="form-field full-width">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-textarea"><%= product.getDescription() %></textarea>
                </div>

                <% if (product.getPhotoPath() != null && !product.getPhotoPath().isEmpty()) { %>
                <div class="form-field full-width">
                    <label class="form-label">Current Photo</label>
                    <div class="current-photo">
                        <img src="<%= request.getContextPath() %>/<%= product.getPhotoPath() %>">
                    </div>
                </div>
                <% } %>

                <div class="form-field full-width">
                    <label class="form-label">Change Photo</label>
                    <input type="file" name="productPhoto" class="form-input" accept="image/*">
                </div>

            </div>

            <div class="form-actions">
                <a href="<%= request.getContextPath() %>/admin/products" class="btn-secondary">
                    Cancel
                </a>

                <button type="submit" class="btn-primary">
                    Update Product
                </button>
            </div>

        </form>

    </div>

</div>