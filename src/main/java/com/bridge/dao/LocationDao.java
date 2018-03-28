package com.bridge.dao;

import com.bridge.entity.Area;
import com.bridge.entity.City;
import com.bridge.entity.Province;

public interface LocationDao {
    Area findAreaById(Integer id);

    City findCityById(Integer id);

    Province findProvinceById(Integer id);


}
