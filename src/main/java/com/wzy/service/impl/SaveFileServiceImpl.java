package com.wzy.service.impl;

import com.wzy.service.ISaveFileService;
import org.springframework.stereotype.Service;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service("saveFileService")
public class SaveFileServiceImpl implements ISaveFileService{
    @Override
    public Map<String, Object> docPath(String fileName) {
        HashMap<String, Object> map = new HashMap<>();
        //根据时间生成文件夹路径
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd");
        String docUrl = simpleDateFormat.format(date);
        //文件保存地址
        String path = "/chatroomupfile/images/" + docUrl;

        // 把文件的名称设置唯一值，uuid
        String uuid = UUID.randomUUID().toString().replace("-", "");
        String newFileName = uuid+"_"+fileName;
        //创建文件
        File dest = new File(path+"/" + newFileName);

        //如果文件已经存在就先删除掉
        if (dest.getParentFile().exists()) {
            dest.delete();
        }

        //文件对象
        map.put("dest", dest);
        //文件的路径
        map.put("path", path+"/" + newFileName);
        map.put("downloadPath","/"+docUrl+"/"+newFileName);
        return map;
    }

    @Override
    public boolean saveFileFromByte(byte[] b, Map<String, Object> map) {
        //创建文件输出流
        FileOutputStream fops = null;
        //从map中获取file对象
        File file = (File) map.get("dest");
        //判断存放路径是否存在
        if(!file.getParentFile().exists()){
            file.getParentFile().mkdirs();
        }
        try {
            fops = new FileOutputStream(file,true);
            fops.write(b);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }finally {
            if(fops!=null){
                try {
                    fops.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return true;
    }
}
