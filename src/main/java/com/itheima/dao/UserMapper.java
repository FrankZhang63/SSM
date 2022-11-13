package com.itheima.dao;

import com.itheima.pojo.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {
    public User login(User user);
    public User isexist(User user);
    public int register(User user);
    public User selectbalanceByusername(String username);
    public int updatebalanceByusername(User user);
}
