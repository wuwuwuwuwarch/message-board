package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// 主要功能是连接数据库，关闭数据库
public class DataBaseConnection {

    // 定义数据库驱动类
    private static final String DBDRIVER = "com.mysql.cj.jdbc.Driver";
    // 定义数据库连接URL
    private static final String DBURL = "jdbc:mysql://localhost:3306/202203049135_messageboard?serverTimezone=Asia/Shanghai&useSSL=false&allowPublicKeyRetrieval=true&characterEncoding=utf8";
    // 定义数据库连接用户名
    private static final String DBUSER = "root";
    // 定义数据库连接密码
    private static final String DBPASSWORD = "699576";

    // 定义数据库连接对象
    private Connection conn = null;

    // 构造方法，加载驱动程序，得到数据库连接对象
    public DataBaseConnection() {
        try {
            Class.forName(DBDRIVER);
            conn = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
        } catch (ClassNotFoundException e) {
            System.out.println("数据库驱动未找到!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("数据库连接失败! 错误代码: " + e.getErrorCode() + ", 错误信息: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // 取得数据库连接对象
    public Connection getConnection() {
        return conn;
    }

    // 关闭数据库连接
    public void close() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            System.out.println("数据库连接关闭失败! 错误代码: " + e.getErrorCode() + ", 错误信息: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
