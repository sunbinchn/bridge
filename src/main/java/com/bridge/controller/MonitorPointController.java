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
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("monitorPoint")
public class MonitorPointController {
    private static final Integer PAGE_SIZE = 10;
    private static final Integer NAVIGATE_PAGES = 5;
    @Autowired
    private MonitorPointDao monitorPointDao;
    @Autowired
    private LocationDao locationDao;
    @Autowired
    private UserDao userDao;

    @RequestMapping("/index")
    public String index(@RequestParam(value = "pn", defaultValue = "1") Integer pn, HttpServletRequest request) {
        Integer role = (Integer) request.getSession().getAttribute("role");
        PageHelper.startPage(pn, PAGE_SIZE); // PageHelper 只对紧跟着的第一个 SQL 语句起作用
        PageInfo<MonitorPoint> pageInfo;
        if (RoleConstant.ADMIN.getRole().equals(role) || RoleConstant.SUPER_ADMIN.getRole().equals(role)) {
            pageInfo = new PageInfo<>(monitorPointDao.findAll(), NAVIGATE_PAGES);
            //管理员添加监测点需要指定监测点的所属用户
            List<User> targetUserList = userDao.findAllByRoleLevel(role);
            request.setAttribute("targetUserList", targetUserList);
        } else { //普通用户只能看到自己的监测点
            Integer userId = (Integer) request.getSession().getAttribute("userId");
            pageInfo = new PageInfo<>(monitorPointDao.findAllByUserId(userId), NAVIGATE_PAGES);
        }
        if (!CollectionUtils.isEmpty(pageInfo.getList())) {
            for (MonitorPoint monitorPoint : pageInfo.getList()) {
                Area area = monitorPoint.getArea();
                if (area != null) {
                    String province = area.getCity().getProvince().getProvince();
                    String city = area.getCity().getCity();
                    String location = province + "，" + city + "，" + area.getArea();
                    monitorPoint.setLocation(location);
                }
            }
        }
        request.setAttribute("pageInfo", pageInfo);
        List<Province> provinceList = locationDao.findAllProvince();
        request.setAttribute("provinceList", provinceList);
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
            Integer userId = (Integer) request.getSession().getAttribute("userId");
            user.setUserId(userId);
        }
        if (vo.getId() == null) { //update
            //保存前判断目标用户是否已经存在这个名字的监测点
            MonitorPoint find = monitorPointDao.findByUserIdAndPointName(user.getUserId(), vo.getName());
            if (find != null) {
                result.setSuccess(false);
                result.setMessage("该检测点已经存在！不能重复创建");
                return result;
            }
        }
        monitorPoint.setUser(user);
        monitorPoint.setName(vo.getName());
        Area area = new Area();
        area.setAreaid(vo.getAreaId());
        monitorPoint.setArea(area);
        monitorPoint.setLongitude(vo.getLongitude());
        monitorPoint.setLatitude(vo.getLatitude());
        monitorPoint.setRemark(vo.getRemark());
        if (vo.getId() != null) { //update
            boolean save = monitorPointDao.save(monitorPoint);
            if (save) {
                result.setSuccess(true);
            }
        } else { //create
            boolean update = monitorPointDao.update(monitorPoint);
            if (update) {
                result.setSuccess(true);
            }
        }

        return result;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public BaseResult delete(@RequestParam("id") Integer id, HttpServletRequest request) {
        BaseResult result = new BaseResult();
        Integer role = (Integer) request.getSession().getAttribute("role");
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        boolean delete = false;
        if (RoleConstant.ADMIN.getRole().equals(role) || RoleConstant.SUPER_ADMIN.getRole().equals(role)) { //管理员可以直接删除
            delete = monitorPointDao.delete(id);
        } else { //非管理员只可以删除属于自己的监测点
            MonitorPoint byId = monitorPointDao.findById(id);
            if (byId.getUser() != null && byId.getUser().getUserId().equals(userId)) {
                delete = monitorPointDao.delete(id);
            }
        }
        result.setSuccess(delete);
        return result;
    }

}
