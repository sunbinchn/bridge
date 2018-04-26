package com.bridge.controller;

import com.bridge.dao.MonitorDataDao;
import com.bridge.entity.MonitorData;
import com.bridge.vo.criteria.MonitorDataCriteria;
import com.bridge.vo.result.BaseResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("monitorInfoData")
@SuppressWarnings("all")
public class MonitorDataInfoController {
    private static final Integer PAGE_SIZE = 15;
    private static final Integer NAVIGATE_PAGES = 5;

    @Autowired
    private MonitorDataDao monitorDataDao;


    @RequestMapping("getAll")
    public String getAll(@RequestParam(value = "pn", defaultValue = "1") Integer pn, @RequestParam(value = "dateRange", required = false) String dateRange, HttpServletRequest request) {
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        PageHelper.startPage(pn, PAGE_SIZE); // PageHelper 只对紧跟着的第一个 SQL 语句起作用
        PageInfo<MonitorData> pageInfo;
        Date fromDate = null;
        Date toDate = null;
        if (StringUtils.isNotEmpty(dateRange)) {
            try {
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                String[] split = dateRange.split("_");
                if (split.length == 2) {
                    fromDate = simpleDateFormat.parse(split[0]);
                    toDate = simpleDateFormat.parse(split[1]);
                } else if (split.length == 1){
                    fromDate = simpleDateFormat.parse(split[0]);
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        MonitorDataCriteria criteria = new MonitorDataCriteria();
        criteria.setUserId(userId);
        criteria.setFromDate(fromDate);
        criteria.setToDate(toDate);
        pageInfo = new PageInfo<>(monitorDataDao.findAllByCriteria(criteria), NAVIGATE_PAGES);
        request.setAttribute("pageInfo", pageInfo);
        return "monitorDataInfo";
    }


    @RequestMapping("/alert/getAll")
    public String alertAetAll(@RequestParam(value = "pn", defaultValue = "1") Integer pn, @RequestParam(value = "dateRange", required = false) String dateRange, HttpServletRequest request) {
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        PageHelper.startPage(pn, PAGE_SIZE); // PageHelper 只对紧跟着的第一个 SQL 语句起作用
        PageInfo<MonitorData> pageInfo;
        Date fromDate = null;
        Date toDate = null;
        if (StringUtils.isNotEmpty(dateRange)) {
            try {
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                String[] split = dateRange.split("_");
                if (split.length == 2) {
                    fromDate = simpleDateFormat.parse(split[0]);
                    toDate = simpleDateFormat.parse(split[1]);
                } else if (split.length == 1){
                    fromDate = simpleDateFormat.parse(split[0]);
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        MonitorDataCriteria criteria = new MonitorDataCriteria();
        criteria.setUserId(userId);
        criteria.setFromDate(fromDate);
        criteria.setToDate(toDate);
        pageInfo = new PageInfo<>(monitorDataDao.findAllAlertByCriteria(criteria), NAVIGATE_PAGES);
        request.setAttribute("pageInfo", pageInfo);
        return "monitorDataAlertInfo";
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
