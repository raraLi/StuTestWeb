package com.qst.action;

import com.qst.entity.User;
import com.qst.service.IUserService;
import com.qst.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;

@WebServlet("/user/update")
public class UserUpdateServlet extends HttpServlet {
    private static final String UPDATE_BTN = "update";
    private static final String RETURN_BTN = "return";
    private IUserService userService = new UserServiceImpl();
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*设置编码*/
        req.setCharacterEncoding("utf-8");
        /*获取请求参数*/
        String id = req.getParameter("id");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String time = req.getParameter("time");
        String isMaster = req.getParameter("isMaster");
        String state = req.getParameter("state");
        /*获取按钮*/
        String btn = req.getParameter("action");
        /*封装数据*/
       User user = new User(Long.valueOf(id),username,password,time,isMaster,state);
       /*判断按钮*/
       if(UPDATE_BTN.equals(btn)){
           /*调用业务层代码，更新*/
           userService.edit(user);
           /*重新查询展示数据，跳转到/user/list  回到userlist.jsp展示数据*/
           req.setAttribute("user",user);
           //跳转页面【转发，共享请求对象】
           req.getRequestDispatcher("/userPersonal.jsp").forward(req,resp);
       }
       if(RETURN_BTN.equals(btn)){
           req.setAttribute("user",user);
           //跳转页面【转发，共享请求对象】
           req.getRequestDispatcher("/startgame.jsp?id="+user.getId()).forward(req,resp);
       }
    }
}
