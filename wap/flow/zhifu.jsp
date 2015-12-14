<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%>
<%
if(!Tools.isNull(request.getParameter("payId")) && !Tools.isNull(request.getParameter("OdrID"))){
	int payId=Integer.parseInt(request.getParameter("payId"));
	/*
	int p=0;
	switch (payId){
	case 4:
	case 6:
	case 25:
	case 26:
	case 27:
	case 34:
	case 35:
	case 36:
	case 37:
	case 38:
	case 39:
	case 40:
	case 41:
	case 42:
	case 43:
		p=2;
		break;
	case 20:
		p=4;
		break;
	case 21:
		p=3;
		break;
	case 14:
	case 31:
		p=5;
		break;
	case 33:
		p=1;
	case 60:
		p=6;
		break;
}
	*/
	switch(payId){
	case 1:
		response.sendRedirect("/interface/pay/mobile/mobileRequest.jsp?OdrID="+request.getParameter("OdrID"));
		
		break;
	case 2:
		response.sendRedirect("/interface/pay/tenpay/TenPayRequest.jsp?OdrID="+request.getParameter("OdrID"));
		
		break;
	case 3:
		response.sendRedirect("/interface/pay/99bill/99billRequest.jsp?OdrID="+request.getParameter("OdrID"));
		
		break;
	case 4:
		//response.sendRedirect("/interface/pay/alipay/AlipayRequest.jsp?OdrID="+request.getParameter("OdrID"));
		response.sendRedirect("/interface/pay/wapalipay/Trade.jsp?OdrID="+request.getParameter("OdrID"));

		break;
		
	case 5:
		response.sendRedirect("/interface/pay/yeepay/YeepayRequest.jsp?OdrID="+request.getParameter("OdrID"));
		
		break;
	case 6:
		response.sendRedirect("/pingan/pay.jsp?OdrID="+request.getParameter("OdrID"));
		break;
	case 7:
		response.sendRedirect("http://baidupaymentgateway.d1.cn/baidu_wap_payment_gateway.aspx?goods_name="+request.getParameter("OdrID"));
		break;
	default:
		out.print("在线支付方式错误，请联系客服处理！");
		//obj.disabled = false;
}
}
%>