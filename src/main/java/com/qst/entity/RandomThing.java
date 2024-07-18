package com.qst.entity;

public class RandomThing {
    private int rid;
    private String rtext;
    private int rhealthy;
    private int rsan;
    private int rmoney;
    private int rtalent;
    private String address;

    public RandomThing(int rid, String rtext, int rhealthy, int rsan, int rmoney, int rtalent,String address) {
        this.rid = rid;
        this.rtext = rtext;
        this.rhealthy = rhealthy;
        this.rsan = rsan;
        this.rmoney = rmoney;
        this.rtalent = rtalent;
        this.address = address;
    }

    public RandomThing() {
    }


    public int getRid() {
        return rid;
    }

    public void setRid(int rid) {
        this.rid = rid;
    }

    public String getRtext() {
        return rtext;
    }

    public void setRtext(String rtext) {
        this.rtext = rtext;
    }

    public int getRhealthy() {
        return rhealthy;
    }

    public void setRhealthy(int rhealthy) {
        this.rhealthy = rhealthy;
    }

    public int getRsan() {
        return rsan;
    }

    public void setRsan(int rsan) {
        this.rsan = rsan;
    }

    public int getRmoney() {
        return rmoney;
    }

    public void setRmoney(int rmoney) {
        this.rmoney = rmoney;
    }

    public int getRtalent() {
        return rtalent;
    }

    public void setRtalent(int rtalent) {
        this.rtalent = rtalent;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
