<%--
  Created by IntelliJ IDEA.
  User: 11391
  Date: 2020/2/22
  Time: 21:17
  To change this template use File | Settings | File Templates.
  session.setAttribute("user",userGet);
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = "localhost:8080"+request.getContextPath(); %>
<html>
<head>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="${APP_PATH}/static/js/jquery-3.1.1.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>欢迎来到聊天室</title>

</head>
<body>
    <div>
        <div class="down" id="down">
            <ul id="contentUI"></ul>

        </div><br/>
        <div>
            <textarea id="sendText"></textarea>
            <button id="sendBtn" onclick="sendMsg()">发送消息</button>
            <button onclick="getConnection()">打开连接</button>
            <button onclick="closeConnection()">断开连接</button>

        </div>
        <div class="form-group"></br>
            选择文件:<input type="file" name="" onchange="fileOnchange()" id="fileId">
            <span id="filename"></span><br/>
            <button onclick="sendFile()" >上传文件</button>
        </div>
    </div>

</body>
<script>
    //发送者的id和名字
    var fromId='${sessionScope.user.id}';
    var fromName='${sessionScope.user.userName}';
    //websocket连接
    var websocket = null;
    //文件对象
    var fileObject;
    /**
     * 打开链接
     */
    function getConnection() {
        if (websocket == null) {
            websocket = new WebSocket("ws://<%=path%>"+"/websocket");
            //连接建立时触发
            websocket.onopen = function (event) {
                alert("链接服务器成功!");
            };
            //客户端接收服务端数据时触发
            websocket.onmessage = function (event) {
                var message = $.parseJSON(event.data);
                console.log("WebSocket:收到一条消息",message);
                $("#contentUI").append("<li><b>"+message.fromName+"</b> : <span>"+message.text+"</span></li>");
            };
            //通信发生错误时触发,监听异常
            websocket.onerror = function (event) {
                alert("发生错误，与服务器断开了链接!")
            };
            // 监听WebSocket的关闭
            websocket.onclose = function (event) {
                alert("与服务器断开了链接!")
            };
            // $('#send').bind('click', function () {
            //     send();
            // });
        } else {
            alert("连接已存在!")
        }
    }

    /**
     * 关闭连接
     */
    function closeConnection() {
        if (websocket != null) {
            websocket.close();
            websocket = null;
            alert("已经关闭连接")
        } else {
            alert("未开启连接")
        }
    }

    /**
     * 发送消息
     */
    function sendMsg(){
        //对象为空了
        if(websocket==undefined||websocket==null){
            //alert('WebSocket connection not established, please connect.');
            alert('您的连接已经丢失，请退出聊天重新进入');
            return;
        }
        //获取用户要发送的消息内容
        var msg=$("#sendText").val();
        console.log(msg);
        if(msg == ""){
            return;
        }else{
            //发送消息的信息
            var data={};
            data["fromId"]=fromId;
            data["fromName"]=fromName;
            data["text"]=msg;
            data["type"]="word";
            //将data转化为字符串并发送消息给MyHandle
            websocket.send(JSON.stringify(data));
            //发送完消息，清空输入框
            $("#sendText").val("");
        }
    }
    /**
     * 发送文件
     */
    function sendFile() {
        // //连接断开
        // if(!websocket){
        //     //alert('WebSocket connection not established, please connect.');
        //     alert('您的连接已经丢失，请退出聊天重新进入');
        //     return;
        // }
        //没有文件
        if(!fileObject || fileObject == "")return;
        var inputElement = $("#fileId");
        //一切正常，开始传输文件,创建文件读取器
        var reader = new FileReader();
        //以二进制形式读取文件
        reader.readAsArrayBuffer(fileObject);
        //读取完毕后响应
        reader.onload = function loader(ev) {
            // console.log(ev.target.result);//这个和下面那个是一样的，就是不知道为什么编译器报错
            // console.log(this.result);
            var data={};
            data["fromId"]=fromId;
            data["fromName"]=fromName;
            data["fileName"]=fileObject.name;
            data["text"]=this.result;
            data["type"]="file";
            //发送消息
            websocket.send(JSON.stringify(data));
            //重置<input type="file">的值
            inputElement.val("");
            //清空名字
            $("#filename").html("");
        }


    }
    //监听file域对象的变化，然后用于回显文件名
    function fileOnchange() {
        //从file域对象获取文件对象
        var files = $("#fileId")[0].files;
        //存储文件对象
        fileObject = files[0];
        //测试输出
        console.log(fileObject);
        //回显文件名
        $("#filename").html(fileObject.name);
    }

</script>
<script>


    // var socketPath = "ws://" + "  " +"/ws";
    // var websocket = null;
    // // 打开链接
    // function getConnection() {
    //     if(websocket == null){
    //         websocket = new WebSocket(socketPath);
    //         websocket.onopen = function(event){
    //             console.log("连接成功");
    //             console.log(event);
    //         };
    //         websocket.onerror = function(event){
    //             console.log("连接失败");
    //             console.log(event);
    //         };
    //         websocket.onclose = function(event){
    //             console.log("Socket连接断开");
    //             console.log(event);
    //         };
    //         websocket.onmessage = function(event){
    //             //接受来自服务器的消息
    //             //...
    //             console.log(event.data);
    //         }
    //     }else {
    //         alert("链接已存在")
    //     }
    //
    // }

</script>
</html>
