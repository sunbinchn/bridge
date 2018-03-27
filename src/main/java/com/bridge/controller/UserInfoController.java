package com.bridge.controller;

import com.bridge.dao.UserDao;
import com.bridge.entity.User;
import com.bridge.vo.UserVo;
import com.bridge.vo.result.BaseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("userInfo")
public class UserInfoController {
    @Autowired
    private UserDao userDao;

    @RequestMapping("/index")
    public String index(HttpServletRequest request) {
        Integer userId = (Integer)request.getSession().getAttribute("userId");
        User user = userDao.findById(userId);
        request.setAttribute("user", user);
        return "baseUserInfo";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public BaseResult update(@RequestBody User user, HttpServletRequest request) {
        BaseResult result = new BaseResult();
        Integer userId = (Integer)request.getSession().getAttribute("userId");
        user.setUserId(userId);
        boolean update = userDao.update(user);
        if (update) {
            result.setSuccess(true);
        }
        return result;
    }
    @RequestMapping(value = "/updatePass", method = RequestMethod.POST)
    @ResponseBody
    public BaseResult updatePassword(@RequestBody UserVo userVo, HttpServletRequest request) {
        BaseResult result = new BaseResult();
        Integer userId = (Integer)request.getSession().getAttribute("userId");
        User user = userDao.findById(userId);
        if (user.getPassword().equals(userVo.getOldPassword())) {
            user.setPassword(userVo.getNewPassword());
            boolean updatePassword = userDao.updatePassword(user);
            if (updatePassword) {
                result.setSuccess(true);
            }
        } else {
            result.setSuccess(false);
            result.setMessage("原密码输入错误，请重新输入!");
        }
        return result;
    }


}
