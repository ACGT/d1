<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%><%!//判断当月是否有晒单积分
static ArrayList<UserScore> getUserSDScore(String mbrid){
	ArrayList<UserScore> rlist = new ArrayList<UserScore>();
	Calendar ca = Calendar.getInstance();
    int year = ca.get(Calendar.YEAR);//获取年份
    int month=ca.get(Calendar.MONTH)+1;//获取月份
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("usrscore_mbrid", new Long(mbrid)));
	clist.add(Restrictions.eq("usrscore_type", new Long(8)));
	clist.add(Restrictions.eq("usrscore_year", year+""));
	clist.add(Restrictions.eq("usrscore_month", month+""));
	List<BaseEntity> list = Tools.getManager(UserScore.class).getList(clist, null, 0, 10);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((UserScore)be);
	}
	return rlist ;
} %>
<%
String showid=request.getParameter("showid");

String mbrid=request.getParameter("mid");

if(Tools.isNull(showid) || Tools.isNull(request.getParameter("backtype")) || Tools.isNull(request.getParameter("yx")) || Tools.isNull(request.getParameter("sh")) || Tools.isNull(request.getParameter("jf")) || Tools.isNull(mbrid)){
	 out.print("{\"succ\":false,\"message\":\"参数错误！\"}");
	 return;
	}
if(!Tools.isNumber(showid)){
	 out.print("{\"succ\":false,\"message\":\"参数错误！\"}");
	 return;
}
MyShow show=(MyShow)Tools.getManager(MyShow.class).get(showid);
if(show==null){
	 out.print("{\"succ\":false,\"message\":\"参数错误！\"}");
	 return;
}

Long sh=Tools.parseLong(request.getParameter("sh"));
Long jf=Tools.parseLong(request.getParameter("jf"));
Long backtype=Tools.parseLong(request.getParameter("backtype"));
Long score=0l;
if(show.getMyshow_score()!=null){
	score=show.getMyshow_score();
}
show.setMyshow_checkdate(new Date());
show.setMyshow_checkuser(session.getAttribute("admin_mng").toString());
show.setMyshow_score(jf);
show.setMyshow_status(sh);
show.setMyshow_reasontype(backtype);
if("0".equals(mbrid)){
	show.setMyshow_content(request.getParameter("sdcontent"));
}
show.setMyshow_reason(request.getParameter("tcontent"));
Tools.getManager(MyShow.class).clearListCache(show);
if(Tools.getManager(MyShow.class).update(show, true)){
	if("0".equals(mbrid)|| UserHelper.getById(mbrid)!=null ){
		 jf=jf-score;
		 if(jf!=0 && !"0".equals(mbrid)){
			 ArrayList<UserScore> scorelist=getUserSDScore(mbrid) ;
				if(scorelist!=null && scorelist.size()>0){
					  UserScore userscore= scorelist.get(0);
					 
					  userscore.setUsrscore_allscr(userscore.getUsrscore_allscr().floatValue()+jf);
					  userscore.setUsrscore_createdate(new Date());
					  userscore.setUsrscore_realscr(userscore.getUsrscore_realscr().floatValue()+jf);
					  userscore.setUsrscore_scr(userscore.getUsrscore_scr().floatValue()+jf);
					  
					 Tools.getManager(userscore.getClass()).clearListCache(userscore);
					if(Tools.getManager(userscore.getClass()).update(userscore, true)){
						out.print("{\"success\":true,message:\"保存成功！\"}");
						return;
					
					}else{
						out.print("{\"success\":true,message:\"用户积分添加失败！\"}");
						return;
					}

				}else{
				Calendar ca = Calendar.getInstance();
				   int year = ca.get(Calendar.YEAR);//获取年份
				   int month=ca.get(Calendar.MONTH)+1;//获取月份
				  UserScore userscore= new UserScore();
				 userscore.setUsrscore_allscr(new Float(jf));
				 userscore.setUsrscore_buymoney(new Float(0));
				 userscore.setUsrscore_createdate(new Date());
				 userscore.setUsrscore_jlper("0");
				 userscore.setUsrscore_lxmonth(new Long(0));
				 userscore.setUsrscore_mbrid(new Long(mbrid));
				 userscore.setUsrscore_month(month+"");
				 userscore.setUsrscore_rcmscr(new Float(0));
				 userscore.setUsrscore_realscr(new Float(jf));
				 userscore.setUsrscore_scr(new Float(jf));
				 userscore.setUsrscore_tktvalue(new Float(0));
				 userscore.setUsrscore_type(new Long(8));
				 userscore.setUsrscore_year(year+"");
				userscore=(UserScore)Tools.getManager(UserScore.class).create(userscore);
				if(userscore!=null && !Tools.isNull(userscore.getId())){
					out.print("{\"success\":true,message:\"保存成功！\"}");
					return;
				}else{
					out.print("{\"success\":true,message:\"用户积分添加失败！\"}");
					return;
				}
			} 
		 }
		 

		
}else{
	out.print("{\"success\":true,message:\"用户不存在！\"}");
	return;

}
	out.print("{\"success\":true,message:\"保存成功！\"}");
	return;	
}else{
	out.print("{\"success\":true,message:\"保存失败！\"}");
	return;
}
%>