<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("username");
    boolean isLoggedIn = (username != null && !username.trim().isEmpty());
    
    // Get cart count from session attribute
    Integer cartCount = (Integer) session.getAttribute("cartCount");
    if (cartCount == null) {
        cartCount = 0;
    }
%>

<div class="top-nav">
    <div class="nav-links">
        <a href="/skincare/home" class="nav-link">Home</a>
        <a href="/skincare/products" class="nav-link">Products</a>
        <a href="/skincare/home#about" class="nav-link">About</a>
        <a href="/skincare/home#developers" class="nav-link">Developers</a>
    </div>

    <div class="auth-buttons">
        <% if (isLoggedIn) { %>
            <!-- Logged in: Show user info, cart, profile, logout -->
            <div class="user-info">
                <a href="/skincare/profile" class="profile-link">Hello, <span><%= username %></span></a>
                <span class="divider">|</span>
                <a href="/skincare/cart" class="cart-link">
                    <svg class="cart-icon" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="9" cy="21" r="1"></circle>
                        <circle cx="20" cy="21" r="1"></circle>
                        <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                    </svg>
                    <span class="cart-count"><%= cartCount %></span>
                </a>
                <a href="/skincare/logout" class="logout-btn">Logout</a>
            </div>
        <% } else { %>
            <!-- Logged out: Show Login and Register buttons -->
            <a href="/skincare/login" class="btn-secondary">Login</a>
            <a href="/skincare/register" class="btn-primary">Register</a>
        <% } %>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    // Active link highlighting logic only (no cart count JS)
    const navLinks = document.querySelectorAll(".nav-link");

    function setActiveLink() {
        const currentPath = window.location.pathname;
        const currentHash = window.location.hash;

        navLinks.forEach(link => {
            link.classList.remove("active");
            const href = link.getAttribute("href");

            // HASH LINKS
            if (href.includes("#")) {
                const [linkPath, hash] = href.split("#");
                const fullHash = "#" + hash;

                if (currentPath === linkPath && currentHash === fullHash) {
                    link.classList.add("active");
                }
            }
            // NORMAL LINKS
            else {
                if (currentPath === href || currentPath.startsWith(href + "/")) {
                    link.classList.add("active");
                }
            }
        });
    }

    setActiveLink();
    window.addEventListener("hashchange", setActiveLink);
});
</script>