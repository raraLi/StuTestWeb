<%@ page import="java.sql.*" %>
<%@ page import="com.qst.util.JDBCUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int rid = Integer.parseInt(request.getParameter("rid")); // 获取要删除的随机事件的ID
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        conn = JDBCUtil.getConnection();
        String sql = "DELETE FROM random WHERE rid = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, rid);
        pstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        JDBCUtil.close(conn, pstmt, null);
    }
    response.sendRedirect("random_manage.jsp");
%>

