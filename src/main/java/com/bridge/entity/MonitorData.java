package com.bridge.entity;

import java.math.BigDecimal;
import java.util.Date;

public class MonitorData {
    private Integer id;
    private Sensor sensor;
    private MonitorType monitorType; //一条数据当中会记录传感器和监测类型（里面包括了监测点），这样当传感器换了监测类型之后，这条数据也还是不会变的
    private BigDecimal temp;
    private BigDecimal measurements; //测量值
    private BigDecimal deviation; //偏差值
    private String unit;
    private Integer isSendEmail;
    private Date createTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Sensor getSensor() {
        return sensor;
    }

    public void setSensor(Sensor sensor) {
        this.sensor = sensor;
    }

    public MonitorType getMonitorType() {
        return monitorType;
    }

    public void setMonitorType(MonitorType monitorType) {
        this.monitorType = monitorType;
    }

    public BigDecimal getTemp() {
        return temp;
    }

    public void setTemp(BigDecimal temp) {
        this.temp = temp;
    }

    public BigDecimal getMeasurements() {
        return measurements;
    }

    public void setMeasurements(BigDecimal measurements) {
        this.measurements = measurements;
    }

    public BigDecimal getDeviation() {
        return deviation;
    }

    public void setDeviation(BigDecimal deviation) {
        this.deviation = deviation;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Integer getIsSendEmail() {
        return isSendEmail;
    }

    public void setIsSendEmail(Integer isSendEmail) {
        this.isSendEmail = isSendEmail;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
