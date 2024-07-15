<%@ page import="java.sql.*" %>
<%@ page import="com.qst.util.JDBCUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>编辑问题</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }

        .container {
            width: 50%;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ccc;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
        }

        form {
            margin-top: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }

        input[type=text] {
            width: calc(100% - 20px);
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        input[type=submit] {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
        }

        input[type=submit]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>编辑题目</h1>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            int qid = Integer.parseInt(request.getParameter("qid"));
            String qtext = request.getParameter("qtext");
            Connection conn = null;
            PreparedStatement pstmt = null;
            try {
                conn = JDBCUtil.getConnection();
                String sql = "UPDATE question SET qtext = ? WHERE qid = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, qtext);
                pstmt.setInt(2, qid);
                pstmt.executeUpdate();
                response.sendRedirect("question_manage.jsp");
                return;
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                JDBCUtil.close(conn, pstmt, null);
            }
        } else {
            int qid = Integer.parseInt(request.getParameter("qid"));
            String qtext = "";
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                conn = JDBCUtil.getConnection();
                String sql = "SELECT qtext FROM question WHERE qid = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, qid);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    qtext = rs.getString("qtext");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                JDBCUtil.close(conn, pstmt, rs);
            }
    %>

    <form method="post">
        <input type="hidden" name="qid" value="<%= qid %>">
        <label for="qtext">题目内容：</label>
        <input type="text" id="qtext" name="qtext" value="<%= qtext %>" required><br><br>
        <input type="submit" value="更新题目">
    </form>

    <%
        }
    %>
</div>

</body>
</html>
