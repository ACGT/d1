<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date dStartDate=null;
Date endDate=null;
Date mbrDate=null;
try{
	 dStartDate =fmt.parse("2015-04-30");
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
	//System.out.println("d1gjl:"+httpurl);
	if(httpurl.startsWith("m.d1.cn")){
		response.sendRedirect("http://m.d1.cn/wap/login.html?url=/html/gettkt150317.jsp");
		return;
	}else{
	response.sendRedirect("http://www.d1.com.cn/login.jsp?url=/html/gettkt150317.jsp");
	return;
	}
}

//if(lUser.getMbrmst_createdate().getTime()>mbrDate.getTime()) {
//	out.print("优宝贝，非常感谢您的关注，本活动仅限老会员参加，请持续关注D1优尚，下次一定会邀请您参加新的活动~~");
//	return;
//}



String tktcardno="pkt150317";


String strtkt=tktcardno+lUser.getId();
Ticket tktcard=(Ticket)Tools.getManager(Ticket.class).findByProperty("tktmst_cardno", strtkt);
try{
	endDate=fmt2.parse("2015-04-30 23:59:59");
}
catch(Exception ex){
	 ex.printStackTrace();
}
if(tktcard == null) {
	//for(int i=0;i<5;i++){
		
		Ticket tktmst1=new Ticket();
		tktmst1.setTktmst_value(new Float(150));
		tktmst1.setTktmst_type("005009");
		tktmst1.setTktmst_mbrid(Tools.parseLong(lUser.getId()));
		tktmst1.setTktmst_validflag(new Long(0));
		tktmst1.setTktmst_createdate(new Date());
		tktmst1.setTktmst_validates(new Date());
		tktmst1.setTktmst_validatee(endDate);
		tktmst1.setTktmst_rackcode("030");
		tktmst1.setTktmst_gdsvalue(new Float(200));
		tktmst1.setTktmst_payid(new Long(-1));
		tktmst1.setTktmst_cardno(strtkt);
		tktmst1.setTktmst_ifcrd(new Long(0));
		tktmst1.setTktmst_shopcodes("00000000");
		tktmst1.setTktmst_memo("活动领券--kitty！！");
		Tools.getManager(Ticket.class).create(tktmst1);
		
		Ticket tktmst2=new Ticket();
		tktmst2.setTktmst_value(new Float(150));
		tktmst2.setTktmst_type("005009");
		tktmst2.setTktmst_mbrid(Tools.parseLong(lUser.getId()));
		tktmst2.setTktmst_validflag(new Long(0));
		tktmst2.setTktmst_createdate(new Date());
		tktmst2.setTktmst_validates(new Date());
		tktmst2.setTktmst_validatee(endDate);
		tktmst2.setTktmst_rackcode("020");
		tktmst2.setTktmst_gdsvalue(new Float(200));
		tktmst2.setTktmst_payid(new Long(-1));
		tktmst2.setTktmst_cardno(strtkt);
		tktmst2.setTktmst_ifcrd(new Long(0));
		tktmst2.setTktmst_shopcodes("00000000");
		tktmst2.setTktmst_memo("活动领券--kitty！！");
		Tools.getManager(Ticket.class).create(tktmst2);
		
		Ticket tktmst3=new Ticket();
		tktmst3.setTktmst_value(new Float(30));
		tktmst3.setTktmst_type("005009");
		tktmst3.setTktmst_mbrid(Tools.parseLong(lUser.getId()));
		tktmst3.setTktmst_validflag(new Long(0));
		tktmst3.setTktmst_createdate(new Date());
		tktmst3.setTktmst_validates(new Date());
		tktmst3.setTktmst_validatee(endDate);
		tktmst3.setTktmst_rackcode("000");
		tktmst3.setTktmst_gdsvalue(new Float(299));
		tktmst3.setTktmst_payid(new Long(-1));
		tktmst3.setTktmst_cardno(strtkt);
		tktmst3.setTktmst_ifcrd(new Long(0));
		tktmst3.setTktmst_shopcodes("11111111");
		tktmst3.setTktmst_memo("活动领券--kitty！");
		Tools.getManager(Ticket.class).create(tktmst3);

	//}
	String gourl="/user/ticket.jsp";
	if(httpurl.startsWith("m.d1.cn"))gourl="/wap/user/mytkts.html";
	Tools.outJs(out,"恭喜你，获得1张满299元减30元购物券全场通用、1张满200元减150元购物券自营男装可用、1张满200元减150元购物券自营女装可用 （特别标注不让用券的特价商品除外）购物券有效期是2015年4月30日",gourl);

		return;
}else{
out.print("对不起您已经领过了优惠券！");
}

%>