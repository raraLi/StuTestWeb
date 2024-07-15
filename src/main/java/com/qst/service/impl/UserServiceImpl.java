package com.qst.service.impl;

import com.qst.dao.IUserDao;
import com.qst.dao.impl.UserDaoImpl;
import com.qst.entity.User;
import com.qst.service.IUserService;

import java.sql.SQLException;
import java.util.List;
//业务逻辑处理
public class UserServiceImpl implements IUserService {
    private IUserDao userDao = new UserDaoImpl();

    @Override
    public List<User> findAll() {

        List<User> users = userDao.selectAll();
        return users;
    }

    @Override
    public Long add(User user) {
        try {
            return userDao.insert(user);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return null;
    }

    @Override
    public void edit(User user) {
        try {
            userDao.update(user);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    @Override
    public void remove(Long id) {
        try {
            userDao.delete(id);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    @Override
    public User findOne(Long id) {
        User user = null;
        try {
            user = userDao.selectOne(id);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return user;
    }
}
