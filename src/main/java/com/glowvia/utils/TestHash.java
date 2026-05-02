package com.glowvia.utils;

public class TestHash {
    public static void main(String[] args) {
        String hashed = PasswordUtil.getHashPassword("admin");
        System.out.println(hashed);
    }
}