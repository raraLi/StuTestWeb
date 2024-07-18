<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
       <!DOCTYPE html>
       <html lang="en">
       <head>
           <meta charset="UTF-8">
           <meta name="viewport" content="width=device-width, initial-scale=1.0">
           <title>Register</title>
           <link rel="stylesheet" href="CSS/loginStyle.css">
       </head>
       <body>
       <jsp:include page="background.jsp" />
           <div class="container">
               <h2>注册</h2>
               <form action="/login/add" method="post">
                   <input type="text" name="username" placeholder="用户名" required>
                   <input type="password" name="password" placeholder="密码" required>
                   <button type="submit">注册</button>
               </form>
               <p>已经注册账号？  <a href="login.jsp">点击登录</a></p>
           </div>
       </body>
       </html>