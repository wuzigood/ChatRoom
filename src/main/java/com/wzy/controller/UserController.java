package com.wzy.controller;

import com.wzy.javabean.User;
import com.wzy.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.jws.soap.SOAPBinding;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;


/*
    用户控制器
    user/login登录地址
 */
@Controller
@RequestMapping("/user")
public class UserController {

    //调用业务层需要的变量
    @Autowired
    private IUserService userService;

    //成功页面
    @RequestMapping("success")
    public String success(){
        return "success";

    }
    @RequestMapping("fail")
    public String fail(){
        return "fail";
    }

    //登录操作
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public void login(String username, String password, HttpServletRequest request,HttpServletResponse response){
        System.out.println("用户名："+username+"\t密码："+password);
        User user = new User(username,password);
        int result = userService.userLogin(user);
        if(result>0){
            //放入request域中共享数据
//            request.setAttribute("username",username);
//            request.setAttribute("password",password);
//            return "success";
            response.setStatus(302);
            response.setHeader("location",request.getContextPath()+"/user/success");

        }else{
            try {
                //返回登录页面

                response.sendRedirect(request.getContextPath()+"?error=yes");
            } catch (IOException e) {
                e.printStackTrace();
            }

        }

    }

    //注册
    @RequestMapping(value = "/register",method = RequestMethod.POST)
    public void register(String username,String password,HttpServletRequest request,HttpServletResponse response){
        User user = new User();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        user.setUserName(username);
        user.setPassword(password);
        user.setRegisterDate(sdf.format(new Date()));
        userService.userRegister(user);
        response.setStatus(302);
        response.setHeader("location",request.getContextPath());
    }
}
