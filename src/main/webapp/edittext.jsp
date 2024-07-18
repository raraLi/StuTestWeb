<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.qst.util.JDBCUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理系统 - 编辑帖子</title>
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
            var title = document.getElementById('title').value.trim();
            var text = document.getElementById('text').value.trim();
            var aClass = document.getElementById('class').value;

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

            return true;
        }
    </script>
</head>
<body>

<div class="container">
    <h1>编辑帖子</h1>

    <%
        try {
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null, rsClasses = null;
            boolean isPost = request.getMethod().equalsIgnoreCase("post");
            int tid = 0;
            if (isPost) {
                tid = Integer.parseInt(request.getParameter("tid"));
                String tname = request.getParameter("tname");
                String title = request.getParameter("title");
                String text = request.getParameter("text");
                String classValue = request.getParameter("class");

                conn = JDBCUtil.getConnection();
                String sql = "UPDATE test SET tname=?, title=?, text=?, class=? WHERE tid=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, tname);
                stmt.setString(2, title);
                stmt.setString(3, text);
                stmt.setString(4, classValue);
                stmt.setInt(5, tid);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
    %>
    <div style="color: green;">帖子修改成功！</div>
    <%
                    response.sendRedirect("testmanage.jsp?tid=" + tid);
                    return;
                } else {
    %>
    <div style="color: red;">帖子修改失败，请重试。</div>
    <%
                }
            } else {
                tid = Integer.parseInt(request.getParameter("tid"));
                conn = JDBCUtil.getConnection();
                String sql = "SELECT * FROM test WHERE tid = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, tid);
                rs = stmt.executeQuery();
                if (rs.next()) {
                    String tname = rs.getString("tname");
                    String title = rs.getString("title");
                    String text = rs.getString("text");
                    String classValue = rs.getString("class");

                    // Fetch all distinct class values
                    String sqlClasses = "SELECT DISTINCT class FROM test";
                    stmt = conn.prepareStatement(sqlClasses);
                    rsClasses = stmt.executeQuery();
    %>

    <form action="edittext.jsp" method="post" onsubmit="return validateForm()">
        <input type="hidden" name="tid" value="<%= tid %>">
        <label for="tname">用户名:</label>
        <input type="text" id="tname" name="tname" value="<%= tname %>">
        <span id="tnameError" class="error-message"></span>

        <label for="title">标题:</label>
        <input type="text" id="title" name="title" value="<%= title %>">
        <span id="titleError" class="error-message"></span>

        <label for="text">内容:</label>
        <textarea id="text" name="text" rows="4"><%= text %></textarea>
        <span id="textError" class="error-message"></span>

        <label for="class">分类:</label>
        <select id="class" name="class">
            <% while (rsClasses.next()) {
                    String classOption = rsClasses.getString("class");
            %>
            <option value="<%= classOption %>" <%= classOption.equals(classValue) ? "selected" : "" %>><%= classOption %></option>
            <% } %>
        </select>
        <span id="classError" class="error-message"></span>

        <input type="submit" value="保存修改">
    </form>

    <%
                } else {
                    out.println("未找到指定的帖子记录。");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("编辑帖子出现异常：" + e.getMessage());
        } finally {
            // Close resources manually

        }
    %>

</div>

</body>
</html>