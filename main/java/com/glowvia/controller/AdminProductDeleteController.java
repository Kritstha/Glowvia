package com.glowvia.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.File;   // ✅ ADD THIS
import com.glowvia.model.Product;
import com.glowvia.service.ProductService;

@WebServlet("/admin/products/delete")
public class AdminProductDeleteController extends HttpServlet {
    
    private ProductService productService = new ProductService();
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        doPost(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productService.getProductById(id);
        
        if (product != null && product.getPhotoPath() != null && !product.getPhotoPath().isEmpty()) {
            String fullPath = getServletContext().getRealPath("/") + product.getPhotoPath();
            new File(fullPath).delete();
        }
        
        boolean success = productService.deleteProduct(id);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            HttpSession session = request.getSession();
            session.setAttribute("message", "Product Deleted Successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/products/list?error=Failed to delete product");
        }
    }
}