<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date dStartDate=null;
Date endDate=null;
try{
	 dStartDate =fmt.parse("2012-3-16");
	 endDate=fmt2.parse(fmt.format(new Date())+" 23:59:59");
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

String tktid = request.getParameter("id");
if (tktid==null){
	tktid="3";
}
float tktvalue=0;
float gdsvalue=0;
if ("1".equals(tktid)){
	tktvalue=100;
	gdsvalue=1000;
}else if("2".equals(tktid)){
	tktvalue=50;
	gdsvalue=500;
}else{
	tktvalue=20;
	gdsvalue=200;
}
String strtkt="ptactall"+Tools.getFormatDate(new Date().getTime(), "yyyyMMdd")+lUser.getId()+tktid;
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
		tktmst.setTktmst_rackcode("015002");
		tktmst.setTktmst_gdsvalue(new Float(gdsvalue));
		tktmst.setTktmst_payid(new Long(-1));
		tktmst.setTktmst_cardno(strtkt);
		tktmst.setTktmst_ifcrd(new Long(0));
		tktmst.setTktmst_memo("Zippo名表军刀活动赠券！");
		Tools.getManager(Ticket.class).create(tktmst);
		out.print("{\"success\":false,\"message\":\"成功！\"}");
		return;
	}
else{
out.print("{\"success\":false,\"message\":\"对不起您今天您已经领过了优惠券！\"}");
}

%>