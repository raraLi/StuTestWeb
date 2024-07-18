<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
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
    </style>
</head>
<body>

<!-- 弹窗内容 -->
<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="window.history.back()">&times;</span>
        <img src="/images/fd.jpg" alt="Warning" class="modal-image">
        <h3>fd汽车</h3>
    </div>
</div>

<script>
    // 获取弹窗元素
    var modal = document.getElementById("myModal");

    // 页面加载完成后自动打开弹窗
    window.onload = function() {
        modal.style.display = "block";
    }
</script>

</body>
</html>
