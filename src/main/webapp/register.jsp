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
    <title>Title</title>
</head>
<body>
    <h3>注册页面</h3><br/>
    <form action="/easychatroom_war_exploded/user/register" method="post" >
        姓名：<input type="text" name="username" /><br/>
        密码：<input type="text" name="password" /><br/>
        <input type="submit" value="注册"/><br/>
    </form>

</body>


</html>
