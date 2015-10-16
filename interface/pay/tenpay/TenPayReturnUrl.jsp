<%@ page contentType="text/html; charset=UTF-8" import="com.tenpay.*,com.tenpay.util.*"%><%@include file="../../../inc/header.jsp"%><%@include file="../PayConfig.jsp"%><%
boolean isTest = ("0".equals(PubConfig.get("TenPayRunMode"))?true:false);//是否是测试的。
//密钥
String key = PubConfig.get("TenPaySPKey"+(isTest?"_T":""));

//创建PayResponseHandler实例
ResponseHandler resHandler = new ResponseHandler(request, response);
resHandler.setKey(key);
//判断签名
if(resHandler.isTenpaySign()) {
	//商户交易单号
	String strOutTradeNo = resHandler.getParameter("out_trade_no");
	//财付通流水号
	String transaction_id = resHandler.getParameter("transaction_id");
	
	if(!Tools.isNull(strOutTradeNo)){
		//金额金额,以分为单位
		String strTotalFee = resHandler.getParameter("total_fee");
		//支付结果
		String pay_result = resHandler.getParameter("trade_state");//支付结果0：成功，1：失败
		String strTradeMode = resHandler.getParameter("trade_mode");//交易模式 1-即时到账,其他保留
		
		if("0".equals(pay_result)) {
			
			logInfo("财付通直通：非及时反馈，财付通支付成功，财付通流水号："+transaction_id+"，交易单号："+strOutTradeNo+"，支付金额："+strTotalFee);
			
			OrderBase order = OrderHelper.getById(strOutTradeNo);
			if(order != null){
				if(Tools.longValue(order.getOdrmst_orderstatus()) == 0){
			        double r3_amount = Tools.parseDouble(strTotalFee)/100;
			        
			        OrderService os = (OrderService)Tools.getService(OrderService.class);
			        int reValue = os.updateOrderStatus(order,r3_amount);
			        if(reValue == 0){
			        	logInfo("财付通直通：及时反馈，订单："+strOutTradeNo+"支付成功！");
			        	response.sendRedirect("http://www.d1.com.cn/user/selforder.jsp");
	        			return;
			        }else{
			        	response.sendRedirect("http://www.d1.com.cn/user/selforder.jsp");
	        			return;
			        }
				}else{
					response.sendRedirect("http://www.d1.com.cn/user/selforder.jsp");
        			return;
				}
			}else{
				out.println("订单："+strOutTradeNo+"有误，无法完成支付！");
			}
		}else{
			out.println("支付失败，请联系客服处理！");
		}
	}else{
		out.println("订单号错误，支付失败，请联系客服处理！");
	}
}else{
	out.println("认证签名失败");
}
%>