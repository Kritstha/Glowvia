<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.glowvia.model.Product" %>
<%@ page import="com.glowvia.model.Brand" %>

<div class="container" id="home">
    <div class="hero">
        <div class="hero-content">
            <span class="hero-badge"> Clean Beauty, Pure Radiance</span>
            <h1>Glow naturally with <span>GlowVia</span></h1>
            <p class="hero-description">Cruelty-free, dermatologist-tested cosmetics that celebrate your authentic skin. Made with love, powered by nature.</p>
            <div class="hero-buttons">
                <a href="#products" class="btn-primary">Shop Now →</a>
                <a href="#about" class="btn-secondary">Learn More</a>
            </div>
        </div>
        <div class="hero-image">
            <img src="/skincare/images/hero.png" alt="GlowVia Beauty Products">
        </div>
    </div>
</div>

<div class="container" id="products">
    <div class="section-header">
        <h2>Our Bestsellers</h2>
        <p>Discover what our GlowVia community is loving right now</p>
    </div>

    <div class="product-grid">
    <% 
        List<Product> products = (List<Product>) request.getAttribute("productList");
        
        int displayCount = Math.min(products.size(), 6);
        
        for (int i = 0; i < displayCount; i++) { 
            Product p = products.get(i);
            
            String imagePath = p.getPhotoPath();
            if (imagePath == null || imagePath.isEmpty()) {
                imagePath = "/skincare/images/placeholder.jpg";
            }
    %>
    <div class="product-card" onclick="window.location.href='<%= request.getContextPath() %>/products/details?productId=<%= p.getProductId() %>'">
        <div class="product-image">
            <img src="/skincare/<%= imagePath %>" 
                 alt="<%= p.getName() %>">
        </div>
        <h3><%= p.getName() %></h3>
        <div class="product-brand"><%= p.getBrandName() != null ? p.getBrandName() : "GlowVia" %></div>
        <div class="product-price">$<%= String.format("%.2f", p.getPrice()) %></div>
        
        <form action="<%= request.getContextPath() %>/cart/add" method="post" style="margin-top: 16px;" onclick="event.stopPropagation();">
            <input type="hidden" name="productId" value="<%= p.getProductId() %>">
            <button type="submit" class="btn-secondary" style="padding: 8px 16px; font-size: 0.8rem;">
                Add to Cart
            </button>
        </form>
    </div>
    <% } %>
    </div>
</div>
      
<div class="view-all-btn" id="about">
    <a href="/skincare/products" class="btn-primary">View All Products →</a>
</div>

<div class="container">
    <div class="about">
        <div class="about-grid">
            <div class="about-image">
                <img src="/skincare/images/about.jpeg" alt="About GlowVia">
            </div>
            <div class="about-content">
                <h2>We believe skin care is self care</h2>
                <p>GlowVia was born from a simple idea: everyone deserves access to clean, effective, and affordable skincare. We spent years researching ingredients, testing formulas, and building relationships with ethical suppliers to create products that truly work.</p>
                <p>Today, we're proud to be a community-driven brand. Every product is dermatologist-tested, cruelty-free, and packaged thoughtfully for our planet.</p>
                <div class="stats">
                    <div class="stat">
                        <div class="stat-number">50K+</div>
                        <div class="stat-label">Happy Customers</div>
                    </div>
                    <div class="stat">
                        <div class="stat-number">15</div>
                        <div class="stat-label">Clean Products</div>
                    </div>
                    <div class="stat">
                        <div class="stat-number">100%</div>
                        <div class="stat-label">Cruelty-Free</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container" id="developers">
    <div class="section-header">
        <h2>Meet the Developers</h2>
        <p>The passionate team behind GlowVia</p>
    </div>
    <div class="developers-grid">
        <div class="developer-card">
            <div class="developer-avatar">
                <img src="https://placehold.co/140x140/EFEBE4/8A8176?text=SK" alt="Developer">
            </div>
            <h3>Salina Karki</h3>
            <div class="developer-role">Lead Developer</div>
            <div class="developer-bio">Full-stack architect who loves creating seamless digital experiences.</div>
        </div>
        <div class="developer-card">
            <div class="developer-avatar">
                <img src="https://placehold.co/140x140/EFEBE4/8A8176?text=VS" alt="Developer">
            </div>
            <h3>Vishal Singh</h3>
            <div class="developer-role">UI/UX Designer</div>
            <div class="developer-bio">Crafts beautiful, intuitive interfaces that people love to use.</div>
        </div>
        <div class="developer-card">
            <div class="developer-avatar">
                <img src="https://placehold.co/140x140/EFEBE4/8A8176?text=ST" alt="Developer">
            </div>
            <h3>Subham Tiwari</h3>
            <div class="developer-role">Backend Engineer</div>
            <div class="developer-bio">Ensures everything runs smoothly behind the scenes.</div>
        </div>
    </div>
</div>