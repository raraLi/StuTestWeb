<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.qst.util.JDBCUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理系统 - 编辑选项</title>
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

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
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
            var cage = document.getElementById('cage').value.trim();
            var chealthy = document.getElementById('chealthy').value.trim();
            var csan = document.getElementById('csan').value.trim();
            var cmoney = document.getElementById('cmoney').value.trim();
            var ctalent = document.getElementById('ctalent').value.trim();

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
    <h1>编辑选项</h1>

    <%
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            if (request.getMethod().equalsIgnoreCase("post")) {
                int cid = Integer.parseInt(request.getParameter("cid"));
                int qid = Integer.parseInt(request.getParameter("qid"));
                String ctext = request.getParameter("ctext");
                double cage = Double.parseDouble(request.getParameter("cage"));
                double chealthy = Double.parseDouble(request.getParameter("chealthy"));
                double csan = Double.parseDouble(request.getParameter("csan"));
                double cmoney = Double.parseDouble(request.getParameter("cmoney"));
                double ctalent = Double.parseDouble(request.getParameter("ctalent"));

                conn = JDBCUtil.getConnection();
                String sql = "UPDATE choice SET qid=?, ctext=?, cage=?, chealthy=?, csan=?, cmoney=?, ctalent=? WHERE cid=?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, qid);
                stmt.setString(2, ctext);
                stmt.setDouble(3, cage);
                stmt.setDouble(4, chealthy);
                stmt.setDouble(5, csan);
                stmt.setDouble(6, cmoney);
                stmt.setDouble(7, ctalent);
                stmt.setInt(8, cid);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
    %>
    <div style="color: green;">选项修改成功！</div>
    <%-- Redirect to choice_manage.jsp with qid parameter --%>
    <%
                    response.sendRedirect("choice_manage.jsp?qid=" + qid);
                } else {
    %>
    <div style="color: red;">选项修改失败，请重试。</div>
    <%
                }
            }

            // Fetch the current choice data to display in form
            int cid = Integer.parseInt(request.getParameter("cid"));
            conn = JDBCUtil.getConnection();
            String sql = "SELECT * FROM choice WHERE cid = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cid);
            rs = stmt.executeQuery();
            if (rs.next()) {
                int qid = rs.getInt("qid");
                String ctext = rs.getString("ctext");
                double cage = rs.getDouble("cage");
                double chealthy = rs.getDouble("chealthy");
                double csan = rs.getDouble("csan");
                double cmoney = rs.getDouble("cmoney");
                double ctalent = rs.getDouble("ctalent");
    %>

    <form action="editChoice.jsp" method="post" onsubmit="return validateForm()">
        <input type="hidden" name="cid" value="<%= cid %>">
         <label for="qid">题目ID:</label>
                <input type="text" id="qid" name="qid" value="<%= qid %>">
                <span id="qidError" class="error-message"></span>

        <label for="ctext">选项内容:</label>
        <textarea id="ctext" name="ctext" rows="4"><%= ctext %></textarea>

        <label for="cage">年龄:</label>
        <input type="text" id="cage" name="cage" value="<%= cage %>">
        <span id="cageError" class="error-message"></span>

        <label for="chealthy">健康值:</label>
        <input type="text" id="chealthy" name="chealthy" value="<%= chealthy %>">
        <span id="chealthyError" class="error-message"></span>

        <label for="csan">精神值:</label>
        <input type="text" id="csan" name="csan" value="<%= csan %>">
        <span id="csanError" class="error-message"></span>

        <label for="cmoney">财富值:</label>
        <input type="text" id="cmoney" name="cmoney" value="<%= cmoney %>">
        <span id="cmoneyError" class="error-message"></span>

        <label for="ctalent">能力值:</label>
        <input type="text" id="ctalent" name="ctalent" value="<%= ctalent %>">
        <span id="ctalentError" class="error-message"></span>

        <input type="submit" value="保存修改">
    </form>

    <%
            } else {
                out.println("未找到指定的选项记录。");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("更新选项出现异常：" + e.getMessage());
        } finally {
            // Close resources manually
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            // Close connection manually
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>

</div>

</body>
</html>
