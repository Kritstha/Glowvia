<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GlowVia - Natural Radiance, Authentic Beauty</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/skincare/css/home.css">
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

<jsp:include page="/includes/customer_top_nav.jsp" />

<main>

    <%
        String contentPage = (String) request.getAttribute("contentPage");
        if (contentPage == null || contentPage.trim().isEmpty()) {
            contentPage = "/pages/error.jsp";
        }
    %>

    <jsp:include page="<%= contentPage %>" />
</main>

<jsp:include page="/includes/customer_footer.jsp" />

</body>
</html>