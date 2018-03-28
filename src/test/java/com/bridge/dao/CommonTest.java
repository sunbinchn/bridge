package com.bridge.dao;

import com.bridge.entity.*;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/spring-dao.xml")
public class CommonTest {

    private static Logger logger = LoggerFactory.getLogger(CommonTest.class);
    @Autowired
    private BridgeDao bridgeDao;
    @Autowired
    private MonitorDataDao monitorDataDao;
    @Autowired
    private MonitorPointDao monitorPointDao;
    @Autowired
    private MonitorTypeDao monitorTypeDao;
    @Autowired
    private SensorTypeDao sensorTypeDao;

    @Test
    public void testFindById() {
        Bridge bridge = bridgeDao.findById(1);
        MonitorData monitorData = monitorDataDao.findById(1);
        MonitorPoint monitorPoint = monitorPointDao.findById(1);
        MonitorType monitorType = monitorTypeDao.findById(1);
        SensorType byId = sensorTypeDao.findById(1);
    }

    @Test
    public void testFindAll() {
        List<Bridge> bridgeList = bridgeDao.findAll();
        List<MonitorData> monitorDataList = monitorDataDao.findAll();
        List<MonitorPoint> monitorPointList = monitorPointDao.findAll();
        List<MonitorType> monitorTypeList = monitorTypeDao.findAll();
        List<SensorType> sensorTypes = sensorTypeDao.findAll();
    }
}

