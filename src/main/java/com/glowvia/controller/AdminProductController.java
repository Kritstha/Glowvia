package com.glowvia.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.util.List;

import com.glowvia.model.Brand;
import com.glowvia.model.Product;
import com.glowvia.service.BrandService;
import com.glowvia.service.ProductService;

@WebServlet("/admin/products")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AdminProductController extends HttpServlet {
    
    private ProductService productService = new ProductService();
    private BrandService brandService = new BrandService();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Product> products = productService.getAllProducts();
        List<Brand> brands = brandService.getAllBrands();
        
        request.setAttribute("products", products);
        request.setAttribute("brands", brands);
        request.setAttribute("contentPage", "/pages/admin/products.jsp");
        request.getRequestDispatcher("/layouts/admin-layout.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
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
                response.sendRedirect("products?error=Invalid action");
        }
    }
    
    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        
        String name = request.getParameter("productName");
        int brandId = Integer.parseInt(request.getParameter("brandId"));
        String productType = request.getParameter("productType");
        
        Part filePart = request.getPart("productPhoto");
        String photoPath = savePhoto(filePart, null);
        
        Product product = new Product();
        product.setName(name);
        product.setBrandId(brandId);
        product.setProductType(productType);
        product.setPhotoPath(photoPath);
        
        boolean success = productService.addProduct(product);
        
        if (success) {
            response.sendRedirect("products?message=Product added successfully");
        } else {
            response.sendRedirect("products?error=Failed to add product. Duplicate or invalid data.");
        }
    }
    
    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        
        int id = Integer.parseInt(request.getParameter("productId"));
        String name = request.getParameter("productName");
        int brandId = Integer.parseInt(request.getParameter("brandId"));
        String productType = request.getParameter("productType");
        
        Product existingProduct = productService.getProductById(id);
        String photoPath = existingProduct.getPhotoPath();
        
        Part filePart = request.getPart("productPhoto");
        if (filePart != null && filePart.getSize() > 0) {

            if (photoPath != null && !photoPath.isEmpty()) {
                deleteOldPhoto(photoPath);
            }
            photoPath = savePhoto(filePart, id);
        }
        
        Product product = new Product();
        product.setId(id);
        product.setName(name);
        product.setBrandId(brandId);
        product.setProductType(productType);
        product.setPhotoPath(photoPath);
        
        boolean success = productService.updateProduct(product);
        
        if (success) {
            response.sendRedirect("products?message=Product updated successfully");
        } else {
            response.sendRedirect("products?error=Failed to update product");
        }
    }
    
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        int id = Integer.parseInt(request.getParameter("productId"));
        
        Product product = productService.getProductById(id);
        if (product != null && product.getPhotoPath() != null && !product.getPhotoPath().isEmpty()) {
            deleteOldPhoto(product.getPhotoPath());
        }
        
        boolean success = productService.deleteProduct(id);
        
        if (success) {
            response.sendRedirect("products?message=Product deleted successfully");
        } else {
            response.sendRedirect("products?error=Failed to delete product");
        }
    }
    
    private String savePhoto(Part filePart, Integer productId) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }
        
        String uploadPath = getServletContext().getRealPath("/") + "uploads/products/";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
        String filePath = uploadPath + fileName;
        filePart.write(filePath);
        
        return "uploads/products/" + fileName;
    }
    
    private void deleteOldPhoto(String photoPath) {
        if (photoPath != null && !photoPath.isEmpty()) {
            String fullPath = getServletContext().getRealPath("/") + photoPath;
            File oldPhoto = new File(fullPath);
            if (oldPhoto.exists()) {
                oldPhoto.delete();
            }
        }
    }
}