package com.itheima.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:application-service.xml","classpath:application-dao.xml"})
public class BookServiceTest {
    @Autowired
    private BookService bookService;

    @Test
    public void testFindBookById() {
        Book book = bookService.findBookById(1);
        System.out.println(book);
    }
}