package com.bridge.dao;

import com.bridge.entity.User;

public interface UserDao {

    int insert(User user);

    User findUserByName(String userName);

    User findUserByEmail(String email);

    User findById(Integer id);
}
