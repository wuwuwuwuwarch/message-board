package Servlet;

import dao.NoteDAO;
import dao.sqlBean.Note;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/Servlet.AddNoteServlet")
public class AddNoteServlet extends HttpServlet {
    private NoteDAO noteDAO = new NoteDAO(); // 初始化 NoteDAO

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 从请求中获取参数
        String useridStr = request.getParameter("userid");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String email = request.getParameter("email");
        String ip = request.getRemoteAddr(); // 获取用户的IP地址
        String writetime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

        // 输入有效性检查
        if (useridStr == null || useridStr.trim().isEmpty() || title == null || title.trim().isEmpty() ||
                content == null || content.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "所有输入字段都是必填项");
            return;
        }
        String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";
        if (!email.matches(emailPattern)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "邮箱格式不正确");
            return;
        }


        // 尝试将 userid 转换为 int
        int userid;
        try {
            userid = Integer.parseInt(useridStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "用户ID格式不正确");
            return;
        }

        // 创建 Note 对象
        Note note = new Note();
        note.setUserId(userid); // 设置用户 ID
        note.setTitle(title);
        note.setContent(content);
        note.setEmail(email);
        note.setIp(ip);
        note.setWritetime(writetime);

        // 使用 DAO 添加留言
        noteDAO.insertNote(note);

        // 添加完留言后重定向到首页
        response.sendRedirect("index.jsp");
    }
}
