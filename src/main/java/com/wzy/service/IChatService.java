package com.wzy.service;

import com.wzy.javabean.ChatMessage;

import java.util.List;

public interface IChatService {
    //将消息添加到数据库
    void saveChatMessage(ChatMessage chatMessage);

    List<ChatMessage> findAllWord();

    List<ChatMessage> findAllFile();

}
