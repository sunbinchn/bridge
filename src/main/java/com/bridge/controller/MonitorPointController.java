package com.bridge.controller;

import com.bridge.contants.RoleConstant;
import com.bridge.dao.LocationDao;
import com.bridge.dao.MonitorPointDao;
import com.bridge.dao.UserDao;
import com.bridge.entity.Area;
import com.bridge.entity.MonitorPoint;
import com.bridge.entity.Province;
import com.bridge.entity.User;
import com.bridge.vo.MonitorPointVo;
import com.bridge.vo.result.BaseResult;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("monitorPoint")
public class MonitorPointController {
    @Autowired
    private MonitorPointDao monitorPointDao;
    @Autowired
    private LocationDao locationDao;
    @Autowired
    private UserDao userDao;

    @RequestMapping("/index")
    public String index(HttpServletRequest request) {
        List<Province> provinceList = locationDao.findAllProvince();
        request.setAttribute("provinceList", provinceList);
        Integer role = (Integer) request.getSession().getAttribute("role");
        List<MonitorPoint> monitorPointList;
        if (RoleConstant.ADMIN.getRole().equals(role) || RoleConstant.SUPER_ADMIN.getRole().equals(role)) {
            monitorPointList = monitorPointDao.findAll();
            //管理员添加监测点需要指定监测点的所属用户
            List<User> targetUserList = userDao.findAllByRoleLevel(role);
            request.setAttribute("targetUserList", targetUserList);
        } else { //普通用户只能看到自己的监测点
            Integer userId = (Integer) request.getSession().getAttribute("userId");
            monitorPointList = monitorPointDao.findAllByUserId(userId);
        }
        request.setAttribute("monitorPointList", monitorPointList);
        return "monitorPointManage";
    }
    @RequestMapping("/save")
    @ResponseBody
    public BaseResult save(@RequestBody MonitorPointVo vo, HttpServletRequest request) {
        BaseResult result = new BaseResult();
        if (StringUtils.isEmpty(vo.getName())) {
            result.setSuccess(false);
            result.setMessage("监测点名称不能为空！");
            return result;
        }
        MonitorPoint monitorPoint = new MonitorPoint();
        User user = new User();
        if (vo.getUserId() != null) { //管理员为目标用户添加相应的监测点
            user.setUserId(vo.getUserId());
        } else { //当前用户为自己添加
            Integer userId = (Integer)request.getSession().getAttribute("userId");
            user.setUserId(userId);
        }
        //保存前判断目标用户是否已经存在这个名字的监测点
        MonitorPoint find = monitorPointDao.findByUserIdAndPointName(user.getUserId(), vo.getName());
        if (find != null) {
            result.setSuccess(false);
            result.setMessage("该检测点已经存在！不能重复创建");
            return result;
        }

        monitorPoint.setUser(user);
        monitorPoint.setName(vo.getName());
        Area area = new Area();
        area.setAreaid(vo.getAreaId());
        monitorPoint.setArea(area);
        monitorPoint.setLongitude(vo.getLongitude());
        monitorPoint.setLatitude(vo.getLatitude());
        monitorPoint.setRemark(vo.getRemark());
        boolean save = monitorPointDao.save(monitorPoint);
        if (save) {
            result.setSuccess(true);
        }
        return result;
    }
}
