package com.itheima.controller;

import com.alibaba.fastjson.JSON;
import com.itheima.pojo.Goods;
import com.itheima.pojo.Record;
import com.itheima.pojo.User;
import com.itheima.service.GoodsService;
import com.itheima.service.RecordService;
import com.itheima.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class GoodsController {
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private RecordService recordService;
    @Autowired
    private UserService userService;

    //点击分页展示
    @RequestMapping ("/selectPageGoods")
    public void selectPageGoods(HttpServletResponse resp, int pageNum) throws IOException {
        List<Goods> goods = goodsService.selectPageGoods(pageNum, 4);
        String s = JSON.toJSONString(goods);
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(s);
    }

    //页面预加载
    @RequestMapping("/selectAllGoods")
    public void selectAllGoods(HttpServletResponse resp) throws IOException {
        List<Goods> goods = goodsService.selectAllGoods();
        String s = JSON.toJSONString(goods);
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(s);
    }
    //添加购物车
    @RequestMapping("/addshopcar")
    public void addshopcar(int id,String username,int price,HttpServletResponse resp) throws IOException {
        Goods goods = goodsService.selectGoodsById(id);
        Record record = new Record();
        record.setUsername(username);
        record.setGoodsimage(goods.getImage());
        record.setGoodsprice(String.valueOf(price));
        String s="";
        // 查询是否有记录
        Record record1=recordService.selectrecordByUsernameAndGoodsimage(username,goods.getImage());
        if (record1==null){
            recordService.addrecord(record);
            // 表示不存在
            s = "0";
        }else {
            //表示已经存在
            s = "1";
        }
        resp.getWriter().write(s);
    }
    //查看购物车
    @RequestMapping("/showshoplist")
    public void showshoplist(String username,HttpServletResponse resp) throws IOException{
       List<Record> records = recordService.selectrecordByUsername(username);
       String s = JSON.toJSONString(records);
       resp.setContentType("text/json;charset=utf-8");
       resp.getWriter().write(s);
    }
    //购买操作
    @RequestMapping("/buyselect")
    public void buySelect(String goods[],String username,String price,HttpServletResponse resp) throws IOException {
        //获取操作时间
        Date date = new Date();
        SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        User user = userService.selectbalanceByusername(username);
        String a;
        if (Integer.parseInt(user.getBalance())>=Integer.parseInt(price)){
            String x = String.valueOf(Integer.parseInt(user.getBalance())-Integer.parseInt(price));
            User user1 = new User();
            user1.setBalance(x);
            user1.setUsername(username);
            userService.updatebalanceByusername(user1);
            Record record = new Record();
            record.setUsername(username);
            record.setBuytime(dateFormat.format(date));
            for (String good:goods) {
                String[] s = good.split(" ");
                record.setGoodsimage(s[0]);
                record.setBuynum(s[1]);
                System.out.println(s[0]);
                System.out.println(s[1]);
                recordService.updaterecord(record);
            }
            a="1";
        }else {
            a="0";
        }
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(a);
    }
    //查看已购买的商品
    @RequestMapping("/showbuylist")
    public void showbuylist(String username,HttpServletResponse resp) throws IOException {
        List<Record> records = recordService.showbuylist(username);
        String s = JSON.toJSONString(records);
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(s);
    }
    //展示个人信息
    @RequestMapping("/showusermessage")
    public void showusermessage(String username,HttpServletResponse resp) throws IOException {
       User user = userService.selectMessageByUsername(username);
        String s = JSON.toJSONString(user);
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(s);
    }
    //模糊查询
    @RequestMapping("/likeselect")
    public void likeselect(String content,HttpServletResponse resp) throws IOException {
        System.out.println(content);
        List<Goods> goods = goodsService.likeselect(content);
        String s = JSON.toJSONString(goods);
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(s);
    }
    //充值
    @RequestMapping("/recharge")
    public void recharge(String money,String username,HttpServletResponse resp) throws IOException {
        userService.rechargebalance(money,username);
        User user = userService.selectbalanceByusername(username);
        String s = JSON.toJSONString(user.getBalance());
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(s);
    }
    //删除商品
    @RequestMapping("/removeshopcar")
    public void removeshopcar(int id,HttpServletResponse resp) throws IOException {
       goodsService.removeshoplist(id);
    }
    //展示所有用户的记录
    @RequestMapping("/showallbuylist")
    public void showallbuylist(HttpServletResponse resp) throws IOException {
        List<Record> records = recordService.selectrecord();
        String s = JSON.toJSONString(records);
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(s);
    }
}
