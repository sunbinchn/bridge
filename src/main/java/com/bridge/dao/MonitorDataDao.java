package com.bridge.dao;

import com.bridge.entity.MonitorData;

import java.util.List;

public interface MonitorDataDao {

    MonitorData findById(Integer id);

    List<MonitorData> findAll();
}
