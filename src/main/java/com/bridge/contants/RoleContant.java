package com.bridge.contants;

public enum RoleContant {

    SUPER_ADMIN(2, "超级管理员"), ADMIN(1,"管理员"), NORMAL(0,"普通用户");

    private Integer role;
    private String name;

    RoleContant(Integer role, String name) {
        this.role = role;
        this.name = name;
    }
}
