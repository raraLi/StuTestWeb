<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>游戏开始页面</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            position: relative;
            background-image: url('background.jpg');
            background-size: cover;
            background-position: center;
        }

        .container {
            text-align: center;
        }

        button {
            padding: 10px 20px;
            font-size: 18px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            margin-top: 20px;
        }

        button:hover {
            background-color: #45a049;
        }

        .profile-icon {
            position: absolute;
            top: 10px;
            right: 10px;
        }

        .profile-icon img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
        }

        .profile-icon:hover::after {
            content: "个人主页";
            position: absolute;
            top: 50%;
            right: calc(100% + 5px);
            transform: translateY(-50%);
            padding: 5px;
            background-color: #888;
            color: #fff;
            border-radius: 5px;
            white-space: nowrap;
        }

        h1 {
            font: 96px "微软雅黑";
            margin: 50px auto 50px;
            font-weight: 500;
            text-align: center;
            color: #FFA500;
            -webkit-animation: bounce 2s infinite;
        }

        @-webkit-keyframes bounce {
            0%,100%,20%,50%,80% {
                -webkit-transform: translateY(0);
            }

            40% {
                -webkit-transform: translateY(-30px);
            }

            60% {
                -webkit-transform: translateY(-15px);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>大富翁模拟器</h1>
        <button onclick="startGame()">开始游戏</button>
        <a href="personal.jsp" class="profile-icon">
            <img src="user.jpg" alt="Profile Icon">
        </a>
    </div>

    <script>
        function startGame() {
            // 获取从index.jsp传递过来的id参数
            var userId = <%= request.getParameter("id") %>;
            // 跳转到game.jsp，并带上userId参数
            window.location.href = "game.jsp?id=" + userId;
        }
    </script>
</body>
</html>
