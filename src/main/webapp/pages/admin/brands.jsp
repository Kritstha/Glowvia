<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.glowvia.model.Brand" %>

 <link rel="stylesheet" type="text/css" href="/skincare/css/admin_brands.css">

<%
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
    List<Brand> brands = (List<Brand>) request.getAttribute("brands");
%>

<div class="brand-dashboard">
    <div class="add-card">
        <h3>Add new brand</h3>
        <p>Register a skincare or beauty brand with contact details.</p>
        
        <form id="addBrandForm" action="/skincare/admin/brands" method="post">
            <input type="hidden" name="action" value="add">
            <div class="form-group">
                <label>Brand name *</label>
                <input type="text" name="brandName" id="addBrandName" placeholder="e.g., Drunk Elephant" autocomplete="off" required>
            </div>
            <div class="form-group">
                <label>Contact</label>
                <input name="contactInfo" id="addContactInfo" rows="2" placeholder="Email, phone, website, social..."></input>
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
                    <div class="table-row" data-brand-id="<%= brand.getId() %>">
                        <div class="brand-name-cell"><%= brand.getName() != null ? brand.getName() : "" %></div>
                        <div class="contact-cell"><%= brand.getContact() != null ? brand.getContact() : "" %></div>
                        <div class="action-cell">
                            <button type="button" class="edit-btn" onclick="openEditModal('<%= brand.getId() %>', '<%= brand.getName() != null ? brand.getName().replace("'", "\\'") : "" %>', '<%= brand.getContact() != null ? brand.getContact().replace("'", "\\'") : "" %>')">Edit</button>
                            <form action="/skincare/admin/brands" method="post" style="display:inline;" class="delete-form" data-brand-name="<%= brand.getName() != null ? brand.getName() : "" %>">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="brandId" value="<%= brand.getId() %>">
                                <button type="submit" class="delete-brand-btn">Delete</button>
                            </form>
                        </div>
                    </div>
                <% } %>
            <% } %>
        </div>
    </div>
</div>

<div id="editModal" class="modal-overlay">
    <div class="modal-container">
        <h4>Edit brand</h4>
        <form id="editBrandForm" action="/skincare/admin/brands" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="brandId" id="editBrandId">
            <div class="form-group">
                <label>Brand name *</label>
                <input type="text" name="brandName" id="editBrandName" required>
            </div>
            <div class="form-group">
                <label>Contact / Info</label>
                <input name="contactInfo" id="editContactInfo" rows="3"></input>
            </div>
            <div class="modal-actions">
                <button type="button" class="modal-cancel" onclick="closeEditModal()">Cancel</button>
                <button type="submit" class="modal-save">Save changes</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openEditModal(brandId, brandName, contactInfo) {
        document.getElementById('editBrandId').value = brandId;
        document.getElementById('editBrandName').value = brandName;
        document.getElementById('editContactInfo').value = contactInfo || '';
        document.getElementById('editModal').classList.add('active');
    }
    
    function closeEditModal() {
        document.getElementById('editModal').classList.remove('active');
    }

    window.addEventListener('DOMContentLoaded', function() {
        const serverMessage = '<%= message != null ? message.replace("'", "\\'") : "" %>';
        const serverError = '<%= error != null ? error.replace("'", "\\'") : "" %>';
        
        if (serverMessage && serverMessage.trim() !== '') {
            showToast(serverMessage, 'success');
        }
        
        if (serverError && serverError.trim() !== '') {
            showToast(serverError, 'error');
        }
        
        const deleteForms = document.querySelectorAll('.delete-form');
        
        deleteForms.forEach(form => {
            form.addEventListener('submit', function(e) {
                const brandName = this.getAttribute('data-brand-name') || 'this brand';
                if (!confirm(`Delete ${brandName}? This action cannot be undone.`)) {
                    e.preventDefault();
                } else {
                    showToast(`Deleting ${brandName}...`, 'success');
                }
            });
        });
        

        const editForm = document.getElementById('editBrandForm');
        if (editForm) {
            editForm.addEventListener('submit', function(e) {
                const brandName = document.getElementById('editBrandName').value.trim();
                if (!brandName) {
                    e.preventDefault();
                    showToast('Brand name cannot be empty', 'error');
                    return;
                }
                showToast('Updating brand...', 'success');
            });
        }

        const modal = document.getElementById('editModal');
        if (modal) {
            modal.addEventListener('click', function(e) {
                if (e.target === modal) {
                    closeEditModal();
                }
            });

            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape' && modal.classList.contains('active')) {
                    closeEditModal();
                }
            });
        }
    });
	//<% %> -  dobot use.  
	//use expression langgae - ${}
    // i did this to make the url pretty and remove the query parameters
    (function handleUrlMessages() {
        const urlParams = new URLSearchParams(window.location.search);
        const urlMessage = urlParams.get('message');
        const urlError = urlParams.get('error');
        
        if (urlMessage) {
            showToast(decodeURIComponent(urlMessage), 'success');

            const newUrl = window.location.pathname;
            window.history.replaceState({}, document.title, newUrl);
        }
        
        if (urlError) {
            showToast(decodeURIComponent(urlError), 'error');
            const newUrl = window.location.pathname;
            window.history.replaceState({}, document.title, newUrl);
        }
    })();
</script>