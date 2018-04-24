package com.bridge.dao;

import com.bridge.entity.MonitorType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MonitorTypeDao {

    MonitorType findById(Integer id);

    List<MonitorType> findAll();

    List<MonitorType> findAllByUserId(Integer userId);

    boolean delete(Integer id);

    MonitorType findByUserIdAndMonitorName(@Param("userId") Integer userId,@Param("monitorName")  String monitorName);

    boolean update(MonitorType monitorType);

    boolean insert(MonitorType monitorType);
}
