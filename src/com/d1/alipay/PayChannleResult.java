package com.d1.alipay;

import java.util.List;



/**
 * 无线收银台针对该笔交易支持的一级资金渠道
 * @author 3y
 *
 * @version $Id: PayChannleResult.java,v 1.1 2012/06/14 09:54:10 ysw Exp $
 */
public class PayChannleResult {

    private LastestPayChannel          lastestPayChannel;
    
    private List<SupportTopPayChannel> supportedPayChannelList;

    public LastestPayChannel getLastestPayChannel() {
        return lastestPayChannel;
    }

    public void setLastestPayChannel(LastestPayChannel lastestPayChannel) {
        this.lastestPayChannel = lastestPayChannel;
    }

    public List<SupportTopPayChannel> getSupportedPayChannelList() {
        return supportedPayChannelList;
    }

    public void setSupportedPayChannelList(List<SupportTopPayChannel> supportedPayChannelList) {
        this.supportedPayChannelList = supportedPayChannelList;
    }

    

}

