package com.glowvia.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;

import com.glowvia.model.Product;
import com.glowvia.service.ProductService;

@WebServlet("/admin/products/delete")
public class AdminProductDeleteController extends HttpServlet {

    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int productId = Integer.parseInt(request.getParameter("id"));

        Product product = productService.getProductById(productId);

        // Delete image file first (if exists)
        if (product != null && product.getPhotoPath() != null && !product.getPhotoPath().isEmpty()) {

            String fullPath =
                    getServletContext().getRealPath("/") + product.getPhotoPath();

            File file = new File(fullPath);

            if (file.exists()) {
                file.delete();
            }
        }

        boolean success = productService.deleteProduct(productId);

        HttpSession session = request.getSession();

        if (success) {
            session.setAttribute("message", "Product Deleted Successfully");

            response.sendRedirect(
                request.getContextPath() + "/admin/products"
            );
        } else {
            session.setAttribute("error_message", "Failed to delete product");

            response.sendRedirect(
                request.getContextPath() + "/admin/products/list?error=delete_failed"
            );
        }
    }
}