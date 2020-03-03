package com.wzy.dao;

import com.wzy.javabean.ChatMessage;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Dao层操作chat表
 *     //消息的id
 *     private Integer id;
 *     //发送消息的用户id
 *     private Integer uId;
 *     //发送消息的用户名
 *     private String uName;
 *     //发送消息的时间
 *     private String sendTime;
 *     //发送的消息类型
 *     private String type;
 *     //发送消息的内容
 *     private String info;
 */
@Repository
public interface IChatDao {

    //保存聊天记录
    @Insert("insert into chat(uid,uName,sendTime,type,info,desp) values(#{uId},#{uName},#{sendTime},#{type},#{info},#{desp});")
    void saveChatMessage(ChatMessage chatMessage);

    @Select("select * from chat where type = 'word'")
    List<ChatMessage> findAllWord();

    @Select("select * from chat where type = 'file'")
    List<ChatMessage> findAllFile();

}
