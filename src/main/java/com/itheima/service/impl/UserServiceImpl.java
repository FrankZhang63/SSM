package com.itheima.service.impl;

import com.itheima.dao.UserMapper;
import com.itheima.pojo.User;
import com.itheima.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Override
    public User selectbalanceByusername(String username) {
        return userMapper.selectbalanceByusername(username);
    }

    @Override
    public void updatebalanceByusername(User user) {

        userMapper.updatebalanceByusername(user);
    }

    @Override
    public User selectMessageByUsername(String username) {
        return userMapper.selectbalanceByusername(username);
    }

    @Override
    public int rechargebalance(String balance, String username) {
        User user = userMapper.selectbalanceByusername(username);
        String bl = user.getBalance();
        User user1 = new User();
        user1.setBalance(String.valueOf(Integer.parseInt(bl)+Integer.parseInt(balance)));
        user1.setUsername(username);
        return userMapper.updatebalanceByusername(user1);
    }
}
