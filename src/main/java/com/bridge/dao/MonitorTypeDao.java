package com.bridge.dao;

import com.bridge.entity.MonitorType;
import com.bridge.entity.Sensor;

import java.util.List;

public interface MonitorTypeDao {

    MonitorType findById(Integer id);

    List<MonitorType> findAll();

    List<Sensor> findAllByUserId(Integer userId);
}
