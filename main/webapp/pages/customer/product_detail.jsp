<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.glowvia.model.Product" %>

<link rel="stylesheet" type="text/css" href="/skincare/css/customer_product_detail.css">
    
<%
    Product product = (Product) request.getAttribute("product");
    if (product == null) {
        response.sendRedirect(request.getContextPath() + "/products");
        return;
    }
    
    String imagePath = product.getPhotoPath();
    if (imagePath == null || imagePath.isEmpty()) {
        imagePath = "/skincare/images/placeholder.jpg";
    }
    
    int stockQuantity = product.getStockQuantity();
    String stockStatus = "";
    String stockClass = "";
    String stockMessage = "";
    
    if (stockQuantity > 10) {
        stockStatus = "in-stock";
        stockClass = "in-stock";
        stockMessage = "In Stock";
    } else if (stockQuantity > 0) {
        stockStatus = "low-stock";
        stockClass = "low-stock";
        stockMessage = "Low Stock - Only " + stockQuantity + " left!";
    } else {
        stockStatus = "out-of-stock";
        stockClass = "out-of-stock";
        stockMessage = "Out of Stock";
    }
    
    // Get any messages from session
    String successMessage = (String) session.getAttribute("message");
    String errorMessage = (String) request.getAttribute("error_message");
    
    if (successMessage != null) {
        session.removeAttribute("message");
    }
%>

<div class="container">
    <!-- Breadcrumb -->
    <div style="margin: 20px 0;">
        <a href="<%= request.getContextPath() %>/products" style="color: #8A8176; text-decoration: none;">Products</a>
        <span style="color: #8A8176; margin: 0 8px;">/</span>
        <span style="color: #2D2A24;"><%= product.getName() %></span>
    </div>
    
    <!-- Display Messages -->
    <% if (successMessage != null) { %>
        <div style="background-color: #d4edda; color: #155724; padding: 10px; margin-bottom: 20px; border-radius: 5px;">
            ✓ <%= successMessage %>
        </div>
    <% } %>
    
    <% if (errorMessage != null) { %>
        <div style="background-color: #f8d7da; color: #721c24; padding: 10px; margin-bottom: 20px; border-radius: 5px;">
            ⚠ <%= errorMessage %>
        </div>
    <% } %>
    
    <div class="product-detail">
        <!-- Product Gallery -->
        <div class="product-gallery">
            <div class="main-image">
                <img src="<%= request.getContextPath() %>/<%= imagePath %>" 
                     alt="<%= product.getName() %>">
            </div>
        </div>
        
        <!-- Product Info -->
        <div class="product-info">
            <h1><%= product.getName() %></h1>
            <span class="brand-name"><%= product.getBrandName() != null ? product.getBrandName() : "GlowVia" %></span>
            
            <div class="price-section">
                <span class="current-price">$<%= String.format("%.2f", product.getPrice()) %></span>
            </div>
            
            <!-- Stock Status -->
            <div class="stock-status <%= stockClass %>">
                <span class="stock-badge <%= stockClass %>"></span>
                <%= stockMessage %>
            </div>
            
            <% if (stockQuantity > 0) { %>
                <!-- Add to Cart Form -->
                <div class="action-buttons">
                    <form action="<%= request.getContextPath() %>/cart/add" method="post">
                        <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                        
                        <div class="quantity-selector">
                            <span class="quantity-label">Quantity:</span>
                            <div class="quantity-controls">
                                <select name="quantity" class="quantity-input" style="padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                                    <% for (int i = 1; i <= stockQuantity; i++) { %>
                                        <option value="<%= i %>"><%= i %></option>
                                    <% } %>
                                  
                                </select>
                            </div>
                            <span style="color: #8A8176; font-size: 0.85rem;">
                                <%= stockQuantity %> items available
                            </span>
                        </div>
                        
                        <div style="margin-top: 20px;">
                            <button type="submit" class="btn-primary btn-large">Add to Cart</button>
                        </div>
                    </form>
                </div>
            <% } else { %>
                <div class="alert alert-warning">
                    ⚠️ This product is currently out of stock. Please check back later.
                </div>
            <% } %>
            
            <!-- Product Meta Info -->
            <div class="product-meta">
                <div class="meta-item">
                    <span class="meta-icon">✓</span>
                    <span>Free shipping on orders over $50</span>
                </div>
                <div class="meta-item">
                    <span class="meta-icon">↺</span>
                    <span>30-day return policy</span>
                </div>
                <div class="meta-item">
                    <span class="meta-icon">🔒</span>
                    <span>Secure checkout</span>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Product Description -->
    <div class="description-section">
        <h3>Product Description</h3>
        <div class="description-text">
            <%= product.getDescription() != null ? product.getDescription() : "No description available." %>
        </div>
    </div>
    
    <!-- Additional Info Grid -->
    <div class="info-grid">
        <div class="info-card">
            <h4>Skin Type</h4>
            <p><%= product.getSkinType() != null ? product.getSkinType() : "All skin types" %></p>
        </div>
        <div class="info-card">
            <h4>Category</h4>
            <p><%= product.getCategory() != null ? product.getCategory() : "Skincare" %></p>
        </div>
        <div class="info-card">
            <h4>Key Ingredients</h4>
            <div class="ingredients-list">
                <% 
                    String ingredients = product.getKeyIngredients();
                    if (ingredients != null && !ingredients.trim().isEmpty()) {
                        String[] ingredientArray = ingredients.split(",");
                        for (String ingredient : ingredientArray) {
                %>
                    <span class="ingredient-tag"><%= ingredient.trim() %></span>
                <%
                        }
                    } else {
                %>
                    <span class="ingredient-tag">Hyaluronic Acid</span>
                    <span class="ingredient-tag">Vitamin C</span>
                    <span class="ingredient-tag">Niacinamide</span>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</div>