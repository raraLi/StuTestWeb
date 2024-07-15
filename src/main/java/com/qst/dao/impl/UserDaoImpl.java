package com.qst.dao.impl;

import com.qst.dao.IUserDao;
import com.qst.entity.User;
import com.qst.util.JDBCUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/*持久层的代码，测试使用这个代码，操作数据库*/
public class UserDaoImpl implements IUserDao {
    @Override
    public Long insert(User user) throws SQLException {

        Connection conn = JDBCUtil.getConnection();

        /*3.预：获得sql预编译对象*/
        /*sql*/
        String sql = "insert into user (username,password,intro) value (?,?,?)";

        PreparedStatement statement = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        /*4.执行sql语句*/
        statement.setString(1,user.getUsername());
        statement.setString(2,user.getPassword());
        statement.setString(3,user.getIntro());

        statement.executeUpdate();
        //Integer.toUnsignedLong  把int值转换成Long
        long id = Integer.toUnsignedLong(JDBCUtil.getGeneratedInt(statement));

        /*5.释放资源*/
        JDBCUtil.close(conn,statement,null);

        //添加数据之后，我们希望获得添加数据的ID
        return id;
    }

    @Override
    public void update(User user) throws SQLException {
        Connection conn = JDBCUtil.getConnection();

        /*3.预：获得sql预编译对象*/
        /*sql*/
        String sql = "update user set username = ?,password=?,intro=? where id = ?";

        PreparedStatement statement = conn.prepareStatement(sql);

        /*4.执行sql语句*/
        statement.setString(1,user.getUsername());
        statement.setString(2,user.getPassword());
        statement.setString(3,user.getIntro());
        statement.setInt(4,user.getId().intValue());

        statement.executeUpdate();

        /*5.释放资源*/
        JDBCUtil.close(conn,statement,null);

    }

    @Override
    public void delete(Long id) throws SQLException {
        Connection conn = JDBCUtil.getConnection();

        /*3.预：获得sql预编译对象*/
        /*sql*/
        String sql = "delete from user where id = ?";

        PreparedStatement statement = conn.prepareStatement(sql);

        /*4.执行sql语句*/
        statement.setLong(1,id);

        statement.executeUpdate();

        /*5.释放资源*/
        JDBCUtil.close(conn,statement,null);
    }

    @Override
    public User selectOne(Long id) throws SQLException {

        Connection conn = JDBCUtil.getConnection();
        /*3.预：获得sql预编译对象*/
        /*sql*/
        String sql = "select * from user where id = ?";

        PreparedStatement statement = conn.prepareStatement(sql);
        /*4.执行sql语句*/
        statement.setInt(1,id.intValue());


        ResultSet rs = statement.executeQuery();//结果集对象长什么样子
        User user=null;
        if(rs.next()){//一条数据
            user = createUser(rs);
        }
        /*5.释放资源*/
        JDBCUtil.close(conn,statement,rs);
        return user;
    }

    @Override
    public List<User> selectAll()  {

        /*3.预：获得sql预编译对象*/
        /*sql*/
        String sql = "select * from user";
        ResultSet rs =null;
        PreparedStatement statement = null;
        Connection conn =null;
        List<User> list = null;
        try {
            conn = JDBCUtil.getConnection();
            statement = conn.prepareStatement(sql);
            /*4.执行sql语句*/

            rs = statement.executeQuery();//结果集对象长什么样子
            list = new ArrayList<>();
            while(rs.next()){//一条数据
                User user = createUser(rs);
                list.add(user);
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            /*5.释放资源*/
            JDBCUtil.close(conn,statement,rs);
        }



        return list;
    }

    private User createUser(ResultSet rs) throws SQLException {
        long uId = rs.getLong(1);
        String username = rs.getString(2);
        String pword = rs.getString(3);
        String intro = rs.getString(4);
        User user = new User();
        user.setId(uId);
        user.setUsername(username);
        user.setPassword(pword);
        user.setIntro(intro);
        return user;
    }

}
