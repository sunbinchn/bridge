package com.bridge.controller;

import com.bridge.dao.SensorTypeDao;
import com.bridge.entity.SensorType;
import com.bridge.vo.result.BaseResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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

    @RequestMapping("updateOrCreate")
    @ResponseBody
    public BaseResult updateOrCreate(@RequestBody SensorType vo, HttpServletRequest request) {
        BaseResult result = new BaseResult();
        if (StringUtils.isEmpty(vo.getSensorTypeName())) {
            result.setSuccess(false);
            result.setMessage("传感器类型不能为空！");
            return result;
        }
        if (vo.getId() == null) { // create
            SensorType byName = sensorTypeDao.findByName(vo.getSensorTypeName());
            if (byName != null && byName.getSensorTypeName().equals(vo.getSensorTypeName())){
                result.setSuccess(false);
                result.setMessage("该传感器类型已存在，请不要重复创建！");
                return result;
            } else {
                boolean insert = sensorTypeDao.insert(vo);
                if (insert) {
                    result.setSuccess(true);
                }
            }
        } else { //update
            boolean update = sensorTypeDao.update(vo);
            if (update) {
                result.setSuccess(true);
            }
        }
        return result;
    }
}
