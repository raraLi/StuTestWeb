<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Code页面</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .code-content {
            text-align: center;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative; /* Ensure relative positioning for close button */
        }
        .close-button {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 20px;
            cursor: pointer;
        }
        .code-content img {
            max-width: 100%;
            height: auto;
        }
        .submit-button {
            background-color: #FF6699;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            margin-top: 20px;
        }

        .submit-button:hover {
            background-color: #E84B85;
        }
    </style>
</head>
<body>
    <div class="code-content">
    <h2>长大啦！</h2>
               <img src="/images/stage3.gif" alt="动画" width="750">
               <form action="game.jsp" method="post">
                   <input type="hidden" name="id" value="<%= request.getParameter("id") %>">
                   <input type="hidden" name="qid" value="18">
                   <input type="submit" class="submit-button" value="点击进入人生的下一阶段">
               </form>
           </div>




    </script>
</body>
</html>
