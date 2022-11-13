package com.itheima.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

@Configuration
//spring注解扫描
@ComponentScan("com.itheima.service")
@EnableTransactionManagement //事务管理
@Import({MyBatisConfig.class,JdbcConfig.class}) //导入其他配置类
public class SpringConfig {

    //事务管理器配置
    @Bean
    public DataSourceTransactionManager transactionManager(DataSource dataSource){
        DataSourceTransactionManager transactionManager = new DataSourceTransactionManager();
        //配置数据源
        transactionManager.setDataSource(dataSource);
        return transactionManager;
    }

}
