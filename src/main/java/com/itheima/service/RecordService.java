package com.itheima.service;

import com.itheima.pojo.Record;

import java.util.List;

public interface RecordService {

    public Record selectrecordByUsernameAndGoodsimage(String username, String goodsimage);

    public List<Record> selectrecordByUsername(String username);
    /** 添加消息记录
     * @param record
     */
    public void addrecord(Record record);

    public void updaterecord(Record record);

    public List<Record> showbuylist(String username);
    public List<Record> selectrecord();
}
