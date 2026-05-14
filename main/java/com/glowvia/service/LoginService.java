package com.glowvia.service;

import com.glowvia.dao.UserDAO;
import com.glowvia.model.User;
import com.glowvia.utils.PasswordUtil;

public class LoginService {

	public User loginUser(User user) {
	    try {
	        UserDAO dao = new UserDAO();
	        User dbUser = dao.getUserByUsername(user.getUserName());

	        if (dbUser != null && PasswordUtil.checkPassword(user.getPassword(), dbUser.getPassword())) {
	            return dbUser; // return FULL user object
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}

    // Add this method for ProfileController
    public User getUserByUsername(String username) {
        try {
            UserDAO dao = new UserDAO();
            return dao.getUserByUsername(username);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}