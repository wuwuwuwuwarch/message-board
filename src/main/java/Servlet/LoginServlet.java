package Servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Servlet.LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 简单的用户验证
        if ("admin".equals(username) && "123456".equals(password)) {
            request.getSession().setAttribute("user", username); // 存储用户信息到会话
            response.sendRedirect("admin.jsp"); // 登录成功后重定向到管理页面
        } else {
            // 登录失败，重定向回登录页面并显示错误信息
            response.sendRedirect("login.jsp?error=true");
        }
    }
}
