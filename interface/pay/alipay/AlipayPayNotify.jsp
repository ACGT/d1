<%@ page language="java" contentType="text/html; charset=UTF-8" import="com.alipay.*"%><%@include file="../../../inc/header.jsp" %><%@include file="../PayConfig.jsp"%><%
String partner = PubConfig.get("AlipayPartner"); //partner合作伙伴id（必须填写）
String privateKey = PubConfig.get("AlipayKey"); //partner 的对应交易安全校验码（必须填写）
//**********************************************************************************
//如果您服务器不支持https交互，可以使用http的验证查询地址		
//String alipayNotifyURL = "https://www.alipay.com/cooperate/gateway.do?service=notify_verify"
String alipayNotifyURL = PubConfig.get("AlipayNotifyQuery")+"?"+ "partner="+ partner+ "&notify_id="+ request.getParameter("notify_id");
//获取支付宝ATN返回结果，true是正确的订单信息，false 是无效的
String responseTxt = CheckURL.check(alipayNotifyURL);

Map<String,String> params = new HashMap<String,String>();
//获得POST 过来参数设置到新的params中
Map requestParams = request.getParameterMap();
Iterator iter = requestParams.keySet().iterator();
while(iter.hasNext()) {
	String name = (String) iter.next();
	String[] values = (String[]) requestParams.get(name);
	String valueStr = "";
	for (int i = 0; i < values.length; i++) {
		valueStr = (i == values.length - 1) ? valueStr + values[i]: valueStr + values[i] + ",";		
	}
	params.put(name, valueStr);
}
			
String mysign = SignatureHelper_return.sign(params, privateKey,"UTF-8");

logInfo("支付宝支付，非即时反馈，"+params.get("body")+"，"+params.get("total_fee"));

if (mysign.equals(request.getParameter("sign")) && "true".equals(responseTxt)){
	System.err.println(request.getParameter("trade_status"));
	if(request.getParameter("trade_status")=="TRADE_FINISHED" ){
		out.println("success");
	}
	
	String payId = (String)params.get("out_trade_no");
	
	OrderBase order = OrderHelper.getById(payId);
	if(order != null && Tools.longValue(order.getOdrmst_orderstatus()) == 0){
		String total_fee = (String)params.get("total_fee");
		double r3_amount = Tools.parseDouble(total_fee);
		
		OrderService os = (OrderService)Tools.getService(OrderService.class);
		int reValue = os.updateOrderStatus(order,r3_amount);
        if(reValue == 0){
        	logInfo("支付宝支付，非即时反馈，订单："+payId+"支付成功！");
        }
	}
}else{
	out.println("fail");
}
%>