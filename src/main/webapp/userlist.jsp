<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML >
<html>
<head>
    <title>Title</title>
</head>
<body>

<table border="1" align="center" width="1000">
    <tr>
        <th>id</th>
        <th>username</th>
        <th>password</th>
        <th>intro</th>
        <th colspan="2">操作</th>
    </tr>
    <c:forEach items="${list}" var="u">
        <tr>
            <td>${u.id}</td>
            <td>${u.username}</td>
            <td>${u.password}</td>
            <td>${u.intro}</td>
            <td><a href="/user/del?id=${u.id}">删除</a></td>
            <td><a href="/user/toedit?id=${u.id}">修改</a></td>
        </tr>
    </c:forEach>
    <tr align="right">
        <td colspan="6"><a href="/user/list">查询</a>&emsp;<a href="/useradd.jsp">添加</a> <a href="/loginout">退出登录</a></td>
    </tr>
</table>
</body>
</html>
