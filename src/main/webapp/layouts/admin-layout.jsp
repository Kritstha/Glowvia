<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>GlowVia · Studio Dashboard</title>
    <link rel="stylesheet" type="text/css" href="/skincare/css/styles.css">
    
    <script src="/skincare/js/toast.js"></script>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/includes/sidebar.jsp" />
    <main class="main-content">
        <jsp:include page="/includes/header.jsp" />
        <div class="container">
<%
    String contentPage = (String) request.getAttribute("contentPage");
    if (contentPage == null || contentPage.trim().isEmpty()) {
        contentPage = "/pages/error.jsp";
    }
%>
<jsp:include page="<%= contentPage %>" />
        </div>
    </main>
</div>



</body>
</html>