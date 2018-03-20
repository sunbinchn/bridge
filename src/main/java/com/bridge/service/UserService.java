package com.bridge.service;

import com.bridge.dao.UserDao;
import com.bridge.entity.Image;
import com.bridge.entity.User;
import com.bridge.vo.result.BaseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    UserDao userDao;

    public BaseResult saveUser(User user) {
        BaseResult result = new BaseResult();
        User userByName = userDao.findUserByName(user.getUserName());
        if (userByName != null) {
            result.setSuccess(false);
            result.setMessage("该用户名已存在");
            return result;
        }
        int insert = userDao.insert(user);
        if (insert == 1) {
            result.setSuccess(true);
        }
        return result;
    }

    public User findUserByName(String userName) {
        return userDao.findUserByName(userName);
    }

}
