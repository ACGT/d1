<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date dStartDate=null;
Date endDate=null;
try{
	 dStartDate =fmt.parse("2012-10-01");
	 endDate=fmt2.parse("2012-09-30 23:59:59");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print("{\"success\":false,\"message\":\"对不起活动已经结束！\"}");
	return;
}
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}


float tktvalue=100;
String tktcardno="pa1207hd";

String strtkt=tktcardno+lUser.getId();
TicketCrd tktcard=(TicketCrd)Tools.getManager(TicketCrd.class).findByProperty("tktcrd_cardno", strtkt);

if(tktcard == null) {
	TicketCrd t=new TicketCrd();
	t.setTktcrd_mbrid(new Long(lUser.getId()));
	t.setTktcrd_cardno(strtkt);
	t.setTktcrd_createdate(new Date());
	t.setTktcrd_value(new Long(100));
	t.setTktcrd_realvalue(new Long(100));
	t.setTktcrd_discount(Tools.getFloat(0.15f, 2));
	t.setTktcrd_type("003005");
	t.setTktcrd_validflag(new Long(1));
	t.setTktcrd_enddate(endDate);
	t.setTktcrd_validatee(endDate);
	t.setTktcrd_validates(new Date());
	t.setTktcrd_rackcode("017");
	t.setTktcrd_payid(new Long(-1));
	t.setTktcrd_memo("平安100元服装券！");
	
	
		Tools.getManager(TicketCrd.class).create(t);
		out.print("{\"success\":false,\"message\":\"领优惠券成功！\"}");
		return;
	}
else{
out.print("{\"success\":false,\"message\":\"对不起您已经领过了优惠券！\"}");
}

%>