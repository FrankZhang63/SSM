package com.itheima.controller;

import com.itheima.pojo.User;
import com.itheima.service.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
public class CommonController {
    @Autowired
    private CommonService commonService;

    //登录
    @PostMapping("/login")
    public String login(User user, Model model, HttpSession session){
        User user1 = commonService.login(user);
        if ("1".equals(user1.getRole())){
            session.setAttribute("user",user1);
            return "redirect:adminList.jsp";
        }else if ("0".equals(user1.getRole())){
            //登录成功
            session.setAttribute("user",user1);
            return "redirect:userList.jsp";
            //登录失败
        }else {
            model.addAttribute("msg","用户名或密码错误");
            return "index.jsp";
        }
    }

    //注册
    @PostMapping("/register")
    public String register(User user,Model model){
        int x = commonService.register(user);
        //判断账号是否存在
        if (x==0){
            model.addAttribute("msg","该用户名已经存在");
            return "register.jsp";
        }else {
            return "redirect:index.jsp";
        }
    }

    //退出
    @RequestMapping("/exit")
    public String exit(HttpSession httpSession){
        //清空session
        httpSession.invalidate();
        return "index.jsp";
    }
}
