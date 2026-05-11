package dao;

import dao.sqlBean.Note;
import util.DataBaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NoteDAO {
    // 插入留言
    public void insertNote(Note note) {
        String sql = "INSERT INTO note (userid, title, content, email, ip, writetime) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = new DataBaseConnection().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, note.getUserId());
            pstmt.setString(2, note.getTitle());
            pstmt.setString(3, note.getContent());
            pstmt.setString(4, note.getEmail());
            pstmt.setString(5, note.getIp());
            pstmt.setString(6, note.getWritetime());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // 使用日志框架记录错误
        }
    }

    // 根据 ID 查询留言
    public Note queryNoteById(int id) {
        Note note = null;
        String sql = "SELECT * FROM note WHERE id=?";
        try (Connection conn = new DataBaseConnection().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                note = new Note();
                note.setId(rs.getInt("id"));
                note.setUserId(rs.getInt("userid"));
                note.setTitle(rs.getString("title"));
                note.setContent(rs.getString("content"));
                note.setEmail(rs.getString("email"));
                note.setIp(rs.getString("ip"));
                note.setWritetime(rs.getString("writetime"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return note;
    }

    // 更新留言
    public void updateNote(Note note) {
        String sql = "UPDATE note SET title=?, content=? WHERE id=?";
        try (Connection conn = new DataBaseConnection().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, note.getTitle());
            pstmt.setString(2, note.getContent());
            pstmt.setInt(3, note.getId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 删除留言
    public int deleteById(int id) {
        String sql = "DELETE FROM note WHERE id=?";
        try (Connection conn = new DataBaseConnection().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return id;
    }

    // 查询所有留言
    public List<Note> queryAllNotes() {
        List<Note> notes = new ArrayList<>();
        String sql = "SELECT * FROM note";
        try (Connection conn = new DataBaseConnection().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Note note = new Note();
                note.setId(rs.getInt("id"));
                note.setUserId(rs.getInt("userid"));
                note.setTitle(rs.getString("title"));
                note.setContent(rs.getString("content"));
                note.setEmail(rs.getString("email"));
                note.setIp(rs.getString("ip"));
                note.setWritetime(rs.getString("writetime"));
                notes.add(note);
            }
            System.out.println("查询到的留言数量: " + notes.size());
        } catch (SQLException e) {
            System.err.println("数据库操作错误: " + e.getMessage());
        }
        return notes;
    }
}
