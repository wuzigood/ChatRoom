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
    <script>

        //发送者的id和名字
        var fromId='${sessionScope.user.id}';
        var fromName='${sessionScope.user.userName}';

        var websocket = null;
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
                //将data转化为字符串并发送消息给MyHandle
                websocket.send(JSON.stringify(data));
                //发送完消息，清空输入框
                $("#sendText").val("");
            }
        }

    </script>
</head>
<body>
    <div>
<%--        <ul id="messages"></ul>--%>
        <div class="down" id="down">
            <ul id="contentUI"></ul>

        </div>
    <br/>
        <div>
            <textarea id="sendText"></textarea>
            <button id="sendBtn" onclick="sendMsg()">发送消息</button>
            <button onclick="getConnection()">打开连接</button>
            <button onclick="closeConnection()">断开连接</button>
        </div>
    </div>

</body>
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
