package com.bridge.dao;

import com.bridge.entity.Sensor;

import java.util.List;

public interface SensorDao {

    Sensor findById(Integer id);

    List<Sensor> findAll();
}
