package com.bridge.dao;

import com.bridge.entity.Sensor;

public interface SensorDao {

    Sensor findByName(String name);
}
