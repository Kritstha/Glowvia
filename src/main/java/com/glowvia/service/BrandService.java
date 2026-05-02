package com.glowvia.service;

import java.util.List;

import com.glowvia.dao.BrandDAO;
import com.glowvia.model.Brand;

public class BrandService {

    private BrandDAO dao = new BrandDAO();

    public List<Brand> getAllBrands() {
        return dao.getAllBrands();
    }

    public Brand getBrandById(int id) {
        return dao.getBrandById(id);
    }

    public boolean addBrand(Brand brand) {

        // Business rule: name required
        if (brand.getName() == null || brand.getName().trim().isEmpty()) {
            return false;
        }

        // Business rule: no duplicates
        if (dao.brandExists(brand.getName().trim())) {
            return false;
        }

        brand.setName(brand.getName().trim());
        return dao.addBrand(brand);
    }

    public boolean updateBrand(Brand brand) {

        if (brand.getName() == null || brand.getName().trim().isEmpty()) {
            return false;
        }

        if (dao.brandExistsExcludingId(brand.getName().trim(), brand.getId())) {
            return false;
        }

        brand.setName(brand.getName().trim());
        return dao.updateBrand(brand);
    }

    public boolean deleteBrand(int id) {
        return dao.deleteBrand(id);
    }
}