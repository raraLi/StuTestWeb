<%--
  Created by IntelliJ IDEA.
  User: AA
  Date: 2024/7/10
  Time: 15:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改用户信息</title>
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
    </ul>
</div>

<div class="content">
<div align="center">
    <form action="/manager/user/update" style="width: 500px" method="post">
        <input type="hidden" name="id" value="${user.id}">
        <input type="hidden" name="time" value="${user.time}">
        <input type="hidden" name="state" value="${user.state}">
        <table border="1" width="500px">
            <tr>
                <td>用户名:</td><td><input type="text" name="username" value="${user.username}"></td>
            </tr>
            <tr>
                <td>用户密码:</td><td><input type="text" name="password" value="${user.password}"></td>
            </tr>
            <tr>
             	<td class="head">用户类型</td>
             	<td><input type="radio" name="isMaster" value="用户"   ${"用户" eq user.isMaster?'checked':'' }>用户
             		<input type="radio" name="isMaster" value="管理员" ${"管理员" eq user.isMaster?'checked':'' }>管理员
             	</td>
            </tr>
            <tr>
                <td colspan="2"><button type="submit" name="action" value="update">保存</button>
                <button type="submit" name="action" value="init">重置密码</button>
                <button type="submit" name="action" value="return">返回列表</button></td>
            </tr>
        </table>
    </form>
</div>
</div>
</body>
</html>
