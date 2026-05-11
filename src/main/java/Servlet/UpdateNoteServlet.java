package Servlet;

import dao.NoteDAO;
import dao.sqlBean.Note;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Servlet.UpdateNoteServlet")
public class UpdateNoteServlet extends HttpServlet {
    private NoteDAO noteDAO = new NoteDAO(); // 初始化 NoteDAO

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int noteId = Integer.parseInt(request.getParameter("id")); // 获取留言ID
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        // 创建 Note 对象并设置属性
        Note note = new Note();
        note.setId(noteId);
        note.setTitle(title);
        note.setContent(content);

        // 使用 DAO 更新留言
        noteDAO.updateNote(note);

        // 更新后重定向到管理页面
        response.sendRedirect("admin.jsp");
    }
}
