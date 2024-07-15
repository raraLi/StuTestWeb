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

@WebServlet("/user/toedit")
public class UserEditServlet  extends HttpServlet {
    private IUserService userService = new UserServiceImpl();
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*1.获取请求参数*/
        String id = req.getParameter("id");
        /*2.根据请求参数ID,咱去数据查该id的数据*/
        User one = userService.findOne(Long.valueOf(id));
        //3.将数据存入请求对象，作用域
        req.setAttribute("user",one);
        /*4.跳转到编辑页面，显示这条数据: 因为存入的是请求对象，所以转发，才能共享请求对象，也就是说jsp页面才能拿到user*/
        req.getRequestDispatcher("/useredit.jsp").forward(req,resp);

    }
}
