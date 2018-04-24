package com.bridge.vo;

import java.math.BigDecimal;

public class MonitorTypeVo {
    private Integer id;
    private String monitorName;
    private BigDecimal hial; //高预警
    private BigDecimal loal; //低预警
    private Integer monitorPointId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMonitorName() {
        return monitorName;
    }

    public void setMonitorName(String monitorName) {
        this.monitorName = monitorName;
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

    public Integer getMonitorPointId() {
        return monitorPointId;
    }

    public void setMonitorPointId(Integer monitorPointId) {
        this.monitorPointId = monitorPointId;
    }
}
