<%@ page import="java.sql.*" %>
<%@ page import="com.qst.util.JDBCUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int tid = 0;
    try {
        tid = Integer.parseInt(request.getParameter("tid"));
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JDBCUtil.getConnection();
            String sql = "DELETE FROM test WHERE tid = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, tid);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // 可以选择将错误信息存储在 request 属性中，以便在重定向后的页面显示
            request.setAttribute("error", "删除帖子时发生错误：" + e.getMessage());
        } finally {
            JDBCUtil.close(conn, pstmt, null);
        }
        response.sendRedirect("testmanage.jsp"); // 重定向到帖子管理页面
    } catch (NumberFormatException e) {
        request.setAttribute("error", "无效的帖子ID。");
        response.sendRedirect("testmanage.jsp"); // 重定向到帖子管理页面
    }
%>