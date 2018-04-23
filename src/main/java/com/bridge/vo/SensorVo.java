package com.bridge.vo;

public class SensorVo {
    private Integer id;
    private String name;
    private Integer sensorTypeId;
    private Integer monitorTypeId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getSensorTypeId() {
        return sensorTypeId;
    }

    public void setSensorTypeId(Integer sensorTypeId) {
        this.sensorTypeId = sensorTypeId;
    }

    public Integer getMonitorTypeId() {
        return monitorTypeId;
    }

    public void setMonitorTypeId(Integer monitorTypeId) {
        this.monitorTypeId = monitorTypeId;
    }
}
