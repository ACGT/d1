<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
if(lUser==null){
	out.print("-201");
	return;
}
float realscore=UserScoreHelper.getRealScore(lUser.getId());
float cartAwardValue=AwardHelper.getCartAwardValue(request, response);
float canUseScore=realscore-cartAwardValue;
if(canUseScore<0f){
	out.print("-202");
	return;
}
String aid=request.getParameter("aid");
if(Tools.isNull(aid)){
	out.print("-203");
	return;
}
ArrayList<Award> awardlist=AwardHelper. getAwardById(aid,100);
if(awardlist==null || awardlist.size()==0){
	out.print("-203");
	return;	
}
AwardUseLog uselog=new AwardUseLog();
uselog.setScrchgawd_awardid(new Long(aid));
uselog.setScrchgawd_mbrid(new Long(lUser.getId()));
uselog.setScrchgawd_mbrmst_name(lUser.getMbrmst_name());
uselog.setScrchgawd_uid(lUser.getMbrmst_uid());
uselog.setScrchgawd_status(new Long(0));
uselog.setScrchgawd_applytime(new Date());
uselog.setScrchgawd_mbrmst_postcode(lUser.getMbrmst_postcode());
uselog.setScrchgawd_mbrmst_usephone(lUser.getMbrmst_usephone());
uselog.setScrchgawd_name(lUser.getMbrmst_name());
uselog=(AwardUseLog)Tools.getManager(AwardUseLog.class).create(uselog);
if(uselog==null){
	out.print("-204");
	return;	
}
%>