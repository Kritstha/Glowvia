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

@WebServlet("/admin/products/edit")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class AdminProductEditController extends HttpServlet {

    private ProductService productService = new ProductService();
    private BrandService brandService = new BrandService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int productId = Integer.parseInt(request.getParameter("id"));

        Product product = productService.getProductById(productId);
        List<Brand> brands = brandService.getAllBrands();

        if (product == null) {
            response.sendRedirect(
                request.getContextPath() + "/admin/products/list?error=Product not found"
            );
            return;
        }

        request.setAttribute("product", product);
        request.setAttribute("brands", brands);
        request.setAttribute("contentPage", "/pages/admin/products/edit.jsp");

        request.getRequestDispatcher("/layouts/admin-layout.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int productId = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("productName");
        int brandId = Integer.parseInt(request.getParameter("brandId"));
        String category = request.getParameter("category");
        String skinType = request.getParameter("skinType");
        String keyIngredients = request.getParameter("keyIngredients");
        double price = Double.parseDouble(request.getParameter("price"));
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
        String description = request.getParameter("description");

        Product existingProduct = productService.getProductById(productId);

        if (existingProduct == null) {
            response.sendRedirect(
                request.getContextPath() + "/admin/products/list?error=Product not found"
            );
            return;
        }

        Part filePart = request.getPart("productPhoto");
        String photoPath = existingProduct.getPhotoPath();

        if (filePart != null && filePart.getSize() > 0) {

            if (photoPath != null && !photoPath.isEmpty()) {
                String oldPhotoPath = getServletContext().getRealPath("/") + photoPath;
                File oldPhoto = new File(oldPhotoPath);
                if (oldPhoto.exists()) {
                    oldPhoto.delete();
                }
            }

            photoPath = savePhoto(filePart);
        }

        Product product = new Product();
        product.setProductId(productId);
        product.setName(name);
        product.setBrandId(brandId);
        product.setCategory(category);
        product.setSkinType(skinType);
        product.setKeyIngredients(keyIngredients);
        product.setPrice(price);
        product.setStockQuantity(stockQuantity);
        product.setDescription(description);
        product.setPhotoPath(photoPath);

        boolean success = productService.updateProduct(product);

        if (success) {

            HttpSession session = request.getSession();
            session.setAttribute("message", "Product Edited Successfully");

            response.sendRedirect(
                request.getContextPath() + "/admin/products"
            );

        } else {
            response.sendRedirect(
                request.getContextPath() +
                "/admin/products/edit?id=" + productId +
                "&error=Failed to update product"
            );
        }
    }

    private String savePhoto(Part filePart) throws IOException {

        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        String uploadPath =
                getServletContext().getRealPath("/") + "uploads/products/";

        File uploadDir = new File(uploadPath);

        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String fileName =
                System.currentTimeMillis() + "_" +
                filePart.getSubmittedFileName();

        String filePath = uploadPath + fileName;

        filePart.write(filePath);

        return "uploads/products/" + fileName;
    }
}