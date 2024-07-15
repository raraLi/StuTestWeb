<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.qst.util.JDBCUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理系统 - 添加题目</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .content {
            width: 50%;
            margin: 50px auto; /* 居中显示 */
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ccc;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
        }

        .add-form {
            margin-top: 20px;
            padding: 10px;
        }

        .add-form input[type=text] {
            width: calc(100% - 20px); /* 考虑输入框的 padding */
            padding: 8px;
            margin: 5px 0 15px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .add-form input[type=submit], .add-form .close-button {
            width: 49%; /* 平分按钮宽度 */
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            margin: 8px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none; /* 去除链接默认下划线 */
            text-align: center;
            display: inline-block;
            box-sizing: border-box;
        }

        .add-form input[type=submit]:hover, .add-form .close-button:hover {
            background-color: #45a049;
        }

        .error-message, .success-message {
            color: white;
            background-color: #f44336; /* 红色背景 */
            padding: 10px;
            text-align: center;
            border-radius: 4px;
            margin-top: 10px;
        }

        .success-message {
            background-color: #4CAF50; /* 绿色背景 */
        }
    </style>
</head>
<body>

<div class="content">
    <h1>添加题目</h1>

    <div class="add-form">
        <%-- 处理表单提交 --%>
        <%
            // 获取表单提交的题目内容
            String qtext = request.getParameter("qtext");

            // 如果 qtext 不为空，则执行添加操作
            if (qtext != null && !qtext.isEmpty()) {
                Connection conn = null;
                PreparedStatement stmt = null;
                try {
                    conn = JDBCUtil.getConnection();
                    String sql = "INSERT INTO question (qtext) VALUES (?)";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, qtext);
                    int rowsAffected = stmt.executeUpdate();

                    // 检查是否成功插入记录
                    if (rowsAffected > 0) {
        %>
        <p class="success-message">题目添加成功！</p>
        <%-- 添加成功后进行页面重定向 --%>
        <% response.sendRedirect("question_manage.jsp"); %>
        <%
                    } else {
        %>
        <p class="error-message">添加题目失败，请重试。</p>
        <%
                    }
                } catch (SQLException e) {
                    // 打印异常信息到控制台
                    e.printStackTrace();
                    // 输出错误消息到页面
                    out.println("<p class=\"error-message\">添加题目失败，请重试。</p>");
                } finally {
                    JDBCUtil.close(conn, stmt, null);
                }
            }
        %>

        <form action="addQuestion.jsp" method="post">
            <label for="qtext">问题内容：</label>
            <input type="text" id="qtext" name="qtext" required>
            <br>
            <input type="submit" value="添加">
            <a href="question_manage.jsp" class="close-button">关闭</a>
        </form>
    </div>

</div>

</body>
</html>
