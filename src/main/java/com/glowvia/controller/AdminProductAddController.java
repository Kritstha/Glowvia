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

@WebServlet("/admin/products/add")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class AdminProductAddController extends HttpServlet {
    
    private BrandService brandService = new BrandService();
    private ProductService productService = new ProductService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Brand> brands = brandService.getAllBrands();
        request.setAttribute("brands", brands);
        request.setAttribute("contentPage", "/pages/admin/products/add.jsp");
        request.getRequestDispatcher("/layouts/admin-layout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("productName");
        int brandId = Integer.parseInt(request.getParameter("brandId"));
        String category = request.getParameter("category");
        String skinType = request.getParameter("skinType");
        String keyIngredients = request.getParameter("keyIngredients");
        double price = Double.parseDouble(request.getParameter("price"));
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
        String description = request.getParameter("description");
        
        Part filePart = request.getPart("productPhoto");
        String photoPath = savePhoto(filePart);
        
        Product product = new Product();
        product.setName(name);
        product.setBrandId(brandId);
        product.setCategory(category);
        product.setSkinType(skinType);
        product.setKeyIngredients(keyIngredients);
        product.setPrice(price);
        product.setStockQuantity(stockQuantity);
        product.setDescription(description);
        product.setPhotoPath(photoPath);
        
        boolean success = productService.addProduct(product);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/products/add?error=Failed to add product");
        }
    }
    
    private String savePhoto(Part filePart) throws IOException {
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
}