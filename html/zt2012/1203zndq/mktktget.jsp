<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date endDate=null;
try{

	 endDate=fmt2.parse("2012-4-15 23:59:59");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(endDate)<System.currentTimeMillis())
{
	out.print("{\"success\":false,\"message\":\"对不起活动已经结束！\"}");
	return;
}
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>Login_Dialog();<%
	return;
}
PingAnUser pauser=(PingAnUser)Tools.getManager(PingAnUser.class).findByProperty("mbrmstpingan_mbrid", Tools.parseLong(lUser.getId()));
if(pauser!=null){
	out.print("{\"success\":false,\"message\":\"对不起平安会员不能参与此活动！\"}");
	return;
}



String cardno="mzn1203"+Tools.getFormatDate(new Date().getTime(), "yyyyMMdd")+lUser.getId();
TicketCrd tktcrd2=(TicketCrd)Tools.getManager(TicketCrd.class).findByProperty("tktcrd_cardno", cardno);

if(tktcrd2 == null) {
	 TicketCrd tktcrd=new TicketCrd();
	 tktcrd.setTktcrd_cardno(cardno);
	 tktcrd.setTktcrd_mbrid(Tools.parseLong(lUser.getId()));
	 tktcrd.setTktcrd_value(new Long(100));
	 tktcrd.setTktcrd_realvalue(new Long(100));
	 tktcrd.setTktcrd_discount(new Float(0.15));
	 tktcrd.setTktcrd_type("004001");
	 tktcrd.setTktcrd_createdate(new Date());
	 tktcrd.setTktcrd_validflag(new Long(1));
	 tktcrd.setTktcrd_enddate(endDate);
	 tktcrd.setTktcrd_validates(new Date());
	 tktcrd.setTktcrd_validatee(endDate);
	 tktcrd.setTktcrd_memo("9周年市场活动领券！");
	 tktcrd.setTktcrd_payid(new Long(-1));
	 Tools.getManager(TicketCrd.class).create(tktcrd);
	out.print("{\"success\":false,\"message\":\"您已成功领取100元优惠券，请到您的账户查看！\"}");
		return;
	}
else{
out.print("{\"success\":false,\"message\":\"对不起您已经领过了优惠券！\"}");
}

%>