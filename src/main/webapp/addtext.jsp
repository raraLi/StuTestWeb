<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.qst.util.JDBCUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理系统 - 添加选项</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 60%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
        }

        label {
            display: block;
            margin-bottom: 10px;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"], .close-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }

        input[type="submit"]:hover, .close-button:hover {
            background-color: #45a049;
        }

        .error-message {
            color: red;
            font-size: 0.9em;
            margin-top: 5px;
        }
    </style>
    <script>
        function validateForm() {
            var tid = document.getElementById('tid').value.trim();
            var tname = document.getElementById('tname').value.trim();
            var title = document.getElementById('title').value.trim();
            var text = document.getElementById('text').value.trim();
            var aClass = document.querySelector('input[name="class"]:checked').value;

            // 验证tid是否为空
            if (tid === '') {
                document.getElementById('tidError').innerText = '请输入你的ID';
                return false;
            }

            // 验证标题、文本内容、分类和测试名称是否为空
            if (title === '') {
                document.getElementById('titleError').innerText = '请输入标题';
                return false;
            }
            if (text === '') {
                document.getElementById('textError').innerText = '请输入发布内容';
                return false;
            }
            if (!aClass) {
                document.getElementById('classError').innerText = '请选择分类';
                return false;
            }
            if (tname === '') {
                document.getElementById('tnameError').innerText = '请输入用户名';
                return false;
            }

            // 可以添加更多的验证逻辑，例如验证文本内容是否过长等

            return true;
        }
    </script>
</head>
<body>

<div class="container">
    <form action="addtext" method="post" onsubmit="return validateForm()">
        <label for="tid">你的ID：</label>
        <input type="text" id="tid" name="tid">
        <label for="tname">用户名</label>
        <input type="text" id="tname" name="tname">
        <label for="title">标题:</label>
        <input type="text" id="title" name="title">

        <label for="text">文本内容:</label>
        <textarea id="text" name="text" rows="4"></textarea>

        <label>分类:</label>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        conn = JDBCUtil.getConnection();
                        stmt = conn.createStatement();
                        String sql = "SELECT DISTINCT class FROM test";
                        rs = stmt.executeQuery(sql);

                        // 检查结果集并输出单选按钮
                        while (rs.next()) {
                            String className = rs.getString("class");
                %>
                            <label><input type="radio" name="class" value="<%= className %>"><%= className %></label>
                <%
                        }
                    } catch (SQLException e) {
                        // 异常处理逻辑
                    } finally {
                        // 关闭资源
                        if (rs != null) {
                            try { rs.close(); } catch (SQLException e) { /* 忽略异常 */ }
                        }
                        if (stmt != null) {
                            try { stmt.close(); } catch (SQLException e) { /* 忽略异常 */ }
                        }
                        if (conn != null) {
                            try { conn.close(); } catch (SQLException e) { /* 忽略异常 */ }
                        }
                    }
                %>
        <input type="submit" value="添加帖子">
        <a href="testmanage.jsp" class="close-button">关闭</a>
    </form>
</div>
</body>
</html>