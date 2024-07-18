<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.qst.util.JDBCUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理系统 - 选项管理</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 180px;
            height: 100vh;
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
            margin-left: 200px;
            padding: 20px;
            position: relative;
        }

        .content h1 {
            display: inline-block;
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
            font-size: 16px; /* Font size adjusted */
        }

        th#qidHeader {
            background-color: #4CAF50; /* Green background */
            color: white; /* White text color */
            font-size: 15px; /* Font size adjusted */
        }

        th#qidHeader select {
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
            border: 0; /* Remove border */
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
                <li><a href="/question_manage.jsp">题目管理</a></li>
                <li><a href="/choice_manage.jsp">选项管理</a></li>
                <li><a href="/random_manage.jsp">随机事件管理</a></li>
                <li><a href="/end_manage.jsp">游戏结局管理</a></li>
                <li><a href="/testmanage.jsp">论坛管理</a></li>
    </ul>
</div>

<div class="content">
    <h1>选项管理</h1>

    <table id="choiceTable">
        <thead>
            <tr>
                <th>选项ID</th>
                <th id="qidHeader">
                    <select id="filterByQuestion" onchange="filterTable()">
                        <option value="">题目ID</option>
                        <%
                            Connection conn = null;
                            Statement stmt = null;
                            ResultSet rs = null;
                            try {
                                conn = JDBCUtil.getConnection();
                                stmt = conn.createStatement();
                                String sql = "SELECT DISTINCT qid FROM choice";
                                rs = stmt.executeQuery(sql);
                                while (rs.next()) {
                        %>
                        <option value="<%= rs.getInt("qid") %>"><%= rs.getInt("qid") %></option>
                        <%
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } finally {
                                JDBCUtil.close(conn, stmt, rs);
                            }
                        %>
                    </select>
                </th>
                <th>选项内容</th>
                <th>年龄</th>
                <th>健康值</th>
                <th>精神值</th>
                <th>财富值</th>
                <th>能力值</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    conn = JDBCUtil.getConnection();
                    stmt = conn.createStatement();
                    String sql = "SELECT cid, qid, ctext, cage, chealthy, csan, cmoney, ctalent FROM choice";
                    rs = stmt.executeQuery(sql);
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("cid") %></td>
                <td><%= rs.getInt("qid") %></td>
                <td><%= rs.getString("ctext") %></td>
                <td><%= rs.getString("cage") %></td>
                <td><%= rs.getString("chealthy") %></td>
                <td><%= rs.getString("csan") %></td>
                <td><%= rs.getString("cmoney") %></td>
                <td><%= rs.getString("ctalent") %></td>
                <td>
                    <a href="editChoice.jsp?cid=<%= rs.getInt("cid") %>"class="action-link">编辑</a>
                    <a href="deleteChoice.jsp?cid=<%= rs.getInt("cid") %>"class="action-link">删除</a>
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
        </tbody>
    </table>

    <a href="addChoice.jsp" class="add-button">添加选项</a>

</div>

<script>
    function filterTable() {
        var dropdown = document.getElementById("filterByQuestion");
        var selectedQuestionId = dropdown.value;
        var table = document.getElementById("choiceTable");
        var rows = table.getElementsByTagName("tr");

        for (var i = 1; i < rows.length; i++) {
            var qidCell = rows[i].getElementsByTagName("td")[1]; // Index 1 corresponds to the question ID column
            if (selectedQuestionId === "" || qidCell.textContent.trim() === selectedQuestionId) {
                rows[i].style.display = "";
            } else {
                rows[i].style.display = "none";
            }
        }
    }
</script>

</body>
</html>
