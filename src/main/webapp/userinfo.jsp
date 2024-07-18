<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>查看用户信息</title>
    <link rel="stylesheet" href="/CSS/manage.css">
    <style>
    /*箭头*/
             .link-container {
                        text-align: right;
                        margin-top: 20px;
                    }

                    .arrow-link {
                        position: relative;
                        display: inline-block;
                        text-decoration: none;
                        color: white;
                        background-color: #6c757d;
                        padding: 10px 20px;

                        border-radius: 5px;
                        transition: all 0.3s ease;
                        font-size: 15px;
                        font-weight: bold;
                        overflow: hidden;
                    }

                    .arrow-link::before {

                        position: absolute;
                        top: -5px;
                        left: -10px;
                        font-size: 15px;
                        transform: rotate(-45deg)
                        pointer-events: none;
                    }

                    .arrow-link:hover {
                        background-color: #333;
                        color: white;
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

<div align="center">
        <table border="1" width="500px">
            <tr>
                <td>用户ID</td>
                <td>${user.id}</td>
            </tr>
            <tr>
                <td>用户名称</td>
                <td>${user.username}</td>
            </tr>
            <tr>
                <td>用户密码</td>
                <td>${user.password}</td>
            </tr>
            <tr>
              	<td>游戏年龄</td>
                <td>${play.age}</td>
            </tr>
            <tr>
             	<td>健康值</td>
                <td>${play.healthy}</td>
            </tr>
            <tr>
             	<td>精神值</td>
                <td>${play.san}</td>
            </tr>
            <tr>
               	<td>财富值</td>
                <td>${play.money}</td>
            </tr>
            <tr>
             	<td>能力值</td>
                <td>${play.talent}</td>
            </tr>
            <tr>
                <td>最高资产</td>
                <td>${user.state}</td>
            </tr>
            <tr>
             	<td>用户类型</td>
             	 <td>${user.isMaster}</td>
            </tr>
            <tr>
                <td>注册时间</td>
                <td>${user.time}</td>
            </tr>
        </table>
    </form>
</div>

<div class="link-container">
    <a href="/user/list" class="arrow-link">返回列表</a>
</div>

</div>
</body>
</html>
