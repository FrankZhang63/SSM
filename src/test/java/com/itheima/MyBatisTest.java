package com.itheima;


import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.InputStream;

public class MyBatisTest {
    public static void main(String[] args) throws Exception{

        InputStream is = Resources.getResourceAsStream("mybatis-config.xml");
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        SqlSession sqlSession = sqlSessionFactory.openSession();
        BookMapper bookMapper = sqlSession.getMapper(BookMapper.class);
        Book book = bookMapper.findBookById(1);
        System.out.println(book);
    }
}
