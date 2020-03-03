<%--
  Created by IntelliJ IDEA.
  User: 11391
  Date: 2020/3/3
  Time: 14:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>History</title>
</head>
<body>
${requestScope.list}<br/>
<c:forEach items="${requestScope.list}" var="file">
    <tbody>
    <tr>
        <%String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();%>
        <th><a href="<%=basePath%>/${file.info}" target='_blank' download='${file.info}'>
                ${file.uName}-${file.sendTime}-${file.info}</a>
        </th>
    </tr>
    </tbody>
</c:forEach>

</body>
</html>
