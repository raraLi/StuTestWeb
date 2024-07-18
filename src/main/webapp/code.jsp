<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.qst.util.JDBCUtil" %>

<%
    // Retrieve parameters from the request
    String id = request.getParameter("id");

    // Database connection and SQL query
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = JDBCUtil.getConnection(); // Get connection using JDBCUtil class
        String sqlUpdate = "UPDATE play p, choice c SET p.age = p.age + c.cage, " +
                           "p.healthy = p.healthy + c.chealthy, " +
                           "p.san = p.san + c.csan, " +
                           "p.money = p.money + c.cmoney, " +
                           "p.talent = p.talent + c.ctalent " +
                           "WHERE p.id = ? AND c.cid = 3";

        pstmt = conn.prepareStatement(sqlUpdate);
        pstmt.setString(1, id);
        pstmt.executeUpdate();
    } catch (SQLException ex) {
        ex.printStackTrace();  // Handle your errors appropriately
    } finally {
        JDBCUtil.close(conn, pstmt, null); // Close resources in finally block
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Code页面</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .code-content {
            text-align: center;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative; /* Ensure relative positioning for close button */
        }
        .close-button {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 20px;
            cursor: pointer;
        }
        .code-content img {
            max-width: 100%;
            height: auto;
        }
        .submit-button {
            background-color: #FF6699;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            margin-top: 20px;
        }

        .submit-button:hover {
            background-color: #E84B85;
        }
    </style>
</head>
<body>
    <div class="code-content">
        <span class="close-button" onclick="return confirmClose();">&times;</span>
        <h2>请扫描下方二维码氪金：</h2>
               <img src="path_to_your_image.jpg" alt="二维码">
               <form action="/game/code" method="post">
                   <input type="hidden" name="id" value="<%= request.getParameter("id") %>">
                   <input type="hidden" name="qid" value="3">
                   <input type="submit" class="submit-button" value="我已氪金">
               </form>
           </div>

    <script>
        function confirmClose() {
            if (confirm("不是哥们，你真不扫描二维码氪金吗？")) {
                window.history.back();
            }
            return false; // Prevent default behavior of the close button
        }


    </script>
</body>
</html>
