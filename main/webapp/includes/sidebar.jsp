<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<aside class="sidebar">

    <div class="sidebar-logo">
        <a href="/skincare/admin/dashboard"
           style="text-decoration: none; color: inherit;">
            <h2>GlowVia</h2>
        </a>
    </div>

    <div class="nav-menu">

        <a href="/skincare/admin/dashboard"
           class="nav-item" data-nav="dashboard">
            <svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
                <path d="M3 9l9-6 9 6v11a2 2 0 0 1-2 2h-5v-7H9v7H5a2 2 0 0 1-2-2z"/>
            </svg>
            <span>Dashboard</span>
        </a>

        <a href="/skincare/admin/brands"
           class="nav-item" data-nav="brands">
            <svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
                <path d="M20 7h-4.5M7 7H4M12 3v4m0 14v-4m-5-2H4m16 0h-3M4 14h16"/>
                <circle cx="12" cy="12" r="3"/>
            </svg>
            <span>Brands</span>
        </a>

        <a href="/skincare/admin/products"
           class="nav-item" data-nav="products">
            <svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
                <path d="M4 6h16v12H4z"/>
                <path d="M8 10h8"/>
            </svg>
            <span>Product Library</span>
        </a>

    </div>

    <div class="user-meta-side">
        <div id="sideGreeting" style="margin-bottom: 8px;">Welcome, Admin</div>
    </div>

</aside>

<script>
document.addEventListener("DOMContentLoaded", function () {
	  
    const currentPath = window.location.pathname;
    
    document.querySelectorAll(".nav-item").forEach(item => {
        const navValue = item.getAttribute("data-nav");
        
        if (navValue && currentPath.includes(navValue)) {
            item.classList.add("active");
        }
    });
});
</script>