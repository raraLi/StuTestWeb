package com.qst.action;

import com.qst.entity.Play;
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

@WebServlet("/random/do")
public class RandomDo extends HttpServlet {

    private IUserService userService = new UserServiceImpl();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        String id = req.getParameter("id");
        int uid = Integer.parseInt(id);
        String qqid = req.getParameter("qid");
        int qid = Integer.parseInt(qqid)+1;

        String rhealthy = req.getParameter("rhealthy");
        String rsan = req.getParameter("rsan");
        String rmoney = req.getParameter("rmoney");
        String rtalent = req.getParameter("rtalent");

        int Rhealthy = Integer.parseInt(rhealthy);
        int Rsan = Integer.parseInt(rsan);
        int Rmoney = Integer.parseInt(rmoney);
        int Rtalent = Integer.parseInt(rtalent);

        Play play = userService.findOnePlay(uid);
        int healthy = play.getHealthy();
        int san = play.getSan();
        int money = play.getMoney();
        int talent = play.getTalent();
        play.setHealthy(healthy+Rhealthy);
        play.setSan(san+Rsan);
        play.setMoney(money+Rmoney);
        play.setTalent(talent+Rtalent);
        play = play.setLimit(play);
        userService.editPlay(play);

        /*是否触发短线结局*/
        if (play.getHealthy() < 0) {
            req.setAttribute("id",play.getUid());
            req.getRequestDispatcher("/endHealthy.jsp").forward(req,resp);
        } else if (play.getSan() < 0) {
            req.setAttribute("id",play.getUid());
            req.getRequestDispatcher("/endSan.jsp").forward(req,resp);
        } else if (play.getTalent() < 0) {
            req.setAttribute("id",play.getUid());
            req.getRequestDispatcher("/endTalent.jsp").forward(req,resp);
        } else if (play.getMoney() < 0) {
            req.setAttribute("id",play.getUid());
            req.getRequestDispatcher("/endMoney.jsp").forward(req,resp);
        } else {
            resp.sendRedirect("/game.jsp?id="+play.getUid()+"&qid="+qid);
        }
    }
}
