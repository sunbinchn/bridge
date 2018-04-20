package com.bridge.dao;

import com.bridge.entity.MonitorType;
import com.bridge.entity.Sensor;
import com.bridge.entity.SensorType;
import com.bridge.entity.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/spring-dao.xml")
public class SensorDaoTest {
    private static Logger logger = LoggerFactory.getLogger(CommonTest.class);
    @Autowired
    private SensorDao sensorDao;

    @Test
    public void test() {
        Sensor byName = sensorDao.findByName("SZY-001");
    }
    @Test
    public void insertOrUpdate() {
        Sensor sensor = new Sensor();
        sensor.setName("传感器002");
        SensorType sensorType = new SensorType();
        sensorType.setId(1);
        sensor.setSensorType(sensorType);
        User user = new User();
        user.setUserId(1);
        sensor.setUser(user);
        MonitorType monitorType = new MonitorType();
        monitorType.setId(1);
        sensor.setMonitorType(monitorType);
        sensorDao.insert(sensor);
        sensor.setName("传感器003");
        sensorDao.update(sensor);
    }
}
