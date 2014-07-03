package com.cssweb.payment.common;

import java.io.Serializable;

/**
 * Created by chenhf on 2014/6/27.
 */
public class BasicResponse implements Serializable{

    private int retCode;
    private String retMsg;

    public String getRetMsg() {
        return retMsg;
    }

    public void setRetMsg(String retMsg) {
        this.retMsg = retMsg;
    }

    public int getRetCode() {
        return retCode;
    }

    public void setRetCode(int retCode) {
        this.retCode = retCode;
    }
}
