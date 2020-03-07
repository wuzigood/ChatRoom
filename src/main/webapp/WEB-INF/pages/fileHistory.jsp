<%--
  Created by IntelliJ IDEA.
  User: 11391
  Date: 2020/3/3
  Time: 14:51
  To change this template use File | Settings | File Templates.<tbody>
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <title>History</title>
</head>
<body>
<h3>所有历史文件</h3><br/>
<table class="table table-bordered">
    <c:forEach items="${requestScope.list}" var="file">
        <tr>
            <%String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();%>
            <td><a href="<%=basePath%>/${file.info}" target='_blank' download='${file.info}'>
                    ${file.uName}-${file.sendTime}-${file.desp}</a><br/>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
