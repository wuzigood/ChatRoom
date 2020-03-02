package com.wzy.service;

import java.util.Map;

//保存文件的接口
public interface ISaveFileService {
    /**
     * 生成文件保存路径
     * @param fileName 接收文件名
     * @return
     */
    Map<String,Object> docPath(String fileName);

    /**
     * 将字节流写入文件
     * @param b 字节流数组
     * @param map 文件路径
     * @return 返回是否成功
     */
    boolean saveFileFromByte(byte[] b,Map<String,Object> map);

}
