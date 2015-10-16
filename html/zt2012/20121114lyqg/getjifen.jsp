<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!//判断当月是否有晒单积分
static ArrayList<UserScore> getUserSDScore(String mbrid){
	ArrayList<UserScore> rlist = new ArrayList<UserScore>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("usrscore_mbrid", new Long(mbrid)));
	clist.add(Restrictions.eq("usrscore_type", new Long(9)));
	List<BaseEntity> list = Tools.getManager(UserScore.class).getList(clist, null, 0, 10);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((UserScore)be);
	}
	return rlist ;
} %>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date dStartDate=null;
Date endDate=null;
try{
	 dStartDate =fmt.parse("2012-12-31");
	 endDate=fmt2.parse("2012-12-31 23:59:59");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print("{\"success\":false,\"message\":\"该活动己结束\"}");
	return;
}
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}
//白金用户才能领取
if(!UserHelper.isPtVip(lUser)){
	out.print("{\"success\":false,\"message\":\"您不是白金VIP用户，不能领取！\"}");
	return;
}
ArrayList<UserScore> list= getUserSDScore(lUser.getId());
if(list!=null && list.size()>0){
	out.print("{\"success\":false,\"message\":\"此活动期间您已领过积分\"}");
	return;
}

Calendar ca = Calendar.getInstance();
 int year = ca.get(Calendar.YEAR);//获取年份
 int month=ca.get(Calendar.MONTH)+1;//获取月份
UserScore userscore= new UserScore();
userscore.setUsrscore_allscr(new Float(1000));
userscore.setUsrscore_buymoney(new Float(0));
userscore.setUsrscore_createdate(new Date());
userscore.setUsrscore_jlper("0");
userscore.setUsrscore_lxmonth(new Long(0));
userscore.setUsrscore_mbrid(new Long(lUser.getId()));
userscore.setUsrscore_month(month+"");
userscore.setUsrscore_rcmscr(new Float(0));
userscore.setUsrscore_realscr(new Float(1000));
userscore.setUsrscore_scr(new Float(1000));
userscore.setUsrscore_tktvalue(new Float(0));
userscore.setUsrscore_type(new Long(9));
userscore.setUsrscore_year(year+"");
userscore=(UserScore)Tools.getManager(UserScore.class).create(userscore);
if(userscore!=null && !Tools.isNull(userscore.getId())){
	out.print("{\"success\":true,\"message\":\"领积分成功，您可以在账户中心-我的积分页面查到\"}");
	return;
}
out.print("{\"success\":false,\"message\":\"领积分失败\"}");
return;
%>