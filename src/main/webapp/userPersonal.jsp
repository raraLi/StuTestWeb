<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Personal</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="/CSS/userPersonalStyle.css">
</head>
<body>
    <div class="container">
        <h2>个人信息</h2>
        <img src="/images/login.jpg" alt="Avatar" class="avatar">
        <form action="/user/update" method="post">
         <input type="hidden" name="id" value="${user.id}">
         <input type="hidden" name="isMaster" value="${user.isMaster}">
            <div class="form-group">
                <label for="username">用户名:</label>
                <input type="text" class="form-control" id="username" name="username" value="${user.username}">
            </div>
            <div class="form-group">
                <label for="password">密码:</label>
                <input type="password" class="form-control" id="password" name="password" value="${user.password}">
            </div>
            <div class="form-group">
            <label for="state">最高资产:</label>
            <input type="text" class="form-control" id="state" name="state" value="${user.state}" readonly>
            </div>
            <div class="form-group">
            <label for="time">注册日期:</label>
            <input type="text" class="form-control" id="time" name="time" value="${user.time}" readonly>
            </div>
            <div class="button-container">
            <button type="submit" class="btn btn-primary" name="action" value="update">更新信息</button>
            <button type="submit" class="btn btn-primary" name="action" value="return">返回游戏</button>
            </div>
        </form>
    </div>
</body>
</html>