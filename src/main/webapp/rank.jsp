<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.qst.util.JDBCUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户排名</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            color: #333;
            font-weight: bold;
        }
        .close-btn {
            display: inline-block;
            text-align: center;

            margin-top: 20px;
            padding: 10px 20px;
            background-color: #333;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .close-btn:hover {
            background-color: #555;
        }
        .return{
        text-align:right;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>雷布斯富翁榜</h2>
        <table>
            <thead>
                <tr>
                    <th>排名</th>
                    <th>用户名</th>
                    <th>最高资产</th>
                </tr>
            </thead>
            <tbody>
                <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    conn = JDBCUtil.getConnection();
                    stmt = conn.createStatement();
                    String sql = "SELECT username, state FROM user ORDER BY CAST(state AS UNSIGNED) DESC";
                    rs = stmt.executeQuery(sql);

                    int rank = 1;
                    while (rs.next()) {
                        String username = rs.getString("username");
                        String state = rs.getString("state");
                %>
                <tr>
                    <td><%= rank++ %></td>
                    <td><%= username %></td>
                    <td><%= state %></td>
                </tr>
                <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    JDBCUtil.close(conn, stmt, rs);
                }
                %>
            </tbody>
        </table>
        <div class="return">
        <a href="javascript:history.go(-1);" class="close-btn">关闭</a>
        </div>
    </div>
</body>
</html>
