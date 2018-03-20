package com.bridge.dao;

import com.bridge.entity.User;

public interface UserDao {

    int insert(User user);

    User findUserByName(String userName);

    User findById(Integer id);
}
