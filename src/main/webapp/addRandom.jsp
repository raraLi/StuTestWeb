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
            var rid = document.getElementById('rid').value.trim();
            var rhealthy = document.getElementById('rhealthy').value.trim();
            var rsan = document.getElementById('rsan').value.trim();
            var rmoney = document.getElementById('rmoney').value.trim();
            var rtalent = document.getElementById('rtalent').value.trim();


            if (!isValidNumber(rhealthy)) {
                document.getElementById('rhealthyError').innerText = '请输入有效的健康值（数字）。';
                return false;
            }
            if (!isValidNumber(rsan)) {
                document.getElementById('rsanError').innerText = '请输入有效的精神值（数字）。';
                return false;
            }
            if (!isValidNumber(rmoney)) {
                document.getElementById('rmoneyError').innerText = '请输入有效的财富值（数字）。';
                return false;
            }
            if (!isValidNumber(rtalent)) {
                document.getElementById('rtalentError').innerText = '请输入有效的能力值（数字）。';
                return false;
            }

            return true;
        }

        function isValidNumber(value) {
            return !isNaN(value);
        }
    </script>
</head>
<body>

<div class="container">
    <h1>添加随机事件</h1>

    <form action="" method="post" onsubmit="return validateForm()">

        <label for="rtext">随机事件内容:</label>
        <textarea id="rtext" name="rtext" rows="4"></textarea>


        <label for="rhealthy">健康值:</label>
        <input type="text" id="rhealthy" name="rhealthy">
        <span id="rhealthyError" class="error-message"></span>

        <label for="rsan">精神值:</label>
        <input type="text" id="rsan" name="rsan">
        <span id="rsanError" class="error-message"></span>

        <label for="rmoney">财富值:</label>
        <input type="text" id="rmoney" name="rmoney">
        <span id="rmoneyError" class="error-message"></span>

        <label for="rtalent">能力值:</label>
        <input type="text" id="rtalent" name="rtalent">
        <span id="rtalentError" class="error-message"></span>

        <input type="submit" value="添加随机事件">
        <a href="random_manage.jsp" class="close-button">关闭</a>
    </form>

    <%-- Java 代码处理表单提交 --%>
    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            Connection conn = null;
            PreparedStatement stmt = null;
            try {
                // 获取表单提交的数据
                String rtext = request.getParameter("rtext");
                double rhealthy = Double.parseDouble(request.getParameter("rhealthy"));
                double rsan = Double.parseDouble(request.getParameter("rsan"));
                double rmoney = Double.parseDouble(request.getParameter("rmoney"));
                double rtalent = Double.parseDouble(request.getParameter("rtalent"));

                // 插入数据到数据库
                conn = JDBCUtil.getConnection();
                String sql = "INSERT INTO random ( rtext,rhealthy, rsan, rmoney, rtalent) VALUES (?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, rtext);
                stmt.setDouble(2, rhealthy);
                stmt.setDouble(3, rsan);
                stmt.setDouble(4,rmoney);
                stmt.setDouble(5, rtalent);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
    %>
                    <div style="color: green;">随机事件添加成功！</div>
    <%
                    response.sendRedirect("random_manage.jsp");
                } else {
    %>
                    <div style="color: red;">随机事件添加失败，请重试。</div>
    <%
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("有没填写的内容！" );
            } finally {
                // 关闭数据库连接和语句
                JDBCUtil.close(conn, stmt, null);
            }
        }
    %>

</div>

</body>
</html>
