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
<style>
    .greyblock{
        border-top-right-radius: 5px;
        border-top-left-radius: 5px;
        border-bottom-right-radius:5px;
        border-bottom-left-radius:5px;
        border-style: solid;
        border-color: #c0c0c0;
    }
    .people{
        border-top-right-radius: 5px;
        border-top-left-radius: 5px;
        border-bottom-right-radius:5px;
        border-bottom-left-radius:5px;
        height:700px;
        border-style: solid;
        border-color: #c0c0c0;
        margin-bottom:10px;
        padding:15px;
        overflow:auto;
        margin-top: 10px;
    }
    .up{
        border-top-right-radius: 5px;
        border-top-left-radius: 5px;
        border-bottom-right-radius:5px;
        border-bottom-left-radius:5px;
        height:300px;
        border-style: solid;
        border-color: #c0c0c0;
        margin-bottom:10px;
        padding:15px;
        overflow:auto;
        margin-top: 10px;
    }
    .up em{ font-style:normal; background:#FF6600; color:#FFFFFF; padding:3px 5px; margin:0 5px; float:left;}
    .up b{ font-weight:normal; background-color:#333333; padding:2px 5px; color:#f4f4f4; float:left;}
    .up span{ background:#f4f4f4; padding:3px 5px; float:left; max-width:480px;}
    .up ul li{ margin-bottom:10px;overflow:hidden;}
</style>
<head>
    <script src=”http://html5shiv.googlecode.com/svn/trunk/html5.js”></script>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="${APP_PATH}/static/js/jquery-3.1.1.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>聊天室</title>

</head>
<body>
<div class="row">
    <div class="col-md-1">
        <div id="people" class="people">
            <p class="text-danger" style="text-align: center">在线名单</p>
            <ul class="list-group" id="chatUserList">
            </ul>
        </div>
    </div>
    <div class="col-md-11">
        <div class="row">
            <div class="col-md-12" >
                <div class="up" id="up">
                    <ul id="contentUI">

                    </ul>
                </div>
            </div>
        </div>
        <div class="greyblock" style="height:390px;">
            <div class="row">
                <div class="col-md-12" style="margin-top: 10px;">
                    <div class="col-md-12">
                        <textarea class="form-control" rows="10" id="sendText"></textarea>
                    </div>
                </div>
            </div>

            <div class="row" style="margin-top: 10px">
                <div class="col-md-8">
                    <form  id="tf"  enctype="multipart/form-data" >
                        <div class="col-md-4">
                            用户名：<input class="form-control" type="text" name="fromName" id="uName" value="用户名" disabled><br/>
                            用户ID：<input class="form-control" type="text" name="fromId" id="uId" value="用户Id" disabled><br/>
                        </div>
                        <div class="col-md-8">
                            <table class="table">
                                <tr>
                                    <td>文件描述:</td>
                                    <td><input class="form-control" type="text" name="description" id="filedesp"></td>
                                </tr>
                                <tr>
                                    <td>请选择文件:</td>
                                    <td><input type="file" name="upload" id="fileId"></td>
                                </tr>
                                <tr>
                                    <td><input class="btn btn-default" type="button" value="上传" onclick="newSendFile()"></td>
                                </tr>
                            </table>
                        </div>
                    </form>
                </div>


                <div class="col-md-4">

                    <button id="sendBtn" class="btn btn-success" onclick="sendMsg()">发送消息</button>
                    <button class="btn btn-info" onclick="getConnection()">打开连接</button>
                    <button class="btn btn-danger" onclick="closeConnection()">断开连接</button>
                    <a class="btn btn-default active" role="button" href="../file/fileDownload" target='_blank'>历史文件</a><br/>
                </div>
                <%--        <div class="form-group"></br>--%>
                <%--            选择文件:<input type="file" name="" onchange="fileOnchange()" id="fileId">--%>
                <%--            <span id="filename"></span><br/>--%>
                <%--            <button onclick="sendFile()" >上传文件</button>--%>
                <%--        </div>--%>



                <%--        <input type="button" value="发送异步请求" onclick="fun();">--%>


            </div>
        </div>

    </div>
</div>




</body>
<script>
    //发送者的id和名字
    var fromId='${sessionScope.user.id}';
    var fromName='${sessionScope.user.userName}';
    $("#uName").val(fromName);
    $("#uId").val(fromId);
    function newSendFile(){
        // var data = {};//一个空的对象
        var form = new FormData($('#tf')[0]);
        form.append("fromName",fromName);
        form.append("fromId",fromId);
        console.log(fromId);
        console.log(fromName);
        $.ajax({
            url:"../file/fileUpload",
            type:"POST",
            data:form,
            processData:false,
            contentType:false,
            success:function(data){
                alert("上传成功");
                //重置<input type="file">的值
                $("#fileId").val("");
                //清空名字
                $("#filedesp").val("");
                // $("#contentUI").append("<li><b>"+fromName+"</b><span>"+data+"</span></li>");
            }
        });
        //发送消息的信息
        var data={};
        data["fromId"]=fromId;
        data["fromName"]=fromName;
        data["text"]="=======上传了一个文件======";//代表消息内容
        data["type"]="word";
        //将data转化为字符串并发送消息给MyHandle
        websocket.send(JSON.stringify(data));
        scrollToBottom();
    }

    //定义测试的方法
    // function  fun() {
    //     //使用$.ajax()发送异步请求
    //     $.ajax({
    //         url:"../file/fileDownload" , // 请求路径
    //         contentType:"application/json;charset=UTF-8",
    //         type:"POST" , //请求方式
    //         // data: "username=jack&age=23",//请求参数
    //         data:'{"username":"jack","age":23}',
    //         success:function (data) {
    //             alert(data);
    //
    //         },//响应成功后的回调函数
    //         error:function () {
    //             alert("出错啦...")
    //         },//表示如果请求响应出现错误，会执行的回调函数
    //
    //         dataType:"text"//设置接受到的响应数据的格式
    //     });
    // }

</script>
<script>
    //下载文件地址
    var downloadPath = "localhost:8080/images";
    <%--//发送者的id和名字--%>
    <%--var fromId='${sessionScope.user.id}';--%>
    <%--var fromName='${sessionScope.user.userName}';--%>
    //websocket连接
    var websocket = null;
    //文件对象
    var fileObject;

    var paragraph = 5120;//文件分块上传大小5kb
    var startSize, endSize = 0;//文件的起始大小和文件的结束大小

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
                if(message.type === "again"){
                    websocket = null;
                    alert("账号在其他地方登陆")
                }
                else if (message.type === "people") {
                    $("#chatUserList").empty();
                    //将名称字符串转成对象
                    var obj = eval('(' + message.info + ')');
                    //把在线人数的名字显示出来
                    $.each(obj,function(i,j){
                        $("#chatUserList").append("<li class=\"list-group-item\">"+j+"</li>");
                    })
                }else if(message.type === "word"){
                    $("#contentUI").append("<li><b>"+message.fromName+"</b><span>"+message.text+"</span></li>");
                    scrollToBottom();
                }else if(message.type === "ok"){
                    // websocket.send(fileObject);
                    if(endSize < fileObject.size){
                        startSize = endSize;
                        endSize += paragraph;
                        //选定已有数组中的元素
                        console.log(startSize,endSize);
                        var blob = fileObject.slice(startSize, endSize);
                        //一切正常，开始传输文件,创建文件读取器
                        var reader = new FileReader();
                        //以二进制形式读取blob
                        reader.readAsArrayBuffer(blob);
                        //读取完毕后响应
                        reader.onload = function loader(ev) {
                            // console.log(ev.target.result);//这个和下面那个是一样的，就是不知道为什么编译器报错
                            // console.log(this.result);
                            //获取读取到的结果
                            var arrayBuffer = ev.target.result;
                            //发送二进制
                            websocket.send(arrayBuffer);
                        }
                    }else{
                        alert("上传成功");
                        var data={};
                        data["fromId"]=fromId;
                        data["fromName"]=fromName;
                        data["text"]=fileObject.name;//代表文件名
                        data["type"]="over";
                        //发送 该文件上传成功的 消息
                        websocket.send(JSON.stringify(data));
                        //重置<input type="file">的值
                        $("#fileId").val("");
                        //清空名字
                        $("#filename").html("");
                    }
                }else if(message.type === "link"){
                    $("#contentUI").append("<li><b>"+message.uName+"</b> : <a href='' id='downUrl' download='图片' target='_blank'>"+message.info+"</a></li>");
                    $("#downUrl").attr("href",downloadPath+message.info);
                    $("#downUrl").attr("download",message.info);
                }
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
        scrollToBottom();
    }

    /**
     * 关闭连接
     */
    function closeConnection() {
        if (websocket != null) {
            websocket.close();
            websocket = null;
            // alert("已经关闭连接")
            //清空在线名单
            $("#chatUserList").empty();
        } else {
            alert("未开启连接")
        }
        scrollToBottom();
    }

    /**
     * 发送消息
     */
    function sendMsg(){
        //对象为空了
        if(!websocket){
            //alert('WebSocket connection not established, please connect.');websocket==undefined||websocket==null
            alert('您的连接已经丢失，请退出聊天重新进入');
            return;
        }
        //获取用户要发送的消息内容
        var msg=$("#sendText").val();
        console.log(msg);
        if(msg === ""){
            return;
        }else{
            //发送消息的信息
            var data={};
            data["fromId"]=fromId;
            data["fromName"]=fromName;
            data["text"]=msg;//代表消息内容
            data["type"]="word";
            //将data转化为字符串并发送消息给MyHandle
            websocket.send(JSON.stringify(data));
            //发送完消息，清空输入框
            $("#sendText").val("");
        }
        scrollToBottom();
    }
    /**
     * 发送文件
     */
    function sendFile() {
        //连接断开
        if(!websocket){
            //alert('WebSocket connection not established, please connect.');
            alert('您的连接已经丢失，请退出聊天重新进入');
            return;
        }
        //没有文件
        if(!fileObject || fileObject == "")
            return;
        // var inputElement = $("#fileId");
        //获取文件对象
        // var fileData = fileObject;

        var data={};
        data["fromId"]=fromId;
        data["fromName"]=fromName;
        data["text"]=fileObject.name;//代表文件名
        data["type"]="file";
        //发送 准备发文件的 消息
        websocket.send(JSON.stringify(data));



        // //重置<input type="file">的值
        // inputElement.val("");
        // //清空名字
        // $("#filename").html("");



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

    //div滚动条(scrollbar)保持在最底部
    function scrollToBottom(){
        //var div = document.getElementById('chatCon');
        var div = document.getElementById('up');
        div.scrollTop = div.scrollHeight;
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
