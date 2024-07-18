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

@WebServlet("/game/again")
public class GameAgainServlet extends HttpServlet {
    private IUserService userService = new UserServiceImpl();
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        Long uid = Long.valueOf(id);
        int pid = Integer.valueOf(id);
        Play play = new Play(pid,0,0,0,0,0);
        userService.editPlay(play);
        User one = userService.findOne(uid);
        req.setAttribute("user",one);
        req.getRequestDispatcher("/startgame.jsp?id="+pid).forward(req,resp);
    }
}
