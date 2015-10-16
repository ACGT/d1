package com.d1.alipay;

import java.util.List;



/**
 * 无线收银台针对该笔交易支持的一级资金渠道
 * @author 3y
 * @version $Id: SupportTopPayChannel.java,v 1.1 2012/06/14 09:54:47 ysw Exp $
 */
public class SupportTopPayChannel {

    private String                     name;
    
    private String                     cashierCode;

    private List<SupportSecPayChannel> supportSecPayChannelList;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<SupportSecPayChannel> getSupportSecPayChannelList() {
        return supportSecPayChannelList;
    }

    public void setSupportSecPayChannelList(List<SupportSecPayChannel> supportSecPayChannelList) {
        this.supportSecPayChannelList = supportSecPayChannelList;
    }

    public String getCashierCode() {
        return cashierCode;
    }

    public void setCashierCode(String cashierCode) {
        this.cashierCode = cashierCode;
    }

}

