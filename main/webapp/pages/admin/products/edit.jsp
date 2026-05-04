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
        <a href="<%= request.getContextPath() %>/admin/products/list" class="btn-primary">Back to Products</a>
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
        <form action="<%= request.getContextPath() %>/admin/products/edit" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= product.getId() %>">
            
            <div class="form-grid">
                <div class="form-field">
                    <label class="form-label" for="productName">Product Name <span>*</span></label>
                    <input type="text" id="productName" name="productName" class="form-input" required 
                           value="<%= product.getName() != null ? product.getName().replace("\"", "&quot;") : "" %>"
                           placeholder="e.g., Vitamin C Serum">
                </div>
                
                <div class="form-field">
                    <label class="form-label" for="brandId">Brand <span>*</span></label>
                    <select id="brandId" name="brandId" class="form-select" required>
                        <option value="">Select a brand</option>
                        <% if (brands != null && !brands.isEmpty()) {
                            for (Brand brand : brands) { %>
                                <option value="<%= brand.getId() %>" <%= (product.getBrandId() == brand.getId()) ? "selected" : "" %>>
                                    <%= brand.getName() %>
                                </option>
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
                    <label class="form-label" for="skinType">Skin Type</label>
                    <select id="skinType" name="skinType" class="form-select">
                        <option value="">All skin types</option>
                        <option value="All" <%= "All".equals(product.getSkinType()) ? "selected" : "" %>>All skin types</option>
                        <option value="Dry" <%= "Dry".equals(product.getSkinType()) ? "selected" : "" %>>Dry</option>
                        <option value="Oily" <%= "Oily".equals(product.getSkinType()) ? "selected" : "" %>>Oily</option>
                        <option value="Combination" <%= "Combination".equals(product.getSkinType()) ? "selected" : "" %>>Combination</option>
                        <option value="Normal" <%= "Normal".equals(product.getSkinType()) ? "selected" : "" %>>Normal</option>
                        <option value="Sensitive" <%= "Sensitive".equals(product.getSkinType()) ? "selected" : "" %>>Sensitive</option>
                    </select>
                </div>
                
                <div class="form-field">
                    <label class="form-label" for="price">Price (USD) <span>*</span></label>
                    <div class="price-input-group">
                        <span class="price-symbol">$</span>
                        <input type="number" id="price" name="price" class="form-input" step="0.01" min="0" required 
                               value="<%= product.getPrice() %>" placeholder="29.99">
                    </div>
                </div>
                
                <div class="form-field">
                    <label class="form-label" for="stockQuantity">Stock Quantity <span>*</span></label>
                    <input type="number" id="stockQuantity" name="stockQuantity" class="form-input" min="0" required 
                           value="<%= product.getStockQuantity() %>" placeholder="100">
                </div>
                
                <div class="form-field full-width">
                    <label class="form-label" for="keyIngredients">Key Ingredients</label>
                    <input type="text" id="keyIngredients" name="keyIngredients" class="form-input" 
                           value="<%= product.getKeyIngredients() != null ? product.getKeyIngredients().replace("\"", "&quot;") : "" %>"
                           placeholder="e.g., Vitamin C, Hyaluronic Acid, Niacinamide">
                    <div class="input-help">Separate ingredients with commas</div>
                </div>
                
                <div class="form-field full-width">
                    <label class="form-label" for="description">Description</label>
                    <textarea id="description" name="description" class="form-textarea" 
                              placeholder="Describe the product benefits, usage instructions, and features..."><%= product.getDescription() != null ? product.getDescription() : "" %></textarea>
                </div>
                
                <% if (product.getPhotoPath() != null && !product.getPhotoPath().isEmpty()) { %>
                <div class="form-field full-width">
                    <label class="form-label">Current Photo</label>
                    <div class="current-photo">
                        <img src="<%= request.getContextPath() %>/<%= product.getPhotoPath() %>" alt="Current product photo">
                        <div class="current-photo-info">
                            <div class="current-photo-label">Current image</div>
                            <div class="current-photo-name"><%= product.getPhotoPath().substring(product.getPhotoPath().lastIndexOf("/") + 1) %></div>
                        </div>
                    </div>
                </div>
                <% } %>
                
                <div class="form-field full-width">
                    <label class="form-label" for="productPhoto">Change Photo (Optional)</label>
                    <div class="file-input-wrapper">
                        <input type="file" id="productPhoto" name="productPhoto" class="file-input" accept="image/jpeg,image/png,image/jpg">
                    </div>
                    <div class="input-help">Upload a new JPG or PNG image to replace the current one (max 5MB). Leave empty to keep the current photo.</div>
                </div>
            </div>
            
            <div class="form-actions">
                <a href="<%= request.getContextPath() %>/admin/products" class="btn-secondary">Cancel</a>
                <button type="submit" class="btn-primary">Update Product</button>
            </div>
        </form>
    </div>
</div>

<script>
document.getElementById('productPhoto')?.addEventListener('change', function(e) {
    const fileName = e.target.files[0]?.name;
    if (fileName) {
        let fileNameDisplay = document.querySelector('.file-name');
        if (!fileNameDisplay) {
            fileNameDisplay = document.createElement('div');
            fileNameDisplay.className = 'file-name';
            e.target.parentNode.appendChild(fileNameDisplay);
        }
        fileNameDisplay.textContent = `Selected: ${fileName}`;
    }
});
</script>