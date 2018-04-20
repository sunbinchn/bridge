package com.bridge.controller;

import com.bridge.dao.MonitorDataDao;
import com.bridge.dao.SensorDao;
import com.bridge.entity.MonitorData;
import com.bridge.vo.result.BaseResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("monitorInfoData")
public class MonitorDataInfoController {
    private static final Integer PAGE_SIZE = 10;
    private static final Integer NAVIGATE_PAGES = 5;

    @Autowired
    private MonitorDataDao monitorDataDao;
    @Autowired
    private SensorDao sensorDao;


    @RequestMapping("getAll")
    public String getAll(@RequestParam(value = "pn", defaultValue = "1") Integer pn, HttpServletRequest request) {
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        PageHelper.startPage(pn, PAGE_SIZE); // PageHelper 只对紧跟着的第一个 SQL 语句起作用
        PageInfo<MonitorData> pageInfo;
        pageInfo = new PageInfo<>(monitorDataDao.findAllByUserId(userId), NAVIGATE_PAGES);
        request.setAttribute("pageInfo", pageInfo);
        return "monitorDataInfo";
    }

    @RequestMapping("delete/{monitorDataId}")
    @ResponseBody
    public BaseResult delete(@PathVariable("monitorDataId") Integer monitorDataId, HttpServletRequest request) {
        BaseResult result = new BaseResult();
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        MonitorData byId = monitorDataDao.findById(monitorDataId);
        if (validMonitorData(byId)) {
            result.setSuccess(false);
            result.setMessage("错误的数据");
            return result;
        }
        if (!byId.getSensor().getUser().getUserId().equals(userId)) {
            boolean delete = monitorDataDao.deleteById(monitorDataId);
            if (delete) {
                result.setSuccess(true);
            }
        }
        return result;
    }

    @RequestMapping(value = "update", method = RequestMethod.POST)
    @ResponseBody
    public BaseResult delete(@RequestBody MonitorData monitorData, HttpServletRequest request) {
        BaseResult result = new BaseResult();
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        MonitorData byId = monitorDataDao.findById(monitorData.getId());
        if (validMonitorData(byId)) {
            result.setSuccess(false);
            result.setMessage("错误的数据");
            return result;
        }
        if (!byId.getSensor().getUser().getUserId().equals(userId)) {
            boolean update = monitorDataDao.updateById(monitorData);
            if (update) {
                result.setSuccess(true);
            }
        }
        return result;
    }

    private boolean validMonitorData(MonitorData data) {
        if (data == null || data.getSensor() == null || data.getSensor().getUser() == null) {
            return false;
        }
        return true;
    }

}
