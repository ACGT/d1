<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date dStartDate=null;
Date endDate=null;
try{
	 dStartDate =fmt.parse("2014-01-06");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print("{\"success\":false,\"urlflag\":false,\"message\":\"对不起活动已经结束！\"}");
	return;
}
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}
String tktid = request.getParameter("id");
if (tktid==null){
	tktid="2";
}

float tktvalue=0;
float gdsvalue=0;
String tktrck="017";
String tktcardno="paptnewyear1224";
if(tktid.equals("1")){
	tktrck="000";
	tktvalue=10;
	gdsvalue=10;
}else if(tktid.equals("2")){
	tktvalue=30;
	gdsvalue=200;
}else if(tktid.equals("3")){
	tktvalue=50;
	gdsvalue=300;
}
tktcardno=tktcardno+tktid;

try{
	endDate=Tools.addDate(new Date(), 30);
}
catch(Exception ex){
	 ex.printStackTrace();
}
String strtkt=tktcardno+lUser.getId();
Ticket tktcard=(Ticket)Tools.getManager(Ticket.class).findByProperty("tktmst_cardno", strtkt);

if(tktcard == null) {
		Ticket tktmst=new Ticket();
		tktmst.setTktmst_value(new Float(tktvalue));
		tktmst.setTktmst_type("003005");
		tktmst.setTktmst_mbrid(Tools.parseLong(lUser.getId()));
		tktmst.setTktmst_validflag(new Long(0));
		tktmst.setTktmst_createdate(new Date());
		tktmst.setTktmst_validates(new Date());
		tktmst.setTktmst_validatee(endDate);
		tktmst.setTktmst_rackcode(tktrck);
		tktmst.setTktmst_gdsvalue(new Float(gdsvalue));
		tktmst.setTktmst_payid(new Long(-1));
		tktmst.setTktmst_cardno(strtkt);
		tktmst.setTktmst_ifcrd(new Long(0));
		tktmst.setTktmst_memo("圣诞活动领券！");
		Tools.getManager(Ticket.class).create(tktmst);
		out.print("{\"success\":false,\"urlflag\":false,\"message\":\"优惠券已发到您的帐户中，购物结算时可直接使用！\"}");
		return;
	}
else{
out.print("{\"success\":false,\"urlflag\":false,\"message\":\"对不起您已经领过了优惠券！\"}");
}

%>