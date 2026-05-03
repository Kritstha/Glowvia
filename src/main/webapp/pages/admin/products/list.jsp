<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.glowvia.model.Product" %>
<%@ page import="com.glowvia.model.Brand" %>
 <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin_products.css">

<%
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
    List<Product> products = (List<Product>) request.getAttribute("products");
%>

<jsp:include page="/includes/admin_product_top_nav.jsp" />

<div class="products-list-card">
    <div class="list-header">
        <h3>All products</h3>
        <span class="product-count">
            <% if (products == null || products.isEmpty()) { %>
                0 products
            <% } else { %>
                <%= products.size() %> product<%= products.size() != 1 ? "s" : "" %>
            <% } %>
        </span>
    </div>
    
    <div class="table-wrapper">
        <table class="products-table">
            <thead>
                <tr>
                    <th style="width: 70px">Photo</th>
                    <th>Product name</th>
                    <th>Brand</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th style="width: 140px">Actions</th>
                </tr>
            </thead>
            <tbody>
                <% if (products == null || products.isEmpty()) { %>
                    <tr>
                        <td colspan="7" class="empty-state-table">
                            ✨ No products yet.
                        </td>
                    </tr>
                <% } else { 
                    for (Product product : products) { 
                        String productNameClean = product.getName() != null ? product.getName() : "";
                        String brandName = product.getBrandName() != null ? product.getBrandName() : "Unknown Brand";
                        String category = product.getCategory() != null ? product.getCategory() : "Uncategorized";
                        String photoPath = product.getPhotoPath();
                %>
                    <tr>
                        <td class="product-thumb">
                            <% if (photoPath != null && !photoPath.isEmpty()) { %>
                                <img class="thumbnail-img" src="/skincare/<%= photoPath %>" alt="<%= productNameClean %>">
                            <% } else { %>
                                <div class="no-thumb">No Image</div>
                            <% } %>
                        </td>
                        <td class="product-name-cell"><%= productNameClean %></td>
                        <td><span class="brand-text"><%= brandName %></span></td>
                        <td><span class="type-badge-table"><%= category %></span></td>
                        <td>$<%= String.format("%.2f", product.getPrice()) %></td>
                        <td class="<%= product.getStockQuantity() <= 5 ? "low-stock" : "" %>">
                            <%= product.getStockQuantity() %>
                            <% if (product.getStockQuantity() <= 0) { %>
                                <span class="stock-badge out">Out of stock</span>
                            <% } else if (product.getStockQuantity() <= 5) { %>
                                <span class="stock-badge low">Low stock</span>
                            <% } %>
                        </td>
                        <td>
							<div class="action-buttons">
							    <a href="/skincare/admin/products/edit?id=<%= product.getId() %>" class="edit-link">Edit</a>
							    <a href="/skincare/admin/products/delete?id=<%= product.getId() %>" 
							       class="delete-btn" 
							       onclick="return confirm('Delete this product?');">Delete</a>
							</div>
                        </td>
                    </tr>
                <% } 
                } %>
            </tbody>
        </table>
    </div>
</div>