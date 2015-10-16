<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!public static void addtkt(String mbrid2,String mbrid,Date endDate,String strtkt,long tktvalue){
Ticket tktmst6=new Ticket();
tktmst6.setTktmst_value(new Float(tktvalue));
tktmst6.setTktmst_type("005009");
tktmst6.setTktmst_mbrid(Tools.parseLong(mbrid2));
tktmst6.setTktmst_validflag(new Long(0));
tktmst6.setTktmst_createdate(new Date());
tktmst6.setTktmst_validates(new Date());
tktmst6.setTktmst_validatee(endDate);
tktmst6.setTktmst_rackcode("000");
tktmst6.setTktmst_gdsvalue(new Float(tktvalue));
tktmst6.setTktmst_payid(new Long(-1));
tktmst6.setTktmst_cardno(strtkt);
tktmst6.setTktmst_ifcrd(new Long(0));
tktmst6.setTktmst_shopcodes("11111111");
tktmst6.setTktmst_memo(mbrid+"为推荐会号ID微信活动分享赠券--邹！");
Tools.getManager(Ticket.class).create(tktmst6);
}
%>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date dStartDate=null;
Date endDate=null;
Date mbrDate=null;
try{
	 dStartDate =fmt.parse("2015-07-30");
	// mbrDate=fmt.parse("2015-01-21");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print("{\"jflag\":3,\"message\":\"对不起活动已经结束！\"}");
	return;
}

String erroinfo="";
String httpurl=request.getServerName()+request.getRequestURI();
if(lUser==null) {
	erroinfo="请先登陆再来领取优惠券！";
	out.print("{\"jflag\":2,\"message\":\""+erroinfo+"\"}");
	return;
}

String mbrid=lUser.getId();
String tktcardno="weixinN1506";

String strtkt=tktcardno+mbrid;
Ticket tktcard=(Ticket)Tools.getManager(Ticket.class).findByProperty("tktmst_cardno", strtkt);
try{
	endDate=fmt2.parse("2015-07-30 23:59:59");
}
catch(Exception ex){
	 ex.printStackTrace();
}
if(tktcard == null) {
	//for(int i=0;i<5;i++){
		/*200-120 自营男装券 2张
200-120 自营女装券 2张
100-30  全场券  4张
18-18  全场券 1张*/
for(int i=0;i<2;i++){
		Ticket tktmst1=new Ticket();
		tktmst1.setTktmst_value(new Float(120));
		tktmst1.setTktmst_type("005009");
		tktmst1.setTktmst_mbrid(Tools.parseLong(mbrid));
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
		tktmst1.setTktmst_memo("微信活动领券--邹！！");
		Tools.getManager(Ticket.class).create(tktmst1);
}
for(int i=0;i<2;i++){
		Ticket tktmst2=new Ticket();
		tktmst2.setTktmst_value(new Float(120));
		tktmst2.setTktmst_type("005009");
		tktmst2.setTktmst_mbrid(Tools.parseLong(mbrid));
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
		tktmst2.setTktmst_memo("微信活动领券--邹！！");
		Tools.getManager(Ticket.class).create(tktmst2);
}	
for(int i=0;i<4;i++){
		Ticket tktmst3=new Ticket();
		tktmst3.setTktmst_value(new Float(30));
		tktmst3.setTktmst_type("005009");
		tktmst3.setTktmst_mbrid(Tools.parseLong(mbrid));
		tktmst3.setTktmst_validflag(new Long(0));
		tktmst3.setTktmst_createdate(new Date());
		tktmst3.setTktmst_validates(new Date());
		tktmst3.setTktmst_validatee(endDate);
		tktmst3.setTktmst_rackcode("000");
		tktmst3.setTktmst_gdsvalue(new Float(100));
		tktmst3.setTktmst_payid(new Long(-1));
		tktmst3.setTktmst_cardno(strtkt);
		tktmst3.setTktmst_ifcrd(new Long(0));
		tktmst3.setTktmst_shopcodes("11111111");
		tktmst3.setTktmst_memo("微信活动领券--邹！");
		Tools.getManager(Ticket.class).create(tktmst3);
}
Ticket tktmst4=new Ticket();
tktmst4.setTktmst_value(new Float(18));
tktmst4.setTktmst_type("005009");
tktmst4.setTktmst_mbrid(Tools.parseLong(mbrid));
tktmst4.setTktmst_validflag(new Long(0));
tktmst4.setTktmst_createdate(new Date());
tktmst4.setTktmst_validates(new Date());
tktmst4.setTktmst_validatee(endDate);
tktmst4.setTktmst_rackcode("000");
tktmst4.setTktmst_gdsvalue(new Float(18));
tktmst4.setTktmst_payid(new Long(-1));
tktmst4.setTktmst_cardno(strtkt);
tktmst4.setTktmst_ifcrd(new Long(0));
tktmst4.setTktmst_shopcodes("11111111");
tktmst4.setTktmst_memo("微信活动领券--邹！");
Tools.getManager(Ticket.class).create(tktmst4);


if(session.getAttribute("Wxhbfx201506")!=null&&!mbrid.equals(session.getAttribute("Wxhbfx201506").toString())){
	LotCode lotc = (LotCode)Tools.getManager(LotCode.class).findByProperty("Lotcode_rec", mbrid);
	if(lotc==null){
		String mbrid2=session.getAttribute("Wxhbfx201506").toString();
		lotc = new LotCode();
		lotc.setLotcode_mbrid(new Long(mbrid2));
		lotc.setLotcode_rec(mbrid);
		lotc.setLotcode_createdate(new Date());
		Tools.getManager(LotCode.class).create(lotc);
		
		Random rnd = new Random();
		   long rndvalue=(long)rnd.nextInt(1000);
		   /*20%    8
		   20%    10
		   20%    12
		   20%    15
		   10%    20
		   5%     25
		   5%     30*/
		   if (rndvalue>950){
			   addtkt(mbrid2,mbrid,endDate,strtkt,30);
		   }
		   else if(rndvalue>750 && rndvalue<=950){
			   addtkt(mbrid2,mbrid,endDate,strtkt,15);
		   }
		   else if(rndvalue>650 && rndvalue<=750){
			   addtkt(mbrid2,mbrid,endDate,strtkt,20);
			
		   } else if(rndvalue>450 && rndvalue<=650){
			   addtkt(mbrid2,mbrid,endDate,strtkt,12);
			  
		   }
		   else if(rndvalue>250 && rndvalue<=450){
			   addtkt(mbrid2,mbrid,endDate,strtkt,10);
			 
		   }
		   else if(rndvalue>50 && rndvalue<=250){
			   addtkt(mbrid2,mbrid,endDate,strtkt,8);
			  
		   }
		 
		   else if(rndvalue>=0 && rndvalue<=50){
			   addtkt(mbrid2,mbrid,endDate,strtkt,25);
			  
		   }
		
	}
}

	//}
erroinfo="恭喜您成功领取优惠券！";
out.print("{\"jflag\":0,\"message\":\""+erroinfo+"\",\"mid\":"+mbrid+"}");
		return;
}else{

erroinfo="对不起您已经领过了优惠券！";
out.print("{\"jflag\":1,\"message\":\""+erroinfo+"\"}");
return;
}

%>