package com.bridge.dao;

import com.bridge.entity.SensorType;

import java.util.List;

public interface SensorTypeDao {

    SensorType findById(Integer id);

    List<SensorType> findAll();

    SensorType findByName(String sensorTypeName);

    boolean insert(SensorType vo);

    boolean update(SensorType vo);
}
