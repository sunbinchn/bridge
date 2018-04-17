<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>桥梁监测系统-图形监测</title>


    <script type="text/javascript" src="${PATH}static/js/jqplot/jquery.min.js"></script>
    <link href="${PATH}static/js/jqplot/jquery.jqplot.min.css" rel="stylesheet" />
    <link href="${PATH}static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${PATH}static/css/common.css" rel="stylesheet">
    <script type="text/javascript" src="${PATH}static/js/jqplot/jquery.jqplot.min.js"></script>
    <script type="text/javascript" src="${PATH}static/js/common.js"></script>
    <script type="text/javascript" src="${PATH}static/js/underscore.js"></script>
    <script type="text/javascript" src="${PATH}static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <script type="text/javascript" src="${PATH}static/js/jqplot/excanvas.min.js"></script>
    <script type="text/javascript" src="${PATH}static/js/jqplot/plugins/jqplot.canvasTextRenderer.js"></script>
    <script type="text/javascript" src="${PATH}static/js/jqplot/plugins/jqplot.canvasAxisLabelRenderer.js"></script>

    <script type="text/javascript" src="${PATH}static/js/chartInfo.js"></script>
</head>
<body>
<div class="container">
    <%@ include file="head.jsp" %>
    <div class="row">
        <!-- 左侧导航栏-->
        <%@ include file="leftMeun.jsp" %>
        <div class="col-sm-10">
            <div id="chart" style="width:500px;height:300px;" ></div>
        </div>

    </div>
</div>
</body>
</html>