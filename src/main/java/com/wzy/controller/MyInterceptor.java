package com.wzy.controller;

import com.wzy.javabean.User;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 拦截器，就是可以在获取连接之前进行一些操作
 */
@Component
public class MyInterceptor extends HttpSessionHandshakeInterceptor {
    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
        System.out.println("握手前。。。");
        ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
        HttpSession session = servletRequest.getServletRequest().getSession(false);
        if(session != null){
            User user = (User) session.getAttribute("user");
            //将用户放入socket处理器的会话(WebSocketSession)中
            attributes.put("loginUser",user);
            System.out.println("Websocket:用户[ID:" + (user.getId() + ",Name:"+user.getUserName()+"]要建立连接"));
        }
        return super.beforeHandshake(request, response, wsHandler, attributes);
    }

    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Exception ex) {
        System.out.println("握手后。。。");
        super.afterHandshake(request, response, wsHandler, ex);
    }
}
