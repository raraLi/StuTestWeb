package com.qst.action;

import com.qst.entity.User;
import com.qst.service.IUserService;
import com.qst.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/text")
public class TextServlet extends HttpServlet {
    private IUserService userService = new UserServiceImpl();
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        /*1.获取请求参数*/
        String id = req.getParameter("id");
        Long uid = Long.valueOf(id);
        /*2.根据请求参数ID,咱去数据查该id的数据*/
        User user = userService.findOne(uid);
        req.setAttribute("user",user);
        /*4.跳转到编辑页面，显示这条数据: 因为存入的是请求对象，所以转发，才能共享请求对象，也就是说jsp页面才能拿到user*/
        req.getRequestDispatcher("/addtext.jsp").forward(req,resp);
        }
}
