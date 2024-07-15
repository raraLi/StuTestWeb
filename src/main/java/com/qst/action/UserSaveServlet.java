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

@WebServlet("/user/add")
public class UserSaveServlet extends HttpServlet {
    private IUserService userService = new UserServiceImpl();
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*设置编码*/
        req.setCharacterEncoding("utf-8");
        /*从请求对象钟获取参数*/
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String intro = req.getParameter("intro");
        /*封装数据，成user对象*/
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setIntro(intro);
        /*调用业务层userServc保存数据*/
        userService.add(user);//

        /*跳转到奥/user/list,从重新查询展示数据*/
        /*1. 转发，跳转到另外一个路劲，转发特点，共请求对象，内部跳转*/
        //req.getRequestDispatcher("/user/list").forward(req,resp);
        /*2.重从定向：重新改变方向，不能共享请求对象req，，，跳转到百度其他站点*/
        resp.sendRedirect("/user/list");

    }
}
