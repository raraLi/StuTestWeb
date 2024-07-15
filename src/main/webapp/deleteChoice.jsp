<%@ page import="java.sql.*" %>
<%@ page import="com.qst.util.JDBCUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int cid = Integer.parseInt(request.getParameter("cid"));
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        conn = JDBCUtil.getConnection();
        String sql = "DELETE FROM choice WHERE cid = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, cid);
        pstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        JDBCUtil.close(conn, pstmt, null);
    }
    response.sendRedirect("choice_manage.jsp");
%>
