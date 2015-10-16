<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date dStartDate=null;
Date endDate=Tools.addDate(new Date(), 15);
try{
	 dStartDate =fmt.parse("2014-04-01");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print("{\"success\":false,\"urlflag\":false,\"message\":\"对不起活动已经结束！\"}");
	return;
}
String strSubad = Tools.getCookie(request,"d1.com.cn.peoplercm.subad");
if(Tools.isNull(strSubad)||!strSubad.equals("pcshqc28")){
	out.print("{\"success\":false,\"urlflag\":false,\"message\":\"对不起！你不符合领券条件！\"}");
	return;
}

if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}


float tktvalue=0;
float gdsvalue=0;
String tktrck="000";
String tktcardno="sqc140127";

	tktvalue=50;
	gdsvalue=50;

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
		tktmst.setTktmst_brandname("");
		tktmst.setTktmst_sprckcodeStr("9146,9147,9148,9149,9150");
		tktmst.setTktmst_cardno(strtkt);
		tktmst.setTktmst_ifcrd(new Long(0));
		tktmst.setTktmst_memo("市场活动发清仓券！");
		Tools.getManager(Ticket.class).create(tktmst);
		out.print("{\"success\":false,\"urlflag\":false,\"message\":\"优惠券已发到您的帐户中有效期15天，购物结算时可直接使用！\"}");
		return;

}else{
out.print("{\"success\":false,\"urlflag\":false,\"message\":\"对不起您已经领过了优惠券！\"}");
}
%>