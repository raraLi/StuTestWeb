package com.qst.service;

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


}
