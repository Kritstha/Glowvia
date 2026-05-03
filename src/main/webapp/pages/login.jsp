<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GlowVia · Sign In</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/login.css">
</head>
<body>

<%
    String errorMsg = (String) request.getAttribute("error");
%>

<div class="card">
    <div class="brand">
        <h1>GlowVia</h1>
        <p>Sign in to your skincare studio</p>
    </div>

    <% if (errorMsg != null && !errorMsg.trim().isEmpty()) { %>
        <div class="error-message">
            <%= errorMsg %>
        </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/login" method="post">
        
        <div class="form-group">
            <label>Username</label>
            <input type="text" name="username" placeholder="username" required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" placeholder="••••••••" required>
        </div>

        <button type="submit" class="btn-primary">Sign in</button>
    </form>

    <div class="register-link">
        No account? <a href="register.jsp">Create account</a>
    </div>
</div>

</body>
</html>