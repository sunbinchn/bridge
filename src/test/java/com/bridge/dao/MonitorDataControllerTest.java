package com.bridge.dao;

import com.bridge.controller.MonitorDataController;
import com.bridge.entity.MonitorType;
import com.bridge.entity.Sensor;
import com.bridge.entity.User;
import com.bridge.vo.MonitorDataVo;
import org.junit.Test;

import java.math.BigDecimal;

/**
 * Created by SUNNE on 4/18/2018.
 */
//@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration("classpath:spring/spring-dao.xml")
public class MonitorDataControllerTest {

    @Test
    public void email() {
        MonitorDataController controller = new MonitorDataController();
        Sensor sensor = new Sensor();
        sensor.setName("XZY-001");
        User user = new User();
        user.setEmail("411938182@qq.com");
        user.setUserName("admin");
        sensor.setUser(user);
        MonitorType monitorType = new MonitorType();
        monitorType.setHial(BigDecimal.TEN);
        monitorType.setLoal(BigDecimal.ZERO);
        sensor.setMonitorType(monitorType);

        MonitorDataVo vo = new MonitorDataVo();
        vo.setValue("11");
        controller.checkAndEmail(sensor, vo);
    }
}
