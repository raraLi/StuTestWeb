<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML >
<html>
<head>
    <title>用户管理</title>
    <link rel="stylesheet" href="/CSS/manage.css">
</head>
<body>

<div class="sidebar">
    <h2>后台管理</h2>
    <ul>
        <li><a href="/user/list">用户管理</a></li>
        <li><a href="/question_manage.jsp">题目管理</a></li>
        <li><a href="/choice_manage.jsp">选项管理</a></li>
        <li><a href="/random_manage.jsp">随机事件管理</a></li>
        <li><a href="/end_manage.jsp">游戏结局管理</a></li>
        <li><a href"testmanage.jsp">论坛管理</a></li>
    </ul>
</div>

<div class="content">
    <h1>用户管理</h1>

<table border="1" align="center" width="1000">
    <tr>
        <th>用户ID</th>
        <th>用户名称</th>
        <th>用户类型</th>
        <th>注册时间</th>
        <th colspan="4">操作</th>
    </tr>
    <c:forEach items="${list}" var="u">
        <tr>
            <td>${u.id}</td>
            <td>${u.username}</td>
            <td>${u.isMaster}</td>
            <td>${u.time}</td>
            <td><a href="/user/info?id=${u.id}"class="action-link">查看</a>
            <a href="/user/edit?id=${u.id}"class="action-link">修改</a>
            <a href="/user/del?id=${u.id}"class="action-link">删除</a>
        </tr>
    </c:forEach>
</table>
</div>
</body>
</html>
