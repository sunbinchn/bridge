package com.bridge.controller;

import com.bridge.dao.LocationDao;
import com.bridge.dao.MonitorPointDao;
import com.bridge.entity.Province;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("monitorPoint")
public class MonitorPointController {
    @Autowired
    private MonitorPointDao monitorPointDao;
    @Autowired
    private LocationDao locationDao;

    @RequestMapping("/index")
    public String index(HttpServletRequest request) {
        List<Province> provinceList = locationDao.findAllProvince();
        request.setAttribute("provinceList", provinceList);
        return "monitorPointManage";
    }


}
