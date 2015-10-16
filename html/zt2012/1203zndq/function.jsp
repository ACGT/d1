<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
static ArrayList<UserScore> getUserZfScore(String mbrid){
	ArrayList<UserScore> rlist = new ArrayList<UserScore>();
	Calendar ca = Calendar.getInstance();
    int year = ca.get(Calendar.YEAR);//获取年份
    int month=ca.get(Calendar.MONTH)+1;//获取月份
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("usrscore_mbrid", new Long(mbrid)));
	clist.add(Restrictions.eq("usrscore_type", new Long(6)));
	clist.add(Restrictions.eq("usrscore_year", year+""));
	clist.add(Restrictions.eq("usrscore_month", month+""));
	List<BaseEntity> list = Tools.getManager(UserScore.class).getList(clist, null, 0, 10);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((UserScore)be);
	}
	return rlist ;
}
%>
<%
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>Login_Dialog();<%
	return;
}
if(!Tools.isNull(request.getParameter("zf")) && !Tools.isNull(request.getParameter("zfcontent"))){
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
		out.print("2");
		return;
	}else{
		ZhuFu zf=new ZhuFu();
		zf.setZnzhufu_content(request.getParameter("zfcontent"));
		zf.setZnzhufu_createdate(new Date());
		zf.setZnzhufu_mbrid(new Long(lUser.getId()));
		zf.setZnzhufu_mbruid(lUser.getMbrmst_uid());
		zf=(ZhuFu)Tools.getManager(ZhuFu.class).create(zf);
		if(zf!=null){
			 ArrayList<UserScore> uscorelist=getUserZfScore(lUser.getId()) ;
			 if(uscorelist!=null && uscorelist.size()>0){
				 UserScore userscore= uscorelist.get(0);
    			  float olduscore=userscore.getUsrscore_allscr().floatValue();
    			  userscore.setUsrscore_allscr(userscore.getUsrscore_allscr().floatValue()+50);
	    			  userscore.setUsrscore_createdate(new Date());
	    			  userscore.setUsrscore_realscr(userscore.getUsrscore_realscr().floatValue()+50);
	    			  userscore.setUsrscore_scr(userscore.getUsrscore_scr().floatValue()+50);
	    			  
    			  
    			 Tools.getManager(userscore.getClass()).clearListCache(userscore);
    			if(Tools.getManager(userscore.getClass()).update(userscore, true)){
    				out.print("1");
    				return;
    			}
			}else{
				 Calendar ca = Calendar.getInstance();
 	    		    int year = ca.get(Calendar.YEAR);//获取年份
 	    		    int month=ca.get(Calendar.MONTH)+1;//获取月份
 	    		   UserScore userscore= new UserScore();
	    			  userscore.setUsrscore_allscr(new Float(50));
	    			  userscore.setUsrscore_buymoney(new Float(0));
	    			  userscore.setUsrscore_createdate(new Date());
	    			  userscore.setUsrscore_jlper("0");
	    			  userscore.setUsrscore_lxmonth(new Long(0));
	    			  userscore.setUsrscore_mbrid(new Long(lUser.getId()));
	    			  userscore.setUsrscore_month(month+"");
	    			  userscore.setUsrscore_rcmscr(new Float(0));
	    			  userscore.setUsrscore_realscr(new Float(50));
	    			  userscore.setUsrscore_scr(new Float(50));
	    			  userscore.setUsrscore_tktvalue(new Float(0));
	    			  userscore.setUsrscore_type(new Long(6));
	    			  userscore.setUsrscore_year(year+"");
	    			userscore=(UserScore)Tools.getManager(UserScore.class).create(userscore);
	    			if(userscore!=null){
	    				out.print("1");
	    				return;
	    			}
			}
		}
			
	}
}

%>