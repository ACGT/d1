<%@ page language="java" contentType="text/html; charset=UTF-8" import="com.hisun.iposm.HiiposmUtil"%><%@include file="../../../inc/header.jsp" %><%@include file="../PayConfig.jsp"%><%
try {
	String merchantId = Tools.formatString(request.getParameter("merchantId"));
    String payNo = Tools.formatString(request.getParameter("payNo"));
    String returnCode = Tools.formatString(request.getParameter("returnCode"));
    String message = Tools.formatString(request.getParameter("message"));
    String signType = Tools.formatString(request.getParameter("signType"));
    String type = Tools.formatString(request.getParameter("type"));
    String version = Tools.formatString(request.getParameter("version"));
    String amount = Tools.formatString(request.getParameter("amount"));
    String amtItem = Tools.formatString(request.getParameter("amtItem"));
    String bankAbbr = Tools.formatString(request.getParameter("bankAbbr"));
    String mobile = Tools.formatString(request.getParameter("mobile"));
    String orderId = Tools.formatString(request.getParameter("orderId"));
    String payDate = Tools.formatString(request.getParameter("payDate"));
    String reserved1 = Tools.formatString(request.getParameter("reserved1"));
    String reserved2 = Tools.formatString(request.getParameter("reserved2"));
    String status = Tools.formatString(request.getParameter("status"));
    String orderDate = Tools.formatString(request.getParameter("orderDate"));
    String fee = Tools.formatString(request.getParameter("fee"));
    String hmac = Tools.formatString(request.getParameter("hmac"));
    String accountDate = Tools.formatString(request.getParameter("accountDate"));
    
  	//商户密钥
    String signKey = PubConfig.get("MobileKey");
    
  	//验签报文
    String signData = merchantId + payNo + returnCode + message + signType
          + type + version + amount + amtItem + bankAbbr + mobile 
          + orderId + payDate + accountDate + reserved1 + reserved2 + status
          + orderDate + fee;
  
    HiiposmUtil util = new HiiposmUtil();
    //out.println("验签报文："+signData+"<br/>");
    //验签消息摘要
    String hmac1 = util.MD5Sign(signData, signKey);
    
  	//验签
    boolean sign_flag = util.MD5Verify(signData,hmac,signKey);
  	
    if(sign_flag) {//验签成功
    	String payId = orderId;
    	
    	OrderBase order = OrderHelper.getById(payId);
    	if(order != null){
    		if(Tools.longValue(order.getOdrmst_orderstatus()) == 0){
    			String total_fee = amount;
    			double r3_amount = Tools.parseDouble(total_fee);
    			
    			OrderService os = (OrderService)Tools.getService(OrderService.class);
    			int reValue = os.updateOrderStatus(order,r3_amount);
    	        if(reValue == 0){
    	        	response.sendRedirect("http://www.d1.com.cn/user/orderdetail.jsp?orderid="+payId);
        			return;
    	        }else{
    	        	response.sendRedirect("http://www.d1.com.cn/user/orderdetail.jsp?orderid="+payId);
        			return;
    	        }
    		}else{
    			response.sendRedirect("http://www.d1.com.cn/user/orderdetail.jsp?orderid="+payId);
    			return;
    		}
    	}else{
    		out.println("订单："+payId+"未找到！");
    	}
    }else{
    	out.println("验签失败！");
    }
} catch (Exception e) {
    out.println("交易异常:" + e.getMessage());
}
%>