<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>桥梁监测系统-监测点设置</title>
    <%@ include file="common.jsp" %>
    <script src="${PATH}static/js/monitorPointManage.js"></script>
</head>
<body>
<div class="container">
    <%@ include file="head.jsp" %>
    <div class="row">
        <!-- 左侧导航栏-->
        <%@ include file="leftMeun.jsp" %>
        <div class="col-sm-10" style="margin-bottom: 30px">
            <ul class="nav nav-tabs">
                <li role="presentation" class="active" id="viewPointLi"><a href="">查看</a></li>
                <li role="presentation" id="addPointLi"><a href="" id="addPointA">添加</a></li>
            </ul>
        </div>
        <div class="col-sm-10">
            <form method="post" onsubmit="return;" class="form-horizontal" role="form" id="addPointForm" style="display: none">
                <div class="form-group">
                    <div id="addPointSuccessDiv" class="alert  alert-success col-sm-offset-2 col-sm-4 alert-dismissible" role="alert" style="margin-bottom: 0px;display: none">
                        <button id="addPointSuccessClose" type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <strong>添加成功!</strong>
                    </div>
                </div>
                <div class="form-group" hidden="true" id="error-msg-div" style="margin-left: 20px;">
                    <label class="control-label" id="error-msg-label" style="color:red;"></label>
                </div>
                <div class="form-group">
                    <label for="pointName" class="col-sm-2 control-label">监测点名称：</label>
                    <div class="col-sm-6">
                        <input class="form-control" id="pointName" name="pointName" type="text" required autofocus/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="select-province" class="col-sm-2 control-label">城市：</label>
                    <div class="col-sm-6">
                        <select id="select-province" name="select-province"
                                class="form-control selectpicker show-tick col-sm-3" data-live-search="false" style="width: 33.333333333%;">
                            <option value="-1">---省份---</option>
                            <c:forEach items="${provinceList}" var="province">
                                <option value="${province.provinceid}">${province.province}</option>
                            </c:forEach>
                        </select>
                        <select id="select-city" name="select-city"
                                class="form-control selectpicker show-tick col-sm-3" data-live-search="false" style="width: 33.333333333%;">
                            <option value="-1">---地级市---</option>
                        </select>
                        <select id="select-area" name="select-area"
                                class="form-control selectpicker show-tick col-sm-3" data-live-search="false" style="width: 33.333333333%;">
                            <option value="-1">---区域---</option>
                        </select>
                    </div>
                </div>
                <c:if test="${not empty targetUserList}">
                    <div class="form-group"> <!-- 如果是管理员，需要填写监测点的目标用户 -->
                        <label for="select-user" class="col-sm-2 control-label">所属用户：</label>
                        <div class="col-sm-6">
                            <select id="select-user" name="select-user"
                                    class="form-control selectpicker">
                                <c:forEach items="${targetUserList}" var="targetUser">
                                    <option value="${targetUser.userId}">${targetUser.userName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </c:if>
                <div class="form-group">
                    <label for="longitude" class="col-sm-2 control-label">经度：</label>
                    <div class="col-sm-6">
                        <input class="form-control" id="longitude" name="longitude" type="number"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="latitude" class="col-sm-2 control-label">纬度：</label>
                    <div class="col-sm-6">
                        <input class="form-control" id="latitude" name="latitude" type="number"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="remark" class="col-sm-2 control-label">备注：</label>
                    <div class="col-sm-6">
                        <input class="form-control" id="remark" name="remark" type="text"/>
                    </div>
                </div>
                <div class="form-group">
                    <button type="submit" class="col-sm-offset-3 btn btn-primary" style="width: 100px;"
                            id="addPointButton">添加
                    </button>
                </div>
            </form><!-- 添加监测点form -->
            <div class="col-md-10" id="point-view-div"> <!-- 监测点div -->
                <table class="table table-bordered table-hover" id="point_table_id" style="margin-top: 5px; margin-bottom: 0px;">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>监测点名称</th>
                        <th>城市</th>
                        <th>经度</th>
                        <th>纬度</th>
                        <th>备注</th>
                        <th>操作</th>
                        <%--<th>所属用户</th>--%>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="point" items="${pageInfo.list}" varStatus="status">
                        <c:choose>
                            <c:when test="${status.count%2 eq 1}">
                                <tr class="info" data-id="${point.id}" location-ids="${point.area.areaid},${point.area.city.cityid},${point.area.city.province.provinceid}">
                                    <td>${status.count + (pageInfo.pageNum-1) * pageInfo.pageSize}</td>
                                    <td>${point.name}</td>
                                    <td>${point.location}</td>
                                    <c:choose>
                                        <c:when test="${point.longitude eq 0}">
                                            <td></td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>${point.longitude}</td>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${point.latitude eq 0}">
                                            <td></td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>${point.latitude}</td>
                                        </c:otherwise>
                                    </c:choose>
                                    <td>${point.remark}</td>
                                    <td>
                                        <a href="" class="update-point">修改</a>
                                        <a href="" class="delete-point">删除</a>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <tr data-id="${point.id}" location-ids="${point.area.areaid},${point.area.city.cityid},${point.area.city.province.provinceid}">
                                    <td>${status.count + (pageInfo.pageNum-1) * pageInfo.pageSize}</td>
                                    <td>${point.name}</td>
                                    <td>${point.location}</td>
                                    <c:choose>
                                        <c:when test="${point.longitude eq 0}">
                                            <td></td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>${point.longitude}</td>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${point.latitude eq 0}">
                                            <td></td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>${point.latitude}</td>
                                        </c:otherwise>
                                    </c:choose>
                                    <td>${point.remark}</td>
                                    <td>
                                        <a class="update-point">修改</a>
                                        <a class="delete-point">删除</a>
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
                                        <a href="${PATH}monitorPoint/index?pn=${pageInfo.pageNum-1}" aria-label="Previous">
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
                                            <li><a href="${PATH}monitorPoint/index?pn=${curNum}">${curNum}</a></li>
                                        </c:otherwise>
                                    </c:choose>

                                </c:forEach>
                                <c:if test="${pageInfo.hasNextPage}">
                                    <li>
                                        <a href="${PATH}monitorPoint/index?pn=${pageInfo.pageNum+1}" aria-label="Next">
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