package dao.sqlBean;

public class Note {
    private int id; // 留言ID
    private int userid; // 留言人ID，用 int 类型
    private String title; // 主旨
    private String content; // 内容
    private String email; // 邮箱
    private String ip; // IP地址
    private String writetime; // 留言时间

    // Getter 和 Setter 方法
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() { // 修改为 getUserId
        return userid; // 返回 userid
    }

    public void setUserId(int userid) { // 修改为 setUserId
        this.userid = userid; // 设置 userid
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getWritetime() {
        return writetime;
    }

    public void setWritetime(String writetime) {
        this.writetime = writetime;
    }
}
