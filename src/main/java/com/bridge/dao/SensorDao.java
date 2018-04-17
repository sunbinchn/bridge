package com.bridge.dao;

import com.bridge.entity.Sensor;

import java.util.List;

public interface SensorDao {

    Sensor findByName(String name);

    Sensor findById(Integer id);

    List<Sensor> findAll();
}
