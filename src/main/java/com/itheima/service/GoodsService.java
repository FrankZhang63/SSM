package com.itheima.service;

import com.itheima.pojo.Goods;

import java.util.List;

public interface GoodsService {
    //查询所有商品 一页展示五个

    /**
     * 分页查询
     * @param pageNum
     * @param PageSize
     * @return
     */
    public List<Goods> selectPageGoods(int pageNum,int PageSize);

    /**
     * 查询所有商品
     * @return
     */
    public List<Goods> selectAllGoods();



    public Goods selectGoodsById(int id);

    public List<Goods> likeselect(String content);
    public int removeshoplist(int id);
    public void addshop(Goods goods);
    public String selectGoodsByimage(String filename);
}
