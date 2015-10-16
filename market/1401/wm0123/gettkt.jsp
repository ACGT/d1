<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%String tktid = request.getParameter("flag");
if (tktid==null){
	tktid="1";
}



SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date dStartDate=null;
Date endDate=null;
try{
	 dStartDate =fmt.parse("2014-2-15");
	 endDate=fmt2.parse("2014-2-14 23:59:59");
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
	if("2".equals(tktid)){
	%>$.inCart.close();Login_Dialog('/newlogin/valitel.jsp');<%
	}else{
		%>$.inCart.close();Login_Dialog();
		<%
	}
	return;
}
if ("2".equals(tktid)&&lUser.getMbrmst_finishdate() !=null){
	 
		out.print("{\"success\":false,\"urlflag\":false,\"message\":\"此券只有新客才可以领取！\"}");
		return;

}
//System.out.println("周年领券手机验证："+lUser.getMbrmst_phoneflag());
if(lUser.getMbrmst_phoneflag()==null||lUser.getMbrmst_phoneflag().longValue()==0&&"2".equals(tktid)){
		session.setAttribute("zntkturl", "/market/1401/wm0123/");
	out.print("{\"success\":false,\"urlflag\":true,\"message\":\"对不起请认证手机然后再来领券！\"}");
	///newlogin/valitel.jsp
	return;
}


float tktvalue=0;
float gdsvalue=0;
String tktrck="000";
String tktcardno="mqwm1401qrja";
if ("2".equals(tktid)){
	tktvalue=15;
	gdsvalue=15;
	tktcardno="mqwm1401qrjb";
}else{
	tktvalue=10;
	gdsvalue=100;
	
}
String strtkt=tktcardno+lUser.getId();
Ticket tktcard=(Ticket)Tools.getManager(Ticket.class).findByProperty("tktmst_cardno", strtkt);

if(tktcard == null) {
		Ticket tktmst=new Ticket();
		tktmst.setTktmst_value(new Float(tktvalue));
		tktmst.setTktmst_type("004003");
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
		tktmst.setTktmst_memo("市场情人节活动领券！");
		Tools.getManager(Ticket.class).create(tktmst);
		out.print("{\"success\":false,\"urlflag\":false,\"message\":\"优惠券已发到您的帐户中，购物结算时可直接使用！\"}");
		return;
	}
else{
out.print("{\"success\":false,\"urlflag\":false,\"message\":\"对不起您已经领过了优惠券！\"}");
}

%>