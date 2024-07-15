<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.qst.util.JDBCUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理系统 - 编辑游戏结局</title>
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
    <h1>编辑游戏结局</h1>

    <%-- Java 代码片段 --%>
    <%
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // 判断请求方法，如果是 POST 方法则处理表单提交
            if (request.getMethod().equalsIgnoreCase("post")) {
                int eid = Integer.parseInt(request.getParameter("eid"));
                String etext = request.getParameter("etext");
                double ehealthy = Double.parseDouble(request.getParameter("ehealthy"));
                double esan = Double.parseDouble(request.getParameter("esan"));
                double emoney = Double.parseDouble(request.getParameter("emoney"));
                double etalent = Double.parseDouble(request.getParameter("etalent"));

                conn = JDBCUtil.getConnection();
                String sql = "UPDATE end SET etext=?, ehealthy=?, esan=?, emoney=?, etalent=? WHERE eid=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, etext);
                stmt.setDouble(2, ehealthy);
                stmt.setDouble(3, esan);
                stmt.setDouble(4, emoney);
                stmt.setDouble(5, etalent);
                stmt.setInt(6, eid);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
    %>
                    <div style="color: green;">游戏结局修改成功！</div>
    <%-- 重定向到游戏结局管理页面 --%>
    <%
                    response.sendRedirect("end_manage.jsp");
                } else {
    %>
                    <div style="color: red;">游戏结局修改失败，请重试。</div>
    <%
                }
            } else {
                // 如果不是 POST 请求，则显示表单以编辑游戏结局
                int eid = Integer.parseInt(request.getParameter("eid"));
                conn = JDBCUtil.getConnection();
                String sql = "SELECT * FROM end WHERE eid=?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, eid);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    // 从结果集中获取游戏结局的各个属性值
                    String etext = rs.getString("etext");
                    double ehealthy = rs.getDouble("ehealthy");
                    double esan = rs.getDouble("esan");
                    double emoney = rs.getDouble("emoney");
                    double etalent = rs.getDouble("etalent");
    %>

                <form action="editEnd.jsp" method="post" onsubmit="return validateForm()">
                    <input type="hidden" name="eid" value="<%= eid %>">

                    <label for="etext">游戏结局内容:</label>
                    <textarea id="etext" name="etext" rows="4"><%= etext %></textarea>

                    <label for="ehealthy">健康值:</label>
                    <input type="text" id="ehealthy" name="ehealthy" value="<%= ehealthy %>">
                    <span id="ehealthyError" class="error-message"></span>

                    <label for="esan">精神值:</label>
                    <input type="text" id="esan" name="esan" value="<%= esan %>">
                    <span id="esanError" class="error-message"></span>

                    <label for="emoney">财富值:</label>
                    <input type="text" id="emoney" name="emoney" value="<%= emoney %>">
                    <span id="emoneyError" class="error-message"></span>

                    <label for="etalent">能力值:</label>
                    <input type="text" id="etalent" name="etalent" value="<%= etalent %>">
                    <span id="etalentError" class="error-message"></span>

                    <input type="submit" value="保存修改">
                </form>

    <%
                } else {
                    out.println("未找到指定的游戏结局记录。");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("更新游戏结局出现异常：" + e.getMessage());
        } finally {
            // 关闭资源
            JDBCUtil.close(conn, stmt, rs);
        }
    %>

</div>

</body>
</html>
