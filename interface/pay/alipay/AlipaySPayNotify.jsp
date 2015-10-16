<%@ page language="java" contentType="text/html; charset=UTF-8" import="com.alipay.util.AlipayNotify"%><%@include file="../../../inc/header.jsp" %><%@include file="../PayConfig.jsp"%><%
//获取支付宝POST过来反馈信息
Map<String,String> params = new HashMap<String,String>();
Map requestParams = request.getParameterMap();
for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
	String name = (String) iter.next();
	String[] values = (String[]) requestParams.get(name);
	String valueStr = "";
	for (int i = 0; i < values.length; i++) {
		valueStr = (i == values.length - 1) ? valueStr + values[i]
				: valueStr + values[i] + ",";
	}
	//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
	//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "UTF-8");
	params.put(name, valueStr);
}



//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//

String trade_no = request.getParameter("trade_no");				//支付宝交易号
String order_no = request.getParameter("out_trade_no");	        //获取订单号
String total_fee = request.getParameter("price");		        //获取总金额
String trade_status = request.getParameter("trade_status");		//交易状态

//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//

if(AlipayNotify.verify(params)){//验证成功
	//////////////////////////////////////////////////////////////////////////////////////////
	//请在这里加上商户的业务逻辑程序代码

	//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
	
	if(trade_status.equals("WAIT_BUYER_PAY")){
		//该判断表示买家已在支付宝交易管理中产生了交易记录，但没有付款
		
			//判断该笔订单是否在商户网站中已经做过处理（可参考“集成教程”中“3.4返回数据处理”）
				//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				//如果有做过处理，不执行商户的业务程序
			
			out.println("success");	//请不要修改或删除
		} else if(trade_status.equals("WAIT_SELLER_SEND_GOODS")){
		//该判断表示买家已在支付宝交易管理中产生了交易记录且付款成功，但卖家没有发货
		
			//判断该笔订单是否在商户网站中已经做过处理（可参考“集成教程”中“3.4返回数据处理”）
				//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				//如果有做过处理，不执行商户的业务程序
			
			//执行付款操作
			String payId = trade_no;
			OrderBase order = OrderHelper.getById(payId);
			if(order != null && Tools.longValue(order.getOdrmst_orderstatus()) == 0){
				double r3_amount = Tools.parseDouble(total_fee);
				
				OrderService os = (OrderService)Tools.getService(OrderService.class);
				int reValue = os.updateOrderStatus(order,r3_amount);
		        if(reValue == 0){
		        	logInfo("支付宝双接口，非及时反馈，订单："+payId+"支付成功！");
		        }
			}
			out.println("success");	//请不要修改或删除
		} else if(trade_status.equals("WAIT_BUYER_CONFIRM_GOODS")){
		//该判断表示卖家已经发了货，但买家还没有做确认收货的操作
		
			//判断该笔订单是否在商户网站中已经做过处理（可参考“集成教程”中“3.4返回数据处理”）
				//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				//如果有做过处理，不执行商户的业务程序
			
			out.println("success");	//请不要修改或删除
		} else if(trade_status.equals("TRADE_FINISHED")){
		//该判断表示买家已经确认收货，这笔交易完成
		
			//判断该笔订单是否在商户网站中已经做过处理（可参考“集成教程”中“3.4返回数据处理”）
				//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				//如果有做过处理，不执行商户的业务程序
			
			out.println("success");	//请不要修改或删除
		}
		else {
			out.println("success");	//请不要修改或删除
		}

	//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

	//////////////////////////////////////////////////////////////////////////////////////////
}else{//验证失败
	out.println("fail");
}
%>