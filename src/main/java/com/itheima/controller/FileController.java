package com.itheima.controller;

import com.itheima.pojo.Goods;
import com.itheima.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

@Controller
public class FileController {

    @Autowired
    private GoodsService goodsService;

    @PostMapping( "/addshop")
    public String test09(@RequestParam("file") MultipartFile multipartFile, String type, String brand, String price, HttpServletRequest request, HttpServletResponse resp) throws IOException {
        // 获取文件上传到具体文件夹的绝对路径
        String realpath = request.getSession().getServletContext().getRealPath("upload");
        // 获取上传的文件名
        String fileName = multipartFile.getOriginalFilename();
        // 根据路径构建文件对象
        // 在构建过程中一定要注意路径问题
        File uploadFile = new File(realpath, fileName);
        // 判断指定文件夹uploadfiles是否存在，不存在就创建
        if (!uploadFile.exists()) {
            uploadFile.mkdirs();
        }
        String s;
        String image = goodsService.selectGoodsByimage(fileName);
        if (image==null) {
            // 上传文件
            multipartFile.transferTo(uploadFile);
            System.out.println(type + " " + brand + " " + price);
            Goods goods = new Goods();
            goods.setBrand(brand);
            goods.setPrice(Integer.parseInt(price));
            goods.setImage(fileName);
            goods.setType(type);
            goodsService.addshop(goods);
            s = "添加成功";
        }else {
            s = "用户已存在";
        }
        resp.getWriter().write(s);
        return "adminList.jsp";
    }
}
