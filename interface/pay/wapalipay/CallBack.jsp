<%@ page contentType="text/html; charset=UTF-8" import="com.d1.alipay.*"%><%@include file="/inc/header.jsp"%>
<%
/**接收支付宝回调参数*/
String sign = request.getParameter("sign");
String result = request.getParameter("result");
String requestToken = request.getParameter("request_token");
String outTradeNo = request.getParameter("out_trade_no");
String tradeNo = request.getParameter("trade_no");
Map<String,String> resMap  = new HashMap<String,String>();
resMap.put("result", result);
resMap.put("request_token", requestToken);
resMap.put("out_trade_no", outTradeNo);
resMap.put("trade_no", tradeNo);
/**得到验签数据*/
String verifyData = wapParameterUtil.getSignData(resMap);
boolean verified = false;

try {
	/**使用MD5验签名*/
    verified = wapMD5Signature.verify(verifyData, sign, AlipayConfig.key);
    response.setContentType("text/html");
    if (!verified || !result.equals("success")) {
    	/**验签失败商户业务逻辑处理*/
    	out.println("参数验证未通过！");
    } else {
    	/**验签成功商户业务逻辑处理*/
    	OrderBase order = OrderHelper.getById(outTradeNo);
    	if(order != null){
    		/**
    		if(Tools.longValue(order.getOdrmst_orderstatus()) == 0){
    		
    			double r3_amount = Tools.doubleValue(order.getOdrmst_acturepaymoney());
    			
    			OrderService os = (OrderService)Tools.getService(OrderService.class);
    			int reValue = os.updateOrderStatus(order,r3_amount);
    	        if(reValue == 0){
    	        	
    	        	response.sendRedirect("http://www.d1.com.cn/user/orderdetail.jsp?orderid="+outTradeNo);
    				return;
    	        }else{
    	        	response.sendRedirect("http://www.d1.com.cn/user/orderdetail.jsp?orderid="+outTradeNo);
    				return;
    	        }
    		}else{
    			response.sendRedirect("http://www.d1.com.cn/user/orderdetail.jsp?orderid="+outTradeNo);
    			return;
    		}
    		**/
    		response.sendRedirect("http://m.d1.cn/wap/user/orderdetail.html?odrid="+outTradeNo);
			return;
    	}else{
    		out.println("订单："+outTradeNo+"未找到！");
    	}
    }
    out.flush();
	out.close();
} catch (Exception e) {
    e.printStackTrace();
}


%>