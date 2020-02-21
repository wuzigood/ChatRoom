package com.wzy.service;

import com.wzy.javabean.User;

public interface IUserService {

    User getUserById(int id);

    User getUserByUserName(String username);

    //查询用户是否注册
    int userLogin(User user);

    //用户注册
    void userRegister(User user);

}
