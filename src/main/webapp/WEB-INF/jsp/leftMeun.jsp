<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div class="col-md-2">
    <div class="panel-group table-responsive" role="tablist">
        <div class="panel panel-primary leftMenu">
            <!-- 利用data-target指定要折叠的分组列表 -->
            <div class="panel-heading" id="collapseListGroupHeading1" data-toggle="collapse" data-target="#collapseListGroup1" role="tab" >
                <h4 class="panel-title">
                    隧道监测
                    <span class="glyphicon glyphicon-chevron-up right"></span>
                </h4>
            </div>
            <!-- .panel-collapse和.collapse标明折叠元素 .in表示要显示出来 -->
            <div id="collapseListGroup1" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="collapseListGroupHeading1">
                <ul class="list-group">
                    <li class="list-group-item">
                        <!-- 利用data-target指定URL -->
                        <button class="menu-item-left" data-target="test2.html">
                            <span class="glyphicon glyphicon-triangle-right"></span>监测数据
                        </button>
                    </li>
                    <li class="list-group-item">
                        <button class="menu-item-left">
                            <span class="glyphicon glyphicon-triangle-right"></span>图形分析
                        </button>
                    </li>
                </ul>
            </div>
        </div><!--panel end-->
        <div class="panel panel-primary leftMenu">
            <div class="panel-heading" id="collapseListGroupHeading2" data-toggle="collapse" data-target="#collapseListGroup2" role="tab" >
                <h4 class="panel-title">
                    管理
                    <span class="glyphicon glyphicon-chevron-down right"></span>
                </h4>
            </div>
            <div id="collapseListGroup2" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="collapseListGroupHeading2">
                <ul class="list-group">
                    <li class="list-group-item">
                        <button class="menu-item-left" id="userManageButton">
                            <span class="glyphicon glyphicon-triangle-right"></span>用户管理
                        </button>
                    </li>
                    <li class="list-group-item">
                        <button class="menu-item-left">
                            <span class="glyphicon glyphicon-triangle-right"></span>权限管理
                        </button>
                    </li>
                    <li class="list-group-item">
                        <button class="menu-item-left">
                            <span class="glyphicon glyphicon-triangle-right"></span>个人信息
                        </button>
                    </li>
                </ul>
            </div>
        </div><!--panel end-->
        <div class="panel panel-primary leftMenu">
            <div class="panel-heading" id="collapseListGroupHeading3" data-toggle="collapse" data-target="#collapseListGroup3" role="tab" >
                <h4 class="panel-title">
                    设置
                    <span class="glyphicon glyphicon-chevron-down right"></span>
                </h4>
            </div>
            <div id="collapseListGroup3" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="collapseListGroupHeading3">
                <ul class="list-group">
                    <li class="list-group-item">
                        <button class="menu-item-left">
                            <span class="glyphicon glyphicon-triangle-right"></span>传感器设置
                        </button>
                    </li>
                    <li class="list-group-item">
                        <button class="menu-item-left">
                            <span class="glyphicon glyphicon-triangle-right"></span>监测点设置
                        </button>
                    </li>
                </ul>
            </div>
        </div><!--panel end-->
    </div>
</div>