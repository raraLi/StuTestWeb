package com.qst.action;

import com.qst.entity.Play;
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
import java.util.Random;

import static java.lang.System.out;

@WebServlet("/game/submit")
public class GameSubmit extends HttpServlet {

    private IUserService userService = new UserServiceImpl();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        Connection conn = null;
        PreparedStatement userStmt = null;
        ResultSet userRs = null;

        /*获取id和qid*/
        String iid = req.getParameter("id");
        int id = Integer.parseInt(iid);
        int qid = 0;
        String Sqid = req.getParameter("qid");
        if (Sqid != null && !Sqid.isEmpty()) {
            qid = Integer.parseInt(Sqid);
        }

        /*获取题目数量*/
        int Qnum = 0;
        try {
            Qnum = userService.questionNum();
        } catch (SQLException e) {
            e.printStackTrace();
        }


        Play play = userService.findOnePlay(id);
        int age = play.getAge();
        int healthy = play.getHealthy();
        int san = play.getSan();
        int money = play.getMoney();
        int talent = play.getTalent();

        // 处理答题提交
        String selectedOptionId = req.getParameter("option");

        // 跳转付款二维码
        int nextQuestionId = 1; // 默认第一题
        String qidParam = req.getParameter("qid");
        if (qidParam != null && !qidParam.isEmpty()) {
            nextQuestionId = Integer.parseInt(qidParam) + 1;
        if(nextQuestionId==3&&Integer.parseInt(selectedOptionId)==4){
            req.setAttribute("id",id);
            req.setAttribute("qid",nextQuestionId);
            /*4.跳转到编辑页面，显示这条数据: 因为存入的是请求对象，所以转发，才能共享请求对象，也就是说jsp页面才能拿到user*/
            req.getRequestDispatcher("/code.jsp?id="+id+"&qid="+nextQuestionId).forward(req,resp);
            return;
        }


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
                        updateStmt.setInt(6, id);
                        updateStmt.executeUpdate();

                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("更新用户信息出错：" + e.getMessage());
                } finally {
                    JDBCUtil.close(null, updateStmt, null);
                    JDBCUtil.close(null, optionStmt, optionRs); // 关闭 option 相关资源
                }
            }else{

            }

        /*规范数值*/
        Play uplay = userService.findOnePlay(id);
        uplay = uplay.setLimit(uplay);
        userService.editPlay(uplay);

        /*是否发生随机事件*/
            Random rand = new Random();
            int num = rand.nextInt(100);
            if(num%5==1){
                resp.sendRedirect("/random/get?id=" + id + "&qid=" + qid);
                return; // 确保不会继续执行下面的逻辑，避免重复输出页面内容
            }



            /*是否触发短线结局*/
        if (uplay.getHealthy() < 0) {
            req.setAttribute("id",id);
            req.getRequestDispatcher("/endHealthy.jsp").forward(req,resp);
        } else if (uplay.getSan() < 0) {
            req.setAttribute("id",id);
            req.getRequestDispatcher("/endSan.jsp").forward(req,resp);
        } else if (uplay.getTalent() < 0) {
            req.setAttribute("id",id);
            req.getRequestDispatcher("/endTalent.jsp").forward(req,resp);
        } else if (uplay.getMoney() < 0 && qid < Qnum) {
            req.setAttribute("id",id);
            req.getRequestDispatcher("/endMoney.jsp").forward(req,resp);
        } else {
            // 可以在这里设置一个状态码或者消息，表示所有属性都大于0
            // 获取下一个题目ID

            if(nextQuestionId==8){
                //跳转动画
                resp.sendRedirect("/stage1.jsp?id=" + id);
            }else if(nextQuestionId==12){
                //跳转动画
                resp.sendRedirect("/stage2.jsp?id=" + id);
            }else if(nextQuestionId==17){
                //跳转动画
                resp.sendRedirect("/stage3.jsp?id=" + id);
            }else if(nextQuestionId==25){
                //跳转动画
                resp.sendRedirect("/stage4.jsp?id=" + id);
            }else{
                // 完成更新后重定向到当前页面，保持 id 和当前题目ID（qid）
                resp.sendRedirect("/game.jsp?id=" + id + "&qid=" + nextQuestionId);
                return; // 确保不会继续执行下面的逻辑，避免重复输出页面内容
            }
        }
     }

    }
}

