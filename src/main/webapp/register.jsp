<%--
  Created by IntelliJ IDEA.
  User: 11391
  Date: 2020/2/22
  Time: 20:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%>
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
    <title>REGISTER</title>
    <script type="text/javascript">
        /*字符串是否由字符，字母，下划线组成，可以用来判断密码
         *由数字、26个英文字母或者下划线组成的字符串：^\w+$ 或 ^\w{3,20}$
         */
        function isValid(str) {
            return /^\w+$/.test(str);
        }

        /*只含有汉字、数字、字母、下划线不能以下划线开头和结尾,验证用户名*/
        function isUserName(str) {
            var reg = /^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+$/;
            return reg.test(str);
        }

        function validateForm() {
            var userName = document.getElementById("myUsername").value;
            var password = document.getElementById("myPassword").value;

            if (userName == null || userName == "") {
                text = "输入不能为空";
                document.getElementById("no_username").innerHTML = text;
                return false;
            } else if (!isUserName(userName)) {
                text = "用户名格式错误，只能含有汉字、数字、字母、下划线且不能以下划线开头和结尾";
                document.getElementById("no_username").innerHTML = text;
                return false;
            }else {
                var text = "";
                document.getElementById("no_username").innerHTML = text;
            }

            if (password == null || password == "") {
                text = "密码不能为空";
                document.getElementById("no_password").innerHTML = text;
                return false;
            } else if (!isValid(password)) {
                text = "密码格式错误，只能含有数字，字母，下划线";
                document.getElementById("no_password").innerHTML = text;
                return false;
            }else {
                var text = "";
                document.getElementById("no_password").innerHTML = text;
            }
            return true;
        }

    </script>
</head>
<body>
    <h3>注册页面</h3><br/>
    <form action="/easychatroom_war_exploded/user/register" method="post" onsubmit="return validateForm()">
        <div>
            账号：<input id="myUsername" type="text" name="username" /><br/>
            <p id="no_username"></p>
            密码：<input id="myPassword" type="text" name="password" /><br/>
            <p id="no_password"></p>
            <input type="submit" value="注册" /><br/>
        </div>

    </form>
    <p id="errorTip"></p>
    <script>
        //取出传回来的参数error并与yes比较
        var isErr ='<%=request.getParameter("error")%>';
        if(isErr=='yes'){
            var tip = document.getElementById("errorTip").value;
            if (tip == null || tip == "") {
                var text = "用户名已存在";
                document.getElementById("errorTip").innerHTML = text;
            }
        }
    </script>

</body>


</html>
