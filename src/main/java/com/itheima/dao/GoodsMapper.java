package com.itheima.dao;

import com.github.pagehelper.Page;
import com.itheima.pojo.Goods;
import com.itheima.pojo.Record;
import com.itheima.pojo.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface GoodsMapper {
    public List<Goods> selectAllGoods();

    //查询商品信息通过id名
    public Goods selectGoodsById(int id);
    public List<Goods> likeselect(@Param("content") String content);
    public int updateshoplist(int id);
    public void addshop(Goods goods);
    public String selectGoodsByimage(String image);
}
