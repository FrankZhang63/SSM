package com.itheima.service.impl;

import com.itheima.dao.UserMapper;
import com.itheima.pojo.User;
import com.itheima.service.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommonServiceImpl implements CommonService {

    @Autowired //自动注入
    private UserMapper userMapper;
    @Override
    public User login(User user) {

        return userMapper.login(user);
    }

    @Override
    public int register(User user) {
        User user1 = userMapper.isexist(user);
        //账号未使用
        if (user1==null){
            return userMapper.register(user);
        }else {
            return 0;
        }
    }
}
