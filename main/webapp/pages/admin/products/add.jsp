<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.glowvia.model.Brand" %>
 <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin_products.css">

<%
    String error = (String) request.getAttribute("error");
    List<Brand> brands = (List<Brand>) request.getAttribute("brands");
%>

<jsp:include page="/includes/admin_product_top_nav.jsp" />

<div class="product-form-card">
    <div class="form-header">
        <h3>Add New Product</h3>
        <p>Fill in the details below to add a new skincare product to your catalog</p>
    </div>
    
    <div class="form-container">
        <form action="/skincare/admin/products/add" method="post" enctype="multipart/form-data">
            <div class="form-grid">
                <div class="form-field">
                    <label class="form-label" for="productName">Product Name <span>*</span></label>
                    <input type="text" id="productName" name="productName" class="form-input" required 
                           placeholder="e.g., Vitamin C Serum">
                </div>
                
                <div class="form-field">
                    <label class="form-label" for="brandId">Brand <span>*</span></label>
                    <select id="brandId" name="brandId" class="form-select" required>
                        <option value="">Select a brand</option>
                        <% if (brands != null && !brands.isEmpty()) {
                            for (Brand brand : brands) { %>
                                <option value="<%= brand.getBrand_id() %>"><%= brand.getName() %></option>
                        <%   }
                           } else { %>
                            <option value="" disabled>No brands available</option>
                        <% } %>
                    </select>
                </div>
                
                <div class="form-field">
                    <label class="form-label" for="category">Category <span>*</span></label>
                    <select id="category" name="category" class="form-select" required>
                        <option value="">Select category</option>
                        <option value="Cleanser">Cleanser</option>
                        <option value="Toner">Toner</option>
                        <option value="Serum">Serum</option>
                        <option value="Moisturizer">Moisturizer</option>
                        <option value="Sunscreen">Sunscreen</option>
                        <option value="Mask">Mask</option>
                        <option value="Exfoliator">Exfoliator</option>
                        <option value="Eye Cream">Eye Cream</option>
                        <option value="Oil">Facial Oil</option>
                    </select>
                </div>
                
                <div class="form-field">
                    <label class="form-label" for="skinType">Skin Type</label>
                    <select id="skinType" name="skinType" class="form-select">
                        <option value="">All skin types</option>
                        <option value="All">All skin types</option>
                        <option value="Dry">Dry</option>
                        <option value="Oily">Oily</option>
                        <option value="Combination">Combination</option>
                        <option value="Normal">Normal</option>
                        <option value="Sensitive">Sensitive</option>
                    </select>
                </div>
                
                <div class="form-field">
                    <label class="form-label" for="price">Price (NPR) <span>*</span></label>
                    <div class="price-input-group">
                        <input type="number" id="price" name="price" class="form-input" step="0.01" min="0" required 
                               placeholder="29.99">
                    </div>
                </div>
                
                <div class="form-field">
                    <label class="form-label" for="stockQuantity">Stock Quantity <span>*</span></label>
                    <input type="number" id="stockQuantity" name="stockQuantity" class="form-input" min="0" required 
                           placeholder="100">
                </div>
                
                <div class="form-field full-width">
                    <label class="form-label" for="keyIngredients">Key Ingredients</label>
                    <input type="text" id="keyIngredients" name="keyIngredients" class="form-input" 
                           placeholder="e.g., Vitamin C, Hyaluronic Acid, Niacinamide">
                    <div class="input-help">Separate ingredients with commas</div>
                </div>
                
                <div class="form-field full-width">
                    <label class="form-label" for="description">Description</label>
                    <textarea id="description" name="description" class="form-textarea" 
                              placeholder="Describe the product benefits, usage instructions, and features..."></textarea>
                </div>
                
                <div class="form-field full-width">
                    <label class="form-label" for="productPhoto">Product Photo</label>
                    <div class="file-input-wrapper">
                        <input type="file" id="productPhoto" name="productPhoto" class="file-input" accept="image/jpeg,image/png,image/jpg">
                    </div>
                    <div class="input-help">Upload JPG or PNG image (max 5MB)</div>
                </div>
            </div>
            
            <div class="form-actions">
                <a href="/skincare/admin/products" class="btn-secondary">Cancel</a>
                <button type="submit" class="btn-primary">Add Product</button>
            </div>
        </form>
    </div>
</div>