<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.qst.util.JDBCUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理系统 - 编辑随机事件</title>
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
    <h1>编辑随机事件</h1>

    <%-- Java 代码片段 --%>
    <%
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // 判断请求方法，如果是 POST 方法则处理表单提交
            if (request.getMethod().equalsIgnoreCase("post")) {
                int rid = Integer.parseInt(request.getParameter("rid"));
                String rtext = request.getParameter("rtext");
                double rhealthy = Double.parseDouble(request.getParameter("rhealthy"));
                double rsan = Double.parseDouble(request.getParameter("rsan"));
                double rmoney = Double.parseDouble(request.getParameter("rmoney"));
                double rtalent = Double.parseDouble(request.getParameter("rtalent"));

                conn = JDBCUtil.getConnection();
                String sql = "UPDATE random SET rtext=?, rhealthy=?, rsan=?, rmoney=?, rtalent=? WHERE rid=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, rtext);
                stmt.setDouble(2, rhealthy);
                stmt.setDouble(3, rsan);
                stmt.setDouble(4, rmoney);
                stmt.setDouble(5, rtalent);
                stmt.setInt(6, rid);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
    %>
                    <div style="color: green;">随机事件修改成功！</div>
    <%-- 重定向到随机事件管理页面 --%>
    <%
                    response.sendRedirect("random_manage.jsp");
                } else {
    %>
                    <div style="color: red;">随机事件修改失败，请重试。</div>
    <%
                }
            }

            // 获取rid参数并查询对应的随机事件信息
            int rid = Integer.parseInt(request.getParameter("rid"));
            conn = JDBCUtil.getConnection();
            String sql = "SELECT * FROM random WHERE rid=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, rid);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // 从结果集中获取随机事件的各个属性值
                String rtext = rs.getString("rtext");
                double rhealthy = rs.getDouble("rhealthy");
                double rsan = rs.getDouble("rsan");
                double rmoney = rs.getDouble("rmoney");
                double rtalent = rs.getDouble("rtalent");
    %>

                <form action="editRandom.jsp" method="post" onsubmit="return validateForm()">
                    <input type="hidden" name="rid" value="<%= rid %>">

                    <label for="rtext">随机事件内容:</label>
                    <textarea id="rtext" name="rtext" rows="4"><%= rtext %></textarea>

                    <label for="rhealthy">健康值:</label>
                    <input type="text" id="rhealthy" name="rhealthy" value="<%= rhealthy %>">
                    <span id="rhealthyError" class="error-message"></span>

                    <label for="rsan">精神值:</label>
                    <input type="text" id="rsan" name="rsan" value="<%= rsan %>">
                    <span id="rsanError" class="error-message"></span>

                    <label for="rmoney">财富值:</label>
                    <input type="text" id="rmoney" name="rmoney" value="<%= rmoney %>">
                    <span id="rmoneyError" class="error-message"></span>

                    <label for="rtalent">能力值:</label>
                    <input type="text" id="rtalent" name="rtalent" value="<%= rtalent %>">
                    <span id="rtalentError" class="error-message"></span>

                    <input type="submit" value="保存修改">
                </form>

    <%
            } else {
                out.println("未找到指定的随机事件记录。");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("更新随机事件出现异常：" + e.getMessage());
        } finally {
            // 关闭资源
            JDBCUtil.close(conn, stmt, rs);
        }
    %>

</div>

</body>
</html>
