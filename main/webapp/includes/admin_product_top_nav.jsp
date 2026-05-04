<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.module-nav {
    background: white;
    border: 1px solid #EEE7DE;
    border-radius: 20px;
    padding: 14px 18px;
    margin-bottom: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 12px;
}

.module-title {
    font-size: 1rem;
    font-weight: 600;
    color: #2D2A24;
}

.module-links {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
}

.module-link {
    text-decoration: none;
    font-size: 0.8rem;
    font-weight: 500;
    color: #5D5448;
    padding: 6px 14px;
    border-radius: 30px;
    border: 1px solid #E6DFD6;
    transition: 0.2s ease;
    background: #fff;
}

.module-link:hover {
    background: #2D2A24;
    color: white;
    border-color: #2D2A24;
}

.module-link.primary {
    background: #2D2A24;
    color: white;
    border-color: #2D2A24;
}

.module-link.primary:hover {
    opacity: 0.9;
}

.module-link.active {
    background: #2D2A24;
    color: white;
    border-color: #2D2A24;
}
</style>

<div class="module-nav">
    <div class="module-title">Products Management</div>
    <div class="module-links">
        <a href="/skincare/admin/products" class="module-link">Products</a>
        <a href="/skincare/admin/products/add" class="module-link">+ Add Product</a>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    var currentPath = window.location.pathname;

    document.querySelectorAll(".module-link").forEach(function(link) {
        var href = link.getAttribute("href");

        // exact match OR last part match
        if (currentPath === href || currentPath.endsWith(href)) {
            link.classList.add("active");
        }
    });
});
</script>