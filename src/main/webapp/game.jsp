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

           .user-info {
               margin-bottom: 20px;
               text-align: center;
               border-bottom: 1px solid #ddd;
               padding-bottom: 10px;
           }

           .user-info p {
               margin: 5px 0;
           }

           .question-container {
               margin-top: 20px;
           }

           .options {
               margin-top: 10px;
           }

           .option {
               margin-bottom: 5px;
           }

           .submit-button {
               background-color: #4CAF50;
               color: white;
               padding: 10px 20px;
               border: none;
               cursor: pointer;
           }

           .submit-button:hover {
               background-color: #45a049;
           }

           .message {
               margin-top: 10px;
               padding: 10px;
               text-align: center;
           }

           .error-message {
               color: red;
           }

           .success-message {
               color: green;
           }
       </style>
    <script>
            function validateOption() {
                var qidParam = document.querySelector('input[name="qid"]');
                if (qidParam && qidParam.value === '13') {
                    var selectedOption = document.querySelector('input[name="option"]:checked');
                    if (selectedOption && selectedOption.value !== '30') {
                        alert('只能选择选项30！');
                        return false; // Prevent form submission
                    }
                }
                return true; // Allow form submission
            }
        </script>
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
        double playAge = 0;
        double playHealthy = 0;
        double playSan = 0;
        double playMoney = 0;
        double playTalent = 0;
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
                    playAge = userRs.getDouble("age");
                    playHealthy = userRs.getDouble("healthy");
                    playSan = userRs.getDouble("san");
                    playMoney = userRs.getDouble("money");
                    playTalent = userRs.getDouble("talent");
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

        // 处理答题提交
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String selectedOptionId = request.getParameter("option");
            if (selectedOptionId != null && !selectedOptionId.isEmpty()) {
                PreparedStatement updateStmt = null;
                PreparedStatement optionStmt = null; // 声明 optionStmt
                ResultSet optionRs = null; // 声明 optionRs
                try {
                    conn = JDBCUtil.getConnection();
                    // 查询选项信息
                    String optionSql = "SELECT * FROM choice WHERE cid=?";
                    optionStmt = conn.prepareStatement(optionSql); // 初始化 optionStmt
                    optionStmt.setInt(1, Integer.parseInt(selectedOptionId));
                    optionRs = optionStmt.executeQuery(); // 执行查询
                    if (optionRs.next()) {
                        // 更新用户信息
                        double ageDelta = optionRs.getDouble("cage");
                        double healthyDelta = optionRs.getDouble("chealthy");
                        double sanDelta = optionRs.getDouble("csan");
                        double moneyDelta = optionRs.getDouble("cmoney");
                        double talentDelta = optionRs.getDouble("ctalent");

                        playAge = ageDelta;
                        playHealthy += healthyDelta;
                        playSan += sanDelta;
                        playMoney += moneyDelta;
                        playTalent += talentDelta;

                        // 更新用户信息到数据库
                        String updateSql = "UPDATE play SET age=?, healthy=?, san=?, money=?, talent=? WHERE uid=?";
                        updateStmt = conn.prepareStatement(updateSql);
                        updateStmt.setDouble(1, playAge);
                        updateStmt.setDouble(2, playHealthy);
                        updateStmt.setDouble(3, playSan);
                        updateStmt.setDouble(4, playMoney);
                        updateStmt.setDouble(5, playTalent);
                        updateStmt.setInt(6, id);
                        updateStmt.executeUpdate();

                        // 获取下一个题目ID
                        int nextQuestionId = 1; // 默认第一题
                        String qidParam = request.getParameter("qid");
                        if (qidParam != null && !qidParam.isEmpty()) {
                            nextQuestionId = Integer.parseInt(qidParam) + 1;
                        }

                        // 完成更新后重定向到当前页面，保持 id 和当前题目ID（qid）
                        response.sendRedirect("game.jsp?id=" + id + "&qid=" + nextQuestionId);
                        return; // 确保不会继续执行下面的逻辑，避免重复输出页面内容
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("更新用户信息出错：" + e.getMessage());
                } finally {
                    JDBCUtil.close(null, updateStmt, null);
                    JDBCUtil.close(null, optionStmt, optionRs); // 关闭 option 相关资源
                }
            }
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
            <h2>用户信息：</h2>
            <p>用户名： <%= userName %></p>
            <p>年龄： <%= playAge %></p>
            <p>健康值： <%= playHealthy %></p>
            <p>精神值： <%= playSan %></p>
            <p>财富值： <%= playMoney %></p>
            <p>能力值： <%= playTalent %></p>
        </div>


    <div class="question-container">
        <h2>题目：</h2>
        <p><%= questionText %></p>

        <form action="game.jsp" method="post" onsubmit="return validateOption();">
            <input type="hidden" name="id" value="<%= id %>">
            <input type="hidden" name="qid" value="<%= currentQuestionId %>">
            <div class="options">
                <%
                if (choiceRs != null) {
                    while (choiceRs.next()) {
                        boolean disableOption = (currentQuestionId == 13 && choiceRs.getInt("cid") != 30);
                %>
                    <div class="option">
                        <input type="radio" id="option_<%= choiceRs.getInt("cid") %>" name="option" value="<%= choiceRs.getInt("cid") %>" <%= disableOption ? "disabled" : "" %>>
                        <label for="option_<%= choiceRs.getInt("cid") %>"><%= choiceRs.getString("ctext") %></label>
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

</body>
</html>
