<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date dStartDate=null;
Date endDate=Tools.addDate(new Date(), 30);
String httpurl=request.getServerName()+request.getRequestURI();
if(lUser==null) {
	if(httpurl.startsWith("m.d1.cn")){
		out.print("{\"success\":false,\"urlflag\":true,\"gourl\":\"/wap/login.html?url=/wap/etkt.html\",\"message\":\"\"}");
		return;
	}else{
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog('/html/zt2013/etkt0708/');<%
	return;
	}
}


float tktvalue=0;
float gdsvalue=0;
String tktrck="017";
String tktcardno="paetkt130708";

	tktvalue=30;
	gdsvalue=30;

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
		tktmst.setTktmst_memo("手机扑克领券！");
		Tools.getManager(Ticket.class).create(tktmst);
		out.print("{\"success\":false,\"urlflag\":false,\"message\":\"优惠券已发到您的帐户中有效期1个月，购物结算时可直接使用！\"}");
		return;
	}
else{
out.print("{\"success\":false,\"urlflag\":false,\"message\":\"对不起您已经领过了优惠券！\"}");
}

%>