<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    if (request.getParameter("dateRange") != null) {
        pageContext.setAttribute("DATERANGE", request.getParameter("dateRange"));
    }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>桥梁监测系统-用户管理</title>
    <%@ include file="common.jsp" %>
    <link href="${PATH}static/js/datetime/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <script src="${PATH}static/js/datetime/moment-with-locales.js"></script>
    <script src="${PATH}static/js/datetime/bootstrap-datetimepicker.min.js"></script>
    <script src="${PATH}static/js/datetime/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="${PATH}static/js/monitorDataInfo.js"></script>
</head>
<body>
<input hidden="true" value="${param.dateRange}" id="dateRangeInput"/>
<div class="container">
    <%@ include file="head.jsp" %>
    <div class="row">
        <!-- 左侧导航栏-->
        <%@ include file="leftMeun.jsp" %>
        <!-- 右侧内容栏 -->
        <div class="col-md-10">
            <label class="control-label" style="float: left;width: 75px">日期范围：</label>
            <a class='input-group date' id='datetimepicker1' style="float: left;">
                <input type='text' class="form-control" id='from-date' style="width: 150px; height: 30px;" />
                <span class="input-group-addon" style="float: left; width: 50px; height: 30px;">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
            </a>
            <a class='input-group date' id='datetimepicker2' style="float: left;">
                <input type='text' class="form-control" id='to-date' style="width: 150px; height: 30px;" />
                <span class="input-group-addon" style="float: left; width: 50px; height: 30px;">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
            </a>
            <button id="search-button" class="btn btn-info btn-sm">搜索</button>
            <label style="color: red" id="error-label"></label>
            <table class="table table-bordered table-hover" id="emp_table_id" style="margin-top: 5px; margin-bottom: 0px;">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>监测点</th>
                        <th>监测类型</th>
                        <th>传感器名称</th>
                        <th>传感器类型</th>
                        <th>温度</th>
                        <th>测量值</th>
                        <th>允许误差</th>
                        <th>单位</th>
                        <th>创建时间</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="monitorData" items="${pageInfo.list}" varStatus="status">
                        <c:choose>
                            <c:when test="${status.count%2 eq 1}">
                                <tr class="info" data-id="${monitorData.id}">
                                    <td>${status.count + (pageInfo.pageNum-1) * pageInfo.pageSize}</td>
                                    <td>${monitorData.monitorType.monitorPoint.name}</td>
                                    <td>${monitorData.monitorType.monitorName}</td>
                                    <td>${monitorData.sensor.name}</td>
                                    <td>${monitorData.sensor.sensorType.sensorTypeName}</td>
                                    <td><fmt:formatNumber value="${monitorData.temp}" pattern="#.#####"/></td>
                                    <td><fmt:formatNumber value="${monitorData.measurements}" pattern="#.#####"/></td>
                                    <td><fmt:formatNumber value="${monitorData.deviation}" pattern="#.#####"/></td>
                                    <td>${monitorData.unit}</td>
                                    <td><fmt:formatDate value="${monitorData.createTime}"  type="both" /></td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <tr data-id="${monitorData.id}">
                                    <td>${status.count + (pageInfo.pageNum-1) * pageInfo.pageSize}</td>
                                    <td>${monitorData.monitorType.monitorPoint.name}</td>
                                    <td>${monitorData.monitorType.monitorName}</td>
                                    <td>${monitorData.sensor.name}</td>
                                    <td>${monitorData.sensor.sensorType.sensorTypeName}</td>
                                    <td><fmt:formatNumber value="${monitorData.temp}" pattern="#.#####"/></td>
                                    <td><fmt:formatNumber value="${monitorData.measurements}" pattern="#.#####"/></td>
                                    <td><fmt:formatNumber value="${monitorData.deviation}" pattern="#.#####"/></td>
                                    <td>${monitorData.unit}</td>
                                    <td><fmt:formatDate value="${monitorData.createTime}"  type="both" /></td>
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
                                    <c:choose>
                                        <c:when test="${!empty DATERANGE}">
                                            <a href="${PATH}monitorInfoData/getAll?pn=${pageInfo.pageNum-1}&dateRange=${DATERANGE}" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${PATH}monitorInfoData/getAll?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </c:if>
                            <c:forEach items="${pageInfo.navigatepageNums}" var="curNum">
                                <c:choose>
                                    <c:when test="${pageInfo.pageNum eq curNum}" >
                                        <li class="active"><span>${curNum}</span></li>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${!empty DATERANGE}">
                                                <li><a href="${PATH}monitorInfoData/getAll?pn=${curNum}&dateRange=${DATERANGE}">${curNum}</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <li><a href="${PATH}monitorInfoData/getAll?pn=${curNum}">${curNum}</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>

                            </c:forEach>
                            <c:if test="${pageInfo.hasNextPage}">
                                <li>
                                    <c:choose>
                                        <c:when test="${!empty DATERANGE}">
                                            <a href="${PATH}monitorInfoData/getAll?pn=${pageInfo.pageNum+1}&dateRange=${DATERANGE}" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${PATH}monitorInfoData/getAll?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div> <!-- 分页结束 -->
            </c:if>
    </div>
</div>
</body>
</html>