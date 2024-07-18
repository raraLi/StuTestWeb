package com.qst.action;

import com.qst.entity.Play;
import com.qst.entity.User;
import com.qst.service.IUserService;
import com.qst.service.impl.UserServiceImpl;
import com.qst.util.JDBCUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static java.lang.System.out;

@WebServlet("/game/code")
public class CodeServlet extends HttpServlet {
    private IUserService userService = new UserServiceImpl();
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // Retrieve parameters from the request
        String id = req.getParameter("id");
        String qid = req.getParameter("qid");

        Play play = userService.findOnePlay(Integer.valueOf(id));
        int age = play.getAge();
        int healthy = play.getHealthy();
        int san = play.getSan();
        int money = play.getMoney();
        int talent = play.getTalent();

        PreparedStatement updateStmt = null;
        PreparedStatement optionStmt = null; // 声明 optionStmt
        ResultSet optionRs = null; // 声明 optionRs

        Connection conn = null;
        try {
            conn = JDBCUtil.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // 查询选项信息
        String optionSql = "SELECT * FROM choice WHERE cid=4";
        try {
            optionStmt = conn.prepareStatement(optionSql); // 初始化 optionStmt
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            optionRs = optionStmt.executeQuery(); // 执行查询
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (optionRs.next()) {
                // 更新用户信息
                int ageDelta = optionRs.getInt("cage");
                int healthyDelta = optionRs.getInt("chealthy");
                int sanDelta = optionRs.getInt("csan");
                int moneyDelta = optionRs.getInt("cmoney");
                int talentDelta = optionRs.getInt("ctalent");

                age = ageDelta;
                healthy += healthyDelta;
                san += sanDelta;
                money += moneyDelta;
                talent += talentDelta;

                // 更新用户信息到数据库
                String updateSql = "UPDATE play SET age=?, healthy=?, san=?, money=?, talent=? WHERE uid=?";
                updateStmt = conn.prepareStatement(updateSql);
                updateStmt.setDouble(1, age);
                updateStmt.setDouble(2, healthy);
                updateStmt.setDouble(3, san);
                updateStmt.setDouble(4, money);
                updateStmt.setDouble(5, talent);
                updateStmt.setInt(6, Integer.valueOf(id));
                updateStmt.executeUpdate();

                JDBCUtil.close(null, updateStmt, null);
                JDBCUtil.close(null, optionStmt, optionRs); // 关闭 option 相关资源

                Play uplay = userService.findOnePlay(Integer.valueOf(id));
                uplay = uplay.setLimit(uplay);
                userService.editPlay(uplay);

                resp.sendRedirect("/game.jsp?id=" + id + "&qid=" + qid);


            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
