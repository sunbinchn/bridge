package com.bridge.dao;

import com.bridge.entity.MonitorType;

import java.util.List;

public interface MonitorTypeDao {

    MonitorType findById(Integer id);

    List<MonitorType> findAll();
}
