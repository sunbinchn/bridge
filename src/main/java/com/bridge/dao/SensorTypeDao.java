package com.bridge.dao;

import com.bridge.entity.SensorType;

import java.util.List;

public interface SensorTypeDao {

    SensorType findById(Integer id);

    List<SensorType> findAll();
}
