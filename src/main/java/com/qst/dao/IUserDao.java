package com.qst.dao;

import com.qst.entity.Play;
import com.qst.entity.RandomThing;
import com.qst.entity.User;

import java.sql.SQLException;
import java.util.List;

/*持久层，数据库的持久化操作*/
public interface IUserDao {
    /*定义操作的方法插入数据*/
    Long insert(User user) throws SQLException;
    /*定义操作的方法修改数据*/
    void update(User user) throws SQLException;
    /*定义操作的方法删除数据*/
    void delete(Long id) throws SQLException;
    /*定义操作的方方查询一个数据*/
    User selectOne(Long id) throws SQLException;
    /*定义操作的方方查询所有数据*/
    List<User> selectAll();

    User selectOnebyName(String username) throws SQLException;

    Play selectOnePlay(int uid) throws SQLException;

    void insertPlay(Play play) throws SQLException;

    void deletePlay(int uid) throws SQLException;

    RandomThing selectOneRandom(int rid) throws SQLException;

    int randomNum() throws SQLException;

    void updatePlay(Play play) throws SQLException;

    int questionNum() throws SQLException;
}
