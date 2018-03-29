package com.bridge.dao;

import com.bridge.entity.Area;
import com.bridge.entity.City;
import com.bridge.entity.Province;

import java.util.List;

public interface LocationDao {
    Area findAreaById(Integer id);

    City findCityById(Integer id);

    Province findProvinceById(Integer id);

    List<Province> findAllProvince();

    List<City> findAllCityByProvinceId(Integer id);

    List<Area> findAllAreaByCityId(Integer id);
}
