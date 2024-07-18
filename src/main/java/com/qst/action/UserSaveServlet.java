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
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/login/add")
public class UserSaveServlet extends HttpServlet {
    private IUserService userService = new UserServiceImpl();
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*设置编码*/
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        /*从请求对象钟获取参数*/
        User user = new User();

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String time = getCurrentDate();
        String isMaster = "用户";
        String state = "0";
        /*封装数据，成user对象*/
        user.setUsername(username);
        user.setPassword(password);
        user.setTime(time);
        user.setIsMaster(isMaster);
        user.setState(state);
        /*调用业务层userService保存数据*/
        userService.add(user);//

        /*创建对应游戏对象play*/
        User one = userService.findOnebyName(username);
        long id = one.getId();
        int uid = (int)id;
        Play play = new Play(uid,0,0,0,0,0);
        userService.addPlay(play);



        /*跳转到奥/user/list,从重新查询展示数据*/
        /*1. 转发，跳转到另外一个路劲，转发特点，共请求对象，内部跳转*/
        //req.getRequestDispatcher("/user/list").forward(req,resp);
        /*2.重从定向：重新改变方向，不能共享请求对象req，，，跳转到百度其他站点*/
        /* 跳转到游戏开始界面 */
        String script="<script>alert('注册成功！');location.href='/login.jsp'</script>";
        resp.getWriter().println(script);


    }

    public String getCurrentDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(new Date());
    }
}
