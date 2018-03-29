package com.bridge.controller;

import com.bridge.dao.LocationDao;
import com.bridge.entity.Area;
import com.bridge.entity.City;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@RequestMapping("location")
@Controller
public class LocationController {
    @Autowired
    private LocationDao locationDao;

    @RequestMapping("/getCitiesByProvinceId")
    @ResponseBody
    public List<City> getCitiesByProvinceId(@RequestParam("provinceId") String provinceId) {
        List<City> cityList = new ArrayList<>();
        if (StringUtils.isNotEmpty(provinceId)) {
            cityList = locationDao.findAllCityByProvinceId(Integer.parseInt(provinceId));
        }
        return cityList;
    }

    @RequestMapping("/getAreasByCityId")
    @ResponseBody
    public List<Area> getAreasByCityId(@RequestParam("cityId") String cityId) {
        List<Area> areaList = new ArrayList<>();
        if (StringUtils.isNotEmpty(cityId)) {
            areaList = locationDao.findAllAreaByCityId(Integer.parseInt(cityId));
        }
        return areaList;
    }
}
