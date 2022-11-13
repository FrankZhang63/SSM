package com.itheima.dao;

import com.itheima.pojo.Record;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RecordMapper {
    //增加消息记录
    public void addrecord(Record record);
    //检查购物车是否存在记录
    public Record selectrecordByUsernameAndGoodsimage(@Param("username") String username, @Param("goodsimage") String goodsimage);
    //展示购物车页面
    public List<Record> selectrecordByUsername(String username);
    /**
     * 提交订单
     */
    public void updaterecord(Record record);
    //展示已完成订单
    public List<Record> showbuylist(String username);
    public List<Record> selectrecord();
}
