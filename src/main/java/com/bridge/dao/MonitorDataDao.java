package com.bridge.dao;

import com.bridge.entity.MonitorData;
import com.bridge.vo.criteria.MonitorDataCriteria;

import java.util.List;

public interface MonitorDataDao {

    MonitorData findById(Integer id);

    List<MonitorData> findAll();

    List<MonitorData> findAllByUserId(Integer userId);

    List<MonitorData> findAllByCriteria(MonitorDataCriteria criteria);

    boolean insert(MonitorData monitorData);

    boolean deleteById(Integer monitorDataId);

    boolean updateById(MonitorData monitorData);

    Integer countBySensorId(Integer sensorId);

    /**
     * 找到所有需要预警的数据
     * @param criteria
     * @return
     */
    List<MonitorData> findAllAlertByCriteria(MonitorDataCriteria criteria);

    Integer countByMonitorTypeId(Integer id);
}
