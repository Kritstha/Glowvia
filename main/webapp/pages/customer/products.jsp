<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.glowvia.model.Product" %>

<style>
    /* Your existing CSS styles here (keep them exactly as you have) */
    .btn-primary {
        background: #2D2A24;
        color: white;
        padding: 10px 24px;
        border-radius: 40px;
        text-decoration: none;
        font-weight: 500;
        font-size: 0.9rem;
        transition: all 0.2s;
        display: inline-block;
        border: none;
        cursor: pointer;
    }

    .btn-primary:hover {
        background: #D9776A;
        transform: translateY(-2px);
    }

    .btn-secondary {
        background: transparent;
        color: #2D2A24;
        padding: 10px 24px;
        border-radius: 40px;
        text-decoration: none;
        font-weight: 500;
        font-size: 0.9rem;
        border: 1px solid #E6DFD6;
        transition: all 0.2s;
        display: inline-block;
        cursor: pointer;
    }

    .btn-secondary:hover {
        background: #F1EDE8;
        border-color: #D9776A;
    }

    .btn-outline {
        background: transparent;
        color: #D9776A;
        padding: 8px 20px;
        border-radius: 40px;
        text-decoration: none;
        font-weight: 500;
        font-size: 0.85rem;
        border: 1px solid #D9776A;
        transition: all 0.2s;
        display: inline-block;
        cursor: pointer;
    }

    .btn-outline:hover {
        background: #D9776A;
        color: white;
    }

    .container {
        max-width: 1280px;
        margin: 0 auto;
        padding: 0 40px;
    }

    .page-header {
        padding: 48px 0 24px;
        text-align: center;
    }

    .page-header h1 {
        font-size: 2.5rem;
        font-weight: 600;
        letter-spacing: -1px;
        color: #2D2A24;
        margin-bottom: 12px;
    }

    .page-header p {
        color: #8A8176;
        font-size: 1rem;
    }

    .filter-bar {
        background: white;
        border-radius: 60px;
        padding: 8px 20px;
        margin: 20px 0 40px;
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        align-items: center;
        gap: 20px;
        border: 1px solid #EFEBE4;
    }

    .filter-group {
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
    }

    .filter-chip {
        padding: 8px 20px;
        border-radius: 40px;
        background: #F6F4F0;
        color: #5D5448;
        font-size: 0.85rem;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.2s;
        border: none;
    }

    .filter-chip.active {
        background: #2D2A24;
        color: white;
    }

    .filter-chip:hover {
        background: #D9776A;
        color: white;
    }

    .sort-select {
        padding: 8px 16px;
        border-radius: 40px;
        border: 1px solid #E6DFD6;
        background: white;
        font-family: 'Inter', sans-serif;
        font-size: 0.85rem;
        color: #2D2A24;
        cursor: pointer;
    }

    .product-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 32px;
        margin: 40px 0;
    }

    .product-card {
        background: white;
        border-radius: 24px;
        padding: 24px 20px;
        text-align: center;
        transition: all 0.3s;
        border: 1px solid #EFEBE4;
        position: relative;
    }

    .product-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 25px -10px rgba(0, 0, 0, 0.08);
        border-color: #D9776A;
    }

    .product-badge {
        position: absolute;
        top: 16px;
        left: 16px;
        background: #D9776A;
        color: white;
        font-size: 0.7rem;
        font-weight: 600;
        padding: 4px 10px;
        border-radius: 20px;
        letter-spacing: 0.5px;
    }

    .product-badge.sale {
        background: #2D2A24;
    }

    .product-badge.new {
        background: #8A8176;
    }

    .product-image {
        width: 180px;
        height: 180px;
        margin: 0 auto 16px;
        background: #F6F4F0;
        border-radius: 90px;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
    }

    .product-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .product-card h3 {
        font-size: 1.1rem;
        font-weight: 600;
        margin-bottom: 6px;
        color: #2D2A24;
    }

    .product-brand {
        font-size: 0.75rem;
        color: #8A8176;
        margin-bottom: 8px;
    }

    .product-price {
        font-weight: 700;
        color: #D9776A;
        font-size: 1.2rem;
        margin-bottom: 16px;
    }

    .old-price {
        font-size: 0.85rem;
        color: #B0A89E;
        text-decoration: line-through;
        font-weight: normal;
        margin-left: 8px;
    }

    .product-actions {
        display: flex;
        gap: 10px;
        justify-content: center;
    }

    .pagination {
        display: flex;
        justify-content: center;
        gap: 8px;
        margin: 50px 0;
    }

    .page-btn {
        width: 40px;
        height: 40px;
        border-radius: 40px;
        border: 1px solid #E6DFD6;
        background: white;
        font-family: 'Inter', sans-serif;
        cursor: pointer;
        transition: all 0.2s;
    }

    .page-btn.active {
        background: #2D2A24;
        color: white;
        border-color: #2D2A24;
    }

    .page-btn:hover:not(.active) {
        border-color: #D9776A;
        color: #D9776A;
    }
</style>

<div class="container">
    <div class="page-header">
        <h1>Our Collection</h1>
        <p>Clean, cruelty-free skincare crafted for your unique glow</p>
    </div>

    <div class="filter-bar">
        <div class="filter-group">
            <button class="filter-chip active" data-category="all">All Products</button>
            <button class="filter-chip" data-category="cleanser">Cleansers</button>
            <button class="filter-chip" data-category="serum">Serums</button>
            <button class="filter-chip" data-category="moisturizer">Moisturizers</button>
            <button class="filter-chip" data-category="mask">Masks</button>
        </div>
        <div>
            <select class="sort-select" id="sortSelect">
                <option value="featured">Featured</option>
                <option value="price-low">Price: Low to High</option>
                <option value="price-high">Price: High to Low</option>
                <option value="rating">Top Rated</option>
            </select>
        </div>
    </div>

    <div class="product-grid" id="productGrid">
    <% 
        List<Product> products = (List<Product>) request.getAttribute("productList");
        
        if (products != null && !products.isEmpty()) {
            for (Product p : products) {
                String imagePath = p.getPhotoPath();
                if (imagePath == null || imagePath.isEmpty()) {
                    imagePath = "/skincare/images/placeholder.jpg";
                }
    %>
    <div class="product-card">
        <div class="product-image">
            <img src="/skincare/<%= imagePath %>" alt="<%= p.getName() %>">
        </div>
        <h3><%= p.getName() %></h3>
        <div class="product-brand"><%= p.getBrandName() != null ? p.getBrandName() : "GlowVia" %></div>
        <div class="product-price">$<%= String.format("%.2f", p.getPrice()) %></div>
        
        <div class="product-actions">
            <form action="<%= request.getContextPath() %>/cart/add" method="post">
                <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                <button type="submit" class="btn-outline">Add to Cart</button>
            </form>
            
            <a href="<%= request.getContextPath() %>/products/details?productId=<%= p.getProductId() %>" class="btn-secondary">
                Details
            </a>
        </div>
    </div>
    <% 
            }
        } else {
    %>
        <p>No products found.</p>
    <% 
        }
    %>
</div>
</div>

<script>
    // Filter functionality
    const filterChips = document.querySelectorAll('.filter-chip');
    const productCards = document.querySelectorAll('.product-card');
    const sortSelect = document.getElementById('sortSelect');
    
    let currentCategory = 'all';
    
    function filterProducts() {
        productCards.forEach(card => {
            if (currentCategory === 'all' || card.dataset.category === currentCategory) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
        sortProducts();
    }
    
    function sortProducts() {
        const sortValue = sortSelect.value;
        const grid = document.getElementById('productGrid');
        const visibleCards = Array.from(productCards).filter(card => card.style.display !== 'none');
        
        visibleCards.sort((a, b) => {
            if (sortValue === 'price-low') {
                return parseFloat(a.dataset.price) - parseFloat(b.dataset.price);
            } else if (sortValue === 'price-high') {
                return parseFloat(b.dataset.price) - parseFloat(a.dataset.price);
            } else if (sortValue === 'rating') {
                return parseFloat(b.dataset.rating) - parseFloat(a.dataset.rating);
            }
            return 0;
        });
        
        visibleCards.forEach(card => grid.appendChild(card));
    }
    
    filterChips.forEach(chip => {
        chip.addEventListener('click', () => {
            filterChips.forEach(c => c.classList.remove('active'));
            chip.classList.add('active');
            currentCategory = chip.dataset.category;
            
            // Optional: Reload page with filter parameter
            window.location.href = '<%= request.getContextPath() %>/products?category=' + currentCategory + '&sort=' + sortSelect.value;
        });
    });
    
    sortSelect.addEventListener('change', () => {
        window.location.href = '<%= request.getContextPath() %>/products?category=' + currentCategory + '&sort=' + sortSelect.value;
    });
</script>