<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %>
<%
String strtaili_code = request.getParameter("code");
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}
System.out.println("d1gjltaili:"+strtaili_code);
TaiLi2012 taili=(TaiLi2012)Tools.getManager(TaiLi2012.class).findByProperty("taili2012_cardno", strtaili_code);
if(taili==null){
	out.print("{\"success\":false,\"message\":\"该台历券不存在！\"}");
	return;
}
if(taili.getTaili2012_status().longValue()==1){
	out.print("{\"success\":false,\"message\":\"该台历券已经兑刮开！\"}");
	return;
}

        taili.setTaili2012_status(new Long(1));
        taili.setTaili2012_update(new Date());
        taili.setTaili2012_mbrid(new Long(lUser.getId()));
		Tools.getManager(TaiLi2012.class).update(taili, false);
		LotAct lot8zn=(LotAct)Tools.getManager(LotAct.class).findByProperty("lot8zn_mbrid", new Long(lUser.getId()));
		if (lot8zn==null){
			//insert into Lot8zn(Lot8zn_mbrid,Lot8zn_totcount,Lot8zn_count) values("&rsrecid("mbrmst_id")&",1,1)
			LotAct lot8zn2=new LotAct();
			lot8zn2.setLot8zn_mbrid(new Long(lUser.getId()));
			lot8zn2.setLot8zn_totcount(new Long(1));
			lot8zn2.setLot8zn_count(new Long(1));
			Tools.getManager(LotAct.class).create(lot8zn2);
		}
		else{
			lot8zn.setLot8zn_totcount(new Long(lot8zn.getLot8zn_totcount().longValue()+1));
			lot8zn.setLot8zn_count(new Long(lot8zn.getLot8zn_count().longValue()+1));
			Tools.getManager(LotAct.class).update(lot8zn, false);
		}
		out.print("{\"success\":true,\"message\":\"恭喜你获得一次抽奖机会，赶快进行抽奖吧！！\"}");
		return;
%>