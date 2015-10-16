<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date dStartDate=null;
Date endDate=null;
try{
	 endDate=fmt2.parse("2013-03-31 23:59:59");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
String flag="1";//1代表10元通用券，2代表200-40的服装券
if(request.getParameter("flag")!=null)
{
   flag=request.getParameter("flag");
}
if(flag.equals("1"))
{
	float tktvalue=10;
	String tktcardno="mqjs1212ha";

	String strtkt=tktcardno+lUser.getId();
	Ticket ticket=(Ticket)Tools.getManager(Ticket.class).findByProperty("tktmst_cardno", strtkt);
	
	if(ticket == null) {
		Ticket t789=new Ticket();
		t789.setTktmst_createdate(new Date());
		t789.setTktmst_downflag(new Long(1));
		t789.setTktmst_gdsvalue(new Float(10));
		t789.setTktmst_ifcrd(new Long(0));//不是减免券挂出来的
		t789.setTktmst_mbrid(new Long(lUser.getId()));//会员id
		t789.setTktmst_memo("金山10元通用券");
		t789.setTktmst_rackcode("000");
		t789.setTktmst_payid(new Long(-1));//pay id		
		t789.setTktmst_validatee(endDate);
		t789.setTktmst_validates(new Date());
		t789.setTktmst_sodrid("");//订单id
		t789.setTktmst_type("003005");//金山普通券
		t789.setTktmst_value(new Float(tktvalue));
		t789.setTktmst_validflag(new Long(0));//标记为未使用
		t789.setTktmst_uodrid("");
		t789.setTktmst_cardno(strtkt);
		t789.setTktmst_baihuo(new Long(0));
		Tools.getManager(Ticket.class).create(t789);
			out.print("{\"success\":true,\"message\":\"领优惠券成功,请到我的账户中查询！\"}");
			return;
		}
	else{
	    out.print("{\"success\":false,\"message\":\"对不起您已经领过了优惠券！\"}");
	}
}
else
{
	float tktvalue=40;
	String tktcardno="mqjs1212hb";

	String strtkt=tktcardno+lUser.getId();
	Ticket ticket=(Ticket)Tools.getManager(Ticket.class).findByProperty("tktmst_cardno", strtkt);
	
	if(ticket == null) {
		Ticket t789=new Ticket();
		t789.setTktmst_createdate(new Date());
		t789.setTktmst_downflag(new Long(1));
		t789.setTktmst_gdsvalue(new Float(200));
		t789.setTktmst_rackcode("017");
		t789.setTktmst_ifcrd(new Long(0));//不是减免券挂出来的
		t789.setTktmst_mbrid(new Long(lUser.getId()));//会员id
		t789.setTktmst_memo("金山200-40元通用券");
		t789.setTktmst_payid(new Long(-1));//pay id		
		t789.setTktmst_validatee(endDate);
		t789.setTktmst_validates(new Date());
		t789.setTktmst_sodrid("");//订单id
		t789.setTktmst_type("003005");//金山普通券
		t789.setTktmst_value(new Float(tktvalue));
		t789.setTktmst_validflag(new Long(0));//标记为未使用
		t789.setTktmst_uodrid("");
		t789.setTktmst_cardno(strtkt);
		t789.setTktmst_baihuo(new Long(0));
		Tools.getManager(Ticket.class).create(t789);
			out.print("{\"success\":true,\"message\":\"领优惠券成功,请到我的账户中查询！\"}");
			return;
		}
	else{
	    out.print("{\"success\":false,\"message\":\"对不起您已经领过了优惠券！\"}");
	}	
	
}








%>