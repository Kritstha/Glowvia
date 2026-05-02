package com.glowvia.service;

import java.util.List;

import com.glowvia.dao.ProductDAO;
import com.glowvia.model.Product;

public class ProductService {
    
    private ProductDAO dao = new ProductDAO();
    
    public List<Product> getAllProducts() {
        return dao.getAllProducts();
    }
    
    public Product getProductById(int id) {
        return dao.getProductById(id);
    }
    
    public boolean addProduct(Product product) {
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            return false;
        }
        
        if (product.getBrandId() <= 0) {
            return false;
        }

        if (product.getProductType() == null || product.getProductType().trim().isEmpty()) {
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
        
        if (product.getProductType() == null || product.getProductType().trim().isEmpty()) {
            return false;
        }
        
        if (dao.productExistsExcludingId(product.getName().trim(), product.getBrandId(), product.getId())) {
            return false;
        }
        
        product.setName(product.getName().trim());
        return dao.updateProduct(product);
    }
    
    public boolean deleteProduct(int id) {
        return dao.deleteProduct(id);
    }
}