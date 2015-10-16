package com.d1.alipay;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * ��������̨��Ըñʽ���֧�ֵĶ����ʽ�����
 * @author 3y
 * @version $Id: SupportSecPayChannel.java,v 1.1 2012/06/14 09:54:42 ysw Exp $
 */
public class SupportSecPayChannel {

    private String name;

    private String cashierCode;
    
    public SupportSecPayChannel(){
        
    }
    
    public SupportSecPayChannel(String name, String cashierCode){
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

