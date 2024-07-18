<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>masterLogin</title>
    <link rel="stylesheet" href="CSS/loginStyle.css">
</head>
<body>
<jsp:include page="background.jsp" />
    <div class="container">
        <h2>登录</h2>
        <form action="/login/login" method="post">
            <input type="text" name="username" placeholder="用户名" required>
            <input type="password" name="password" placeholder="密码" required>
            <button type="submit">登录</button>
        </form>
        <p>还未建立游戏账号？   <a href="register.jsp"> 点击注册</a></p>
    </div>
    <div class="pic">

    </div>
</body>
</html>