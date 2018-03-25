package com.bridge.dao;

import com.bridge.entity.Bridge;

import java.util.List;

public interface BridgeDao {

    Bridge findById(Integer id);

    List<Bridge> findAll();
}
