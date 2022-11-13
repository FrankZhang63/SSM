package com.itheima.config;

import com.github.pagehelper.PageInterceptor;
import org.apache.ibatis.plugin.Interceptor;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.Properties;


@MapperScan("com.itheima.dao") //扫描mapper对象，交给spring管理
public class MyBatisConfig {

    //配置分页插件拦截器
    @Bean
    public PageInterceptor pageInterceptor(){
        PageInterceptor pageInterceptor = new PageInterceptor();
        //分页插件配置
        Properties properties = new Properties();
        properties.setProperty("value","true");//表示开启分页
        pageInterceptor.setProperties(properties);
        return pageInterceptor;
    }
    @Autowired
    private PageInterceptor pageInterceptor;
    //sqlSessionFactory配置
    @Bean
    public SqlSessionFactoryBean sqlSessionFactoryBean(DataSource dataSource) throws IOException {
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(dataSource);
        //让配置文件知道mapper接口xml文件位置
        PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        Resource[] resources = resolver.getResources("classpath:com/itheima/dao/*.xml");
        sqlSessionFactoryBean.setMapperLocations(resources);
        //将分页查询器插件交给Mybaits容器管理
        sqlSessionFactoryBean.setPlugins(new Interceptor[]{pageInterceptor});
        //实体映射
        sqlSessionFactoryBean.setTypeAliasesPackage("com.itheima.pojo");
        return sqlSessionFactoryBean;
    }
}
