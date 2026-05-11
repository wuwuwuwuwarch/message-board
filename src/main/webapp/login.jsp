<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.sqlBean.Note" %>
<%@ page import="Servlet.LoginServlet" %>
<%@ page import="dao.NoteDAO" %>
<%@ page import="util.DataBaseConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理员登录</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style type="text/css">
        body {
            background: url(./image/lybj.jpg);
            background-size: cover; /* 确保背景覆盖整个页面 */
            padding: 20px;
        }
        .container {
            border-radius: 10px;
            padding: 40px;
            max-width: 400px; /* 设置最大宽度 */
            margin: auto; /* 居中对齐 */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2); /* 增加阴影效果 */
            position: relative; /* 为背景虚化做准备 */
            overflow: hidden; /* 确保虚化效果不超出容器 */
        }
        .container::before {
            content: ''; /* 创建伪元素 */
            position: absolute; /* 绝对定位 */
            top: 0; /* 顶部对齐 */
            left: 0; /* 左侧对齐 */
            right: 0; /* 右侧对齐 */
            bottom: 0; /* 底部对齐 */
            background: inherit; /* 继承父元素的背景 */
            backdrop-filter: blur(10px); /* 设置毛玻璃效果 */
            z-index: 1; /* 确保在背景上 */
            border-radius: 10px; /* 确保圆角 */
        }
        .content {
            position: relative; /* 使内容层次在伪元素之上 */
            z-index: 2; /* 确保内容在虚化之上 */
        }
        h2 {
            text-align: center; /* 标题居中 */
            margin-bottom: 20px; /* 标题下方间距 */
            font-size: 2.5em; /* 增加标题字号 */
            color: #ADD8E6; /* 设置标题字体颜色为浅蓝色 */
        }
        .form-group {
            margin-bottom: 25px; /* 增加输入框的底部间距 */
        }
        label {
            font-size: 1.5em; /* 增加标签字体大小 */
            color: #ADD8E6; /* 设置标签字体颜色为浅蓝色 */
            display: block; /* 标签在新行显示 */
        }
        input, textarea {
            font-size: 1.3em; /* 增加输入框内字体大小 */
            width: 100%; /* 确保输入框占满宽度 */
        }
        .btn-primary {
            width: 100%; /* 按钮宽度占满父元素 */
            font-size: 1.3em; /* 增加按钮字体尺寸 */
            background-color: #808080; /* 设置按钮背景颜色为中灰色 */
            border: none; /* 移除按钮默认边框 */
        }
        .error-message {
            color: red; /* 错误消息颜色 */
            text-align: center; /* 错误消息居中 */
            margin-bottom: 15px; /* 错误消息底部间距 */
        }
    </style>
</head>
<body>

<div class="container">
    <div class="content"> <!-- 确保内容层级高于背景 -->
        <h2>管理员登录</h2>

        <% if ("true".equals(request.getParameter("error"))) { %> <!-- 检查请求参数是否包含错误标记 -->
        <p class="error-message">用户名或密码错误，请重试。</p> <!-- 显示错误提示 -->
        <% } %>

        <form action="Servlet.LoginServlet" method="post"> <!-- 表单提交 -->
            <div class="form-group">
                <label for="username">账号:</label>
                <input type="text" class="form-control" name="username" id="username" value="admin" required> <!-- 用户名输入 -->
            </div>
            <div class="form-group">
                <label for="password">密码:</label>
                <input type="password" class="form-control" name="password" id="password" required> <!-- 密码输入 -->
            </div>
            <button type="submit" class="btn btn-primary">登录</button> <!-- 登录按钮 -->
        </form>
    </div>
</div>

</body>
</html>
