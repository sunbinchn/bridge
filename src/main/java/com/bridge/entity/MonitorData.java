package com.bridge.entity;

import java.math.BigDecimal;
import java.util.Date;

public class MonitorData {
    private Integer id;
    private Sensor sensor;
    private MonitorPoint monitorPoint;
    private BigDecimal temp;
    private BigDecimal measurements;
    private BigDecimal deviation;
    private String unit;
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

    public MonitorPoint getMonitorPoint() {
        return monitorPoint;
    }

    public void setMonitorPoint(MonitorPoint monitorPoint) {
        this.monitorPoint = monitorPoint;
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

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
