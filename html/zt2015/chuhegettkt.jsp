<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date dStartDate=null;
Date endDate=null;
Date mbrDate=null;
try{
	 dStartDate =fmt.parse("2015-12-31");
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
		response.sendRedirect("http://m.d1.cn/wap/login.html?url=/html/zt2015/chuhegettkt.jsp");
		return;
	}else{
	response.sendRedirect("http://www.d1.com.cn/login.jsp?url=/html/zt2015/chuhegettkt.jsp");
	return;
	}
}

//if(lUser.getMbrmst_createdate().getTime()>mbrDate.getTime()) {
//	out.print("优宝贝，非常感谢您的关注，本活动仅限老会员参加，请持续关注D1优尚，下次一定会邀请您参加新的活动~~");
//	return;
//}



String tktcardno="chuhe150819";


String strtkt=tktcardno+lUser.getId();
Ticket tktcard=(Ticket)Tools.getManager(Ticket.class).findByProperty("tktmst_cardno", strtkt);
try{
	endDate=fmt2.parse("2015-12-31 23:59:59");
}
catch(Exception ex){
	 ex.printStackTrace();
}
if(tktcard == null) {
	//for(int i=0;i<5;i++){
		Ticket tktmst=new Ticket();
		tktmst.setTktmst_value(new Float(10));
		tktmst.setTktmst_type("005009");
		tktmst.setTktmst_mbrid(Tools.parseLong(lUser.getId()));
		tktmst.setTktmst_validflag(new Long(0));
		tktmst.setTktmst_createdate(new Date());
		tktmst.setTktmst_validates(new Date());
		tktmst.setTktmst_validatee(endDate);
		tktmst.setTktmst_rackcode("000");
		tktmst.setTktmst_gdsvalue(new Float(50));
		tktmst.setTktmst_payid(new Long(-1));
		tktmst.setTktmst_cardno(strtkt);
		tktmst.setTktmst_ifcrd(new Long(0));
		tktmst.setTktmst_shopcodes("14031201");
		tktmst.setTktmst_memo("锄禾领券活动--邹！");
		Tools.getManager(Ticket.class).create(tktmst);
		
	//}
	String gourl="http://chuhe.d1.cn";
	if(httpurl.startsWith("m.d1.cn"))gourl="http://chuhe.d1.cn";
	Tools.outJs(out,"恭喜您，您已经成功领取锄禾网上商城10元购物券，购物满50元即可在购物流程使用！购物券有效期是2015年12月31日",gourl);

		return;
}else{
//out.print("对不起您已经领过了优惠券！");
Tools.outJs(out,"对不起您已经领过了优惠券！去购物吧","http://chuhe.d1.cn");

}

%>