package com.wzy.service.impl;

import com.wzy.dao.IChatDao;
import com.wzy.javabean.ChatMessage;
import com.wzy.service.IChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("chatService")
public class ChatServiceImpl implements IChatService {
    @Autowired
    private IChatDao chatDao;

    @Override
    public void saveChatMessage(ChatMessage chatMessage) {
        chatDao.saveChatMessage(chatMessage);
    }
}
