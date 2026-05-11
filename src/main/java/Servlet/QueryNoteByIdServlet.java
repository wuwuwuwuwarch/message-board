package Servlet;

import dao.NoteDAO;
import dao.sqlBean.Note;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Servlet.QueryNoteByIdServlet")
public class QueryNoteByIdServlet extends HttpServlet {
    private NoteDAO noteDAO = new NoteDAO(); // 初始化 NoteDAO

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int noteId = Integer.parseInt(request.getParameter("id")); // 获取留言ID

        // 使用 DAO 查询留言
        Note note = noteDAO.queryNoteById(noteId);
        if (note != null) {
            // 将查询结果存储到请求属性中
            request.setAttribute("note", note);
            request.getRequestDispatcher("editNote.jsp").forward(request, response); // 转发到编辑页面
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "留言未找到");
        }
    }
}
