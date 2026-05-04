package com.glowvia.model;

public class Brand {
    private int id;
    private String name;
    private String contact;
    
    // Constructors
    public Brand() {}
    
    public Brand(int id, String name, String contact) {
        this.id = id;
        this.name = name;
        this.contact = contact;
    }
    
    // Getters and Setters
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
    
    public String getContact() {
        return contact;
    }
    
    public void setContact(String contact) {
        this.contact = contact;
    }
}