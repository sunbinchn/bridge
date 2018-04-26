package com.bridge.controller;

import com.bridge.dao.MonitorDataDao;
import com.bridge.dao.MonitorTypeDao;
import com.bridge.dao.SensorDao;
import com.bridge.dao.SensorTypeDao;
import com.bridge.entity.*;
import com.bridge.vo.SensorVo;
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
@RequestMapping("sensor")
public class SensorController {
    private static final Integer PAGE_SIZE = 10;
    private static final Integer NAVIGATE_PAGES = 5;
    @Autowired
    private SensorDao sensorDao;
    @Autowired
    private MonitorTypeDao monitorTypeDao;
    @Autowired
    private SensorTypeDao sensorTypeDao;
    @Autowired
    private MonitorDataDao monitorDataDao;

    @RequestMapping("/index")
    public String index(@RequestParam(value = "pn", defaultValue = "1") Integer pn, HttpServletRequest request) {
        Integer role = (Integer) request.getSession().getAttribute("role");
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        PageHelper.startPage(pn, PAGE_SIZE); // PageHelper 只对紧跟着的第一个 SQL 语句起作用
        PageInfo<Sensor> pageInfo;
//        if (RoleConstant.ADMIN.getRole().equals(role) || RoleConstant.SUPER_ADMIN.getRole().equals(role)) {
//            pageInfo = new PageInfo<>(sensorDao.findAll(), NAVIGATE_PAGES);
//        } else {
            pageInfo = new PageInfo<>(sensorDao.findAllByUserId(userId), NAVIGATE_PAGES);
//        }
        request.setAttribute("pageInfo", pageInfo);
        request.setAttribute("sensorTypeList", sensorTypeDao.findAll());
        request.setAttribute("monitorTypeList", monitorTypeDao.findAllByUserId(userId));
        return "sensorManage";
    }

    @RequestMapping("/save")
    @ResponseBody
    public BaseResult save(@RequestBody SensorVo vo, HttpServletRequest request) {
        BaseResult result = new BaseResult();
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (StringUtils.isEmpty(vo.getName())) {
            result.setSuccess(false);
            result.setMessage("传感器名称不能为空！");
            return result;
        }
        Sensor find = sensorDao.findByUserIdAndSensorName(userId, vo.getName());
        if (find != null && vo.getId() == null) {
            result.setSuccess(false);
            result.setMessage("该传感器名称已经存在！不能重复创建");
            return result;
        }
        Sensor sensor = new Sensor();
        User user = new User();
        user.setUserId(userId);
        sensor.setUser(user);

        sensor.setId(vo.getId());
        sensor.setName(vo.getName());

        SensorType sensorType = new SensorType();
        sensorType.setId(vo.getSensorTypeId());
        sensor.setSensorType(sensorType);

        MonitorType monitorType = new MonitorType();
        monitorType.setId(vo.getMonitorTypeId());
        sensor.setMonitorType(monitorType);

        if (vo.getId() != null) { //update
            boolean update = sensorDao.update(sensor);
            if (update) {
                result.setSuccess(true);
                result.setMessage("update");
            }
        } else { //create
            boolean save = sensorDao.insert(sensor);
            if (save) {
                result.setSuccess(true);
                result.setMessage("save");
            }
        }
        return result;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public BaseResult delete(@RequestParam("id") Integer id, HttpServletRequest request) {
        BaseResult result = new BaseResult();
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        Integer integer = monitorDataDao.countBySensorId(id);
        if (integer > 0) {
            result.setSuccess(false);
            result.setMessage("该传感器已经产生数据，无法删除！");
            return result;
        }
        Sensor byId = sensorDao.findById(id);
        if (byId.getUser().getUserId().equals(userId)) {
            if (sensorDao.delete(id)) {
                result.setSuccess(true);
            }
        }
        return result;
    }

}
