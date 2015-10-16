<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
String cardno = request.getParameter("code");
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
Date dStartDate=null;
try{
	 dStartDate =fmt.parse("2012-11-1");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print("{\"success\":false,\"message\":\"抽奖活动已经结束\"}");
	return;
}
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}
if(cardno.length()>10){//可能是ticketgroup的记录
	String tgid = cardno.substring(0,cardno.length()-10);
	String num = cardno.substring(cardno.length()-10);//10位数
	
	String last2num = num.substring(num.length()-2);
	if(StringUtils.isDigits(num)){
			TuandhGroup tg = (TuandhGroup)Tools.getManager(TuandhGroup.class).findByProperty("tuandhgroup_title", tgid);
		if(tg!=null&& Tools.parseLong(tg.getId())>=1&&Tools.parseLong(tg.getId())<=5){//判断规则
			int sum = 0 ;
			for(int i=0;i<8;i++){//前8位加起来
				sum+=new Integer(num.charAt(i)+"").intValue();
			}
			String sum2 = (sum+tg.getTuandhgroup_checkcode().longValue())+"";
			if(sum2.length()>2)sum2=sum2.substring(sum2.length()-2);//取最后两位
			else if(sum2.length()<2)sum2="0"+sum2 ;//补0，没有这种情况
			if(last2num.equals(sum2)){//符合规则
				LotAct lot = (LotAct)Tools.getManager(LotAct.class).findByProperty("lot8zn_cardno", cardno);
     			if(lot!=null){
     				if (!lUser.getId().equals(lot.getLot8zn_mbrid().toString())){
     					out.print("{\"success\":false,\"message\":\"抽奖码已经被其它用户刮开过！！\"}");
						return;
     				}
					if(lot.getLot8zn_status().longValue()==0){
						out.print("{\"success\":false,\"message\":\"抽奖码已经刮开过，赶快进行抽奖吧！！\"}");
						return;
					}
					if(lot.getLot8zn_status().longValue()==1){
						out.print("{\"success\":false,\"message\":\"抽奖码已经抽奖过不能再使用！！\"}");
						return;
					}
				}else{
					//未刮开过添加一条新纪录
					LotAct lotact=new LotAct();
					lotact.setLot8zn_cardno(cardno);
					lotact.setLot8zn_mbrid(new Long(lUser.getId()));
					lotact.setLot8zn_status(new Long(0));
					lotact.setLot8zn_createdate(new Date());

					Tools.getManager(LotAct.class).create(lotact);
					out.print("{\"success\":true,\"message\":\"抽奖码刮开成功，赶快进行抽奖吧！！\"}");
					return;
				}
				
			
			}
		}
	}// end if
	
	
}
	out.print("{\"success\":false,\"message\":\"抽奖码错误，请输入正确的抽奖码！！\"}");
	return;
	
%>