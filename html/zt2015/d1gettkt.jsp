<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date dStartDate=null;
Date endDate=null;
Date mbrDate=null;
try{
	 dStartDate =fmt.parse("2015-10-1");
	// mbrDate=fmt.parse("2015-01-21");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print("对不起活动已经结束！");
	return;
}
String httpurl=request.getServerName()+request.getRequestURI();
if(lUser==null) {
	
	if(httpurl.startsWith("m.d1.cn")){
		response.sendRedirect("http://m.d1.cn/wap/login.html?url=/html/zt2015/d1gettkt.jsp");
		return;
	}else{
	response.sendRedirect("http://www.d1.com.cn/login.jsp?url=/html/zt2015/d1gettkt.jsp");
	return;
	}
}

//if(lUser.getMbrmst_createdate().getTime()>mbrDate.getTime()) {
//	out.print("优宝贝，非常感谢您的关注，本活动仅限老会员参加，请持续关注D1优尚，下次一定会邀请您参加新的活动~~");
//	return;
//}



String tktcardno="d1tkt150825";


String strtkt=tktcardno+lUser.getId();
Ticket tktcard=(Ticket)Tools.getManager(Ticket.class).findByProperty("tktmst_cardno", strtkt);
try{
	endDate=fmt2.parse("2015-09-30 23:59:59");
}
catch(Exception ex){
	 ex.printStackTrace();
}
if(tktcard == null) {
	//for(int i=0;i<5;i++){
		Ticket tktmst=new Ticket();
		tktmst.setTktmst_value(new Float(30));
		tktmst.setTktmst_type("005009");
		tktmst.setTktmst_mbrid(Tools.parseLong(lUser.getId()));
		tktmst.setTktmst_validflag(new Long(0));
		tktmst.setTktmst_createdate(new Date());
		tktmst.setTktmst_validates(new Date());
		tktmst.setTktmst_validatee(endDate);
		tktmst.setTktmst_rackcode("000");
		tktmst.setTktmst_gdsvalue(new Float(200));
		tktmst.setTktmst_payid(new Long(-1));
		tktmst.setTktmst_cardno(strtkt);
		tktmst.setTktmst_ifcrd(new Long(0));
		tktmst.setTktmst_shopcodes("11111111");
		tktmst.setTktmst_memo("全声券活动--邹！");
		Tools.getManager(Ticket.class).create(tktmst);
		
		Ticket tktmst2=new Ticket();
		tktmst2.setTktmst_value(new Float(120));
		tktmst2.setTktmst_type("005009");
		tktmst2.setTktmst_mbrid(Tools.parseLong(lUser.getId()));
		tktmst2.setTktmst_validflag(new Long(0));
		tktmst2.setTktmst_createdate(new Date());
		tktmst2.setTktmst_validates(new Date());
		tktmst2.setTktmst_validatee(endDate);
		tktmst2.setTktmst_rackcode("017");
		tktmst2.setTktmst_gdsvalue(new Float(200));
		tktmst2.setTktmst_payid(new Long(-1));
		tktmst2.setTktmst_cardno(strtkt);
		tktmst2.setTktmst_ifcrd(new Long(0));
		tktmst2.setTktmst_shopcodes("00000000");
		tktmst2.setTktmst_memo("自营服饰券活动--邹！");
		Tools.getManager(Ticket.class).create(tktmst2);
		
	//}
	String gourl="http://m.d1.cn";
	if(httpurl.startsWith("m.d1.cn"))gourl="http://m.d1.cn";
	Tools.outJs(out,"恭喜您，您已经成功领取1张满200元减30元购物券全场通用、1张满200元减120元购物券自营服饰可用即可在购物流程使用！购物券有效期是2015年09月30日",gourl);

		return;
}else{
//out.print("对不起您已经领过了优惠券！");
Tools.outJs(out,"对不起您已经领过了优惠券！去购物吧","http://m.d1.cn");

}

%>