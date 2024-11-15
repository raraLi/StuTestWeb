<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.qst.util.JDBCUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>查看帖子详情</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
         h1 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        .add-button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #FF6699;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            width: 150px;
        }

        .add-button:hover {
            background-color: #E84B85;
        }
        .content {
                    text-align: center; /* 文本居中 */
                    margin-top: 20px; /* 内容与标题之间的间距 */
                }
                .content p {
                    margin: 10px 0; /* 段落之间的间距 */
                    padding: 10px;
                    border: 1px solid #ddd; /* 边框 */
                    background-color: #f9f9f9; /* 背景颜色 */
                    text-align: left; /* 文本左对齐 */
                }
       </style>
</head>
<body>

<div class="container">
    <h1>帖子详情</h1>
    <%
        // 从请求参数中获取帖子ID
        int postId = 0;
        try {
            postId = Integer.parseInt(request.getParameter("tid")); // 确保这个参数名与testmanage.jsp中的链接参数名一致
        } catch (NumberFormatException e) {
            out.println("<div style=\"color: red;\">无效的ID格式。</div>");
        }

        // 数据库查询操作
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtil.getConnection();
            String sql = "SELECT tname, title, text, class FROM test WHERE tid = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, postId);
            rs = stmt.executeQuery();

            // 判断是否查询到数据
            if (rs.next()) {
                 %>
                                    <p><strong>用户名：</strong> <%= rs.getString("tname") %></p>
                                    <p><strong>标题：</strong> <%= rs.getString("title") %></p>
                                    <p><strong>内容：</strong> <%= rs.getString("text") %></p>
                                    <p><strong>分类：</strong> <%= rs.getString("class") %></p>
                                    <%
            } else {
                out.println("<div style=\"color: red;\">没有找到该ID的帖子。</div>");
            }
        } catch (SQLException e) {
            out.println("<div style=\"color: red;\">数据库查询失败。</div>");
            // e.printStackTrace(); // 在生产环境中，不要打印堆栈跟踪
        } finally {
            // 关闭数据库资源
            JDBCUtil.close(conn, stmt, rs);
        }
    %>
    <!-- 返回按钮 -->
    <a href="javascript:history.back()" class="add-button">返回</a>
</div>

</body>
</html>