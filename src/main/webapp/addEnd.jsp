<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.qst.util.JDBCUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理系统 - 添加游戏结局</title>
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
            var eid = document.getElementById('eid').value.trim();
            var ehealthy = document.getElementById('ehealthy').value.trim();
            var esan = document.getElementById('esan').value.trim();
            var emoney = document.getElementById('emoney').value.trim();
            var etalent = document.getElementById('etalent').value.trim();



            if (!isValidNumber(ehealthy)) {
                document.getElementById('ehealthyError').innerText = '请输入有效的健康值（数字）。';
                return false;
            }
            if (!isValidNumber(esan)) {
                document.getElementById('esanError').innerText = '请输入有效的精神值（数字）。';
                return false;
            }
            if (!isValidNumber(emoney)) {
                document.getElementById('emoneyError').innerText = '请输入有效的财富值（数字）。';
                return false;
            }
            if (!isValidNumber(etalent)) {
                document.getElementById('etalentError').innerText = '请输入有效的能力值（数字）。';
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
    <h1>添加游戏结局</h1>

    <form action="" method="post" onsubmit="return validateForm()">

        <label for="etext">游戏结局内容:</label>
        <textarea id="etext" name="etext" rows="4"></textarea>


        <label for="ehealthy">健康值:</label>
        <input type="text" id="ehealthy" name="ehealthy">
        <span id="ehealthyError" class="error-message"></span>

        <label for="esan">精神值:</label>
        <input type="text" id="esan" name="esan">
        <span id="esanError" class="error-message"></span>

        <label for="emoney">财富值:</label>
        <input type="text" id="emoney" name="emoney">
        <span id="emoneyError" class="error-message"></span>

        <label for="etalent">能力值:</label>
        <input type="text" id="etalent" name="etalent">
        <span id="etalentError" class="error-message"></span>

        <input type="submit" value="添加游戏结局">
        <a href="end_manage.jsp" class="close-button">关闭</a>
    </form>

    <%-- Java 代码处理表单提交 --%>
    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            Connection conn = null;
            PreparedStatement stmt = null;
            try {
                // 获取表单提交的数据
                String etext = request.getParameter("etext");
                double ehealthy = Double.parseDouble(request.getParameter("ehealthy"));
                double esan = Double.parseDouble(request.getParameter("esan"));
                double emoney = Double.parseDouble(request.getParameter("emoney"));
                double etalent = Double.parseDouble(request.getParameter("etalent"));

                // 插入数据到数据库
                conn = JDBCUtil.getConnection();
                String sql = "INSERT INTO end ( etext,ehealthy, esan, emoney, etalent) VALUES (?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, etext);
                stmt.setDouble(2, ehealthy);
                stmt.setDouble(3, esan);
                stmt.setDouble(4,emoney);
                stmt.setDouble(5, etalent);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
    %>
                    <div style="color: green;">游戏结局添加成功！</div>
    <%
                    response.sendRedirect("end_manage.jsp");
                } else {
    %>
                    <div style="color: red;">游戏结局添加失败，请重试。</div>
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
