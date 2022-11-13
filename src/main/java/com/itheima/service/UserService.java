package com.itheima.service;

import com.itheima.pojo.User;

public interface UserService {
    public User selectbalanceByusername(String username);
    public void updatebalanceByusername(User user);
    public User selectMessageByUsername(String username);
    public int rechargebalance(String balance,String username);
}
