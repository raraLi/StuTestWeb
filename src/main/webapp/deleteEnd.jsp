<%@ page import="java.sql.*" %>
<%@ page import="com.qst.util.JDBCUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int eid = Integer.parseInt(request.getParameter("eid"));
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        conn = JDBCUtil.getConnection();
        String sql = "DELETE FROM end WHERE eid = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, eid);
        pstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        JDBCUtil.close(conn, pstmt, null);
    }
    response.sendRedirect("end_manage.jsp");
%>
