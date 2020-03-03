<%--
  Created by IntelliJ IDEA.
  User: 11391
  Date: 2020/2/20
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  %>
<%String path = "localhost:8080"+request.getContextPath(); %>
<html>
<style>
    /*div{margin:1px;}*/
</style>
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

</head>
<body>

    <div class="row" style="margin-top: 50px">
        <div class="col-md-6 col-md-offset-5">
            <h2 class="col-md-12">登录页面</h2>
        </div>
        <div class="col-md-1"></div>
    </div>
    <div class="row">
        <div class="col-md-5 col-md-offset-3">
            <form class="form-horizontal" action="user/login" method="post" name="loginForm" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="myUsername" class="col-sm-2 control-label">账号</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="myUsername" name="username" placeholder="Username">
                        <label class="label label-danger" id="no_username"></label>
                    </div>
                </div>
                <div class="form-group">
                    <label for="myPassword" class="col-sm-2 control-label">密码</label>
                    <div class="col-sm-10">
                        <input type="password" name="password" class="form-control" id="myPassword" placeholder="Password">
                        <span class="label label-danger" id="no_password"></span>
                    </div>
                </div>

                <div class="col-md-4 col-md-offset-5" id="buttonBox">
                    <div class="col-md-4">
                        <input class="btn btn-success" type="submit" value="登录">
                    </div>
                    <div class="col-md-4">
                        <input class="btn btn-default" type="button" value="注册" onclick="location.href='register.jsp'" >
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="row" style="margin-top: 20px">
        <div class="col-md-4 col-md-offset-5">
            <p class="label label-danger" id="errorTip"></p>
        </div>
    </div>





</body>
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
</html>
