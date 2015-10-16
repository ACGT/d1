<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
String cardno = request.getParameter("code");
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
Date dStartDate=null;
try{
	 dStartDate =fmt.parse("2013-1-1");
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
if (cardno!=null){
	cardno=cardno.trim();
				LotAct lot = (LotAct)Tools.getManager(LotAct.class).findByProperty("lot8zn_cardno", cardno);
     			if(lot!=null&&lot.getLot8zn_status().longValue()==0){
     				//未刮开.
     				lot.setLot8zn_mbrid(new Long(Tools.parseLong(lUser.getId())));
					lot.setLot8zn_status(new Long(2));
					lot.setLot8zn_createdate(new Date());

					Tools.getManager(LotAct.class).update(lot, false);
					out.print("{\"success\":true,\"message\":\"抽奖码刮开成功，赶快进行抽奖吧！！\"}");
					return;
				}else{
					if (lot!=null){
					if(lot.getLot8zn_status().longValue()==1){
						out.print("{\"success\":false,\"message\":\"抽奖码已经抽奖过不能再使用！！\"}");
						return;
					}
					if (!lUser.getId().equals(lot.getLot8zn_mbrid().toString())&&lot.getLot8zn_mbrid().longValue()!=0){
     					out.print("{\"success\":false,\"message\":\"抽奖码已经被其它用户刮开过！！\"}");
						return;
     				}
					if(lot.getLot8zn_status().longValue()==2){
						out.print("{\"success\":false,\"message\":\"抽奖码已经刮开过，赶快进行抽奖吧！！\"}");
						return;
					}
					}else{
						out.print("{\"success\":false,\"message\":\"抽奖码不存在，请重新输入！！\"}");
						return;
					}
				}
}else{
	out.print("{\"success\":false,\"message\":\"请输入抽奖码！！\"}");
	return;
}	
			
			
	
%>