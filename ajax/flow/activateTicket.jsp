<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="../islogin.jsp" %><%
String CardNo = request.getParameter("CardNo");//卡号
String payId = request.getParameter("payId");//支付ID
String pwd = "www.d1.com.cn";//密码
if(Tools.isNull(CardNo)){
	out.print("{\"success\":false,\"message\":\"优惠券号码错误！\"}");
	return;
}
CardNo=CardNo.trim();
HashMap<String,Object> map = TicketHelper.drawTicket(request,response,CardNo,pwd,payId);
if(map.get("ticket") == null){
	out.print("{\"success\":false,\"message\":\""+(map.get("failreason")!=null?map.get("failreason"):"优惠券错误！")+"\"}");
	return;
}else{
	out.print("{\"success\":true,\"message\":\"激活优惠券成功！\"}");
	return;
}
%>