package com.bridge.dao;

import com.bridge.entity.Sensor;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SensorDao {

    Sensor findByName(String name);

    Sensor findById(Integer id);

    List<Sensor> findAll();

    List<Sensor> findAllByUserId(Integer userId);

    boolean insert(Sensor sensor);

    boolean update(Sensor sensor);

    boolean delete(Integer id);

    Sensor findByUserIdAndSensorName(@Param("userId") Integer userId,@Param("name") String name);
}
