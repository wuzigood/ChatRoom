package com.wzy.dao;

import com.wzy.javabean.User;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

/*
    Dao层操作user
    private Integer id;
    private String userName;
    private String password;
    private String registerDate;
 */
@Repository
public interface IUserDao {

    @Select("select * from user where id = #{id}")
    @Results(id="userMap",value={
            @Result(id=true,column = "id",property = "id"),
            @Result(column = "username",property = "userName"),
            @Result(column = "password",property = "password"),
            @Result(column = "register_date",property = "registerDate")
    })
    User getUserById(int id);

    @Select("select * from user where username = #{userName}")
    @ResultMap(value = {"userMap"})
    User getUserByUserName(String username);

    //查询用户是否注册
    @Select("select count(*) from user where username = #{userName} AND password = #{password}")//
    int userLogin(User user);

    //用户注册
    @Insert("insert into user(username,password,register_date) values(#{userName},#{password},#{registerDate});")
    @ResultMap(value = {"userMap"})
    void userRegister(User user);

}
