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
    public void userRegister(User user) {
        userDao.userRegister(user);
    }
}
