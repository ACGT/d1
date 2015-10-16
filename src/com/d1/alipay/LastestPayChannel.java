package com.d1.alipay;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 最近使用渠道
 * @author 3y
 * @version $Id: LastestPayChannel.java,v 1.1 2012/06/14 09:53:38 ysw Exp $
 */
public class LastestPayChannel {
    
    private String name;

    private String cashierCode;
    
    public LastestPayChannel() {

    }

    public LastestPayChannel(String name, String cashierCode) {
        this.name = name;
        this.cashierCode = cashierCode;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCashierCode() {
        return cashierCode;
    }

    public void setCashierCode(String cashierCode) {
        this.cashierCode = cashierCode;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SIMPLE_STYLE);
    }

    
}
