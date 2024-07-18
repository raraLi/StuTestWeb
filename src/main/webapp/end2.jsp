<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>欢迎弹窗</title>
    <style>
        /* 弹窗样式 */

        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .modal {
            display: none; /* 默认不显示 */
            position: fixed; /* 固定定位 */
            z-index: 1; /* 确保弹窗在最上层 */
            left: 0;
            top: 0;
            width: 100%; /* 宽度100% */
            height: 100%; /* 高度100% */
            overflow: auto; /* 允许滚动 */
            background-color: rgba(0,0,0,0.4); /* 黑色背景，透明度0.4 */
            animation: fadeIn 0.5s; /* 淡入动画 */
        }


        @keyframes fadeIn {
            from {opacity: 0;}
            to {opacity: 1;}
        }

        /* 弹窗内容样式 */
        .modal-content {
            background-color: #fefefe;
            margin: 10% auto; /* 15%从顶部开始，自动居中 */
            padding: 20px;
            border: 1px solid #888;
            width: 70%; /* 宽度80% */
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2); /* 阴影效果 */
            text-align: center; /* 内容居中对齐 */
            animation: slideIn 0.5s; /* 滑入动画 */
        }

        @keyframes slideIn {
            from {transform: translateY(-50px);}
            to {transform: translateY(0);}
        }

        /* 弹窗关闭按钮样式 */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        /* 图片样式 */
        .modal-image {
            display: block;
            margin: 20px auto; /* 居中对齐 */
            max-width: 50%; /* 控制图片最大宽度 */
            height: auto; /* 高度自动 */
        }
        button {
                    width: 20%;
                    padding: 10px;
                    background: #FF6699;
                    color: white;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                }

                button:hover {
                    background: #E84B85;
                }
    </style>
</head>
<body>

<!-- 弹窗内容 -->
<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <img src="/images/end2.jpg" alt="Warning" class="modal-image">
        <h3>社畜！</h3>
        <p>在游戏的旅程中，你体验了一名社畜的日常生活。每天面对的是无尽的工作和偶尔的小确幸。你的日常，或许充满了重复和压力，但你从未放弃寻找生活的乐趣。你的故事，虽然没有惊天动地的冒险，却有着坚持和努力的足迹。你的成就，或许不是头条新闻，却是自己心中最自豪的篇章。</p>
        <div>
                <form action="/game/again" style="width: 100%" method="post">
                       <input type="hidden" name="id" value="${id}">
                       <button type="submit" name="action" value="submit">再来一局</button>
                </form>
            </div>
    </div>
</div>

<script>
    // 获取弹窗元素
    var modal = document.getElementById("myModal");

    // 获取关闭按钮
    var span = document.getElementsByClassName("close")[0];

    // 点击关闭按钮时，关闭弹窗
    span.onclick = function() {
        modal.style.display = "none";
        xxx()
    }

    // 当用户点击弹窗外部区域时，关闭弹窗
    window.onclick = function(event) {
        if (event.target === modal) {
            modal.style.display = "none";
            xxx()
        }
    }
     function   xxx(){
            alert("你即将退出游戏")
        }

    // 页面加载完成后自动打开弹窗
    window.onload = function() {
        modal.style.display = "block";
    }
</script>

</body>
</html>
