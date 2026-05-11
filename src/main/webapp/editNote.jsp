<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.DataBaseConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>编辑留言</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style type="text/css">
        body {
            background: url(./image/lybj.jpg) no-repeat center center fixed;
            background-size: cover;
            padding: 20px;
        }
        .container {

            border-radius: 10px;
            padding: 40px;
            max-width: 600px;
            margin: auto;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
            position: relative; /* 为背景虚化做准备 */
            overflow: hidden;
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .btn-primary {
            width: 100%;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>编辑留言</h1>

    <%
        int id = Integer.parseInt(request.getParameter("id")); // 获取留言ID
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            DataBaseConnection dbc = new DataBaseConnection(); // 创建实例
            conn = dbc.getConnection(); // 获取连接
            pstmt = conn.prepareStatement("SELECT * FROM note WHERE id = ?");
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
    %>
    <!-- 表单内容 -->
    <form action="UpdateNoteServlet" method="post">
        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
        <div class="form-group">
            <label for="userid">用户ID:</label>
            <input type="number" class="form-control" id="userid" name="userid" value="<%= rs.getInt("userid") %>" readonly>
        </div>
        <div class="form-group">
            <label for="title">标题:</label>
            <input type="text" class="form-control" id="title" name="title" value="<%= rs.getString("title") %>" required>
        </div>
        <div class="form-group">
            <label for="content">留言内容:</label>
            <textarea class="form-control" id="content" name="content" required><%= rs.getString("content") %></textarea>
        </div>
        <div class="form-group">
            <label for="email">邮箱:</label>
            <input type="email" class="form-control" id="email" name="email" value="<%= rs.getString("email") %>" required>
        </div>

        <button type="submit" class="btn btn-primary">更新留言</button>
    </form>
    <%
            } else {
                out.println("<p class='text-danger text-center'>未找到对应的留言信息。</p>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p class='text-danger text-center'>数据库操作错误: " + e.getMessage() + "</p>");
        } catch (NumberFormatException e) {
            out.println("<p class='text-danger text-center'>无效的留言ID。</p>");
        } finally {
            // 确保在这里关闭连接
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    %>

</div>

</body>
</html>
