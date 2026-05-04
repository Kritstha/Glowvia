<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.glowvia.model.Brand" %>

<link rel="stylesheet" type="text/css" href="/skincare/css/admin_brands.css">


<%
    List<Brand> brands = (List<Brand>) request.getAttribute("brands");
    
    String editId = request.getParameter("editId");
    String editName = request.getParameter("editName");
    String editContact = request.getParameter("editContact");
    boolean showEditModal = editId != null && editId.trim().length() > 0;
%>

<div class="brand-dashboard">
    <div class="add-card">
        <h3>Add new brand</h3>
        <p>Register a skincare or beauty brand with contact details.</p>
        
        <form action="/skincare/admin/brands" method="post">
            <input type="hidden" name="action" value="add">
            <div class="form-group">
                <label>Brand name *</label>
                <input type="text" name="brandName" placeholder="e.g., Drunk Elephant" autocomplete="off" required>
            </div>
            <div class="form-group">
                <label>Contact</label>
                <input name="contactInfo" rows="2" placeholder="Email, phone, website, social..."></input>
            </div>
            <button type="submit" class="btn-submit">+ Add brand</button>
        </form>
    </div>

    <div class="brands-list-card">
        <div class="list-header">
            <h3>All brands</h3>
            <span class="brand-count">
                <% if (brands == null || brands.isEmpty()) { %>
                    0 brands
                <% } else { %>
                    <%= brands.size() %> brand<%= brands.size() != 1 ? "s" : "" %>
                <% } %>
            </span>
        </div>
        <div class="brands-table">
            <% if (brands == null || brands.isEmpty()) { %>
                <div class="empty-state">No brands yet. Use the left form to add your first brand.</div>
            <% } else { %>
                <div class="table-row header-row">
                    <div>Brand name</div>
                    <div>Contact / Details</div>
                    <div class="action-cell">Action</div>
                </div>
                <% for (Brand brand : brands) { %>
                    <div class="table-row">
                        <div class="brand-name-cell"><%= brand.getName() != null ? brand.getName() : "" %></div>
                        <div class="contact-cell"><%= brand.getContact() != null ? brand.getContact() : "" %></div>
                        <div class="action-cell">
           
                            <a href="#editModal-<%= brand.getId() %>" class="edit-btn">Edit</a>
                            
 
                            <form action="/skincare/admin/brands" method="post" style="display:inline;" 
                                  onsubmit="return confirm('Delete <%= brand.getName() != null ? brand.getName().replace("'", "\\'") : "this brand" %>? This action cannot be undone.');">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="brandId" value="<%= brand.getId() %>">
                                <button type="submit" class="delete-brand-btn">Delete</button>
                            </form>
                        </div>
                    </div>
                    
                    <div id="editModal-<%= brand.getId() %>" class="modal-overlay">
                        <div class="modal-container">
                            <h4>Edit brand</h4>
                            <form action="/skincare/admin/brands" method="post">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="brandId" value="<%= brand.getId() %>">
                                <div class="form-group">
                                    <label>Brand name *</label>
                                    <input type="text" name="brandName" value="<%= brand.getName() != null ? brand.getName() : "" %>" required>
                                </div>
                                <div class="form-group">
                                    <label>Contact / Info</label>
                     <input name="contactInfo" value="<%= brand.getContact() != null ? brand.getContact() : "" %>">
                                </div>
                                <div class="modal-actions">
                                    <a href="/skincare/admin/brands" class="modal-cancel">Cancel</a>
                                    <button type="submit" class="modal-save">Save changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                <% } %>
            <% } %>
        </div>
    </div>
</div>
