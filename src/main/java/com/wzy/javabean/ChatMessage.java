package com.wzy.javabean;

import java.io.Serializable;

public class ChatMessage implements Serializable {

    //消息的id
    private Integer id;
    //发送消息的用户id
    private Integer uId;
    //发送消息的用户名
    private String uName;
    //发送消息的时间
    private String sendTime;
    //发送的消息类型
    private String type;
    //发送消息的内容
    private String info;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getuId() {
        return uId;
    }

    public void setuId(Integer uId) {
        this.uId = uId;
    }

    public String getuName() {
        return uName;
    }

    public void setuName(String uName) {
        this.uName = uName;
    }

    public String getSendTime() {
        return sendTime;
    }

    public void setSendTime(String sendTime) {
        this.sendTime = sendTime;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public ChatMessage() {
    }

    public ChatMessage(Integer uId, String uName, String sendTime, String info) {
        this.uId = uId;
        this.uName = uName;
        this.sendTime = sendTime;
        this.info = info;
    }


    @Override
    public String toString() {
        return "ChatMessage{" +
                "id=" + id +
                ", uId=" + uId +
                ", uName='" + uName + '\'' +
                ", sendTime='" + sendTime + '\'' +
                ", type='" + type + '\'' +
                ", info='" + info + '\'' +
                '}';
    }
}
