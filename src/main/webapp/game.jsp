<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.qst.util.JDBCUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>答题页面</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .container {
            width: 60%;
            margin: 40px auto;
            background-color: #fff;
            padding-left: 50px;
            padding-right: 50px;
            padding-top: 30px;
            padding-bottom: 30px;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .user-info {
            height: 100px;
            margin-bottom: 20px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }

        .user-info p {
            margin: 5px 0;
        }

        .question-container {
            margin-top: 30px;
            text-align: center;
        }

        h3 {
            text-align: left;
        }

        .options {
            margin-top: 15px;
            text-align: left;
        }

        .option {
            margin-bottom: 15px;
        }

        .option a {
            text-decoration: none; /* Remove underline */
            color:#FF8CB0 ; /* Set link color */
            margin-left: 10px; /* Add margin for spacing */
        }

        .submit-button {
            width: 20%;
            background-color: #FF6699;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            margin-top: 30px;
            border-radius: 5px;
        }

        .submit-button:hover {
            background-color: #E84B85;
        }

        .info-left {
            width: 25%;
            float: left;
            margin-left: 10px;
        }

        .info-name {
            width: 100%;
            float: left;
            margin-right: 10px;
            margin-top: 10px;
        }

        .info-age {
            width: 100%;
            float: left;
            margin-right: 10px;
            margin-top: 10px;
            color: #F4A460;
        }

        .info-money {
            width: 100%;
            float: left;
            margin-right: 10px;
            margin-top: 10px;
            color:	#FFD700;
        }

        .info-right {
            width: 70%;
            height: 100px;
            float: right;
            margin-right: 10px;
        }

        .health-show {
            width: 100%;
            height: 20px;
            margin-top: 10px;
        }

        .health-text {
            width: 15%;
            float: left;
            margin-left: 10px;
        }

        .health-bar {
            width: 80%;
            height: 100%;
            background-color: #ddd;
            position: relative;
            float: right;
            margin-right: 10px;
        }

        .health-bar .bar {
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            background-color: #4CAF50;
            transition: width 0.5s;
        }

        .health-bar .label {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            width: 100%;
            text-align: center;
            color: #fff;
        }
    </style>
</head>
<body>

<%
    // 设置页面字符集为UTF-8
    request.setCharacterEncoding("UTF-8");

    // 获取用户信息，假设用户信息从数据库中获取
    Connection conn = null;
    PreparedStatement userStmt = null;
    ResultSet userRs = null;

    // 声明用户信息变量
    String userName = "";
    int playAge = 0;
    int playHealthy = 0;
    int playSan = 0;
    int playMoney = 0;
    int playTalent = 0;
    String userId = request.getParameter("id"); // 添加 userId 变量
    int id = -1; // 默认值为 -1

    if (userId != null && !userId.isEmpty()) {
        id = Integer.parseInt(userId);

        try {
            conn = JDBCUtil.getConnection();
            String userSql = "SELECT u.id, u.username, p.age, p.healthy, p.san, p.money, p.talent " +
                    "FROM user u INNER JOIN play p ON u.id = p.uid " +
                    "WHERE u.id=?";
            userStmt = conn.prepareStatement(userSql);
            userStmt.setInt(1, id);
            userRs = userStmt.executeQuery();
            if (userRs.next()) {
                userName = userRs.getString("username");
                playAge = userRs.getInt("age");
                playHealthy = userRs.getInt("healthy");
                playSan = userRs.getInt("san");
                playMoney = userRs.getInt("money");
                playTalent = userRs.getInt("talent");
            } else {
                out.println("用户信息不存在或获取失败。");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("获取用户信息出错：" + e.getMessage());
        } finally {
            JDBCUtil.close(conn, userStmt, userRs);
        }
    } else {
        out.println("用户ID不存在或为空。");
    }

    // 获取当前题目ID（qid）
    int currentQuestionId = 1; // 默认第一题
    String qidParam = request.getParameter("qid");
    if (qidParam != null && !qidParam.isEmpty()) {
        currentQuestionId = Integer.parseInt(qidParam);
    }

    // 查询题目内容
    PreparedStatement questionStmt = null;
    ResultSet questionRs = null;
    String questionText = "";
    try {
        conn = JDBCUtil.getConnection();
        String questionSql = "SELECT * FROM question WHERE qid=?";
        questionStmt = conn.prepareStatement(questionSql);
        questionStmt.setInt(1, currentQuestionId);
        questionRs = questionStmt.executeQuery();

        if (questionRs.next()) {
            questionText = questionRs.getString("qtext");
        } else {
            response.sendRedirect("/end/money?id=" + id);
            out.println("题目不存在或已删除。");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("获取题目出错：" + e.getMessage());
    } finally {
        JDBCUtil.close(conn, questionStmt, questionRs);
    }

    // 查询题目对应的选项
    PreparedStatement choiceStmt = null;
    ResultSet choiceRs = null;
    try {
        conn = JDBCUtil.getConnection();
        String choiceSql = "SELECT * FROM choice WHERE qid=?";
        choiceStmt = conn.prepareStatement(choiceSql);
        choiceStmt.setInt(1, currentQuestionId);
        choiceRs = choiceStmt.executeQuery();
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("获取选项出错：" + e.getMessage());
    }
%>

<div class="container">
    <div class="user-info">
        <div class="info-left">
            <div class="info-name">用户名： <%= userName %></div>
            <div class="info-age">年龄： <%= playAge %></div>
            <div class="info-money">财富值： <%= playMoney %></div>
        </div>

        <div class="info-right">
            <div class="health-show">
                <div class="health-text">健康值：</div>
                <div class="health-bar">
                    <div class="bar" style="width: <%=(int)(playHealthy / 100.0 * 100)%>%;"></div>
                    <div class="label"><%=playHealthy%> / 100</div>
                </div>
            </div>

            <div class="health-show">
                <div class="health-text">精神值：</div>
                <div class="health-bar">
                    <div class="bar" style="width: <%=(int)(playSan / 100.0 * 100)%>%;"></div>
                    <div class="label"><%=playSan%> / 100</div>
                </div>
            </div>

            <div class="health-show">
                <div class="health-text">能力值：</div>
                <div class="health-bar">
                    <div class="bar" style="width: <%=(int)(playTalent / 100.0 * 100)%>%;"></div>
                    <div class="label"><%=playTalent%> / 100</div>
                </div>
            </div>
        </div>

    </div>

    <div class="question-container">
        <h3 id="question"><%= questionText %></h3>

        <form id="myForm" action="/game/submit" method="post" onsubmit="return validateOption();">
            <input type="hidden" name="id" value="<%= id %>">
            <input type="hidden" name="qid" value="<%= currentQuestionId %>">
            <div class="options">
                <%
                if (choiceRs != null) {
                    while (choiceRs.next()) {
                        boolean disableOption = (currentQuestionId == 13 && choiceRs.getInt("cid") != 42);
                %>
                <div class="option">
                    <input type="radio" id="option_<%= choiceRs.getInt("cid") %>" name="option"
                           value="<%= choiceRs.getInt("cid") %>" <%= disableOption ? "disabled" : "" %>>
                    <label for="option_<%= choiceRs.getInt("cid") %>"><%= choiceRs.getString("ctext") %></label>
                    <% if (choiceRs.getInt("cid") == 70) { %>
                    <a href="md.jsp">查看市场走势</a>
                    <% } else if (choiceRs.getInt("cid") == 71) { %>
                    <a href="ly.jsp">查看市场走势</a>
                    <% } else if (choiceRs.getInt("cid") == 72) { %>
                    <a href="dq.jsp">查看市场走势</a>
                    <% } else if (choiceRs.getInt("cid") == 73) { %>
                    <a href="fd.jsp">查看市场走势</a>
                    <% } else if (choiceRs.getInt("cid") == 74) { %>
                    <a href="nt.jsp">查看市场走势</a>
                    <% } %>
                </div>
                <%
                    }
                } else {
                    out.println("未能获取选项信息。");
                }
                %>
            </div>

            <input type="submit" class="submit-button" value="提交">
        </form>
    </div>
</div>

<script>
    document.getElementById('myForm').addEventListener('submit', function(event) {
        var radios = document.getElementsByName('option');
        var checked = false;

        for (var i = 0; i < radios.length; i++) {
            if (radios[i].checked) {
                checked = true;
                break;
            }
        }

        if (!checked) {
            alert("请至少选择一个选项!");
            event.preventDefault(); // 阻止表单提交
        }
    });

    function validateOption() {
        var qidParam = document.querySelector('input[name="qid"]');
        if (qidParam && qidParam.value === '13') {
            var selectedOption = document.querySelector('input[name="option"]:checked');
            if (selectedOption && selectedOption.value !== '42') {
                alert('只能选择选项30！');
                return false; // Prevent form submission
            }
        }
        return true; // Allow form submission
    }
</script>

</body>
</html>
