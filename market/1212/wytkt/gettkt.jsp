<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%! String getcard(int length) {	
	char[] ss = new char[length];		
	int[] flag = {0,0,0}; //A-Z, a-z, 0-9	
	int i=0;		
	while(flag[0]==0 || flag[1]==0 || flag[2]==0 || i<length) {	
		i = i%length;		  
		int f = (int) (Math.random()*3%3);		
		if(f==0) ss[i] = (char) ('A'+Math.random()*26);	
		else if(f==1) ss[i] = (char) ('a'+Math.random()*26);	
		else ss[i] = (char) ('0'+Math.random()*10);    	
		flag[f]=1;		 
		i++;		
		}	
	return new String(ss);	
	} %>
<%
String strgdsdh_code = request.getParameter("code");
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.close();Login_Dialog();<%
	return;
}
if(Tools.isNull(strgdsdh_code)){
	out.print("{\"code\":1,message:\"兑换码错误！\"}");
	return;
}
if(!strgdsdh_code.startsWith("mqwyjfcj1211st") && !strgdsdh_code.startsWith("mqwyjf1212cjds") && !strgdsdh_code.startsWith("mqwydh1212d")&& !strgdsdh_code.startsWith("mqwyjftest")){
	out.print("{\"code\":1,message:\"兑换码错误！\"}");
	return;
}
SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
if(strgdsdh_code.startsWith("mqwydh1212d") || strgdsdh_code.startsWith("mqwyjftest")){
	Tuandh  tuandh=(Tuandh)Tools.getManager(Tuandh.class).findByProperty("tuandh_cardno", strgdsdh_code);
		if(tuandh==null){
			out.print("{\"code\":1,message:\"该兑换码不存在！\"}");
			return;
		}
		if(tuandh.getTuandh_status().longValue()==2){
			out.print("{\"code\":1,message:\"该兑换码已经兑换过！\"}");
			return;
		}
		if(Tools.dateValue(tuandh.getTuandh_endtime())<System.currentTimeMillis())
		{
			out.print("{\"code\":1,message:\"该兑换活动已经结束！\"}");
			return;
		}
		if(tuandh.getTuandh_mid()!=4){
			out.print("{\"code\":1,message:\"此兑换码错误！\"}");
			return;
		}
		 String cardno="mqwyjf1212dt"+lUser.getId()+getcard(10);
		 Date enddate=sf.parse("2012-12-31 23:59:59");
		TicketCrd tktcrd=new TicketCrd();
		 tktcrd.setTktcrd_cardno(cardno);
		 tktcrd.setTktcrd_mbrid(Tools.parseLong(lUser.getId()));
		 tktcrd.setTktcrd_value(new Long(100));
		 tktcrd.setTktcrd_realvalue(new Long(100));
		 tktcrd.setTktcrd_discount(new Float(0.15));
		 tktcrd.setTktcrd_type("003005");
		 tktcrd.setTktcrd_rackcode("017");
		 tktcrd.setTktcrd_createdate(new Date());
		 tktcrd.setTktcrd_validflag(new Long(1));
		 tktcrd.setTktcrd_enddate(enddate);
		 tktcrd.setTktcrd_validates(new Date());
		 tktcrd.setTktcrd_validatee(enddate);
		 tktcrd.setTktcrd_memo("网易兑换码换优惠券！");
		 tktcrd.setTktcrd_payid(new Long(-1));
		 Tools.getManager(TicketCrd.class).create(tktcrd);
		 
		 tuandh.setTuandh_status(new Long(2));
		 Tools.getManager(Tuandh.class).update(tuandh, true);
}
else{	
Long Tuandh_mid=0L;
String tgid="";String num="";String last2num="";
if(strgdsdh_code.length()>10){//可能是ticketgroup的记录
	 tgid = strgdsdh_code.substring(0,strgdsdh_code.length()-10);
	  num = strgdsdh_code.substring(strgdsdh_code.length()-10);//10位数
	last2num = num.substring(num.length()-2);
}
if(StringUtils.isDigits(num)){
	TuandhGroup tg = (TuandhGroup)Tools.getManager(TuandhGroup.class).findByProperty("tuandhgroup_title", tgid);
	if(tg!=null){
		Tuandh_mid=tg.getTuandhgroup_mid();
		if(Tools.dateValue(tg.getTuandhgroup_validatee())<System.currentTimeMillis()){
			out.print("{\"code\":1,message:\"该兑换活动已经结束！\"}");
			return;
		}	
		int sum = 0 ;
		for(int i=0;i<8;i++){//前8位加起来
			sum+=new Integer(num.charAt(i)+"").intValue();
		}
		String sum2 = (sum+tg.getTuandhgroup_checkcode().longValue())+"";
		if(sum2.length()>2)sum2=sum2.substring(sum2.length()-2);//取最后两位
		else if(sum2.length()<2)sum2="0"+sum2 ;//补0，没有这种情况
		if(last2num.equals(sum2)){//符合规则
		Tuandh tuan = (Tuandh)Tools.getManager(Tuandh.class).findByProperty("tuandh_cardno", strgdsdh_code);
		if(tuan!=null){
			if(tuan.getTuandh_status().intValue()==2){
				out.print("{\"code\":1,message:\"该兑换码已兑换过！\"}");
				return;
			}
			Random rndcard = new Random();
			 String cardno="mqwydh1211"+lUser.getId()+rndcard.nextInt(1000000);
			 Date enddate=sf.parse("2013-1-31 23:59:59");
			
				 TicketCrd tktcrd=new TicketCrd();
				 tktcrd.setTktcrd_cardno(cardno);
				 tktcrd.setTktcrd_mbrid(Tools.parseLong(lUser.getId()));
				 tktcrd.setTktcrd_value(new Long(100));
				 tktcrd.setTktcrd_realvalue(new Long(100));
				 tktcrd.setTktcrd_discount(new Float(0.15));
				 tktcrd.setTktcrd_type("003005");
				 tktcrd.setTktcrd_rackcode("017");
				 tktcrd.setTktcrd_createdate(new Date());
				 tktcrd.setTktcrd_validflag(new Long(1));
				 tktcrd.setTktcrd_enddate(enddate);
				 tktcrd.setTktcrd_validates(new Date());
				 tktcrd.setTktcrd_validatee(enddate);
				 tktcrd.setTktcrd_memo("网易兑换码换优惠券！");
				 tktcrd.setTktcrd_payid(new Long(-1));
				 Tools.getManager(TicketCrd.class).create(tktcrd);
				 
				 tuan.setTuandh_status(new Long(2));
				 Tools.getManager(Tuandh.class).update(tuan, true);
		}else{
			
			Random rndcard = new Random();
			 String cardno="mqwydh1211"+lUser.getId()+rndcard.nextInt(1000000);
			
			
			 Date enddate=sf.parse("2013-1-31 23:59:59");
			
				 TicketCrd tktcrd=new TicketCrd();
				 tktcrd.setTktcrd_cardno(cardno);
				 tktcrd.setTktcrd_mbrid(Tools.parseLong(lUser.getId()));
				 tktcrd.setTktcrd_value(new Long(100));
				 tktcrd.setTktcrd_realvalue(new Long(100));
				 tktcrd.setTktcrd_discount(new Float(0.15));
				 tktcrd.setTktcrd_type("003005");
				 tktcrd.setTktcrd_rackcode("017");
				 tktcrd.setTktcrd_createdate(new Date());
				 tktcrd.setTktcrd_validflag(new Long(1));
				 tktcrd.setTktcrd_enddate(enddate);
				 tktcrd.setTktcrd_validates(new Date());
				 tktcrd.setTktcrd_validatee(enddate);
				 tktcrd.setTktcrd_memo("网易兑换码换优惠券！");
				 tktcrd.setTktcrd_payid(new Long(-1));
				 Tools.getManager(TicketCrd.class).create(tktcrd);
					
			//未刮开过添加一条新纪录
			Tuandh t=new Tuandh();
			t.setTuandh_cardno(strgdsdh_code);
			t.setTuandh_createtime(tg.getTuandhgroup_createdate());
			t.setTuandh_endtime(tg.getTuandhgroup_validatee());
			t.setTuandh_gdsid(tg.getTuandhgroup_gdsid());
			t.setTuandh_memo(tg.getTuandhgroup_memo2());
			t.setTuandh_title(tg.getTuandhgroup_memo());
			t.setTuandh_status(new Long(2));
			t.setTuandh_yztime(new Date());
			t.setTuandh_mbrid(new Long(lUser.getId()));
			t.setTuandh_mid(tg.getTuandhgroup_mid());
			try{
				Tools.getManager(Tuandh.class).create(t);
				}catch(Exception e){
					
				}
			out.print("{\"code\":0,message:\"恭喜您！成功兑换100元服装优惠券1张！\"}");
			return;
		}
		
		}else{
			out.print("{\"code\":1,message:\"该兑换码不存在！\"}");
			return;
		}
	}
	
}else{
	out.print("{\"code\":1,message:\"该兑换码不存在！\"}");
	return;
}

	if(Tuandh_mid!=4){
		out.print("{\"code\":1,message:\"此兑换码错误！\"}");
		return;
	}
	
}
	
//}
%>