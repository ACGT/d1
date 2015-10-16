<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
//每个用户限领一张
static ArrayList<Ticket> getUserTickets(String cardno,String userId){
		ArrayList<Ticket> list = new ArrayList<Ticket>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("tktmst_mbrid", new Long(userId)));
		clist.add(Restrictions.like("tktmst_cardno", cardno+"%"));
		
		List<BaseEntity> rlist = Tools.getManager(Ticket.class).getList(clist, null, 0, 10);
		if(rlist==null||rlist.size()==0)return null;
		
		for(BaseEntity b:rlist){
			list.add((Ticket)b);
		}
		
		return list ;
	}
%><%
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>Login_Dialog();<%
	return;
}
String ticketvalue=request.getParameter("ticketvalue");
if(Tools.isNull(ticketvalue)){
	out.print("{\"success\":false,\"message\":\"参数错误！\"}");
	return;
}
if(!"10".equals(ticketvalue) && !"30".equals(ticketvalue)){
	out.print("{\"success\":false,\"message\":\"参数错误！\"}");
	return;
}
String cardno="";
int tvalue=0;
int gdsvalue=0;
if("10".equals(ticketvalue)){
	cardno="mqsjzf1205ka";
	tvalue=10;
	gdsvalue=10;
}else if ("30".equals(ticketvalue)){
	cardno="mqsjzf1205kb";
	tvalue=30;
	gdsvalue=200;
}
if(Tools.isNull(cardno)){
	out.print("{\"success\":false,\"message\":\"参数错误！\"}");
	return;
}
ArrayList<Ticket> tlist= getUserTickets( cardno,lUser.getId());
if(tlist!=null && tlist.size()>0){
	out.print("{\"success\":false,\"message\":\"您已经领过该优惠券！\"}");
	return;	
}

SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date dStartDate=null;
	Date StartDate=null;
	try{
		 StartDate =fmt.parse("2012-05-31 00:00:00");
		   	 dStartDate =fmt.parse("2012-07-31 23:59:59");
		 }
	catch(Exception ex){
		ex.printStackTrace();
	}
Random rndcard = new Random();
 cardno+=lUser.getId()+rndcard.nextInt(20000);
 Ticket tktmst=new Ticket();
 tktmst.setTktmst_value(new Float(tvalue));
 tktmst.setTktmst_type("003005");
 tktmst.setTktmst_mbrid(Tools.parseLong(lUser.getId()));
 tktmst.setTktmst_validflag(new Long(0));
 tktmst.setTktmst_createdate(new Date());
 tktmst.setTktmst_validates(StartDate);
 tktmst.setTktmst_validatee(dStartDate);
 tktmst.setTktmst_rackcode("000");
 tktmst.setTktmst_gdsvalue(new Float(gdsvalue));
 tktmst.setTktmst_payid(new Long(33));
 tktmst.setTktmst_cardno(cardno);
 tktmst.setTktmst_ifcrd(new Long(0));
 tktmst.setTktmst_memo("手机支付会员专享！");
 tktmst=(Ticket)Tools.getManager(Ticket.class).create(tktmst);
 if(tktmst!=null){
	 out.print("{\"success\":true,\"message\":\"领取成功，您可以在选择手机支付时使用该优惠券！\"}");
		return;	 
 }else{
	 out.print("{\"success\":false,\"message\":\"领取失败，请稍后再试！\"}");
		return;	
 }
%>