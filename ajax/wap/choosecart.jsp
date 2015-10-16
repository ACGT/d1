<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!

private int getTuandhLength(String strgdsid,String mbrid){
	ArrayList<Tuandh> list=new ArrayList<Tuandh>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("tuandh_gdsid", strgdsid));
	clist.add(Restrictions.eq("tuandh_status", new Long(2)));
	clist.add(Restrictions.eq("tuandh_mbrid", new Long(mbrid)));
	clist.add(Restrictions.eq("tuandh_mid", new Long(4)));
	clist.add(Restrictions.gt("tuandh_endtime", new Date()));
	return Tools.getManager(Tuandh.class).getLength(clist);
	
}
//private static final Object LOCK = new Object();
%>
<%


String strgdsdh_code = request.getParameter("id");
if(lUser==null) {
	out.print("{\"code\":99,\"message\":\"该兑换活动已经结束！\"}");
	return;
}
Long Tuandh_mid=0L;
String strgdsid="";
String memo="";
boolean isnew=false;
String tgid="";String num="";String last2num="";
if(strgdsdh_code.length()>10){//可能是ticketgroup的记录
	 tgid = strgdsdh_code.substring(0,strgdsdh_code.length()-10);
	  num = strgdsdh_code.substring(strgdsdh_code.length()-10);//10位数
	last2num = num.substring(num.length()-2);
}
if(StringUtils.isDigits(num)){
	TuandhGroup tg = (TuandhGroup)Tools.getManager(TuandhGroup.class).findByProperty("tuandhgroup_title", tgid);
	if(tg!=null){
		isnew=true;
		memo=tg.getTuandhgroup_memo2();
		Tuandh_mid=tg.getTuandhgroup_mid();
		if(Tools.dateValue(tg.getTuandhgroup_validatee())<System.currentTimeMillis()){
			out.print("{\"code\":1,\"message\":\"该兑换活动已经结束！\"}");
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
		strgdsid=tg.getTuandhgroup_gdsid();
		Tuandh tuan = (Tuandh)Tools.getManager(Tuandh.class).findByProperty("tuandh_cardno", strgdsdh_code);
		if(tuan!=null){
			if(tuan.getTuandh_status().intValue()==2){
				out.print("{\"code\":1,\"message\":\"该兑换码已经兑换过！\"}");
				return;
			}
		}else{
			//未刮开过添加一条新纪录
			Tuandh t=new Tuandh();
			t.setTuandh_cardno(strgdsdh_code);
			t.setTuandh_createtime(tg.getTuandhgroup_createdate());
			t.setTuandh_endtime(tg.getTuandhgroup_validatee());
			t.setTuandh_gdsid(tg.getTuandhgroup_gdsid());
			t.setTuandh_memo(tg.getTuandhgroup_memo2());
			t.setTuandh_title(tg.getTuandhgroup_memo());
			t.setTuandh_status(new Long(1));
			t.setTuandh_yztime(new Date());
			t.setTuandh_dhprice(tg.getTuandhgroup_dhprice());
			t.setTuandh_maxbuycount(tg.getTuandhgroup_maxbuycount());
			t.setTuandh_shipfee(tg.getTuandhgroup_shipfee());
			t.setTuandh_fee(tg.getTuandhgroup_fee());
			t.setTuandh_mbrid(new Long(lUser.getId()));
			t.setTuandh_mid(tg.getTuandhgroup_mid());
			try{
				Tools.getManager(Tuandh.class).create(t);
				}catch(Exception e){
					
				}
		}
		
		}else{
			out.print("{\"code\":1,\"message\":\"该兑换码不存在！\"}");
			return;
		}
	}
	
}
Tuandh tuandh=null;
if(!isnew){
		tuandh=(Tuandh)Tools.getManager(Tuandh.class).findByProperty("tuandh_cardno", strgdsdh_code);
	
	if(tuandh==null){
		out.print("{\"code\":1,\"message\":\"该兑换码不存在！\"}");
		return;
	}
	if(tuandh.getTuandh_status().longValue()==2){
		out.print("{\"code\":1,\"message\":\"该兑换码已经兑换过！\"}");
		return;
	}
	if(Tools.dateValue(tuandh.getTuandh_endtime())<System.currentTimeMillis())
	{
		out.print("{\"code\":1,\"message\":\"该兑换活动已经结束！\"}");
		return;
	}
	memo=tuandh.getTuandh_memo();
}
if(memo.indexOf(",")>0){
	String [] strs=null;
	String str="";
	if(memo.indexOf(",")>0){
		strs=memo.split(",");
	}
	if(strs!=null && strs.length>0){
		str=strs[0];
	}
	out.print("{\"code\":0,\"message\":\""+str+"\"}");
	return;
}else{
	out.print("{\"code\":2,\"message\":\"\"}");
	return;
}


%>