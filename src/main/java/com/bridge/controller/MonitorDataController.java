package com.bridge.controller;

import com.bridge.dao.MonitorDataDao;
import com.bridge.dao.SensorDao;
import com.bridge.entity.MonitorData;
import com.bridge.entity.Sensor;
import com.bridge.vo.MonitorDataVo;
import com.bridge.vo.result.BaseResult;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;

@Controller
@RequestMapping("monitorData")
public class MonitorDataController {

    @Autowired
    private MonitorDataDao monitorDataDao;
    @Autowired
    private SensorDao sensorDao;
    @RequestMapping("handle")
    @ResponseBody
    public BaseResult handle(@RequestBody MonitorDataVo monitorDataVo, HttpServletRequest request) {
        BaseResult result = new BaseResult();
        if (StringUtils.isEmpty(monitorDataVo.getDeviant()) && StringUtils.isEmpty(monitorDataVo.getTemperature())
                && StringUtils.isEmpty(monitorDataVo.getValue())) {
            result.setSuccess(false);
            result.setMessage("empty data");
            return result;
        }
        MonitorData monitorData = new MonitorData();
        if (StringUtils.isNotEmpty(monitorDataVo.getId())) {
            Sensor sensor = sensorDao.findByName(monitorDataVo.getId());
            monitorData.setSensor(sensor);
        }
        monitorData.setTemp(convert(monitorDataVo.getTemperature()));
        monitorData.setMeasurements(convert(monitorDataVo.getValue()));
        monitorData.setDeviation(convert(monitorDataVo.getDeviant()));
        monitorDataDao.insert(monitorData);
        result.setSuccess(true);
        result.setMessage(String.valueOf(monitorData.getId()));
        return result;
    }
    private BigDecimal convert(String str) {
        if (StringUtils.isNotEmpty(str)) {
            return new BigDecimal(str);
        }
        return null;
    }
}
