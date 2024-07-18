package com.qst.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/login/*")
public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        String requestURI = request.getRequestURI();

        Object login = request.getSession().getAttribute("login");
        if(login!=null||requestURI.equals("/login/add")||requestURI.equals("/login/login")){//说明是登录状态
            filterChain.doFilter(servletRequest,servletResponse);//放行，允许当前用户去Servlet操作
        }else{
            /*非登录状态，让你去登录页面*/
            HttpServletResponse response = (HttpServletResponse) servletResponse;
            response.sendRedirect("/login.jsp");
        }


    }
}
