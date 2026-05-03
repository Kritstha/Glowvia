package com.glowvia.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import com.glowvia.dao.UserDAO;
import com.glowvia.model.User;
import com.glowvia.utils.PasswordUtil;

@WebServlet("/register")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 2,
    maxRequestSize = 1024 * 1024 * 5
)
public class RegisterController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String username = request.getParameter("username");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        
        if (!password.equals(confirmPassword)) {
            HttpSession session = request.getSession();
            session.setAttribute("error_message", "Passwords do not match");
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }
        
        try {
            UserDAO userDAO = new UserDAO();
            
            if (userDAO.isUsernameExists(username)) {
                HttpSession session = request.getSession();
                session.setAttribute("error_message", "Username already exists");
                response.sendRedirect(request.getContextPath() + "/register");
                return;
            }
            
            if (userDAO.isEmailExists(email)) {
                HttpSession session = request.getSession();
                session.setAttribute("error_message", "Email already registered");
                response.sendRedirect(request.getContextPath() + "/register");
                return;
            }
            
            String imagePath = null;
            Part filePart = request.getPart("profile_photo");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + "uploads" + File.separator;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();
                filePart.write(uploadPath + fileName);
                imagePath = "uploads/" + fileName;
            }
            
            User user = new User();
            user.setFullName(firstName + " " + lastName);
            user.setUserName(username);
            user.setDob(dob);
            user.setGender(gender);
            user.setEmail(email);
            user.setPhone(phone);
            user.setPassword(PasswordUtil.getHashPassword(password));
            user.setImagePath(imagePath);
            
            userDAO.insertUser(user);
            
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/login");
            
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("error_message", "Registration failed: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/register");
        }
    }
}