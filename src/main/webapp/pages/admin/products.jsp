<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.glowvia.model.Product" %>
<%@ page import="com.glowvia.model.Brand" %>

<style>


.product-dashboard {
    display: grid;
    grid-template-columns: 380px 1fr;
    gap: 28px;
    align-items: start;
}


.add-card {
    background: white;
    border-radius: 28px;
    border: 1px solid #EEE7DE;
    padding: 28px 24px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.02);
    position: sticky;
    top: 24px;
}

.card-badge {
    display: inline-block;
    background: #F1EDE8;
    border-radius: 40px;
    padding: 4px 12px;
    font-size: 0.7rem;
    font-weight: 500;
    color: #5D5448;
    margin-bottom: 16px;
}

.add-card h3 {
    font-size: 1.35rem;
    font-weight: 500;
    margin-bottom: 8px;
    color: #2D2A24;
}

.add-card p {
    font-size: 0.8rem;
    color: #8A8176;
    margin-bottom: 24px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    font-size: 0.7rem;
    font-weight: 600;
    text-transform: uppercase;
    color: #8A8176;
    display: block;
    margin-bottom: 6px;
    letter-spacing: 0.3px;
}

.form-group input,
.form-group select {
    width: 100%;
    padding: 10px 0;
    border: none;
    border-bottom: 1.5px solid #EFEBE4;
    font-size: 0.9rem;
    background: transparent;
    outline: none;
    font-family: inherit;
    cursor: pointer;
}

.form-group select {
    appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%238A8176' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 0 center;
    padding-right: 20px;
}

.form-group input:focus,
.form-group select:focus {
    border-bottom-color: #CBB99A;
}

.form-group input[type="file"] {
    padding: 8px 0;
    border: none;
    font-size: 0.85rem;
    cursor: pointer;
}

.field-note {
    font-size: 0.7rem;
    color: #8A8176;
    margin-top: 6px;
}

.image-preview {
    margin-top: 12px;
    text-align: center;
    padding: 12px;
    background: #FBF9F6;
    border-radius: 16px;
}

.image-preview img {
    max-width: 100%;
    max-height: 150px;
    border-radius: 12px;
}

.btn-submit {
    background: #2D2A24;
    color: white;
    width: 100%;
    padding: 12px;
    border-radius: 40px;
    border: none;
    font-weight: 500;
    cursor: pointer;
    margin-top: 12px;
    transition: background 0.2s;
    font-size: 0.85rem;
}

.btn-submit:hover {
    background: #4A443C;
}


.products-list-card {
    background: white;
    border-radius: 28px;
    border: 1px solid #EEE7DE;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.02);
}

.list-header {
    padding: 20px 24px;
    border-bottom: 1px solid #EFEBE4;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 12px;
    background: white;
}

.list-header h3 {
    font-weight: 500;
    font-size: 1.2rem;
    color: #2D2A24;
}

.product-count {
    background: #F1EDE8;
    padding: 4px 12px;
    border-radius: 40px;
    font-size: 0.75rem;
    font-weight: 500;
    color: #5D5448;
}

.table-wrapper {
    overflow-x: auto;
    width: 100%;
}

.products-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 0.85rem;
    min-width: 700px;
}

.products-table th {
    text-align: left;
    padding: 16px 16px;
    background: #FBF9F6;
    color: #5D5448;
    font-weight: 600;
    font-size: 0.7rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    border-bottom: 1px solid #EFEBE4;
}

.products-table td {
    padding: 14px 16px;
    border-bottom: 1px solid #F0EDE8;
    vertical-align: middle;
    background: white;
    transition: background 0.15s ease;
}

.products-table tr:hover td {
    background: #FEFCF8;
}


.product-thumb {
    width: 52px;
    padding-right: 8px;
}

.thumbnail-img {
    width: 44px;
    height: 44px;
    object-fit: cover;
    border-radius: 12px;
    background: #FBF9F6;
    border: 1px solid #EFEBE4;
    display: block;
}

.no-thumb {
    width: 44px;
    height: 44px;
    background: #F3F0EB;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.6rem;
    color: #BAAAA0;
    border: 1px solid #EFEBE4;
}


.product-name-cell {
    font-weight: 600;
    color: #2D2A24;
    font-size: 0.9rem;
}


.brand-text {
    color: #5D5448;
    font-weight: 500;
}

.type-badge-table {
    display: inline-block;
    background: #F1EDE8;
    padding: 4px 12px;
    border-radius: 40px;
    font-size: 0.7rem;
    font-weight: 500;
    color: #5D5448;
    white-space: nowrap;
}

.action-buttons {
    display: flex;
    gap: 8px;
    align-items: center;
    justify-content: flex-start;
}
.edit-btn-table {
    background: none;
    border: 1px solid #E6DFD6;
    padding: 6px 14px;
    border-radius: 30px;
    font-size: 0.7rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s;
    color: #5D5448;
    font-family: inherit;
}

.edit-btn-table:hover {
    background: #2D2A24;
    color: white;
    border-color: #2D2A24;
}

.delete-product-btn {
    background: none;
    border: 1px solid #E6DFD6;
    padding: 6px 14px;
    border-radius: 30px;
    font-size: 0.7rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s;
    color: #D9776A;
    font-family: inherit;
}

.delete-product-btn:hover {
    background: #D9776A;
    color: white;
    border-color: #D9776A;
}

.empty-state-table {
    text-align: center;
    padding: 56px 24px;
    color: #BAAAA0;
    font-size: 0.85rem;
    background: white;
}


.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0,0,0,0.3);
    backdrop-filter: blur(3px);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 2000;
    visibility: hidden;
    opacity: 0;
    transition: all 0.2s ease;
}

.modal-overlay.active {
    visibility: visible;
    opacity: 1;
}

.modal-container {
    background: white;
    width: 90%;
    max-width: 480px;
    border-radius: 32px;
    padding: 28px 28px 32px;
    box-shadow: 0 20px 35px -12px rgba(0,0,0,0.2);
}

.modal-container h4 {
    font-size: 1.3rem;
    font-weight: 500;
    margin-bottom: 20px;
    color: #2D2A24;
}

.modal-container .form-group input,
.modal-container .form-group select {
    background: white;
}

#currentPhotoPreview {
    margin-top: 8px;
    padding: 8px;
    background: #FBF9F6;
    border-radius: 12px;
    text-align: center;
}

#currentPhotoPreview img {
    max-width: 100px;
    max-height: 100px;
    border-radius: 8px;
}

#currentPhotoPreview p {
    font-size: 0.75rem;
    color: #8A8176;
    margin: 0;
}

.modal-actions {
    display: flex;
    gap: 12px;
    margin-top: 24px;
    justify-content: flex-end;
}

.modal-actions button {
    padding: 8px 20px;
    border-radius: 40px;
    border: none;
    cursor: pointer;
    font-weight: 500;
    font-size: 0.85rem;
}

.modal-save {
    background: #2D2A24;
    color: white;
}

.modal-save:hover {
    background: #4A443C;
}

.modal-cancel {
    background: #F1EDE8;
    color: #2D2A24;
}

.modal-cancel:hover {
    background: #E6DFD6;
}

</style>
<%
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<Brand> brands = (List<Brand>) request.getAttribute("brands");
    
    String[] productCategories = {"Moisturizer", "Cleanser", "Serum", "Toner", "Exfoliator", "Mask", "Sunscreen", "Eye Cream", "Treatment", "Other"};
    String[] skinTypes = {"All Skin Types", "Dry", "Oily", "Combination", "Normal", "Sensitive", "Acne-Prone", "Mature"};
%>

<div class="product-dashboard">
    

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
                                ✨ No products yet. Use the left form to add your first product.
                            </td>
                        </tr>
                    <% } else { 
                        for (Product product : products) { 
                            String productNameClean = product.getName() != null ? product.getName() : "";
                            String brandName = product.getBrandName() != null ? product.getBrandName() : "Unknown Brand";
                            String category = product.getCategory() != null ? product.getCategory() : "Uncategorized";
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
                            <td><span class="type-badge-table"><%= category %></span></td>
                            <td class="price-cell">$<%= String.format("%.2f", product.getPrice()) %></td>
                            <td class="stock-cell <%= product.getStockQuantity() <= 5 ? "low-stock" : "" %>">
                                <%= product.getStockQuantity() %>
                                <% if (product.getStockQuantity() <= 0) { %>
                                    <span class="stock-badge out">Out of stock</span>
                                <% } else if (product.getStockQuantity() <= 5) { %>
                                    <span class="stock-badge low">Low stock</span>
                                <% } %>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <button type="button" class="edit-btn-table" 
                                            onclick='openEditModal(<%= product.getId() %>, 
                                                "<%= escapedName %>", 
                                                <%= product.getBrandId() %>, 
                                                "<%= category %>", 
                                                "<%= product.getSkinType() != null ? product.getSkinType() : "" %>", 
                                                "<%= product.getKeyIngredients() != null ? product.getKeyIngredients().replace("\"", "&quot;").replace("\n", "\\n") : "" %>", 
                                                <%= product.getPrice() %>, 
                                                <%= product.getStockQuantity() %>, 
                                                "<%= product.getDescription() != null ? product.getDescription().replace("\"", "&quot;").replace("\n", "\\n") : "" %>", 
                                                "<%= photoPath != null ? photoPath : "" %>")'>
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
                <label>Category *</label>
                <select name="category" id="editCategory" required>
                    <option value="">Select category</option>
                    <% for (String cat : productCategories) { %>
                        <option value="<%= cat %>"><%= cat %></option>
                    <% } %>
                </select>
            </div>
            
            <div class="form-group">
                <label>Skin Type</label>
                <select name="skinType" id="editSkinType">
                    <option value="">Select skin type</option>
                    <% for (String skin : skinTypes) { %>
                        <option value="<%= skin %>"><%= skin %></option>
                    <% } %>
                </select>
            </div>
            
            <div class="form-row">
                <div class="form-group half">
                    <label>Price ($) *</label>
                    <input type="number" name="price" id="editPrice" step="0.01" min="0" required>
                </div>
                
                <div class="form-group half">
                    <label>Stock Quantity *</label>
                    <input type="number" name="stockQuantity" id="editStock" min="0" required>
                </div>
            </div>
            
            <div class="form-group">
                <label>Key Ingredients</label>
                <textarea name="keyIngredients" id="editKeyIngredients" rows="2"></textarea>
            </div>
            
            <div class="form-group">
                <label>Description</label>
                <textarea name="description" id="editDescription" rows="3"></textarea>
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
    function openEditModal(productId, productName, brandId, category, skinType, keyIngredients, price, stockQuantity, description, currentPhoto) {
        document.getElementById('editProductId').value = productId;
        document.getElementById('editProductName').value = productName;
        document.getElementById('editBrandId').value = brandId;
        document.getElementById('editCategory').value = category;
        document.getElementById('editSkinType').value = skinType;
        document.getElementById('editKeyIngredients').value = keyIngredients;
        document.getElementById('editPrice').value = price;
        document.getElementById('editStock').value = stockQuantity;
        document.getElementById('editDescription').value = description;
        
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
                const category = document.getElementById('addCategory').value;
                const price = document.getElementById('addPrice').value;
                const stock = document.getElementById('addStock').value;
                
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
                if (!category) {
                    e.preventDefault();
                    alert('Please select a category');
                    return;
                }
                if (!price || parseFloat(price) < 0) {
                    e.preventDefault();
                    alert('Please enter a valid price');
                    return;
                }
                if (!stock || parseInt(stock) < 0) {
                    e.preventDefault();
                    alert('Please enter a valid stock quantity');
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
    
    function showToast(message, type) {
        const toast = document.createElement('div');
        toast.className = `toast toast-${type}`;
        toast.textContent = message;
        document.body.appendChild(toast);
        setTimeout(() => toast.remove(), 3000);
    }
    
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