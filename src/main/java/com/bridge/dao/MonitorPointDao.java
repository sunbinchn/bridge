package com.bridge.dao;

import com.bridge.entity.MonitorPoint;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MonitorPointDao {

    MonitorPoint findById(Integer id);

    List<MonitorPoint> findAll();

    List<MonitorPoint> findAllByUserId(Integer id);

    boolean save(MonitorPoint monitorPoint);

    MonitorPoint findByUserIdAndPointName(@Param("userId") Integer userId,@Param("name") String name);

    boolean delete(Integer id);

    boolean update(MonitorPoint monitorPoint);
}
