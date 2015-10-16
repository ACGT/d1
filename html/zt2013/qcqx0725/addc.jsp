<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
Date dStartDate=null;
try{
	 dStartDate =fmt.parse("2013-08-15");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print("{\"success\":false,\"urlflag\":false,\"message\":\"对不起活动已经结束！\"}");
	return;
}

if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>Login_Dialog();<%
	return;
}
if(!Tools.isNull(request.getParameter("zfcontent"))){
	
	if(lUser.getMbrmst_phoneflag()==null||lUser.getMbrmst_phoneflag().longValue()==0){
	out.print("{\"success\":false,\"urlflag\":true,\"message\":\"对不起请<a href=/newlogin/valitel.jsp target=_blank style='color:#red;font-size:16px'>认证手机</a>然后再来发表白，神秘大礼等拿！\"}");
	return;
}
	
	String nowdate=Tools.getDate();
	String start=nowdate+" 00:00:00";
	String end=nowdate+" 23:59:59";
	 SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("znzhufu_mbrid", new Long(lUser.getId())));
	listRes.add(Restrictions.ge("znzhufu_createdate", format.parse(start)));
	listRes.add(Restrictions.le("znzhufu_createdate", format.parse(end)));
	List<BaseEntity> b_list=Tools.getManager(ZhuFu.class).getList(listRes, null, 0, 10);
	if(b_list!=null && b_list.size()>0){
		out.print("{\"success\":false,\"urlflag\":false,\"message\":\"您今天已发表过，请明天再来!\"}");
		return;
	}else{
		ZhuFu zf=new ZhuFu();
		zf.setZnzhufu_content(request.getParameter("zfcontent"));
		zf.setZnzhufu_createdate(new Date());
		zf.setZnzhufu_mbrid(new Long(lUser.getId()));
		zf.setZnzhufu_mbruid(lUser.getMbrmst_uid());
		zf=(ZhuFu)Tools.getManager(ZhuFu.class).create(zf);
		if(zf!=null){
			Random rnd = new Random();
			   long rndvalue=(long)rnd.nextInt(1000);
			  
			   
			float tktvalue=0;
			float gdsvalue=0;
			String tktrck="017";
			String tktcardno="paqcqxtkt130725";
			String memo="";
			 if(rndvalue<100){
     			tktvalue=80;
				gdsvalue=500;
				memo="表白成功，赠送您一张80元服饰优惠券满500可用有效期1个月，购物结算时可直接使用！";
			 }else if(rndvalue>=100&&rndvalue<400){
				 tktvalue=10;
					gdsvalue=10;
					tktrck="000";
					memo="表白成功，赠送您一张10元优惠券全场通用有效期1个月，购物结算时可直接使用！";
			 }else if(rndvalue>=400&&rndvalue<700){
				 tktvalue=20;
					gdsvalue=150;
					memo="表白成功，赠送您一张20元服饰优惠券满150可用有效期1个月，购物结算时可直接使用！";
			 }else if(rndvalue>=700){
				 tktvalue=30;
					gdsvalue=200;
					memo="表白成功，赠送您一张30元服饰优惠券满200可用有效期1个月，购物结算时可直接使用！";
			 }

			String strtkt=tktcardno+lUser.getId()+rndvalue;
			//Ticket tktcard=(Ticket)Tools.getManager(Ticket.class).findByProperty("tktmst_cardno", strtkt);
			//if(tktcard == null) {
					Ticket tktmst=new Ticket();
					tktmst.setTktmst_value(new Float(tktvalue));
					tktmst.setTktmst_type("003005");
					tktmst.setTktmst_mbrid(Tools.parseLong(lUser.getId()));
					tktmst.setTktmst_validflag(new Long(0));
					tktmst.setTktmst_createdate(new Date());
					tktmst.setTktmst_validates(new Date());
					tktmst.setTktmst_validatee(Tools.addDate(new Date(), 30));
					tktmst.setTktmst_rackcode(tktrck);
					tktmst.setTktmst_gdsvalue(new Float(gdsvalue));
					tktmst.setTktmst_payid(new Long(-1));
					tktmst.setTktmst_cardno(strtkt);
					tktmst.setTktmst_ifcrd(new Long(0));
					tktmst.setTktmst_memo("浪漫七夕表白赠券！");
					Tools.getManager(Ticket.class).create(tktmst);
					out.print("{\"success\":false,\"urlflag\":false,\"message\":\""+memo+"\"}");
					return;
				//}
		}
			
	}
}

%>