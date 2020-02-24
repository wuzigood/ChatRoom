<%--
  Created by IntelliJ IDEA.
  User: 11391
  Date: 2020/2/22
  Time: 21:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>欢迎来到chatroom</title>
</head>
<body>

    <div>
<%--        <ul id="messages"></ul>--%>
        <div class="chatter" id="chatter">
            <p id="msg"></p>

        </div>
    <br/>
        <div>
            <textarea id="sendText"></textarea>
            <button id="sendBtn">发送消息</button>
            <button onclick="connection()">打开连接</button>
            <button>断开连接</button>
        </div>
    </div>

</body>
<script>
    function connection() {
        <%String path = "localhost:8080"+request.getContextPath(); %>
        var websocket = new WebSocket("ws://<%=path%>"+"/websocket");
        websocket.onopen = function(event){
            console.log("连接成功");
            console.log(event);

        };
        websocket.onerror = function(event){
            console.log("连接失败");
            console.log(event);
        };
        websocket.onclose = function(event){
            console.log("Socket连接断开");
            console.log(event);
        };
        websocket.onmessage = function(event){
            //接受来自服务器的消息
            //...
            console.log(event.data);
        }
        document.getElementById("sendBtn").onclick = function(){
            var txt =  document.getElementById("sendText").value;
            websocket.send(txt);
        }
    }

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
