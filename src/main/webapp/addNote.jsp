<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.sqlBean.Note" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>发布留言</title>
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
            margin-top: 20px;
            padding: 40px; /* 增加内边距 */
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3); /* 增加阴影效果 */
            position: relative; /* 使用于背景虚化 */
            overflow: hidden; /* 确保虚化效果不超出容器 */
        }
        .container::before {
            content: ''; /* 创建伪元素 */
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: inherit; /* 继承父元素的背景 */
            backdrop-filter: blur(10px); /* 设置虚化效果 */
            z-index: 1; /* 确保在背景上 */
            border-radius: 10px; /* 使边角圆滑 */
        }
        .content {
            position: relative; /* 使内容层次在伪元素之上 */
            z-index: 2; /* 确保内容在虚化之上 */
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 2.5em; /* 增加标题字号 */
            color: #ADD8E6; /* 设置标题字体颜色为很浅的蓝色 */
        }
        .form-group {
            margin-bottom: 25px; /* 增加输入框间距 */
            width: 100%; /* 确保占满宽度 */
        }
        label {
            font-size: 1.2em; /* 增加标签字体大小 */
            display: block; /* 使标签在新行显示 */
            margin-bottom: 5px; /* 确保标签与输入框之间的间距 */
        }
        input, textarea {
            font-size: 1.2em; /* 增加输入框内字体大小 */
            width: 100%; /* 确保输入框占满宽度 */
        }
        button.btn {
            margin-top: 15px; /* 按钮顶部间距 */
        }
    </style>
</head>
<body>

<div class="container">
    <div class="content">
        <h2>发布留言</h2> <!-- 此处修改了标题颜色 -->
        <form action="AddNoteServlet" method="post">
            <div class="form-group">
                <label for="userid">用户ID:</label>
                <input type="number" class="form-control" name="userid" id="userid" required>
            </div>
            <div class="form-group">
                <label for="username">姓名:</label>
                <input type="text" class="form-control" name="username" id="username" required>
            </div>
            <div class="form-group">
                <label for="email">邮件:</label>
                <input type="email" class="form-control" name="email" id="email" placeholder="请输入您的邮箱" required>
            </div>
            <div class="form-group">
                <label for="title">主旨:</label>
                <input type="text" class="form-control" name="title" id="title" required>
            </div>
            <div class="form-group">
                <label for="content">内容:</label>
                <textarea class="form-control" name="content" id="content" rows="5" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary btn-block">提交留言</button>
        </form>
    </div>
</div>

</body>
</html>
