package com.d1.alipay;

import org.nuxeo.common.xmap.annotation.XNode;
import org.nuxeo.common.xmap.annotation.XObject;


/**
 * 
 * 
 * @author feng.chenf
 * @version $Id: wapDirectTradeCreateRes.java,v 1.1 2012/06/14 05:26:00 ysw Exp $
 */
@XObject("direct_trade_create_res")
public class wapDirectTradeCreateRes {

    /**
     * 获得的创建交易的RequestToken
     */
    @XNode("request_token")
    private String requestToken;

    public String getRequestToken() {
        return requestToken;
    }

}
