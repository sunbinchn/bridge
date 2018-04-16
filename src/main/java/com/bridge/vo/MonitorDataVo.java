package com.bridge.vo;

public class MonitorDataVo {

    private String id;
    private String temperature; //温度
    private String value; //测量值
    private String deviant; //偏移值

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTemperature() {
        return temperature;
    }

    public void setTemperature(String temperature) {
        this.temperature = temperature;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getDeviant() {
        return deviant;
    }

    public void setDeviant(String deviant) {
        this.deviant = deviant;
    }
}
