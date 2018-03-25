package com.bridge.dao;

import com.bridge.entity.MonitorPoint;

import java.util.List;

public interface MonitorPointDao {

    MonitorPoint findById(Integer id);

    List<MonitorPoint> findAll();
}
