<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect("/skincare/login");
        return;
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>GlowVia · Studio Dashboard</title>
    <link rel="stylesheet" type="text/css" href="/skincare/css/styles.css">
    
</head>
<body>
<%
    String message = (String) session.getAttribute("message");
	String error_msg = (String) session.getAttribute("error_message");
    session.removeAttribute("message");
    session.removeAttribute("error_message");
%>

<% if (message != null && !message.trim().isEmpty()) { %>
    <div class="message-toast success">
        <%= message %>
    </div>
<% } %>

<% if (error_msg != null && !error_msg.trim().isEmpty()) { %>
    <div class="message-toast error">
        <%= error_msg %>
    </div>
<% } %>

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