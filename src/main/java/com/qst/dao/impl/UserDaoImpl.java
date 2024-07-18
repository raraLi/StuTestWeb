package com.qst.dao.impl;

import com.qst.dao.IUserDao;
import com.qst.entity.Play;
import com.qst.entity.RandomThing;
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
        String sql = "insert into user (username,password,time,isMaster,state) value (?,?,?,?,?)";

        PreparedStatement statement = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        /*4.执行sql语句*/
        statement.setString(1,user.getUsername());
        statement.setString(2,user.getPassword());
        statement.setString(3,user.getTime());
        statement.setString(4,user.getIsMaster());
        statement.setString(5,user.getState());

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
        String sql = "update user set username = ?,password=?,time=?,isMaster=?,state=? where id = ?";

        PreparedStatement statement = conn.prepareStatement(sql);

        /*4.执行sql语句*/
        statement.setString(1,user.getUsername());
        statement.setString(2,user.getPassword());
        statement.setString(3,user.getTime());
        statement.setString(4,user.getIsMaster());
        statement.setString(5,user.getState());
        statement.setInt(6,user.getId().intValue());

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

    @Override
    public User selectOnebyName(String username) throws SQLException {

        Connection conn = JDBCUtil.getConnection();
        /*3.预：获得sql预编译对象*/
        /*sql*/
        String sql = "select * from user where username = ?";

        PreparedStatement statement = conn.prepareStatement(sql);
        /*4.执行sql语句*/
        statement.setString(1,username);


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
    public void insertPlay(Play play) throws SQLException {

        Connection conn = JDBCUtil.getConnection();

        /*3.预：获得sql预编译对象*/
        /*sql*/
        String sql = "insert into play (uid,age,healthy,san,money,talent) value (?,?,?,?,?,?)";

        PreparedStatement statement = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        /*4.执行sql语句*/
        statement.setInt(1,play.getUid());
        statement.setInt(2,play.getAge());
        statement.setInt(3,play.getHealthy());
        statement.setInt(4,play.getSan());
        statement.setInt(5,play.getMoney());
        statement.setInt(6,play.getTalent());

        statement.executeUpdate();

        /*5.释放资源*/
        JDBCUtil.close(conn,statement,null);

        //添加数据之后，我们希望获得添加数据的ID
    }

    @Override
    public void deletePlay(int uid) throws SQLException {
        Connection conn = JDBCUtil.getConnection();

        /*3.预：获得sql预编译对象*/
        /*sql*/
        String sql = "delete from play where uid = ?";

        PreparedStatement statement = conn.prepareStatement(sql);

        /*4.执行sql语句*/
        statement.setInt(1,uid);

        statement.executeUpdate();

        /*5.释放资源*/
        JDBCUtil.close(conn,statement,null);
    }

    @Override
    public RandomThing selectOneRandom(int rid) throws SQLException {
        Connection conn = JDBCUtil.getConnection();
        /*3.预：获得sql预编译对象*/
        /*sql*/
        String sql = "select * from random where rid = ?";

        PreparedStatement statement = conn.prepareStatement(sql);
        /*4.执行sql语句*/
        statement.setInt(1,rid);
        ResultSet rs = statement.executeQuery();//结果集对象长什么样子
        RandomThing randomThing =null;
        if(rs.next()){//一条数据
            randomThing = createRandom(rs);
        }
        /*5.释放资源*/
        JDBCUtil.close(conn,statement,rs);
        return randomThing;
    }

    @Override
    public int randomNum() throws SQLException {
        Connection conn = JDBCUtil.getConnection();
        /*3.预：获得sql预编译对象*/
        /*sql*/
        String sql = "select * from random";
        int num = 0;
        PreparedStatement statement = conn.prepareStatement(sql);
        /*4.执行sql语句*/
        ResultSet rs = statement.executeQuery();//结果集对象长什么样子
        while(rs.next()){//一条数据
            num++;
        }
        /*5.释放资源*/
        JDBCUtil.close(conn,statement,rs);
        return num;
    }

    @Override
    public int questionNum() throws SQLException {
        Connection conn = JDBCUtil.getConnection();
        /*3.预：获得sql预编译对象*/
        /*sql*/
        String sql = "select * from question";
        int num = 0;
        PreparedStatement statement = conn.prepareStatement(sql);
        /*4.执行sql语句*/
        ResultSet rs = statement.executeQuery();//结果集对象长什么样子
        while(rs.next()){//一条数据
            num++;
        }
        /*5.释放资源*/
        JDBCUtil.close(conn,statement,rs);
        return num;
    }

    @Override
    public void updatePlay(Play play) throws SQLException {
        Connection conn = JDBCUtil.getConnection();

        /*3.预：获得sql预编译对象*/
        /*sql*/
        String sql = "update play set age = ?,healthy=?,san=?,money=?,talent=? where uid = ?";

        PreparedStatement statement = conn.prepareStatement(sql);

        /*4.执行sql语句*/
        statement.setInt(1,play.getAge());
        statement.setInt(2,play.getHealthy());
        statement.setInt(3,play.getSan());
        statement.setInt(4,play.getMoney());
        statement.setInt(5,play.getTalent());
        statement.setInt(6,play.getUid());

        statement.executeUpdate();

        /*5.释放资源*/
        JDBCUtil.close(conn,statement,null);
    }


    @Override
    public Play selectOnePlay(int uid) throws SQLException {
        Connection conn = JDBCUtil.getConnection();
        /*3.预：获得sql预编译对象*/
        /*sql*/
        String sql = "select * from play where uid = ?";

        PreparedStatement statement = conn.prepareStatement(sql);
        /*4.执行sql语句*/
        statement.setInt(1,uid);
        ResultSet rs = statement.executeQuery();//结果集对象长什么样子
        Play play=null;
        if(rs.next()){//一条数据
            play = createPlay(rs);
        }
        /*5.释放资源*/
        JDBCUtil.close(conn,statement,rs);
        return play;
    }

    private User createUser(ResultSet rs) throws SQLException {
        long uId = rs.getLong(1);
        String username = rs.getString(2);
        String pword = rs.getString(3);
        String time = rs.getString(4);
        String isMaster = rs.getString(5);
        String state = rs.getString(6);
        User user = new User();
        user.setId(uId);
        user.setUsername(username);
        user.setPassword(pword);
        user.setTime(time);
        user.setIsMaster(isMaster);
        user.setState(state);
        return user;
    }

    private Play createPlay(ResultSet rs) throws SQLException {
        int uid = rs.getInt(1);
        int age = rs.getInt(2);
        int healthy = rs.getInt(3);
        int san = rs.getInt(4);
        int money = rs.getInt(5);
        int talent = rs.getInt(6);
        Play play = new Play();
        play.setUid(uid);
        play.setAge(age);
        play.setHealthy(healthy);
        play.setSan(san);
        play.setMoney(money);
        play.setTalent(talent);
        return play;
    }

    private RandomThing createRandom(ResultSet rs) throws SQLException{
        int rid = rs.getInt(1);
        String rtext = rs.getString(2);
        int rhealthy = rs.getInt(3);
        int rsan = rs.getInt(4);
        int rmoney = rs.getInt(5);
        int rtalent = rs.getInt(6);
        String address = rs.getString(7);
        RandomThing randomThing = new RandomThing();
        randomThing.setRid(rid);
        randomThing.setRtext(rtext);
        randomThing.setRhealthy(rhealthy);
        randomThing.setRsan(rsan);
        randomThing.setRmoney(rmoney);
        randomThing.setRtalent(rtalent);
        randomThing.setAddress(address);
        return randomThing;
    }

}
