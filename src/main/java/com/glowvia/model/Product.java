package com.glowvia.model;

public class Product {
    private int id;
    private String name;
    private int brandId;
    private String brandName;
    private String productType;
    private String photoPath;
    
    // Constructors
    public Product() {}
    
    public Product(int id, String name, int brandId, String productType, String photoPath) {
        this.id = id;
        this.name = name;
        this.brandId = brandId;
        this.productType = productType;
        this.photoPath = photoPath;
    }

    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public int getBrandId() {
        return brandId;
    }
    
    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }
    
    public String getBrandName() {
        return brandName;
    }
    
    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }
    
    public String getProductType() {
        return productType;
    }
    
    public void setProductType(String productType) {
        this.productType = productType;
    }
    
    public String getPhotoPath() {
        return photoPath;
    }
    
    public void setPhotoPath(String photoPath) {
        this.photoPath = photoPath;
    }
}