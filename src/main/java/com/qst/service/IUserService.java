package com.qst.service;

import com.qst.entity.Play;
import com.qst.entity.RandomThing;
import com.qst.entity.User;

import java.sql.SQLException;
import java.util.List;

public interface IUserService {
    List<User> findAll();
    /*定义操作的方法插入数据*/
    Long add(User user);
    /*定义操作的方法修改数据*/
    void edit(User user);
    /*定义操作的方法删除数据*/
    void remove(Long id);
    /*定义操作的方方查询一个数据*/
    User findOne(Long id);
    /*根据用户名查询一条数据*/
    User findOnebyName(String username);


    /*查询用户游戏数据*/
    Play findOnePlay(int uid);
    void addPlay(Play play);
    void removePlay(int uid);
    void editPlay(Play play);

    RandomThing findOneRandom(int rid);
    int randomNum() throws SQLException;

    int questionNum() throws SQLException;
}
