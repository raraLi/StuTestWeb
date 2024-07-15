<%@ page import="java.sql.*" %>
<%@ page import="com.qst.util.JDBCUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int qid = Integer.parseInt(request.getParameter("qid"));
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        conn = JDBCUtil.getConnection();
        String sql = "DELETE FROM question WHERE qid = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, qid);
        pstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        JDBCUtil.close(conn, pstmt, null);
    }
    response.sendRedirect("question_manage.jsp");
%>
