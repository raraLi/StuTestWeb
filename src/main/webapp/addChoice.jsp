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
            var qid = document.getElementById('qid').value.trim();
            var cage = document.getElementById('cage').value.trim();
            var chealthy = document.getElementById('chealthy').value.trim();
            var csan = document.getElementById('csan').value.trim();
            var cmoney = document.getElementById('cmoney').value.trim();
            var ctalent = document.getElementById('ctalent').value.trim();

            if (qid === '') {
                document.getElementById('qidError').innerText = '请输入问题ID。';
                return false;
            }
            if (!isValidNumber(cage)) {
                document.getElementById('cageError').innerText = '请输入有效的年龄（数字）。';
                return false;
            }
            if (!isValidNumber(chealthy)) {
                document.getElementById('chealthyError').innerText = '请输入有效的健康值（数字）。';
                return false;
            }
            if (!isValidNumber(csan)) {
                document.getElementById('csanError').innerText = '请输入有效的精神值（数字）。';
                return false;
            }
            if (!isValidNumber(cmoney)) {
                document.getElementById('cmoneyError').innerText = '请输入有效的财富值（数字）。';
                return false;
            }
            if (!isValidNumber(ctalent)) {
                document.getElementById('ctalentError').innerText = '请输入有效的能力值（数字）。';
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
    <h1>添加选项</h1>

    <form action="" method="post" onsubmit="return validateForm()">
        <label for="qid">题目ID:</label>
        <input type="text" id="qid" name="qid">

        <label for="ctext">选项内容:</label>
        <textarea id="ctext" name="ctext" rows="4"></textarea>

        <label for="cage">年龄:</label>
        <input type="text" id="cage" name="cage">
        <span id="cageError" class="error-message"></span>

        <label for="chealthy">健康值:</label>
        <input type="text" id="chealthy" name="chealthy">
        <span id="chealthyError" class="error-message"></span>

        <label for="csan">精神值:</label>
        <input type="text" id="csan" name="csan">
        <span id="csanError" class="error-message"></span>

        <label for="cmoney">财富值:</label>
        <input type="text" id="cmoney" name="cmoney">
        <span id="cmoneyError" class="error-message"></span>

        <label for="ctalent">能力值:</label>
        <input type="text" id="ctalent" name="ctalent">
        <span id="ctalentError" class="error-message"></span>

        <input type="submit" value="添加选项">
        <a href="choice_manage.jsp" class="close-button">关闭</a>
    </form>

    <%-- Java 代码处理表单提交 --%>
    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            Connection conn = null;
            PreparedStatement stmt = null;
            try {
                // 获取表单提交的数据
                String qid = request.getParameter("qid");
                String ctext = request.getParameter("ctext");
                double cage = Double.parseDouble(request.getParameter("cage"));
                double chealthy = Double.parseDouble(request.getParameter("chealthy"));
                double csan = Double.parseDouble(request.getParameter("csan"));
                double cmoney = Double.parseDouble(request.getParameter("cmoney"));
                double ctalent = Double.parseDouble(request.getParameter("ctalent"));

                // 插入数据到数据库
                conn = JDBCUtil.getConnection();
                String sql = "INSERT INTO choice (qid, ctext, cage, chealthy, csan, cmoney, ctalent) VALUES (?, ?, ?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, qid);
                stmt.setString(2, ctext);
                stmt.setDouble(3, cage);
                stmt.setDouble(4, chealthy);
                stmt.setDouble(5, csan);
                stmt.setDouble(6, cmoney);
                stmt.setDouble(7, ctalent);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
    %>
                    <div style="color: green;">选项添加成功！</div>
    <%
                    // 添加选项成功后跳转到选项管理页面
                    response.sendRedirect("choice_manage.jsp");
                } else {
    %>
                    <div style="color: red;">选项添加失败，请重试。</div>
    <%
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("有没填写的内容!" );
            } finally {
                // 关闭数据库连接和语句
                JDBCUtil.close(conn, stmt, null);
            }
        }
    %>

</div>

</body>
</html>
