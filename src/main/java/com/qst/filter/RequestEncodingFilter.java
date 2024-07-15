package com.qst.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/*设置编码的过滤器，待会再去写一个登录检查过滤器*/
@WebFilter("/*")
public class RequestEncodingFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        System.out.println("过滤器执行了");
        /*设置编码*/
        servletRequest.setCharacterEncoding("utf-8");
        filterChain.doFilter(servletRequest,servletResponse);//放行
    }

    @WebFilter("/user/*")
    public static class LoginFilter implements Filter {

        @Override
        public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
            HttpServletRequest request = (HttpServletRequest) servletRequest;
            Object login = request.getSession().getAttribute("login");
            if(login!=null){//说明是登录状态
                filterChain.doFilter(servletRequest,servletResponse);//放行，允许当前用户去Servlet操作
            }
            /*非登录状态，让你去登录页面*/
            HttpServletResponse response = (HttpServletResponse) servletResponse;
            response.sendRedirect("/login.jsp");

        }
    }
}
