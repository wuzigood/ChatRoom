<%--
  Created by IntelliJ IDEA.
  User: 11391
  Date: 2020/2/20
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  %>
<html>
<head>
    <meta charset="UTF-8">
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="${APP_PATH}/static/js/jquery-3.1.1.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>LOGIN</title>
    <script type="text/javascript">
        function validateForm() {
            var un = document.getElementById("myUsername").value;
            var pw = document.getElementById("myPassword").value;
            if (un == null || un == "") {
                var text = "输入不能为空";
                document.getElementById("no_username").innerHTML = text;
                return false;
            }else {
                var text = "";
                document.getElementById("no_username").innerHTML = text;
            }
            if (pw == null || pw == "") {
                var text = "密码不能为空";
                document.getElementById("no_password").innerHTML = text;
                return false;
            }else{
                var text = "";
                document.getElementById("no_password").innerHTML = text;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <h3 class="col-md-6 col-md-offset-3">登录页面</h3>
        </div>
    </div>

    <form action="user/login" method="post" name="loginForm" onsubmit="return validateForm()">
        <div>
            账号：<input id="myUsername" type="text" name="username"/>
            <p id="no_username"></p>
            密码：<input id="myPassword" type="text"  name="password"/>
            <p id="no_password"></p>
        </div>

<%--        <input type="submit" value="登录"/><br/>--%>
        <div id="buttonBox">
            <input type="submit" value="登录">
            <input type="button" value="注册" onclick="location.href='http://localhost:8080/easychatroom_war_exploded/register.jsp'" >
        </div>
    </form>
    <p id="errorTip"></p>
    <script>
        //取出传回来的参数error并与yes比较
        var isErr ='<%=request.getParameter("error")%>';
        var tip = document.getElementById("errorTip").value;
        if(isErr=='yes'){
            var text = "登录失败!账号或密码错误";
            document.getElementById("errorTip").innerHTML = text;
        }else if(isErr=='no'){
            var text = "注册成功，已自动为你跳转到登录页面";
            document.getElementById("errorTip").innerHTML = text;
        }
    </script>

</body>
</html>
