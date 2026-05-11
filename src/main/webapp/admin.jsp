<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.sqlBean.Note" %>
<%@ page import="dao.NoteDAO" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>留言管理</title>
  <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
  <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
    body {
      background: url(./image/lybj.jpg);
      background-size: cover; /* 确保背景完全覆盖 */
      padding: 20px;
    }
    .container {

      border-radius: 10px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3); /* 增加阴影效果 */
      padding: 40px; /* 增加内边距 */
      position: relative; /* 为虚化效果的伪元素做准备 */
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
      font-size: 2em; /* 可以调整字体大小 */
    }
    table {
      width: 100%;
      margin-top: 20px;
      border-collapse: collapse;
    }
    th, td {
      padding: 10px;
      text-align: center;
      border: 1px solid #ddd;
    }
    th {
      background-color: #f2f2f2;
    }
  </style>

</head>
<body>

<div class="container">
  <div class="content"> <!-- 新增内容容器 -->
    <h2>留言管理</h2>

    <%
      NoteDAO noteDAO = new NoteDAO();
      List<Note> notes = noteDAO.queryAllNotes(); // 查询所有留言
      request.setAttribute("notes", notes);
    %>

    <table>
      <tr>
        <th>用户名</th>
        <th>主旨</th>
        <th>内容</th>
        <th>操作</th>
      </tr>
      <c:forEach var="note" items="${notes}">
        <tr>
          <td>${note.userId}</td>
          <td>${note.title}</td>
          <td>${note.content}</td>
          <td>
            <a href="editNote.jsp?id=${note.id}">编辑</a>
            <form action="Servlet.DeleteNoteByIdServlet" method="post" style="display:inline;">
              <input type="hidden" name="id" value="${note.id}" />
              <button type="submit" class="btn btn-danger" onclick="return confirm('确认要删除这条留言吗？')">删除</button>
            </form>
          </td>
        </tr>
      </c:forEach>
    </table>

    <a class="btn btn-primary" href="index.jsp">注销</a>
  </div>
</div>


</body>
</html>
