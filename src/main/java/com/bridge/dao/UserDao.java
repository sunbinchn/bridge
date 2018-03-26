package com.bridge.dao;

import com.bridge.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {

    int insert(User user);

    User findUserByName(String userName);

    User findById(Integer id);

    List<User> findAllByRoleLevel(@Param("roleLevel") Integer roleLevel);

    boolean delete(@Param("userId") Integer userId, @Param("roleLevel") Integer roleLevel);

    boolean update(User user);

    boolean batchDelete(List<Integer> userList);
}
