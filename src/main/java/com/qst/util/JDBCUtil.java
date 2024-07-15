package com.qst.util;

import java.sql.*;

public class JDBCUtil {

    /*1. 数据库链接信息*/
    private static String url = "jdbc:mysql://localhost:3306/rich?characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true";
    private static String userName = "root";
    private static String password = "root";

    /*2. 加载数据库驱动*/
    static{
        try {
            com.mysql.cj.jdbc.Driver.class.newInstance();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }


    public static Connection getConnection() throws SQLException {
        Connection conn = DriverManager.getConnection(url, userName, password);
        return conn;
    }

    public static void close(Connection conn, Statement statement, ResultSet rs) {
        if(conn!=null){
            try {
                conn.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        if(statement!=null){
            try {
                statement.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        if(rs!=null){
            try {
                rs.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }

    /*根据预编译对象，插入修改数据，啥的，获取ID*/
    public static int getGeneratedInt(Statement stmt) throws SQLException {
        ResultSet rs = stmt.getGeneratedKeys();
        rs.next();
        return rs.getInt(1);

    }

}
