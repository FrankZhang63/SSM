package com.itheima.service;

import com.itheima.pojo.User;

public interface CommonService {
    public User login(User user);
    public int register(User user);
}
