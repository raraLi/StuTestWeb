<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理系统</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .sidebar {
            float: left;
            width: 180px;
            height: 100vh; /* full height */
            background-color: #333;
            color: #fff;
            padding-top: 20px;
        }

        .sidebar h2 {
            padding: 10px;
            text-align: center;
        }

        .sidebar ul {
            list-style-type: none;
            padding: 0;
            text-align: left;
        }

        .sidebar ul li {
            padding: 15px;
            border-bottom: 1px solid #666;
        }

        .sidebar ul li a {
            color: #fff;
            text-decoration: none;
            display: block;
            padding: 10px;
        }

        .sidebar ul li a:hover {
            background-color: #555;
        }

        .content {
            margin-left: 200px; /* same width as sidebar */
            padding: 10px;
        }

        .content h2 {
            color: #333;
        }
    </style>
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
                    <li><a href="/testmanage.jsp">论坛管理</a></li>

        </ul>
    </div>
    <div class="content">
        <h2>欢迎来到后台管理系统</h2>
    </div>
</body>
</html>
