package com.web.common.user;

import java.sql.Timestamp;

public class UserConnectDTO {

    protected String userId="";
    protected String connDt="";
    protected int connCnt=0;
    protected String connIp="";

    /**
     * get userId.
     *
     * @return      userId
     */
    public String getUserId() {
        return  this.userId;
    }

    /**
     * set userId.
     *
     * @param       userId
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }

    /**
     * get connDt.
     *
     * @return      connDt
     */
    public String getConnDt() {
        return  this.connDt;
    }

    /**
     * set connDt.
     *
     * @param       connDt
     */
    public void setConnDt(String connDt) {
        this.connDt = connDt;
    }

    /**
     * get connCnt.
     *
     * @return      connCnt
     */
    public int getConnCnt() {
        return  this.connCnt;
    }

    /**
     * set connCnt.
     *
     * @param       connCnt
     */
    public void setConnCnt(int connCnt) {
        this.connCnt = connCnt;
    }

    /**
     * get connIp.
     *
     * @return      connIp
     */
    public String getConnIp() {
        return  this.connIp;
    }

    /**
     * set connIp.
     *
     * @param       connIp
     */
    public void setConnIp(String connIp) {
        this.connIp = connIp;
    }

    /**
     * toString 
     *
     * @return  String 
     */
    public String toString() {
        return  "userId="+userId+",connDt="+connDt+",connCnt="+connCnt+",connIp="+connIp;
    }

    }
