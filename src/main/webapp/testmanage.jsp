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
        .content .action-link {
            text-decoration: none; /* 去掉下划线 */
            color: #4CAF50; /* 设置默认颜色 */
            transition: color 0.3s ease; /* 添加过渡效果 */
        }

        .content .action-link:hover {
            color: #45a049; /* 悬停时改变颜色 */
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
    <h1>论坛</h1>

    <table id="choiceTable">
        <thead>
            <tr>

                <th>用户ID</th>
                <th>用户名</th>
                <th>标题</th>
                <th>内容</th>
                 <th id="qidHeader">
                                    <select id="filterByQuestion" onchange="filterTable()">
                                        <option value="">分类</option>
                                        <%
                                            Connection conn = null;
                                            Statement stmt = null;
                                            ResultSet rs = null;
                                            try {
                                                conn = JDBCUtil.getConnection();
                                                stmt = conn.createStatement();
                                                String sql = "SELECT DISTINCT class FROM test";
                                                rs = stmt.executeQuery(sql);
                                                while (rs.next()) {
                                        %>
                                        <option value="<%= rs.getString("class") %>"><%= rs.getString("class") %></option>
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
                  <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    conn = JDBCUtil.getConnection();
                    stmt = conn.createStatement();
                    String sql = "SELECT tid,tname,title,text,class FROM test";
                    rs = stmt.executeQuery(sql);
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("tid") %></td>
                <td><%= rs.getString("tname") %></td>
                <td><%= rs.getString("title") %></td>
                <td><%= rs.getString("text") %></td>
                <td><%= rs.getString("class") %></td>
                <td>
                    <a href="view.jsp?tid=<%= rs.getInt("tid") %>" class="action-link">查看</a>
                    <a href="edittext.jsp?tid=<%= rs.getInt("tid") %>" class="action-link">编辑</a>
                    <a href="deletetest.jsp?tid=<%= rs.getInt("tid") %>" class="action-link">删除</a>
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



</div>

<script>
    function filterTable() {
        var dropdown = document.getElementById("filterByQuestion");
        var selectedClass = dropdown.value; // 获取选中的class值
        var table = document.getElementById("choiceTable");
        var rows = table.getElementsByTagName("tr");

        // 遍历所有行，除了表头
        for (var i = 1; i < rows.length; i++) {
            var classCell = rows[i].getElementsByTagName("td")[4]; // 根据class的列索引获取单元格内容
            if (selectedClass === "" || classCell.textContent.trim() === selectedClass) {
                rows[i].style.display = ""; // 如果选中项为空或单元格内容与选中项匹配，则显示行
            } else {
                rows[i].style.display = "none"; // 否则，隐藏行
            }
        }
    }

    // 选择框的change事件监听器
    document.getElementById("filterByQuestion").addEventListener("change", filterTable);

    // 为每个选项添加鼠标悬停和离开事件监听
    var dropdownOptions = document.getElementById("filterByQuestion").options;
    for (var i = 0; i < dropdownOptions.length; i++) {
        var option = dropdownOptions[i];
        option.addEventListener("mouseenter", function() {
            this.style.backgroundColor = "#45a049"; // 鼠标悬停时的背景颜色
            this.style.color = "white"; // 文本颜色
        });
        option.addEventListener("mouseleave", function() {
            this.style.backgroundColor = ""; // 恢复默认背景颜色
            this.style.color = ""; // 恢复默认文本颜色
        });
    }
</script>

</body>
</html>
