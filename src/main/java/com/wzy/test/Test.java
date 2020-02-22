package com.wzy.test;

import com.sun.javaws.IconUtil;
import com.wzy.dao.IUserDao;
import com.wzy.javabean.User;
import com.wzy.service.IUserService;
import com.wzy.service.impl.UserServiceImpl;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Test {

    /*
    User getUserById(int id);
    User getUserByUserName(String username);
    //查询用户是否注册
    int userLogin(User user);
    //用户注册
    void userRegister(User user);
     */

    @org.junit.Test
    public void run1(){
        User user1 = new User();
        user1.setUserName("张三");
        user1.setPassword("test");
        User user2 = new User();
        user2.setUserName("test");
        user2.setPassword("test");
        User user3 = new User();
        user3.setUserName("test");
        user3.setPassword("123");
        // 加载配置文件
        ApplicationContext ac = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
        // 获取对象
        IUserService us = (IUserService) ac.getBean("userService");
//        SqlSessionFactory factory = (SqlSessionFactory) ac.getBean("sqlSessionFactory");
//        //创建SqlSession对象
//        SqlSession session = factory.openSession();
//
//        //获取到代理对象
//        IUserDao dao = session.getMapper(IUserDao.class);
////        dao.userLogin(user2);
//        System.out.println(dao.userLogin(user2));
        // 调用方法
//        System.out.println(us.getUserById(1));
//        System.out.println(us.getUserById(3));
//        System.out.println("==================");
//        System.out.println(us.getUserByUserName("test2"));
//        System.out.println(us.getUserByUserName("123"));
//        System.out.println("==================");
//        System.out.println(us.userLogin(user2));
//        System.out.println(us.userLogin(user1));
//        System.out.println(us.userLogin(user3));

        us.userRegister(user1);


    }
}
