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

@WebServlet("/login/login")
public class UserLoginServlet extends HttpServlet {
    private IUserService userService = new UserServiceImpl();
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        /*1.获取请求参数*/
        String username = req.getParameter("username");
        /*2.根据请求参数ID,咱去数据查该id的数据*/
        User one = userService.findOnebyName(username);

        /* 判断用户名和密码*/
        if(one==null){
            //弹出注册信息
            String script="<script>alert('用户不存在，请先注册！');location.href='/login.jsp'</script>";
            resp.getWriter().println(script);
        }else{
            if( req.getParameter("password").equals(one.getPassword()) && one.getIsMaster().equals("用户")){
                //3.将数据存入请求对象，作用域
                req.setAttribute("user",one);
                /*4.跳转到编辑页面，显示这条数据: 因为存入的是请求对象，所以转发，才能共享请求对象，也就是说jsp页面才能拿到user*/
                req.getRequestDispatcher("/startgame.jsp?id="+one.getId()).forward(req,resp);
            }else if( req.getParameter("password").equals(one.getPassword()) && one.getIsMaster().equals("管理员")){
                //3.将数据存入请求对象，作用域
                req.setAttribute("user",one);
                /*4.跳转到编辑页面，显示这条数据: 因为存入的是请求对象，所以转发，才能共享请求对象，也就是说jsp页面才能拿到user*/
                req.getRequestDispatcher("/backmanage.jsp").forward(req,resp);
            } else {
                //密码错误
                String script="<script>alert('用户名或密码错误，请重新登陆！');location.href='/login.jsp'</script>";
                resp.getWriter().println(script);
            }
        }



    }
}
