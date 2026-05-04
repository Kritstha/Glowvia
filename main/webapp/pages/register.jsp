<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GlowVia · Create Account</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/register.css">
</head>
<body>

<div class="card">
    <div class="brand">
        <h1>GlowVia</h1>
        <p>Create your account</p>
    </div>

<%
    String errorMsg = (String) session.getAttribute("error_message");
    if (errorMsg != null && !errorMsg.trim().isEmpty()) {
%>
    <div class="error-message">
        <%= errorMsg %>
    </div>
<%
        session.removeAttribute("error_message");
    }
%>

    <form action="<%= request.getContextPath() %>/register" method="post" enctype="multipart/form-data">
        <div class="form-row">
            <div class="form-group">
                <label>First name</label>
                <input type="text" name="first_name" placeholder="First name" required>
            </div>
            <div class="form-group">
                <label>Last name</label>
                <input type="text" name="last_name" placeholder="Last name" required>
            </div>
        </div>

        <div class="form-group">
            <label>Username</label>
            <input type="text" name="username" placeholder="username" required>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Date of birth</label>
                <input type="date" name="dob">
            </div>
            <div class="form-group">
                <label>Gender</label>
                <select name="gender">
                    <option value="">Select</option>
                    <option>Female</option>
                    <option>Male</option>
                    <option>Other</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" placeholder="hello@glowvia.com" required>
        </div>

        <div class="form-group">
            <label>Phone number</label>
            <input type="tel" name="phone" placeholder="+1234567890">
        </div>

        <div class="photo-section">
            <div class="photo-title">profile photo</div>
            <div class="upload-item">
                <div class="upload-label">Profile picture</div>
                <div class="upload-hint">JPG or PNG · Max 2MB</div>
                <div class="file-input-wrapper">
                    <label class="custom-file-btn" for="profile_photo">Choose file</label>
                    <input type="file" id="profile_photo" name="profile_photo" accept=".jpg,.jpeg,.png" style="display:none" onchange="updateFileName(this)">
                    <span id="photoName" class="file-name">No file chosen</span>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" placeholder="••••••••" required>
        </div>

        <div class="form-group">
            <label>Confirm password</label>
            <input type="password" name="confirm_password" placeholder="••••••••" required>
        </div>

        <button type="submit" class="btn-primary">Create account</button>
    </form>

    <div class="login-link">
        Already have an account? <a href="login">Sign in</a>
    </div>
</div>

<script>
    function updateFileName(input) {
        var fileNameSpan = document.getElementById('photoName');
        if (input.files && input.files.length > 0) {
            var file = input.files[0];
            if (file.size > 2 * 1024 * 1024) {
                alert('File too large. Max 2MB');
                input.value = '';
                fileNameSpan.textContent = 'No file chosen';
                return;
            }
            fileNameSpan.textContent = file.name;
        } else {
            fileNameSpan.textContent = 'No file chosen';
        }
    }
</script>

</body>
</html>