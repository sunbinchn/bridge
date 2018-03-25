package com.bridge.controller;

import com.bridge.dao.UserDao;
import com.bridge.entity.User;
import com.bridge.vo.result.BaseResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("userManage")
public class UserManageController {

    private static final Integer PAGE_SIZE = 10;
    private static final Integer NAVIGATE_PAGES = 5;
    @Autowired
    private UserDao userDao;

    @RequestMapping("/getAll")
    public String userManage(@RequestParam(value = "pn", defaultValue = "1") Integer pn, HttpServletRequest request) {
        Integer role = (Integer) request.getSession().getAttribute("role");
        PageHelper.startPage(pn, PAGE_SIZE); // PageHelper 只对紧跟着的第一个 SQL 语句起作用
        PageInfo<User> pageInfo;
        pageInfo = new PageInfo<>(userDao.findAllByRoleLevel(role), NAVIGATE_PAGES);
        request.setAttribute("pageInfo", pageInfo);
        return "userManage";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public BaseResult delete(@RequestParam("userId") Integer userId, HttpServletRequest request) {
        BaseResult result = new BaseResult();
        Integer roleLevel = (Integer)request.getSession().getAttribute("role");
        if (roleLevel == 0) {
            result.setSuccess(false);
            result.setMessage("权限不足!");
            return result;
        }
        boolean delete = userDao.delete(userId, roleLevel);
        if (delete) {
            result.setSuccess(true);
            result.setMessage(String.valueOf(userId));
        }
        return result;
    }
}
