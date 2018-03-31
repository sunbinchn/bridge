package com.bridge.entity;

import java.math.BigDecimal;

public class MonitorType {
    private Integer id;
    private Bridge bridge;
    private String monitorName;
    private String type;
    private BigDecimal hial; //高预警
    private BigDecimal loal; //低预警

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Bridge getBridge() {
        return bridge;
    }

    public void setBridge(Bridge bridge) {
        this.bridge = bridge;
    }

    public String getMonitorName() {
        return monitorName;
    }

    public void setMonitorName(String monitorName) {
        this.monitorName = monitorName;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public BigDecimal getHial() {
        return hial;
    }

    public void setHial(BigDecimal hial) {
        this.hial = hial;
    }

    public BigDecimal getLoal() {
        return loal;
    }

    public void setLoal(BigDecimal loal) {
        this.loal = loal;
    }
}
