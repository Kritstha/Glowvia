<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GlowVia · Sign In</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif;
            background: #FAF9F7;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
            position: relative;
        }
        .card {
            max-width: 420px;
            width: 100%;
            background: #FFFFFF;
            border-radius: 28px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.02);
            border: 1px solid #EEEAE2;
            padding: 40px;
        }
        .brand {
            text-align: center;
            margin-bottom: 40px;
        }
        .brand h1 {
            font-size: 1.8rem;
            font-weight: 500;
            letter-spacing: -0.3px;
            color: #2D2A24;
        }
        .brand p {
            font-size: 0.85rem;
            color: #8A8176;
            margin-top: 6px;
        }
        .form-group {
            margin-bottom: 24px;
        }
        .form-group label {
            display: block;
            font-size: 0.75rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            color: #8A8176;
            margin-bottom: 6px;
        }
        .form-group input {
            width: 100%;
            padding: 12px 0;
            border: none;
            border-bottom: 1.5px solid #EFEBE4;
            font-size: 0.95rem;
            background: transparent;
            outline: none;
            transition: border 0.2s;
            color: #2D2A24;
        }
        .form-group input:focus {
            border-bottom-color: #CBB99A;
        }
        .btn-primary {
            width: 100%;
            background: #1A1A1A;
            color: white;
            border: none;
            padding: 14px;
            border-radius: 44px;
            font-size: 0.85rem;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.2s;
            margin-top: 12px;
        }
        .btn-primary:hover {
            background: #2C2C2C;
        }
        .register-link {
            text-align: center;
            margin-top: 24px;
            font-size: 0.8rem;
            color: #8A8176;
        }
        .register-link a {
            color: #CBB99A;
            text-decoration: none;
            font-weight: 500;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
        .demo-note {
            background: #F9F7F4;
            padding: 12px;
            border-radius: 16px;
            margin-top: 24px;
            font-size: 0.7rem;
            color: #8A8176;
            text-align: center;
            border: 1px solid #EFEBE4;
        }
        
        /* Toast Notification Styles */
        .toast {
            position: fixed;
            top: 24px;
            right: 24px;
            left: auto;
            transform: translateX(0);
            background: #FFFFFF;
            color: #2D2A24;
            border-radius: 56px;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 20px 12px 16px;
            z-index: 1000;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12), 0 2px 4px rgba(0, 0, 0, 0.04);
            border: 1px solid #F0EBE4;
            backdrop-filter: blur(8px);
            background: rgba(255, 255, 255, 0.96);
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            pointer-events: none;
            max-width: 380px;
            width: max-content;
        }
        
        .toast.show {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
            pointer-events: auto;
        }
        
        .toast.error {
            border-left: 4px solid #D9776A;
        }
        
        .toast.success {
            border-left: 4px solid #7CB87C;
        }
        
        .toast.info {
            border-left: 4px solid #CBB99A;
        }
        
        .toast-icon {
            font-size: 1.3rem;
            line-height: 1;
        }
        
        .toast-content {
            flex: 1;
            font-weight: 500;
            letter-spacing: -0.2px;
        }
        
        .toast-close {
            background: none;
            border: none;
            font-size: 1.1rem;
            cursor: pointer;
            color: #B0A89C;
            padding: 4px;
            margin-left: 4px;
            transition: color 0.2s;
            pointer-events: auto;
        }
        
        .toast-close:hover {
            color: #2D2A24;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }
        
        .toast.show {
            animation: slideIn 0.3s ease forwards;
        }
        
        @keyframes slideOut {
            to {
                opacity: 0;
                transform: translateX(20px);
                visibility: hidden;
            }
        }
        
        .toast.hiding {
            animation: slideOut 0.2s ease forwards;
        }
        
        /* remove old error message style */
        .error-message {
            display: none;
        }
        
        /* subtle shake animation for form */
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
        
        .form-shake {
            animation: shake 0.3s ease-in-out;
        }
    </style>
</head>
<body>

<%
    // Retrieve error message from request attribute
    String errorMsg = (String) request.getAttribute("error");
    // Also check session attribute as fallback
    if (errorMsg == null && session != null) {
        errorMsg = (String) session.getAttribute("loginError");
        if (errorMsg != null) {
            session.removeAttribute("loginError");
        }
    }
%>

<div class="card">
    <div class="brand">
        <h1>GlowVia</h1>
        <p>Sign in to your skincare studio</p>
    </div>       
    
    <form id="loginForm" action="<%= request.getContextPath() %>/login" method="post">
        <div class="form-group">
            <label>Username</label>
            <input type="text" id="username" name="username" placeholder="username" required>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" id="password" name="password" placeholder="········" required>
        </div>
        <button type="submit" class="btn-primary">Sign in</button>
    </form>
    
    <div class="register-link">
        No account? <a href="register.html">Create account</a>
    </div>
    
    <div class="demo-note">
        Need help? Contact us at <a href="mailto:glowvia@gmail.com" style="color: #CBB99A; text-decoration: none;">glowvia@gmail.com</a>
    </div>
</div>

<!-- Toast Container -->
<div id="toast" class="toast error">
    <span class="toast-icon">⚠️</span>
    <span class="toast-content" id="toastMessage">Error message</span>
    <button class="toast-close" onclick="hideToast()">✕</button>
</div>

<script>
    // Toast management
    const toast = document.getElementById('toast');
    const toastMessage = document.getElementById('toastMessage');
    let hideTimeout = null;
    
    function showToast(message, type = 'error') {
        // Clear any existing timeouts
        if (hideTimeout) {
            clearTimeout(hideTimeout);
        }
        
        // Remove hiding class if present
        toast.classList.remove('hiding');
        
        // Set message
        toastMessage.innerText = message;
        
        // Remove existing type classes
        toast.classList.remove('error', 'success', 'info');
        toast.classList.add(type);
        
        // Update icon based on type
        const iconSpan = toast.querySelector('.toast-icon');
        if (type === 'error') {
            iconSpan.innerHTML = '⚠️';
        } else if (type === 'success') {
            iconSpan.innerHTML = '✓';
        } else {
            iconSpan.innerHTML = 'ℹ️';
        }
        
        // Show toast
        toast.classList.add('show');
        
        // Auto hide after 5 seconds
        hideTimeout = setTimeout(() => {
            hideToast();
        }, 5000);
    }
    
    function hideToast() {
        if (hideTimeout) {
            clearTimeout(hideTimeout);
        }
        toast.classList.add('hiding');
        setTimeout(() => {
            toast.classList.remove('show', 'hiding');
        }, 200);
    }
    
    // Function to add shake animation to form
    function shakeForm() {
        const card = document.querySelector('.card');
        card.classList.add('form-shake');
        setTimeout(() => {
            card.classList.remove('form-shake');
        }, 300);
    }
    
    // Display error if exists from server
    <% if (errorMsg != null && !errorMsg.trim().isEmpty()) { %>
        (function() {
            let errorText = "<%= errorMsg.replace("\"", "\\\"").replace("\n", " ").trim() %>";
            // Decode HTML entities if needed
            var div = document.createElement('div');
            div.innerHTML = errorText;
            errorText = div.textContent || div.innerText || errorText;
            showToast(errorText, 'error');
            shakeForm();
        })();
    <% } %>
    
    // Optional: Client-side validation with toast
    const form = document.getElementById('loginForm');
    form.addEventListener('submit', function(e) {
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value.trim();
        
        if (!username) {
            e.preventDefault();
            showToast('Please enter your username', 'error');
            shakeForm();
            return false;
        }
        
        if (!password) {
            e.preventDefault();
            showToast('Please enter your password', 'error');
            shakeForm();
            return false;
        }
        
        // Optional: Show a loading state
        const submitBtn = form.querySelector('.btn-primary');
        const originalText = submitBtn.innerText;
        submitBtn.innerText = 'Signing in...';
        submitBtn.disabled = true;
        
        // Re-enable if form doesn't submit (fallback)
        setTimeout(() => {
            if (submitBtn.disabled) {
                submitBtn.innerText = originalText;
                submitBtn.disabled = false;
            }
        }, 10000);
        
        return true;
    });
    
    // Reset button state on page load if needed
    window.addEventListener('pageshow', function() {
        const submitBtn = document.querySelector('.btn-primary');
        if (submitBtn) {
            submitBtn.innerText = 'Sign in';
            submitBtn.disabled = false;
        }
    });
    
    // Close toast on escape key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape' && toast.classList.contains('show')) {
            hideToast();
        }
    });
    
    // Click outside to close? Not typical for toast but we'll allow close button
    // Also make sure toast doesn't interfere with form submission
    console.log('Toast notification ready');
</script>
</body>
</html>