<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>masterLogin</title>
    <link rel="stylesheet" href="CSS/loginStyle.css">
</head>
<body>
<p>隐藏结局</p>
<form action="/game/again" style="width: 500px" method="post">
        <input type="hidden" name="id" value="${id}">
        <button type="submit" name="action" value="again">再来一局</button>
    </form>
<button>
</body>
</html>