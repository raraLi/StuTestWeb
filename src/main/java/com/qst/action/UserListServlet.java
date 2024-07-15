package com.qst.action;

import com.qst.dao.IUserDao;
import com.qst.dao.impl.UserDaoImpl;
import com.qst.entity.User;
import com.qst.service.IUserService;

import com.qst.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

@WebServlet("/user/list")
public class UserListServlet extends HttpServlet {
    private IUserService userService = new UserServiceImpl();
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<User> users = userService.findAll();
        HashMap<Object, Object> hashMap = new HashMap<>();
        req.setAttribute("list",users);//前端取值${list}
        //跳转页面【转发，共享请求对象】
        req.getRequestDispatcher("/userlist.jsp").forward(req,resp);

    }
}
