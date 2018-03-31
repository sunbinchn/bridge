package com.bridge.contants;

public enum RoleConstant {

    SUPER_ADMIN(2, "超级管理员"), ADMIN(1,"管理员"), NORMAL(0,"普通用户");

    private Integer role;
    private String name;

    RoleConstant(Integer role, String name) {
        this.role = role;
        this.name = name;
    }

    public Integer getRole() {
        return role;
    }

    public void setRole(Integer role) {
        this.role = role;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
