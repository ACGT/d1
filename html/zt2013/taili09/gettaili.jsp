<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
String end="2013-10-01 00:00:00";
if(df.parse(end).before(new Date())){
	out.print("{\"code\":1,\"message\":\"该活动已结束！\"}");
	return;
}

String cardno = request.getParameter("cardno");//商品编号


TaiLi2012 taili=(TaiLi2012)Tools.getManager(TaiLi2012.class).findByProperty("taili2012_cardno", cardno);

if(taili != null) {
	    Tools.setCookie(response,"rcmdusr_rcmid","278",(int)(Tools.DAY_MILLIS/1000*1));
	    
		out.print("{\"success\":true,\"message\":\"台历券刮开成功！\"}");
		return;
	}
else{
out.print("{\"success\":false,\"message\":\"对不起您台历券不存在！\"}");
}

%>