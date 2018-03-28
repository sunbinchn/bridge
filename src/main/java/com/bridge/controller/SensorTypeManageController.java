package com.bridge.controller;

import com.bridge.dao.SensorTypeDao;
import com.bridge.entity.SensorType;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("sensorTypeManage")
public class SensorTypeManageController {
    private static final Integer PAGE_SIZE = 8;
    private static final Integer NAVIGATE_PAGES = 5;
    @Autowired
    private SensorTypeDao sensorTypeDao;

    @RequestMapping("getAll")
    public String getAll(@RequestParam(value = "pn", defaultValue = "1") Integer pn, HttpServletRequest request) {
        PageHelper.startPage(pn, PAGE_SIZE); // PageHelper 只对紧跟着的第一个 SQL 语句起作用
        PageInfo<SensorType> pageInfo;
        pageInfo = new PageInfo<>(sensorTypeDao.findAll(), NAVIGATE_PAGES);
        request.setAttribute("pageInfo", pageInfo);
        return "sensorTypeManage";
    }
}
