package com.itheima.service.impl;

import com.itheima.dao.RecordMapper;
import com.itheima.pojo.Record;
import com.itheima.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecordServiceImpl implements RecordService {
    @Autowired
    private RecordMapper recordMapper;

    /**
     * 增加消息记录
     * @param goods
     */
    @Override
    public void addrecord(Record record) {
        recordMapper.addrecord(record);
    }

    @Override
    public Record selectrecordByUsernameAndGoodsimage(String username,String goodsimage) {
        return recordMapper.selectrecordByUsernameAndGoodsimage(username,goodsimage);
    }
    public List<Record> selectrecordByUsername(String username){
        return recordMapper.selectrecordByUsername(username);
    }
    @Override
    public void updaterecord(Record record) {
        recordMapper.updaterecord(record);
    }

    @Override
    public List<Record> showbuylist(String username) {
        return recordMapper.showbuylist(username);
    }

    @Override
    public List<Record> selectrecord() {
        return recordMapper.selectrecord();
    }
}
