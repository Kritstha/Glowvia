package com.glowvia.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;

import com.glowvia.model.Product;
import com.glowvia.service.ProductService;

@WebServlet("/admin/products/form")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class AdminProductFormController extends HttpServlet {

    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String mode = request.getParameter("mode");

        if ("edit".equals(mode)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productService.getProductById(id);
            request.setAttribute("product", product);
        }

        request.setAttribute("contentPage", "/pages/admin/product-form.jsp");
        request.getRequestDispatcher("/layouts/admin-layout.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String action = request.getParameter("action");

        switch (action) {
            case "add":
                addProduct(request, response);
                break;
            case "update":
                updateProduct(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            default:
                response.sendRedirect("/admin/products?error=Invalid action");
        }
    }


    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        Product product = extractProductFromRequest(request);

        Part filePart = request.getPart("productPhoto");
        String photoPath = savePhoto(filePart);

        product.setPhotoPath(photoPath);

        boolean success = productService.addProduct(product);

        if (success) {
            response.sendRedirect("/admin/products?message=Product added");
        } else {
            response.sendRedirect("/admin/products?error=Add failed");
        }
    }

    // ================= UPDATE =================
    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        int id = Integer.parseInt(request.getParameter("productId"));
        Product existing = productService.getProductById(id);

        Product product = extractProductFromRequest(request);
        product.setId(id);

        String photoPath = existing.getPhotoPath();

        Part filePart = request.getPart("productPhoto");
        if (filePart != null && filePart.getSize() > 0) {
            deleteOldPhoto(photoPath);
            photoPath = savePhoto(filePart);
        }

        product.setPhotoPath(photoPath);

        boolean success = productService.updateProduct(product);

        if (success) {
            response.sendRedirect("/admin/products?message=Updated");
        } else {
            response.sendRedirect("/admin/products?error=Update failed");
        }
    }

    // ================= DELETE =================
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("productId"));

        Product product = productService.getProductById(id);

        if (product != null && product.getPhotoPath() != null) {
            deleteOldPhoto(product.getPhotoPath());
        }

        boolean success = productService.deleteProduct(id);

        if (success) {
            response.sendRedirect("/admin/products?message=Deleted");
        } else {
            response.sendRedirect("/admin/products?error=Delete failed");
        }
    }

    // ================= HELPER =================
    private Product extractProductFromRequest(HttpServletRequest request) {

        Product product = new Product();

        product.setName(request.getParameter("productName"));
        product.setBrandId(Integer.parseInt(request.getParameter("brandId")));
        product.setCategory(request.getParameter("category"));
        product.setSkinType(request.getParameter("skinType"));
        product.setKeyIngredients(request.getParameter("keyIngredients"));
        product.setPrice(Double.parseDouble(request.getParameter("price")));
        product.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
        product.setDescription(request.getParameter("description"));

        return product;
    }

    private String savePhoto(Part filePart) throws IOException {

        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        String uploadPath = getServletContext().getRealPath("/") + "uploads/products/";
        File dir = new File(uploadPath);

        if (!dir.exists()) dir.mkdirs();

        // safer filename
        String fileName = System.currentTimeMillis() + ".jpg";

        filePart.write(uploadPath + fileName);

        return "uploads/products/" + fileName;
    }

    private void deleteOldPhoto(String path) {

        if (path == null) return;

        String fullPath = getServletContext().getRealPath("/") + path;
        File file = new File(fullPath);

        if (file.exists()) file.delete();
    }
}