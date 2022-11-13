package com.itheima.service.impl;

import com.github.pagehelper.PageHelper;
import com.itheima.dao.GoodsMapper;
import com.itheima.pojo.Goods;
import com.itheima.pojo.Record;
import com.itheima.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class GoodsServiceImpl implements GoodsService {

    @Autowired
    private GoodsMapper goodsMapper;
    /**
     * 分页查询功能
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public List<Goods> selectPageGoods(int pageNum,int pageSize) {
        //开启分页查询
        PageHelper.startPage(pageNum,pageSize);
        //调用dao
        List<Goods> goods = goodsMapper.selectAllGoods();

        return goods;
    }
    /**全查
     * @return
     */
    @Override
    public List<Goods> selectAllGoods() {
        return goodsMapper.selectAllGoods();
    }

    @Override
    public Goods selectGoodsById(int id) {
       return goodsMapper.selectGoodsById(id);
    }

    @Override
    public List<Goods> likeselect(String content) {
        return goodsMapper.likeselect(content);
    }

    @Override
    public int removeshoplist(int id) {
        return goodsMapper.updateshoplist(id);
    }

    @Override
    public void addshop(Goods goods) {
        goodsMapper.addshop(goods);
    }

    @Override
    public String selectGoodsByimage(String filename) {
        return goodsMapper.selectGoodsByimage(filename);
    }
}
