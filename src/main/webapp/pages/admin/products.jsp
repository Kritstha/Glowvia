<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.glowvia.model.Product" %>
<%@ page import="com.glowvia.model.Brand" %>

<link rel="stylesheet" type="text/css" href="/skincare/css/admin_products.css">

<%
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<Brand> brands = (List<Brand>) request.getAttribute("brands");
    
    String[] productTypes = {"Moisturizer", "Cleanser", "Serum", "Toner", "Exfoliator", "Mask", "Sunscreen", "Eye Cream", "Treatment", "Other"};
%>

<div class="product-dashboard">
    <div class="add-card">
        <h3>Add new product</h3>
        <p>Register a skincare or beauty product with details and photo.</p>
        
        <form id="addProductForm" action="/skincare/admin/products" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="add">
            
            <div class="form-group">
                <label>Product name *</label>
                <input type="text" name="productName" id="addProductName" placeholder="e.g., Hydrating Serum" autocomplete="off" required>
            </div>
            
            <div class="form-group">
                <label>Brand *</label>
                <select name="brandId" id="addBrandId" required>
                    <option value="">Select a brand</option>
                    <% if (brands != null) {
                        for (Brand brand : brands) { %>
                            <option value="<%= brand.getId() %>"><%= brand.getName() %></option>
                    <% }
                    } %>
                </select>
                <% if (brands == null || brands.isEmpty()) { %>
                    <div class="field-note">No brands available. Please add a brand first.</div>
                <% } %>
            </div>
            
            <div class="form-group">
                <label>Product type *</label>
                <select name="productType" id="addProductType" required>
                    <option value="">Select product type</option>
                    <% for (String type : productTypes) { %>
                        <option value="<%= type %>"><%= type %></option>
                    <% } %>
                </select>
            </div>
            
            <div class="form-group">
                <label>Product photo</label>
                <input type="file" name="productPhoto" id="addProductPhoto" accept="image/jpeg,image/png,image/jpg,image/webp">
                <div class="field-note">Supported formats: JPEG, PNG, JPG, WEBP. Max size: 10MB</div>
            </div>
            
            <div class="image-preview" id="addPreview" style="display:none;">
                <img id="addPreviewImg" src="" alt="Preview">
            </div>
            
            <button type="submit" class="btn-submit">+ Add product</button>
        </form>
    </div>

    <div class="products-list-card">
        <div class="list-header">
            <h3>All products · List view</h3>
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
                        <th>Type</th>
                        <th style="width: 140px">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (products == null || products.isEmpty()) { %>
                        <tr>
                            <td colspan="5" class="empty-state-table">
                                ✨ No products yet. Use the left form to add your first product.
                            </td>
                        </tr>
                    <% } else { 
                        for (Product product : products) { 
                            String productNameClean = product.getName() != null ? product.getName() : "";
                            String brandName = product.getBrandName() != null ? product.getBrandName() : "Unknown Brand";
                            String productType = product.getProductType() != null ? product.getProductType() : "Uncategorized";
                            String photoPath = product.getPhotoPath();
                            String escapedName = productNameClean.replace("'", "\\'");
                    %>
                        <tr data-product-id="<%= product.getId() %>">
            
                            <td class="product-thumb">
                                <% if (photoPath != null && !photoPath.isEmpty()) { %>
                                    <img class="thumbnail-img" src="/skincare/<%= photoPath %>" alt="<%= productNameClean %>" 
                                         onerror="this.onerror=null; this.src=''; this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                    <div class="no-thumb" style="display: none;">No image</div>
                                <% } else { %>
                                    <div class="no-thumb">No Image</div>
                                <% } %>
                            </td>
                   
                            <td class="product-name-cell"><%= productNameClean %></td>
           
                            <td><span class="brand-text"><%= brandName %></span></td>
                       
                            <td><span class="type-badge-table"><%= productType %></span></td>
              
                            <td>
                            <div class="action-buttons">
                                <button type="button" class="edit-btn-table" 
                                        onclick="openEditModal('<%= product.getId() %>', '<%= escapedName %>', '<%= product.getBrandId() %>', '<%= productType %>', '<%= photoPath != null ? photoPath : "" %>')">
                                    Edit
                                </button>
                                <form action="/skincare/admin/products" method="post" style="display:inline;" class="delete-form" data-product-name="<%= productNameClean %>">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                                    <button type="submit" class="delete-product-btn">Delete</button>
                                </form>
                                </div>
                            </td>
                        </tr>
                    <% } 
                    } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div id="editModal" class="modal-overlay">
    <div class="modal-container">
        <h4>Edit product</h4>
        <form id="editProductForm" action="/skincare/admin/products" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="productId" id="editProductId">
            
            <div class="form-group">
                <label>Product name *</label>
                <input type="text" name="productName" id="editProductName" required>
            </div>
            
            <div class="form-group">
                <label>Brand *</label>
                <select name="brandId" id="editBrandId" required>
                    <option value="">Select a brand</option>
                    <% if (brands != null) {
                        for (Brand brand : brands) { %>
                            <option value="<%= brand.getId() %>"><%= brand.getName() %></option>
                    <% }
                    } %>
                </select>
            </div>
            
            <div class="form-group">
                <label>Product type *</label>
                <select name="productType" id="editProductType" required>
                    <option value="">Select product type</option>
                    <% for (String type : productTypes) { %>
                        <option value="<%= type %>"><%= type %></option>
                    <% } %>
                </select>
            </div>
            
            <div class="form-group">
                <label>Current photo</label>
                <div id="currentPhotoPreview"></div>
            </div>
            
            <div class="form-group">
                <label>Change photo (optional)</label>
                <input type="file" name="productPhoto" id="editProductPhoto" accept="image/jpeg,image/png,image/jpg,image/webp">
                <div class="field-note">Leave empty to keep current photo</div>
            </div>
            
            <div class="image-preview" id="editPreview" style="display:none;">
                <img id="editPreviewImg" src="" alt="Preview">
            </div>
            
            <div class="modal-actions">
                <button type="button" class="modal-cancel" onclick="closeEditModal()">Cancel</button>
                <button type="submit" class="modal-save">Save changes</button>
            </div>
        </form>
    </div>
</div>

<script>

    function openEditModal(productId, productName, brandId, productType, currentPhoto) {
        document.getElementById('editProductId').value = productId;
        document.getElementById('editProductName').value = productName;
        document.getElementById('editBrandId').value = brandId;
        document.getElementById('editProductType').value = productType;
        
        const currentPhotoDiv = document.getElementById('currentPhotoPreview');
        if (currentPhoto && currentPhoto !== '') {
            currentPhotoDiv.innerHTML = '<img src="/skincare/' + currentPhoto + '" alt="Current photo" style="max-width: 100px; max-height: 100px; border-radius: 12px;">';
        } else {
            currentPhotoDiv.innerHTML = '<p>No current photo</p>';
        }
        
        document.getElementById('editModal').classList.add('active');
    }
    
    function closeEditModal() {
        document.getElementById('editModal').classList.remove('active');
        document.getElementById('editPreview').style.display = 'none';
        document.getElementById('editProductPhoto').value = '';
    }
    
    // Image preview for add form
    const addPhotoInput = document.getElementById('addProductPhoto');
    if (addPhotoInput) {
        addPhotoInput.addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(event) {
                    const preview = document.getElementById('addPreview');
                    const img = document.getElementById('addPreviewImg');
                    img.src = event.target.result;
                    preview.style.display = 'block';
                };
                reader.readAsDataURL(file);
            } else {
                document.getElementById('addPreview').style.display = 'none';
            }
        });
    }
    
    // Image preview for edit form
    const editPhotoInput = document.getElementById('editProductPhoto');
    if (editPhotoInput) {
        editPhotoInput.addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(event) {
                    const preview = document.getElementById('editPreview');
                    const img = document.getElementById('editPreviewImg');
                    img.src = event.target.result;
                    preview.style.display = 'block';
                };
                reader.readAsDataURL(file);
            } else {
                document.getElementById('editPreview').style.display = 'none';
            }
        });
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
                const productName = this.getAttribute('data-product-name') || 'this product';
                if (!confirm(`Delete "${productName}"? This action cannot be undone.`)) {
                    e.preventDefault();
                }
            });
        });
        
        const editFormElem = document.getElementById('editProductForm');
        if (editFormElem) {
            editFormElem.addEventListener('submit', function(e) {
                const productName = document.getElementById('editProductName').value.trim();
                if (!productName) {
                    e.preventDefault();
                    alert('Product name cannot be empty');
                    return;
                }
            });
        }
        
        const addFormElem = document.getElementById('addProductForm');
        if (addFormElem) {
            addFormElem.addEventListener('submit', function(e) {
                const productName = document.getElementById('addProductName').value.trim();
                const brandId = document.getElementById('addBrandId').value;
                const productType = document.getElementById('addProductType').value;
                
                if (!productName) {
                    e.preventDefault();
                    alert('Product name cannot be empty');
                    return;
                }
                if (!brandId) {
                    e.preventDefault();
                    alert('Please select a brand');
                    return;
                }
                if (!productType) {
                    e.preventDefault();
                    alert('Please select a product type');
                    return;
                }
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
        
        const thumbs = document.querySelectorAll('.thumbnail-img');
        thumbs.forEach(img => {
            img.addEventListener('error', function() {
                this.style.display = 'none';
                const parent = this.parentElement;
                if (parent && parent.querySelector('.no-thumb')) {
                    parent.querySelector('.no-thumb').style.display = 'flex';
                } else {
                    const fallbackDiv = document.createElement('div');
                    fallbackDiv.className = 'no-thumb';
                    fallbackDiv.innerText = 'No Photo';
                    parent.appendChild(fallbackDiv);
                }
            });
        });
    });
    
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