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

        .profile-icons {
            position: absolute;
            top: 10px;
            right: 10px;
            display: flex;
            flex-direction: column;
            align-items: flex-end; /* Align icons and tooltips to the right */
        }

        .profile-icons a {
            margin-top: 10px;
            text-decoration: none;
            color: #333;
            display: flex;
            align-items: center;
            position: relative; /* Ensure relative positioning for absolute positioning of tooltips */
        }

        .profile-icons a img {
            width: 60px; /* Adjust as needed */
            height: 60px; /* Adjust as needed */
            border-radius: 50%;
            margin-right: 10px; /* Add spacing between icon and tooltip */
        }

        .profile-icons a::after {
            content: attr(data-tooltip);
            position: absolute;
            top: 50%;
            right: calc(100% + 10px); /* Position tooltip to the left of the icon */
            transform: translateY(-50%);
            padding: 5px;
            background-color: #888;
            color: #fff;
            border-radius: 5px;
            white-space: nowrap;
            display: none; /* Hide tooltip by default */
        }

        .profile-icons a:hover::after {
            display: block; /* Show tooltip on hover */
        }

        h1 {
            font: 96px "微软雅黑";
            margin: 50px auto 50px;
            font-weight: 500;
            text-align: center;
            color: #FFA500;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 100%, 20%, 50%, 80% {
                transform: translateY(0);
            }

            40% {
                transform: translateY(-30px);
            }

            60% {
                transform: translateY(-15px);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>大富翁模拟器</h1>
        <button onclick="startGame()">开始游戏</button>
    </div>

    <div class="profile-icons">
        <a href="personal.jsp" class="profile-icon" data-tooltip="个人主页">
            <img src="user.jpg" alt="Profile Icon">
        </a>
        <a href="rank.jsp" data-tooltip="富翁榜">
            <img src="rank_icon.jpg" alt="Rank Icon">
        </a>
        <a href="text.jsp" data-tooltip="文本信息">
            <img src="text_icon.jpg" alt="Text Icon">
        </a>
    </div>

    <script>
        function startGame() {
            var userId = <%= request.getParameter("id") %>;
            window.location.href = "game.jsp?id=" + userId;
        }
    </script>
</body>
</html>

