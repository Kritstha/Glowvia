package com.glowvia.model;

public class Brand {

    private int brand_id;
    private String name;
    private String contact;

    // Constructors
    public Brand() {}

    public Brand(int brand_id, String name, String contact) {
        this.brand_id = brand_id;
        this.name = name;
        this.contact = contact;
    }

    // Getters and Setters
    public int getBrand_id() {
        return brand_id;
    }

    public void setBrand_id(int brand_id) {
        this.brand_id = brand_id;
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