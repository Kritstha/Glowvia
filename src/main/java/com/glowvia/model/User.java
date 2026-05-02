package com.glowvia.model;

import java.util.Date;

public class User {

    private String firstName;
    private String lastName;
    private String userName;
    private Date dob;
    private String gender;
    private String email;
    private String number;
    private String password;
    private String image;

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public Date getDob() { return dob; }
    public void setDob(Date dob) { this.dob = dob; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getNumber() { return number; }
    public void setNumber(String number) { this.number = number; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
}