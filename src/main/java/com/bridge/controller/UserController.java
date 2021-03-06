package com.bridge.controller;

import com.bridge.entity.User;
import com.bridge.service.UserService;
import com.bridge.vo.result.BaseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/login")
public class UserController {

    @Autowired
    UserService userService;

    @RequestMapping("/index.html")
    public String login(HttpServletRequest request) {
        return "login";
    }

    @RequestMapping(value = "/signin", method = RequestMethod.POST)
    @ResponseBody
    public BaseResult signIn(User user, HttpServletRequest request) {
        BaseResult result = new BaseResult();
        if (user == null) {
            result.setSuccess(false);
            result.setMessage("用户名或密码不能为空");
            return result;
        }
        User findUser = userService.findUserByName(user.getUserName());
        if (findUser != null) {
            if (findUser.getPassword().equals(user.getPassword())) {
                result.setSuccess(true);
                request.getSession().setAttribute("userName", findUser.getUserName());
                request.getSession().setAttribute("userId", findUser.getUserId());
                request.getSession().setAttribute("role", findUser.getRole());
            } else {
                result.setSuccess(false);
                result.setMessage("用户名或密码错误");
            }
        } else {
            result.setSuccess(false);
            result.setMessage("用户名或密码错误");
        }
        return result;
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public BaseResult register(User user) {
        BaseResult result = userService.saveUser(user);
        return result;
    }
    @RequestMapping(value = "/logOut")
    public String logOut(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/bridge/login/index.html";
    }
}
