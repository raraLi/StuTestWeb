package com.qst.entity;

public class Play {
    private int uid;
    private int age;
    private int healthy;
    private int san;
    private int money;
    private int talent;

    public Play(int uid,int age,int healthy,int san,int money,int talent) {
        this.uid = uid;
        this.age = age;
        this.healthy = healthy;
        this.san = san;
        this.money = money;
        this.talent = talent;
    }

    public Play() {
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public int getHealthy() {
        return healthy;
    }

    public void setHealthy(int healthy) {
        this.healthy = healthy;
    }

    public int getSan() {
        return san;
    }

    public void setSan(int san) {
        this.san = san;
    }

    public int getMoney() {
        return money;
    }

    public void setMoney(int money) {
        this.money = money;
    }

    public int getTalent() {
        return talent;
    }

    public void setTalent(int talent) {
        this.talent = talent;
    }

    public Play setLimit(Play play){
        if(play.getHealthy()>100){
            play.setHealthy(100);
        }if(play.getSan()>100){
            play.setSan(100);
        }if(play.getTalent()>100){
            play.setTalent(100);
        }
        return play;
    }
}
