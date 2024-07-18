package com.qst.action;

import com.qst.entity.RandomThing;
import com.qst.service.IUserService;
import com.qst.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Random;

@WebServlet("/random/get")
public class RandomGet extends HttpServlet {

    private IUserService userService = new UserServiceImpl();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        String id = req.getParameter("id");
        int uid = Integer.parseInt(id);
        String qqid = req.getParameter("qid");
        int qid = Integer.parseInt(qqid);

        Random rand = new Random();
        int num = 0;
        try {
            num = userService.randomNum();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        int rid = rand.nextInt(num)+1;
        RandomThing one = userService.findOneRandom(rid);
        req.setAttribute("random",one);
        req.setAttribute("id",uid);
        req.setAttribute("qid",qid);
        /*4.跳转到编辑页面，显示这条数据: 因为存入的是请求对象，所以转发，才能共享请求对象，也就是说jsp页面才能拿到user*/
        req.getRequestDispatcher("/randomShow.jsp?").forward(req,resp);
    }
}
