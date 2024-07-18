package com.qst.action;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.qst.util.JDBCUtil;

@WebServlet("/text/add")
public class AddTextServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 获取表单数据
        String tid = request.getParameter("tid");
        String tname = request.getParameter("tname");
        String title = request.getParameter("title");
        String text = request.getParameter("text");
        String aClass = request.getParameter("class");

        // 验证数据是否已填写
        if (tid == null || tname == null || title == null || text == null || aClass == null) {
            out.println("<div style=\"color: red;\">所有字段都是必填项。</div>");
            return;
        }

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO test (tid, tname, title, text, class) VALUES (?, ?, ?, ?, ?)")) {

            stmt.setString(1, tid);
            stmt.setString(2, tname);
            stmt.setString(3, title);
            stmt.setString(4, text);
            stmt.setString(5, aClass);

            // 执行插入操作
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                out.println("<div style=\"color: green;\">记录添加成功！</div>");
                response.sendRedirect("/test.jsp?id="+tid); // 重定向到管理页面
            } else {
                out.println("<div style=\"color: red;\">记录添加失败，请重试。</div>");
            }
        } catch (SQLException e) {
            out.println("<div style=\"color: red;\">数据库操作失败：</div>" + e.getMessage());
            e.printStackTrace();
        }
    }
}