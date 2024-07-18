package com.qst.service.impl;

import com.qst.dao.IUserDao;
import com.qst.dao.impl.UserDaoImpl;
import com.qst.entity.Play;
import com.qst.entity.RandomThing;
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

    @Override
    public User findOnebyName(String username) {
        User user = null;
        try {
            user = userDao.selectOnebyName(username);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return user;
    }



    @Override
    public Play findOnePlay(int uid) {
        Play play = null;
        try {
            play = userDao.selectOnePlay(uid);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return play;
    }

    @Override
    public void addPlay(Play play) {
        try {
            userDao.insertPlay(play);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    @Override
    public void removePlay(int uid) {
        try {
            userDao.deletePlay(uid);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    @Override
    public void editPlay(Play play) {
        try {
            userDao.updatePlay(play);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    @Override
    public RandomThing findOneRandom(int rid) {
        RandomThing randomThing = null;
        try {
            randomThing = userDao.selectOneRandom(rid);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return randomThing;
    }

    @Override
    public int randomNum() throws SQLException {
        int num = userDao.randomNum();
        return num;
    }

    @Override
    public int questionNum() throws SQLException {
        int num = userDao.questionNum();
        return  num;
    }
}
