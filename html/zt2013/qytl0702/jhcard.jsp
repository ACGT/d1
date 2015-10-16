<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
String strgdsdh_code = request.getParameter("cardno");
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}
Tuandh tuandh=null;
	 tuandh=(Tuandh)Tools.getManager(Tuandh.class).findByProperty("tuandh_cardno", strgdsdh_code);
	if(tuandh==null||tuandh.getTuandh_mid().longValue()!=5){
		out.print("{\"code\":1,message:\"该台历号不存在！\"}");
		return;
	}
	if(tuandh.getTuandh_status().longValue()==2){
		out.print("{\"code\":1,message:\"该台历号已经用过！\"}");
		return;
	}
	if(Tools.dateValue(tuandh.getTuandh_endtime())<System.currentTimeMillis())
	{
		out.print("{\"code\":1,message:\"该台历活动已经结束！\"}");
		return;
	}
	session.setAttribute("tlcardno", strgdsdh_code);
	out.print("{\"code\":1,message:\"激活成功！\"}");
%>