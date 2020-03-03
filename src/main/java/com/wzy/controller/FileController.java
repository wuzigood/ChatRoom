package com.wzy.controller;

import com.wzy.javabean.ChatMessage;
import com.wzy.service.IChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/file")
public class FileController {

    @Autowired
    private IChatService chatService;


    @RequestMapping("/fileDownload")
    public ModelAndView fileDownload(){
        ModelAndView mv = new ModelAndView();
        List<ChatMessage> list = chatService.findAllFile();
        //控制台显示数据
        for(ChatMessage cm : list){
            System.out.println(cm);
        }
        mv.addObject("list",list);
        mv.setViewName("fileHistory");
        return mv;
    }
    @RequestMapping("/test")
    public void test(){
        List<ChatMessage> list = chatService.findAllWord();
        for(ChatMessage cm : list){
            System.out.println(cm);
        }
        System.out.println("=========");
        list = chatService.findAllFile();
        for(ChatMessage cm : list){
            System.out.println(cm);
        }
    }

    @RequestMapping("/fileUpload")
    public @ResponseBody String fileUpload(HttpServletRequest request,@RequestParam("description") String description, MultipartFile upload,@RequestParam("fromName")String fromName,@RequestParam("fromId")String fromId)  {
        System.out.println("上传文件的描述："+description);
        if(!upload.isEmpty()){
            // 上传的位置
//            String path = request.getSession().getServletContext().getRealPath("/uploads/");
            String path = "/chatroomupfile/images/";
            // 判断，该路径是否存在
            File file = new File(path);
            if(!file.exists()){
                // 创建该文件夹
                file.mkdirs();
            }
            // 获取上传文件的名称
            String filename = upload.getOriginalFilename();
            // 把文件的名称设置唯一值，uuid
            String uuid = UUID.randomUUID().toString().replace("-", "");
            filename = uuid+"_"+filename;
            // 完成文件上传
            try {
                upload.transferTo(new File(path,filename));
                //发送消息的时间
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                String sentMsgDate = dateFormat.format(new Date());
                ChatMessage fMessage = new ChatMessage();
                fMessage.setuName(fromName);
                fMessage.setuId(Integer.valueOf(fromId));
                fMessage.setType("file");
                fMessage.setSendTime(sentMsgDate);
                fMessage.setInfo("images/"+filename);
                fMessage.setDesp(description);
                //保存文件
                chatService.saveChatMessage(fMessage);
                System.out.println("保存文件成功");
            } catch (IOException e) {
                e.printStackTrace();
            }finally {
                System.out.println(path+filename);
            }
            return "1";
        }else {
            return "0";
        }

    }
}
