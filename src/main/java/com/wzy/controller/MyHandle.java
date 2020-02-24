package com.wzy.controller;

import com.wzy.javabean.User;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

@Component
public class MyHandle implements WebSocketHandler {

    //在线用户的SOCKETsession(存储了所有的通信通道)
    public static final Map<Integer, WebSocketSession> USER_SOCKETSESSION_MAP;
    //用于存储所有的在线用户
    static {
        USER_SOCKETSESSION_MAP = new HashMap<Integer, WebSocketSession>();
    }

    /**
     * 连接建立之后的操作，webscoket建立好链接之后的处理函数--连接建立后的准备工作
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession webSocketSession) throws Exception {
        //将当前的连接的用户会话放入MAP,key是用户编号
        User loginUser=(User) webSocketSession.getAttributes().get("loginUser");
        USER_SOCKETSESSION_MAP.put(loginUser.getId(), webSocketSession);
        System.out.println("afterConnectionEstablished...将用户的session装到map中");

    }

    /**
     * 客户端发送服务器的消息时的处理函数，在这里收到消息之后可以分发消息
     */
    @Override
    public void handleMessage(WebSocketSession webSocketSession, WebSocketMessage<?> message) throws Exception {
        //如果消息没有任何内容，则直接返回
        if(message.getPayloadLength()==0)return;
        //获得输入的字符串
        String str = message.getPayload().toString();
        System.out.println("消息（可存数据库作为历史记录）:"+str);
        //群发出去,对用户发送的消息内容进行转义
        sendMessageToAll(new TextMessage(str));
    }

    /**
     * 消息传输过程中出现的异常处理函数
     */
    @Override
    public void handleTransportError(WebSocketSession webSocketSession, Throwable throwable) throws Exception {
        // 记录日志，准备关闭连接
        System.out.println("Websocket异常断开:" + webSocketSession.getId() + "已经关闭");
        //一旦发生异常，强制用户下线，关闭session
        if (webSocketSession.isOpen()) {
            webSocketSession.close();
        }
        //获取异常的用户的会话中的用户编号
        User loginUser=(User)webSocketSession.getAttributes().get("loginUser");
        //获取所有的用户的会话
        Set<Entry<Integer, WebSocketSession>> entrySet = USER_SOCKETSESSION_MAP.entrySet();
        //并查找出在线用户的WebSocketSession（会话），将其移除（不再对其发消息了。。）
        for (Entry<Integer, WebSocketSession> entry : entrySet) {
            if(entry.getKey().equals(loginUser.getId())){
                //清除在线会话
                USER_SOCKETSESSION_MAP.remove(entry.getKey());
                //记录日志：
                System.out.println("Socket会话已经移除:用户ID" + entry.getKey());
                break;
            }
        }
    }

    /**
     * websocket链接关闭的回调
     */
    @Override
    public void afterConnectionClosed(WebSocketSession webSocketSession, CloseStatus closeStatus) throws Exception {
        System.out.println("Websocket正常断开:" + webSocketSession.getId() + "已经关闭");
        //获取异常的用户的会话中的用户编号
        User loginUser=(User)webSocketSession.getAttributes().get("loginUser");
        Set<Entry<Integer, WebSocketSession>> entrySet = USER_SOCKETSESSION_MAP.entrySet();
        //并查找出在线用户的WebSocketSession（会话），将其移除（不再对其发消息了。。）
        for (Entry<Integer, WebSocketSession> entry : entrySet) {
            if(entry.getKey().equals(loginUser.getId())){
                //清除在线会话
                USER_SOCKETSESSION_MAP.remove(entry.getKey());
                //记录日志：
                System.out.println("Socket会话已经移除:用户ID" + entry.getKey());
                break;
            }
        }
    }

    @Override
    public boolean supportsPartialMessages() {
        System.out.println("supportsPartialMessages...");
        return false;
    }

    /**
     * 群发消息
     */
    private void sendMessageToAll(final TextMessage message){
        //对用户发送的消息内容进行转义

        //获取到所有在线用户的SocketSession对象
        Set<Entry<Integer, WebSocketSession>> entrySet = USER_SOCKETSESSION_MAP.entrySet();
        for (Entry<Integer, WebSocketSession> entry : entrySet) {
            //某用户的WebSocketSession
            final WebSocketSession session = entry.getValue();
            //判断连接是否仍然打开的
            if(session.isOpen()){
                //开启多线程发送消息（效率高）
                new Thread(new Runnable() {
                    public void run() {
                            if (session.isOpen()) {
                                try {
                                    session.sendMessage(message);
                                } catch (IOException e) {
                                    e.printStackTrace();
                                }

                            }
                    }

                }).start();

            }
        }
    }
}
