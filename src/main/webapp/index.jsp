<%@ page language="java" import="mvc.sqlBean.*, dao.NoteDAO" contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.sqlBean.Note" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>留言板</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
    <style type="text/css">
        #head {
            background-image: url(./image/tb.jpg);
            background-size: 100%;
            background-repeat: no-repeat;
            background-position: center;
        }
        table {
            width: 1000px;
        }
        #tb {
            margin: 30px 70px;
        }
        body {
            background: url(./image/lybj.jpg) no-repeat center center fixed;
            background-size: cover; /* 背景图片将覆盖整个页面宽度 */
        }
        .comments-container {
            margin: 30px 70px; /* 确保与其他内容间距一致 */
            padding: 20px; /* 内边距 */
            background-color: rgba(255, 255, 255, 0.8); /* 背景颜色 */
            border-radius: 10px; /* 圆角 */
            position: relative; /* 为毛玻璃效果做准备 */
            overflow: hidden; /* 确保虚化效果不超出容器 */
        }
        .comments-container::before {
            content: ''; /* 创建伪元素 */
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            backdrop-filter: blur(10px); /* 设置毛玻璃效果 */
            z-index: 1; /* 确保在背景上 */
            border-radius: 10px; /* 使边角圆滑 */
        }
        .comments {
            position: relative; /* 使内容层次在伪元素之上 */
            z-index: 2; /* 确保内容在虚化之上 */
            border-bottom: 1px solid #ddd;
        }
        .comment-item:last-child {
            border-bottom: none; /* 去除最后一条的下划线 */
        }
        .white-text {
            color: white; /* 定义一个类来设置字体颜色为白色 */
        }
    </style>
</head>
<body>

<%
    // 获取所有留言
    NoteDAO noteDAO = new NoteDAO();
    List<Note> notes = noteDAO.queryAllNotes();
    session.setAttribute("notes", notes); // 存入 session 供后续使用
%>

<div class="jumbotron text-center" style="margin-bottom:0" id="head">
    <h1>你所欲言，愚你所言</h1>
</div>

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">在线留言</a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav navbar-right">
                <li class="active"><a href="#">主页</a></li>
                <li><a href="addNote.jsp">发布留言</a></li>
                <li><a href="login.jsp">管理员登陆</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container" id="center"> <!-- 主容器，用于显示留言内容 -->
    <div class="row"> <!-- Bootstrap 的行，设置布局 -->
        <div class="col-sm-8"> <!-- 使用 Bootstrap 的网格系统，设置这部分占用8列 -->
            <table width="85%" border="1" id="tb"> <!-- 创建一个表格，宽度为85%，边框为1 -->
                <c:forEach var="note" items="${sessionScope.notes}"> <!-- 循环遍历 session 中的 notes 列表 -->
                    <tr> <!-- 表格行开始 -->
                        <td width="25%"> <!-- 第一列，宽度为25% -->
                            <div class="text-center" style="margin:10px 10px"> <!-- 定义一个文本居中的 div，添加内外边距 -->
                                <p class="white-text">留言人：${note.userId}</p> <!-- 输出留言人的用户 ID，字体颜色设置为白色 -->
                                <p class="white-text">邮箱：${note.email}</p> <!-- 输出留言人的邮箱，字体颜色设置为白色 -->
                                <p class="white-text">留言时间：${note.writetime}</p> <!-- 输出留言的时间，字体颜色设置为白色 -->
                            </div>
                        </td>
                        <td width="70%" style="background-color: rgba(211, 211, 211, 0.5);"> <!-- 第二列，宽度70%，背景色为半透明的浅灰色 -->
                            <div style="margin:10px 3px; padding: 10px; border-radius: 5px;"> <!-- 最外层 div，添加内边距和圆角 -->
                                <p style="margin:0;">主题: <span class="white-text">${note.title}</span></p> <!-- 输出留言的主题，字体颜色设置为白色 -->
                                <hr style="background-color:black;height:1px;border:none;margin-top:0;margin-bottom:10px;"> <!-- 分隔线，黑色，1px高 -->
                                <span class="white-text">${note.content}</span> <!-- 输出留言内容，字体颜色设置为白色 -->
                            </div>
                        </td>
                    </tr> <!-- 表格行结束 -->
                </c:forEach>
            </table> <!-- 表格结束 -->
        </div>
    </div>
</div>

<div class="text-center" style="margin-bottom:0"></div>

</body>
</html>
