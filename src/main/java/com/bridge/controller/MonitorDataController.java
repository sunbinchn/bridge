package com.bridge.controller;

import com.bridge.dao.MonitorDataDao;
import com.bridge.dao.SensorDao;
import com.bridge.entity.MonitorData;
import com.bridge.entity.MonitorType;
import com.bridge.entity.Sensor;
import com.bridge.utils.EmailUtil;
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
import java.text.SimpleDateFormat;
import java.util.Date;

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
            checkAndEmail(sensor, monitorDataVo);
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

    public void checkAndEmail(Sensor sensor, MonitorDataVo monitorDataVo) {
        MonitorType monitorType = sensor.getMonitorType();
        if (monitorType != null && StringUtils.isNotEmpty(monitorDataVo.getValue())) {
            BigDecimal hial = monitorType.getHial();
            BigDecimal loal = monitorType.getLoal();
            BigDecimal value = convert(monitorDataVo.getValue());
            String email = sensor.getUser().getEmail();
            if (sensor.getUser() != null && StringUtils.isNotEmpty(email)) {
                String nowDateStr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
                StringBuffer contentHead = new StringBuffer();
                contentHead.append("尊敬的");
                contentHead.append(sensor.getUser().getUserName());
                contentHead.append("用户：<br>");
                contentHead.append(nowDateStr);
                contentHead.append("您的传感器");
                contentHead.append(sensor.getName());
                contentHead.append("监测实时数据为：");
                contentHead.append(monitorDataVo.getValue());
                if (hial != null && value.compareTo(hial) == 1) {
                    StringBuffer hialBuffer = new StringBuffer(contentHead);
                    hialBuffer.append("，已超过您设定的最高值：");
                    hialBuffer.append(monitorType.getHial());
                    hialBuffer.append("，请及时处理");
                    EmailUtil.sendMail(email, "桥梁检测数据超高预警", hialBuffer.toString());
                }
                if (loal != null && value.compareTo(loal) == -1) {
                    StringBuffer loalBuffer = new StringBuffer(contentHead);
                    loalBuffer.append("，已超过您设定的最低值：");
                    loalBuffer.append(monitorType.getLoal());
                    loalBuffer.append("，请及时处理");
                    EmailUtil.sendMail(email, "桥梁检测数据超低预警", loalBuffer.toString());
                }
            }
        }
    }
}
