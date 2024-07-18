package com.qst.entity;

import java.text.SimpleDateFormat;
import java.util.Date;

public class User {

    private Long id;
    private String username;
    private String password;
    private String time;
    private String isMaster;
    private String state;

    public User(Long id, String username, String password, String time, String isMaster, String state) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.time = time;
        this.isMaster = isMaster;
        this.state = state;
    }

    public User() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getIsMaster() {
        return isMaster;
    }

    public void setIsMaster(String isMaster) {
        this.isMaster = isMaster;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", time='" + time + '\'' +
                '}';
    }
    public String getCurrentDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(new Date());
    }


}
