package com.bridge.controller;

import com.bridge.dao.MonitorDataDao;
import com.bridge.dao.SensorDao;
import com.bridge.dao.UserDao;
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
    private static final long EMAIL_INTERVAL = 60 * 60 * 1000; //一小时

    @Autowired
    private MonitorDataDao monitorDataDao;
    @Autowired
    private SensorDao sensorDao;
    @Autowired
    private UserDao userDao;

    /**
     *
     * @param monitorDataVo
     * @param request
     * @return
     */
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
            if (sensor == null) {
                result.setSuccess(false);
                result.setMessage("Sensor" + monitorDataVo.getId() + "does not exist.");
                return result;
            }
            if (checkAndEmail(sensor, monitorDataVo)) {
                monitorData.setIsSendEmail(1);
            } else {
                monitorData.setIsSendEmail(0);
            }
            monitorData.setSensor(sensor);
            monitorData.setMonitorType(sensor.getMonitorType());
        }
        monitorData.setTemp(convert(monitorDataVo.getTemperature()));
        monitorData.setMeasurements(convert(monitorDataVo.getValue()));
        monitorData.setDeviation(convert(monitorDataVo.getDeviant()));
        monitorData.setUnit("mm");
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

    public boolean checkAndEmail(Sensor sensor, MonitorDataVo monitorDataVo) {
        boolean isSendEmail = false;
        MonitorType monitorType = sensor.getMonitorType();
        if (monitorType != null && StringUtils.isNotEmpty(monitorDataVo.getValue())) {
            BigDecimal hial = monitorType.getHial();
            BigDecimal loal = monitorType.getLoal();
            BigDecimal deviation = convert(monitorDataVo.getDeviant()) == null ? BigDecimal.ZERO : convert(monitorDataVo.getDeviant());

            BigDecimal value = convert(monitorDataVo.getValue());
            if (sensor.getUser() == null) {
                return false;
            }
            Date lastSendEmailTime = sensor.getUser().getLastSendEmailTime();
            if (lastSendEmailTime != null && new Date().getTime() - lastSendEmailTime.getTime() < EMAIL_INTERVAL) { //时间间隔小于指定时间不发送邮件
                return false;
            }
            String email = sensor.getUser().getEmail();
            if (StringUtils.isNotEmpty(email)) {
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
                if (hial != null && value.compareTo(hial.add(deviation)) != -1) { //监测值 >= 最高值+误差(不小于)
                    StringBuffer hialBuffer = new StringBuffer(contentHead);
                    hialBuffer.append("，已超过您设定的最高值：");
                    hialBuffer.append(monitorType.getHial());
                    hialBuffer.append("(±"+deviation+")，请及时处理");
                    EmailUtil.sendMail(email, "桥梁检测数据超高预警", hialBuffer.toString());
                    isSendEmail = true;
                }
                if (loal != null && value.compareTo(loal.subtract(deviation)) != 1) {//监测值 <= 最高值-误差（不大于）
                    StringBuffer loalBuffer = new StringBuffer(contentHead);
                    loalBuffer.append("，已超过您设定的最低值：");
                    loalBuffer.append(monitorType.getLoal());
                    loalBuffer.append("(±"+deviation+")，请及时处理");
                    EmailUtil.sendMail(email, "桥梁检测数据超低预警", loalBuffer.toString());
                    isSendEmail = true;
                }
            }
        }
        if (isSendEmail) {
            userDao.updateLastSendEmailTimeById(sensor.getUser().getUserId());
        }
        return isSendEmail;
    }
}
