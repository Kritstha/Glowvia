package com.glowvia.model;

public class Product {
    private int id;
    private String name;
    private int brandId;
    private String brandName;  // For display (JOIN with brands table)
    private String category;
    private String skinType;
    private String keyIngredients;
    private double price;
    private int stockQuantity;
    private String description;
    private String photoPath;  // Keep as photoPath or change to imagePath
    
    // Constructors
    public Product() {}
    
    public Product(int id, String name, int brandId, String category, String skinType, 
                   String keyIngredients, double price, int stockQuantity, 
                   String description, String photoPath) {
        this.id = id;
        this.name = name;
        this.brandId = brandId;
        this.category = category;
        this.skinType = skinType;
        this.keyIngredients = keyIngredients;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.description = description;
        this.photoPath = photoPath;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public int getBrandId() { return brandId; }
    public void setBrandId(int brandId) { this.brandId = brandId; }
    
    public String getBrandName() { return brandName; }
    public void setBrandName(String brandName) { this.brandName = brandName; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public String getSkinType() { return skinType; }
    public void setSkinType(String skinType) { this.skinType = skinType; }
    
    public String getKeyIngredients() { return keyIngredients; }
    public void setKeyIngredients(String keyIngredients) { this.keyIngredients = keyIngredients; }
    
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    
    public int getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(int stockQuantity) { this.stockQuantity = stockQuantity; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getPhotoPath() { return photoPath; }
    public void setPhotoPath(String photoPath) { this.photoPath = photoPath; }
}