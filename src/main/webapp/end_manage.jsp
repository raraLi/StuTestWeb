<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.qst.util.JDBCUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理系统 - 游戏结局管理</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .sidebar {
            position: fixed; /* 固定在页面左侧 */
            top: 0;
            left: 0;
            width: 180px;
            height: 100vh; /* full height */
            background-color: #333;
            color: #fff;
            padding-top: 20px;
        }

        .sidebar h2 {
            padding: 10px;
            text-align: center;
        }

        .sidebar ul {
            list-style-type: none;
            padding: 0;
            text-align: left;
        }

        .sidebar ul li {
            padding: 15px;
            border-bottom: 1px solid #666;
        }

        .sidebar ul li a {
            color: #fff;
            text-decoration: none;
            display: block;
            padding: 10px;
        }

        .sidebar ul li a:hover {
            background-color: #555;
        }

        .content {
            margin-left: 200px; /* 与 sidebar 的宽度保持一致 */
            padding: 20px;
        }

        .content h1 {
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
            float: right;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .add-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <h2>后台管理</h2>
    <ul>
        <li><a href="user_manage.jsp">用户管理</a></li>
        <li><a href="question_manage.jsp">题目管理</a></li>
        <li><a href="choice_manage.jsp">选项管理</a></li>
        <li><a href="random_manage.jsp">随机事件管理</a></li>
        <li><a href="end_manage.jsp">游戏结局管理</a></li>
    </ul>
</div>

<div class="content">
    <h1>游戏结局管理</h1>

    <table>
        <tr>
            <th>游戏结局ID</th>
            <th>游戏结局内容</th>
            <th>健康值</th>
            <th>精神值</th>
            <th>财富值</th>
            <th>能力值</th>
            <th>操作</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                conn = JDBCUtil.getConnection();
                stmt = conn.createStatement();
                String sql = "SELECT eid,etext, ehealthy, esan, emoney, etalent FROM end";
                rs = stmt.executeQuery(sql);
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("eid") %></td>
            <td><%= rs.getString("etext") %></td>
            <td><%= rs.getString("ehealthy") %></td>
            <td><%= rs.getString("esan") %></td>
            <td><%= rs.getString("emoney") %></td>
            <td><%= rs.getString("etalent") %></td>
                       <td>
                         <a href="editEnd.jsp?eid=<%= rs.getInt("eid") %>">编辑</a>
                          <a href="deleteEnd.jsp?eid=<%= rs.getInt("eid") %>">删除</a>
                       </td>

                    </tr>
                    <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } finally {
                            JDBCUtil.close(conn, stmt, rs);
                        }
                    %>
                </table>

                <a href="addEnd.jsp" class="add-button">添加游戏结局</a>

            </div>

            </body>
            </html>