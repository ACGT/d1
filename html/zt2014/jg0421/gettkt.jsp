<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date dStartDate=null;
Date endDate=null;
try{
	 dStartDate =fmt.parse("2014-05-5");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print("{\"success\":false,\"urlflag\":false,\"message\":\"对不起活动已经结束！\"}");
	return;
}
String  isPingAn = Tools.getCookie(request,"PINGAN");
if (!Tools.isNull(isPingAn)){
	out.print("{\"success\":false,\"urlflag\":false,\"message\":\"您好，平安用户不能参与领券活动！\"}");
	return;
}
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}

String tktid = request.getParameter("id");
if (tktid==null){
	tktid="1";
}

float tktvalue=0;
float gdsvalue=0;
String tktrck="000";
String tktcardno="pym1404";
if ("2".equals(tktid)){
	tktvalue=20;
	gdsvalue=200;
}else if("3".equals(tktid)){
	tktvalue=30;
	gdsvalue=300;
}else if("4".equals(tktid)){
	tktvalue=50;
	gdsvalue=500;
}else if("5".equals(tktid)){
	tktvalue=100;
	gdsvalue=1000;
}else{
	tktvalue=10;
	gdsvalue=100;
}
String strtkt=tktcardno+lUser.getId();
//Ticket tktcard=(Ticket)Tools.getManager(Ticket.class).findByProperty("tktmst_cardno", strtkt);
try{
	endDate=Tools.addDate(new Date(), 30);
}
catch(Exception ex){
	 ex.printStackTrace();
}
//if(tktcard == null) {
		Ticket tktmst=new Ticket();
		tktmst.setTktmst_value(new Float(tktvalue));
		tktmst.setTktmst_type("005009");
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
		tktmst.setTktmst_shopcodes("11111111");
		tktmst.setTktmst_memo("云秒活动领券！");
		Tools.getManager(Ticket.class).create(tktmst);
		out.print("{\"success\":true,\"urlflag\":false,\"message\":\"优惠券已发到您的帐户中，购物结算时可直接使用！\"}");
		return;
	//}else{
//out.print("{\"success\":false,\"urlflag\":false,\"message\":\"对不起您已经领过了优惠券！\"}");
//}

%>