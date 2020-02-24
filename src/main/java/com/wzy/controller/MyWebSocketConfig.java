package com.wzy.controller;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Configuration
@EnableWebMvc
@EnableWebSocket
public class MyWebSocketConfig implements WebSocketConfigurer {


    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        //前台 可以使用websocket环境
        registry.addHandler(getMyHandle(),"/websocket").addInterceptors(new MyInterceptor());


        //前台 不可以使用websocket环境，则使用sockjs进行模拟连接
        registry.addHandler(getMyHandle(), "/sockjs/websocket").addInterceptors(new MyInterceptor())
                .withSockJS();

    }

    @Bean
    public WebSocketHandler getMyHandle(){
        return new MyHandle();
    }
}
