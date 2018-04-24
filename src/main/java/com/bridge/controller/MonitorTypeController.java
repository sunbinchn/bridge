package com.bridge.controller;

import com.bridge.dao.MonitorPointDao;
import com.bridge.dao.MonitorTypeDao;
import com.bridge.entity.MonitorPoint;
import com.bridge.entity.MonitorType;
import com.bridge.entity.User;
import com.bridge.vo.MonitorTypeVo;
import com.bridge.vo.result.BaseResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("monitorType")
public class MonitorTypeController {
    private static final Integer PAGE_SIZE = 10;
    private static final Integer NAVIGATE_PAGES = 5;
    @Autowired
    private MonitorPointDao monitorPointDao;
    @Autowired
    private MonitorTypeDao monitorTypeDao;

    @RequestMapping("/index")
    public String index(@RequestParam(value = "pn", defaultValue = "1") Integer pn, HttpServletRequest request) {
        Integer role = (Integer) request.getSession().getAttribute("role");
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        PageHelper.startPage(pn, PAGE_SIZE); // PageHelper 只对紧跟着的第一个 SQL 语句起作用
        PageInfo<MonitorType> pageInfo;
//        if (RoleConstant.ADMIN.getRole().equals(role) || RoleConstant.SUPER_ADMIN.getRole().equals(role)) {
//            pageInfo = new PageInfo<>(monitorTypeDao.findAll(), NAVIGATE_PAGES);
//            request.setAttribute("monitorPointList", monitorPointDao.findAll());
//        } else {
            pageInfo = new PageInfo<>(monitorTypeDao.findAllByUserId(userId), NAVIGATE_PAGES);
            request.setAttribute("monitorPointList", monitorPointDao.findAllByUserId(userId));
//        }
        request.setAttribute("pageInfo", pageInfo);
        return "monitorTypeManage";
    }

    @RequestMapping("/save")
    @ResponseBody
    public BaseResult save(@RequestBody MonitorTypeVo vo, HttpServletRequest request) {
        BaseResult result = new BaseResult();
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (StringUtils.isEmpty(vo.getMonitorName())) {
            result.setSuccess(false);
            result.setMessage("监测名称不能为空！");
            return result;
        }
        MonitorType find = monitorTypeDao.findByUserIdAndMonitorName(userId, vo.getMonitorName());
        if (find != null && vo.getId() == null) {
            result.setSuccess(false);
            result.setMessage("该传感器名称已经存在！不能重复创建");
            return result;
        }
        MonitorType monitorType = new MonitorType();
        monitorType.setId(vo.getId());
        monitorType.setMonitorName(vo.getMonitorName());
        monitorType.setHial(vo.getHial());
        monitorType.setLoal(vo.getLoal());

        MonitorPoint monitorPoint = new MonitorPoint();
        monitorPoint.setId(vo.getMonitorPointId());
        User user = new User();
        user.setUserId(userId);
        monitorPoint.setUser(user);
        monitorType.setMonitorPoint(monitorPoint);

        if (vo.getId() != null) { //update
            if (monitorTypeDao.update(monitorType)) {
                result.setSuccess(true);
                result.setMessage("update");
            }
        } else { //create
            if (monitorTypeDao.insert(monitorType)) {
                result.setSuccess(true);
                result.setMessage("save");
            }
        }
        return result;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public BaseResult delete(@RequestParam("id") Integer id, HttpServletRequest request) {
        BaseResult result = new BaseResult();
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        MonitorType byId = monitorTypeDao.findById(id);
        if (byId.getMonitorPoint().getUser().getUserId().equals(userId)) {
            if (monitorTypeDao.delete(id)) {
                result.setSuccess(true);
            }
        }
        return result;
    }

}
