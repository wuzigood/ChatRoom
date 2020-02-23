package com.wzy.service.impl;

import com.wzy.dao.IUserDao;
import com.wzy.javabean.User;
import com.wzy.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("userService")
public class UserServiceImpl implements IUserService {

    @Autowired
    private IUserDao userDao;

    @Override
    public User getUserById(int id) {
        return userDao.getUserById(id);
    }

    @Override
    public User getUserByUserName(String username) {
        return userDao.getUserByUserName(username);
    }

    @Override
    public int userLogin(User user) {
        return userDao.userLogin(user);
    }

    @Override
    public int userRegister(User user) {
        //数据库里有就返回非零
        int flag = userDao.userLogin(user);
        if(flag != 0){
            return 0;
        }else{
            System.out.println("注册成功");
            userDao.userRegister(user);
            return 1;
        }

    }
}
