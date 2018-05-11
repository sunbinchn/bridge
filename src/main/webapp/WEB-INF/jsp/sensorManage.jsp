<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>桥梁监测系统-传感器设置</title>
    <%@ include file="common.jsp" %>
    <script src="${PATH}static/js/sensorManage.js"></script>
</head>
<body>
<div class="container">
    <%@ include file="head.jsp" %>
    <div class="row">
        <!-- 左侧导航栏-->
        <%@ include file="leftMeun.jsp" %>
        <div class="col-sm-10" style="margin-bottom: 30px">
            <ul class="nav nav-tabs">
                <li role="presentation" class="active" id="viewSensorLi"><a href="">查看</a></li>
                <li role="presentation" id="addSensorLi"><a href="" id="addSensorA">添加</a></li>
            </ul>
        </div>
        <div class="col-sm-10">
            <form method="post" onsubmit="return;" class="form-horizontal" role="form" id="addSensorForm" style="display: none">
                <div class="form-group">
                    <div id="addSensorSuccessDiv" class="alert  alert-success col-sm-offset-2 col-sm-4 alert-dismissible" role="alert" style="margin-bottom: 0px;display: none">
                        <button id="addSensorSuccessClose" type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <strong></strong>
                    </div>
                </div>
                <div class="form-group" hidden="true" id="error-msg-div" style="margin-left: 20px;">
                    <label class="control-label" id="error-msg-label" style="color:red;"></label>
                </div>
                <div class="form-group">
                    <label for="sensorName" class="col-sm-2 control-label">传感器名称：</label>
                    <div class="col-sm-6">
                        <input class="form-control" id="sensorName" name="sensorName" type="text" required autofocus/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="sensorType" class="col-sm-2 control-label">传感器类型：</label>
                    <div class="col-sm-6">
                        <select id="sensorType" name="sensorType"
                                class="form-control selectpicker show-tick col-sm-3" data-live-search="false">
                            <option value="-1">---类型---</option>
                            <c:forEach items="${sensorTypeList}" var="sensorType">
                                <option value="${sensorType.id}">${sensorType.sensorTypeName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="monitorType" class="col-sm-2 control-label">监测类型：</label>
                    <div class="col-sm-6">
                        <select id="monitorType" name="monitorType"
                                class="form-control selectpicker show-tick col-sm-3" data-live-search="false">
                            <option value="-1">---类型---</option>
                            <c:forEach items="${monitorTypeList}" var="monitorType">
                                <option value="${monitorType.id}">${monitorType.monitorName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <button type="submit" class="col-sm-offset-3 btn btn-primary" style="width: 100px;"
                            id="addSensorButton">添加
                    </button>
                </div>
            </form><!-- 添加监测点form -->
            <div class="col-md-10" id="sensor-view-div"> <!-- 监测点div -->
                <table class="table table-bordered table-hover" id="sensor_table_id" style="margin-top: 5px; margin-bottom: 0px;">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>传感器名称</th>
                        <th>传感器类型</th>
                        <th>监测名称</th>
                        <th>监测点名称</th>
                        <th>高预警</th>
                        <th>低预警</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="sensor" items="${pageInfo.list}" varStatus="status">
                        <c:choose>
                            <c:when test="${status.count%2 eq 1}">
                                <tr class="info" data-id="${sensor.id}" sensor-type-id="${sensor.sensorType.id}" monitor-type-id="${sensor.monitorType.id}">
                                    <td>${status.count + (pageInfo.pageNum-1) * pageInfo.pageSize}</td>
                                    <td>${sensor.name}</td>
                                    <td>${sensor.sensorType.sensorTypeName}</td>
                                    <td>${sensor.monitorType.monitorName}</td>
                                    <td>${sensor.monitorType.monitorPoint.name}</td>
                                    <td><fmt:formatNumber value="${sensor.monitorType.hial}" pattern="#.#####"/></td>
                                    <td><fmt:formatNumber value="${sensor.monitorType.loal}" pattern="#.#####"/></td>
                                    <td>
                                        <a href="" class="update-sensor">修改</a>
                                        <a href="" class="delete-sensor">删除</a>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <tr data-id="${sensor.id}" sensor-type-id="${sensor.sensorType.id}" monitor-type-id="${sensor.monitorType.id}">
                                    <td>${status.count + (pageInfo.pageNum-1) * pageInfo.pageSize}</td>
                                    <td>${sensor.name}</td>
                                    <td>${sensor.sensorType.sensorTypeName}</td>
                                    <td>${sensor.monitorType.monitorName}</td>
                                    <td>${sensor.monitorType.monitorPoint.name}</td>
                                    <td><fmt:formatNumber value="${sensor.monitorType.hial}" pattern="#.#####"/></td>
                                    <td><fmt:formatNumber value="${sensor.monitorType.loal}" pattern="#.#####"/></td>
                                    <td>
                                        <a href="" class="update-sensor">修改</a>
                                        <a href="" class="delete-sensor">删除</a>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    </tbody>
                </table>
                <!-- 分页 -->
                <c:if test="${pageInfo.pages gt 1}">
                    <div style="float:right">
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <c:if test="${pageInfo.hasPreviousPage}">
                                    <li>
                                        <a href="${PATH}sensor/index?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                                <c:forEach items="${pageInfo.navigatepageNums}" var="curNum">
                                    <c:choose>
                                        <c:when test="${pageInfo.pageNum eq curNum}" >
                                            <li class="active"><span>${curNum}</span></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="${PATH}sensor/index?pn=${curNum}">${curNum}</a></li>
                                        </c:otherwise>
                                    </c:choose>

                                </c:forEach>
                                <c:if test="${pageInfo.hasNextPage}">
                                    <li>
                                        <a href="${PATH}sensor/index?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div> <!-- 分页结束 -->
                </c:if>
        </div> <!-- 监测点table结束 -->

    </div>
</div>
</body>
</html>