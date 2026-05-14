package com.glowvia.service;

import java.util.List;

import com.glowvia.dao.ProductDAO;
import com.glowvia.model.Product;

public class ProductService {

    private ProductDAO dao = new ProductDAO();

    public List<Product> getAllProducts() {
        return dao.getAllProducts();
    }

    public Product getProductById(int productId) {
        return dao.getProductById(productId);
    }

    public boolean addProduct(Product product) {

        if (product.getName() == null || product.getName().trim().isEmpty()) {
            return false;
        }

        if (product.getBrandId() <= 0) {
            return false;
        }

        if (product.getCategory() == null || product.getCategory().trim().isEmpty()) {
            return false;
        }

        if (product.getPrice() < 0) {
            return false;
        }

        if (product.getStockQuantity() < 0) {
            return false;
        }

        if (dao.productExists(product.getName().trim(), product.getBrandId())) {
            return false;
        }

        product.setName(product.getName().trim());

        return dao.addProduct(product);
    }

    public boolean updateProduct(Product product) {

        if (product.getName() == null || product.getName().trim().isEmpty()) {
            return false;
        }

        if (product.getBrandId() <= 0) {
            return false;
        }

        if (product.getCategory() == null || product.getCategory().trim().isEmpty()) {
            return false;
        }

        if (product.getPrice() < 0) {
            return false;
        }

        if (product.getStockQuantity() < 0) {
            return false;
        }

        if (dao.productExistsExcludingId(
                product.getName().trim(),
                product.getBrandId(),
                product.getProductId()
        )) {
            return false;
        }

        product.setName(product.getName().trim());

        return dao.updateProduct(product);
    }

    public boolean deleteProduct(int productId) {
        return dao.deleteProduct(productId);
    }
}