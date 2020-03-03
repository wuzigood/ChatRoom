package com.wzy.service.impl;

import com.wzy.dao.IChatDao;
import com.wzy.javabean.ChatMessage;
import com.wzy.service.IChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("chatService")
public class ChatServiceImpl implements IChatService {
    @Autowired
    private IChatDao chatDao;

    @Override
    public void saveChatMessage(ChatMessage chatMessage) {
        chatDao.saveChatMessage(chatMessage);
    }

    @Override
    public List<ChatMessage> findAllWord() {
        return chatDao.findAllWord();
    }

    @Override
    public List<ChatMessage> findAllFile() {
        return chatDao.findAllFile();
    }
}
