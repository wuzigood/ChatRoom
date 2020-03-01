package com.wzy.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.wzy.javabean.ChatMessage;
import com.wzy.javabean.User;
import com.wzy.service.IChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Map.Entry;

//@Component
public class MyHandle implements WebSocketHandler {
    //定义全局变量，用于确定传输消息的类型
    private static final String WORD = "word";
    private static final String FILE = "file";



    //用来调用chatService层
    @Autowired
    private IChatService chatService;



    //在线用户的SOCKETsession(存储了所有的通信通道)
    public static final Map<Integer, WebSocketSession> USER_SOCKETSESSION_MAP;
    //用于存储所有的在线用户
    static {
        USER_SOCKETSESSION_MAP = new HashMap<Integer, WebSocketSession>();
    }
    //在线用户的名字
    private final static List<String> USER_ONLINE = new ArrayList<>();



    //连接建立之后的操作，webscoket建立好链接之后的处理函数--连接建立后的准备工作
    @Override
    public void afterConnectionEstablished(WebSocketSession webSocketSession) throws Exception {
        User loginUser=(User) webSocketSession.getAttributes().get("loginUser");
        //如果账号之前已经登陆过，就让他下线，然后再重新登录
        if(USER_SOCKETSESSION_MAP.containsKey(loginUser.getId())){
            WebSocketSession firstSess = USER_SOCKETSESSION_MAP.get(loginUser.getId());
            ChatMessage chatMessage =new ChatMessage();
            chatMessage.setType("again");
            String json =  JSONObject.toJSON(chatMessage).toString();
            sendMessageToOne(new TextMessage(json),firstSess);
            //将用户从表中删去
            subOnlineCount(firstSess);
            //返回在线人数信息给前端
            rPeopleNum();

        }
        //将当前的连接的用户会话放入MAP,key是用户编号
        addOnlineCount(webSocketSession);
        //返回在线人数信息给前端
        rPeopleNum();

    }

    //客户端发送服务器的消息时的处理函数，在这里收到消息之后可以分发消息
    @Override
    public void handleMessage(WebSocketSession webSocketSession, WebSocketMessage<?> message) throws Exception {
        //如果消息没有任何内容，则直接返回
        if(message.getPayloadLength()==0)return;
        //获得前端传过来的json数据，变为json字符串
        String str = message.getPayload().toString();
        System.out.println("消息（可存数据库作为历史记录）:"+str);
        //将json字符串转换成json对象
        JSONObject jsonObject = JSON.parseObject(str);
        //获取传过来的消息的类型
        String type = jsonObject.get("type").toString();
        Integer uId = Integer.valueOf(jsonObject.get("fromId").toString());
        String uName = jsonObject.get("fromName").toString();
        String info = jsonObject.get("text").toString();
        //发送消息的时间
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String sentMsgDate = dateFormat.format(new Date());

        //如果是短信消息
        if(WORD.equals(type)){
            //将消息保存到数据库
            ChatMessage chatMessage = new ChatMessage(uId,uName,sentMsgDate,info);
            chatMessage.setType(type);
            //调用service层方法存
            System.out.println("保存message成功:"+chatMessage.getInfo());
            //打开注释可以将聊天记录保存到数据库中
//            chatService.saveChatMessage(chatMessage);
            //群发出去,对用户发送的消息内容进行转义
            sendMessageToAll(new TextMessage(str));
        }
        //如果发送过来的是文件
        else if(FILE.equals(type)){
            //文件处理
            System.out.println("文件上传成功");
        }


    }

    //消息传输过程中出现的异常处理函数
    @Override
    public void handleTransportError(WebSocketSession webSocketSession, Throwable throwable) throws Exception {
        // 记录日志，准备关闭连接
        System.out.println("Websocket异常断开:" + webSocketSession.getId() + "已经关闭");
        //一旦发生异常，强制用户下线，关闭session
        if (webSocketSession.isOpen()) {
            webSocketSession.close();
        }
        //将用户从表中删去
        subOnlineCount(webSocketSession);
        //返回在线人数信息给前端
        rPeopleNum();
    }

    //websocket链接关闭的回调
    @Override
    public void afterConnectionClosed(WebSocketSession webSocketSession, CloseStatus closeStatus) throws Exception {
        System.out.println("Websocket正常断开:" + webSocketSession.getId() + "已经关闭");
        //将用户从表中删去
        subOnlineCount(webSocketSession);
        //返回在线人数信息给前端
        rPeopleNum();
    }

    @Override
    public boolean supportsPartialMessages() {
        System.out.println("supportsPartialMessages...");
        return false;
    }

    //私发消息
    private void sendMessageToOne(final TextMessage message,WebSocketSession webSocketSession){
        //获取到所有在线用户的SocketSession对象
        Set<Entry<Integer, WebSocketSession>> entrySet = USER_SOCKETSESSION_MAP.entrySet();
        for (Entry<Integer, WebSocketSession> entry : entrySet) {
            if(webSocketSession.equals(entry.getValue())){
                //判断连接是否仍然打开的
                if(webSocketSession.isOpen()){
                    //开启多线程发送消息（效率高）
                    new Thread(new Runnable() {
                        public void run() {
                            if (webSocketSession.isOpen()) {
                                try {
                                    webSocketSession.sendMessage(message);
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

    //群发消息
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

    //将用户添加到表中
    private static synchronized void addOnlineCount(WebSocketSession webSocketSession) {
        //将当前的连接的用户会话放入MAP,key是用户编号
        User loginUser=(User) webSocketSession.getAttributes().get("loginUser");
        USER_SOCKETSESSION_MAP.put(loginUser.getId(), webSocketSession);
        System.out.println("afterConnectionEstablished...将用户的session装到map中");
        USER_ONLINE.add(loginUser.getUserName());
    }



    //将用户从表中删去
    private static synchronized void subOnlineCount(WebSocketSession webSocketSession) {
        //获取异常的用户的会话中的用户编号
        User loginUser=(User)webSocketSession.getAttributes().get("loginUser");
        if(USER_ONLINE.contains(loginUser.getUserName())){
            //删除在线用户
            USER_ONLINE.remove(loginUser.getUserName());
        }
        if(USER_SOCKETSESSION_MAP.containsKey(loginUser.getId())){
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

    }

    //将在线人数转成json
    private static String onLineCount(){
        return JSONArray.toJSONString(USER_ONLINE);
    }

    //返回在线人数信息给前端
    private void rPeopleNum(){
        //在线人的名字字符串
        String peopleNum = onLineCount();
        //创建消息对象
        ChatMessage cm = new ChatMessage();
        cm.setType("people");
        cm.setInfo(peopleNum);
        //将消息对象转换成json
        String json = JSONArray.toJSON(cm).toString();
        sendMessageToAll(new TextMessage(json));
    }


}
