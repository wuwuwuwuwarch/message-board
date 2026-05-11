package Servlet;

import dao.NoteDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/Servlet.DeleteNoteByIdServlet")
public class DeleteNoteByIdServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(DeleteNoteByIdServlet.class.getName());
    private NoteDAO noteDAO = new NoteDAO(); // 初始化 NoteDAO

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response); // 转发到 doPost 处理
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String noteIdStr = request.getParameter("id"); // 获取要删除的留言ID

        // 输入有效性检查
        if (noteIdStr == null || noteIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "留言ID不能为空");
            return;
        }

        int noteId;
        try {
            noteId = Integer.parseInt(noteIdStr); // 转换为 int
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "留言ID格式不正确");
            return;
        }

        // 使用 DAO 删除留言
        try {
            int result = noteDAO.deleteById(noteId); // 删除数据并返回操作结果
            if (result == 0) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "留言未找到");
                return;
            }
        } catch (Exception e) {
            // 记录错误信息
            logger.log(Level.SEVERE, "删除留言失败，ID: " + noteId, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "删除留言失败");
            return;
        }

        // 删除后重定向到管理页面
        response.sendRedirect("admin.jsp");
    }
}
