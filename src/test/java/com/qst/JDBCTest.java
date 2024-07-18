package com.qst;

import com.qst.dao.IUserDao;
import com.qst.dao.impl.UserDaoImpl;
import com.qst.entity.User;
import org.junit.Test;

import java.sql.*;
import java.util.List;

public class JDBCTest {
    /*JDBC
     * 贾（加），连，预，执，释
     * */

    /*写*/

    @Test
    public void testAdd() throws IllegalAccessException, InstantiationException, SQLException {
        for (int i = 1;i<=10;i++){
            /*1.贾： 加载驱动*/
            com.mysql.cj.jdbc.Driver.class.newInstance();
            /*2.连： 建立链接,*/
            String url = "jdbc:mysql://localhost:3306/rich?characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true";
            String userName = "root";
            String password = "root";
            Connection conn = DriverManager.getConnection(url, userName, password);
            /*3.预：获得sql预编译对象*/
            /*sql*/
            String sql = "insert into user (username,password,intro) value (?,?,?)";

            PreparedStatement statement = conn.prepareStatement(sql);

            /*4.执行sql语句*/
            statement.setString(1,"牛牛");
            statement.setString(2,"999999");
            statement.setString(3,"好牛");
            statement.execute();
            /*5.释放资源*/
            statement.close();
            conn.close();
        }


    }

    /*写*/

    @Test
    public void testDelete() throws IllegalAccessException, InstantiationException, SQLException {
        /*1.贾： 加载驱动*/
        com.mysql.cj.jdbc.Driver.class.newInstance();
        /*2.连： 建立链接,*/
        String url = "jdbc:mysql://localhost:3309/test?characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true";
        String userName = "root";
        String password = "123456";
        Connection conn = DriverManager.getConnection(url, userName, password);
        /*3.预：获得sql预编译对象*/
        /*sql*/
        String sql = "delete from user where id = ?";

        PreparedStatement statement = conn.prepareStatement(sql);

        /*4.执行sql语句*/
        statement.setInt(1,1);
        statement.execute();
        /*5.释放资源*/
        statement.close();
        conn.close();

    }

    /*写*/

    @Test
    public void testUpdate() throws IllegalAccessException, InstantiationException, SQLException {
        /*1.贾： 加载驱动*/
        com.mysql.cj.jdbc.Driver.class.newInstance();
        /*2.连： 建立链接,*/
        String url = "jdbc:mysql://localhost:3309/test?characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true";
        String userName = "root";
        String password = "123456";
        Connection conn = DriverManager.getConnection(url, userName, password);
        /*3.预：获得sql预编译对象*/
        /*sql*/
        String sql = "update user set username=?,password=? where id = 2";

        PreparedStatement statement = conn.prepareStatement(sql);

        /*4.执行sql语句*/
        statement.setString(1,"猪猪");
        statement.execute();
        /*5.释放资源*/
        statement.close();
        conn.close();

    }


    @Test
    public void testSelectOne() throws IllegalAccessException, InstantiationException, SQLException {
        /*1.贾： 加载驱动*/
        com.mysql.cj.jdbc.Driver.class.newInstance();
        /*2.连： 建立链接,*/
        String url = "jdbc:mysql://localhost:3309/test?characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true";
        String userName = "root";
        String password = "123456";
        Connection conn = DriverManager.getConnection(url, userName, password);
        /*3.预：获得sql预编译对象*/
        /*sql*/
        String sql = "select * from user where id = ?";

        PreparedStatement statement = conn.prepareStatement(sql);

        /*4.执行sql语句*/
        statement.setInt(1,2);
        ResultSet rs = statement.executeQuery();//结果集对象长什么样子
        if(rs.next()){//一条数据
            long id = rs.getLong(1);
            String username = rs.getString(2);
            String pword = rs.getString(3);
            String intro = rs.getString(4);

            System.out.println("id:"+id);
            System.out.println("username:"+username);
            System.out.println("password:"+pword);
            System.out.println("intro:"+intro);
        }
        /*5.释放资源*/
        rs.close();
        statement.close();
        conn.close();

    }


    @Test
    public void testSelectAll() throws IllegalAccessException, InstantiationException, SQLException {
        /*1.贾： 加载驱动*/
        com.mysql.cj.jdbc.Driver.class.newInstance();
        /*2.连： 建立链接,*/
        String url = "jdbc:mysql://localhost:3306/test?characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true";
        String userName = "root";
        String password = "root";
        Connection conn = DriverManager.getConnection(url, userName, password);
        /*3.预：获得sql预编译对象*/
        /*sql*/
        String sql = "select * from user";

        PreparedStatement statement = conn.prepareStatement(sql);

        /*4.执行sql语句*/
        //statement.setInt(1,2);
        ResultSet rs = statement.executeQuery();//结果集对象长什么样子
        while(rs.next()){//一条数据
            long id = rs.getLong(1);
            String username = rs.getString(2);
            String pword = rs.getString(3);
            String intro = rs.getString(4);
            System.out.println("id:"+id+",username:"+username+",password:"+pword+",intro:"+intro);
        }
        /*5.释放资源*/
        rs.close();
        statement.close();
        conn.close();

    }


    private IUserDao userDao = new UserDaoImpl();




    @Test
    public void testUserDaoSelectOne() throws SQLException {

        User user = userDao.selectOne(1L);
        System.out.println(user);

    }


    @Test
    public void testUserDaoSelectALL() throws SQLException {

        List<User> users = userDao.selectAll();
        for(User user:users){
            System.out.println(user);
        }

    }


}
