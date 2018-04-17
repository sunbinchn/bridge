package com.bridge.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("chartInfo")
public class ChartInfoController {

    @RequestMapping("/index")
    public String index(HttpServletRequest request) {
        return "chartInfo";
    }

}
