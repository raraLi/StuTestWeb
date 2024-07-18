<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.qst.util.JDBCUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理系统 - 随机事件管理</title>
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
                position: relative; /* Allows absolute positioning of search elements */
                overflow: hidden; /* Ensure content doesn't overlap with sidebar */
            }

            .content h1 {
                color: #333;
                display: inline-block; /* Make h1 and search elements inline */
                margin-right: 20px; /* Add space between h1 and search elements */
                margin-top: 10px;
            }

            #searchContainer {
                float: right; /* Align search box to the right */
                margin-top: 12px; /* Adjust top margin as needed */
            }

            #searchInput {
                padding: 10px;
                width: 200px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
            }

            button {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            button:hover {
                background-color: #45a049;
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
              .content .action-link {
                                  text-decoration: none; /* 去掉下划线 */
                                  color: #4CAF50; /* 设置默认颜色 */
                                  transition: color 0.3s ease; /* 添加过渡效果 */
                              }

                              .content .action-link:hover {
                                  color: #45a049; /* 悬停时改变颜色 */
                              }
        </style>
</head>
<body>

<div class="sidebar">
    <h2>后台管理</h2>
    <ul>
        <li><a href="/user/list">用户管理</a></li>
        <li><a href="question_manage.jsp">题目管理</a></li>
        <li><a href="choice_manage.jsp">选项管理</a></li>
        <li><a href="random_manage.jsp">随机事件管理</a></li>
        <li><a href="end_manage.jsp">游戏结局管理</a></li>
    </ul>
</div>

<div class="content">
    <h1>随机事件管理</h1>

  <div id="searchContainer">
        <input type="text" id="searchInput" placeholder="搜索随机事件内容...">
        <button onclick="searchTable()">搜索</button>
    </div>
    <table>
        <tr>
            <th>随机事件ID</th>
            <th>随机事件内容</th>
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
                String sql = "SELECT rid, rtext,rhealthy, rsan, rmoney, rtalent FROM random";
                rs = stmt.executeQuery(sql);
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("rid") %></td>
            <td><%= rs.getString("rtext") %></td>
            <td><%= rs.getString("rhealthy") %></td>
            <td><%= rs.getString("rsan") %></td>
            <td><%= rs.getString("rmoney") %></td>
            <td><%= rs.getString("rtalent") %></td>
                       <td>
                         <a href="editRandom.jsp?rid=<%= rs.getInt("rid") %>"class="action-link">编辑</a>
                          <a href="deleteRandom.jsp?rid=<%= rs.getInt("rid") %>"class="action-link">删除</a>
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

                <a href="addRandom.jsp" class="add-button">添加随机事件</a>

            </div>
<script>
    function searchTable() {
        // Declare variables
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("searchInput");
        filter = input.value.toUpperCase();
        table = document.querySelector("table");
        tr = table.getElementsByTagName("tr");

        // Loop through all table rows, and hide those that don't match the search query
        for (i = 1; i < tr.length; i++) { // Start from 1 to skip the header row
            td = tr[i].getElementsByTagName("td")[1]; // Index 1 corresponds to the column with question text
            if (td) {
                txtValue = td.textContent || td.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }
</script>

            </body>
            </html>