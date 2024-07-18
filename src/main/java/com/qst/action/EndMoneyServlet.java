package com.qst.action;

import com.qst.entity.Play;
import com.qst.entity.User;
import com.qst.service.IUserService;
import com.qst.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/end/money")
public class EndMoneyServlet extends HttpServlet {

    private IUserService userService = new UserServiceImpl();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

                String uid = req.getParameter("id");
                System.out.println("Received UID: " + uid); // 调试信息

                if (uid == null || uid.isEmpty()) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "UID is required");
                    return;
                }

                try {
                    int money = getMoneyByUid(uid); // 调用查询方法

                    /*记录最高资产*/
                    String newState = String.valueOf(money);
                    Long id = Long.valueOf(uid);
                    User user = userService.findOne(id);

                    String topState = user.getState();
                    int topNum = Integer.valueOf(topState);
                    if(money>topNum){
                        user.setState(newState);
                        userService.edit(user);
                    }

                    if (money > 0 && money < 100000) {
                        req.setAttribute("id",uid);
                        req.getRequestDispatcher("/end2.jsp").forward(req,resp);
                    } else if (money >= 100000 && money < 1000000) {
                        req.setAttribute("id",uid);
                        req.getRequestDispatcher("/end3.jsp").forward(req,resp);
                    } else if (money >= 1000000 && money < 2000000) {
                        req.setAttribute("id",uid);
                        req.getRequestDispatcher("/end4.jsp").forward(req,resp);
                    } else if (money >= 2000000) {
                        req.setAttribute("id",uid);
                        req.getRequestDispatcher("/end5.jsp").forward(req,resp);
                    } else if (money < 0) {
                        req.setAttribute("id",uid);
                        req.getRequestDispatcher("/end1.jsp").forward(req,resp);
                    } else {
                        // 如果money不大于100，可以在这里设置一个状态码或者消息
                        //resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Money value is not within the specified ranges.");
                        req.setAttribute("id",uid);
                        req.getRequestDispatcher("/endSecret.jsp").forward(req,resp);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database access error");
                }
            }

            private int getMoneyByUid(String uid) throws SQLException {
                int pid = Integer.parseInt(uid);
                Play play = userService.findOnePlay(pid);
                int money = play.getMoney();
                    return money;
            }
    }
