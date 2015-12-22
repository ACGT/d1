<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%><%@include
	file="../inc/islogin.jsp"%>
<%!
public static List getMyComment(Long mbrid,String orderid,String goodsid){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdscom_mbrid", mbrid));
	listRes.add(Restrictions.eq("gdscom_odrid", orderid));
	listRes.add(Restrictions.eq("gdscom_gdsid", goodsid));
	//listRes.add(Restrictions.eq("sessionid", sessionid));
	return Tools.getManager(Comment.class).getList(listRes, null, 0, 10);
}
static ArrayList<UserScore> getUserCommentScore(String mbrid){
	ArrayList<UserScore> rlist = new ArrayList<UserScore>();
	Calendar ca = Calendar.getInstance();
    int year = ca.get(Calendar.YEAR);//获取年份
    int month=ca.get(Calendar.MONTH)+1;//获取月份
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("usrscore_mbrid", new Long(mbrid)));
	clist.add(Restrictions.eq("usrscore_type", new Long(4)));
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
if(!Tools.isNull(request.getParameter("orderid"))){
	String orderid=request.getParameter("orderid").trim();
	if(orderid.length()!=12){
		orderid="0"+orderid;
	}
	//判断订单是否属于改用户
	OrderBase obase=OrderHelper.getById(orderid);
	 if(obase!=null){
		  if(!lUser.getId().equals(String.valueOf(obase.getOdrmst_mbrid()))){
			  Tools.outJs(out,"你没有权限进行操作！","back");
				return;
		  }else{
if(request.getParameterValues("productid")!=null && request.getParameterValues("productname")!=null && request.getParameterValues("tcontent")!=null){
String [] pidlist= (String[])request.getParameterValues("productid");
String [] pnamelist= (String[])request.getParameterValues("productname");
String [] scores= new String [pidlist.length];
String [] contents= (String[])request.getParameterValues("tcontent");

for(int i=0;i<pidlist.length;i++){
	String markValue="rlevel"+(i+1);
	if(request.getParameter(markValue)!=null){
		scores[i]=request.getParameter(markValue);
		}
}
String speed= request.getParameter("hfspeed");
String base= request.getParameter("hfbase");
String service= request.getParameter("hfservice");
String msn= request.getParameter("hfmsn");
String other= request.getParameter("txtother");
String sessionid=Tools.getDBDate();
int j=0;
if((pidlist.length==pnamelist.length) && (pidlist.length==scores.length) && (pidlist.length==contents.length)){
	
	int k=0;	
	for(int i=0;i<pidlist.length;i++){
		 List<Comment> list2=getMyComment(new Long(lUser.getId()),orderid,pidlist[i]);//
			if(list2!=null && list2.size()>0){
				 k++;
			}
	}
	if(k==pidlist.length){
		out.print("对不起，该商品您已评论过，请务重复评论");
		response.sendRedirect("/wap/user/comment.jsp");
		return;
	}else{	
		int nocontentcount=0;//没有填写评价内容的个数
	for(int i=0;i<pidlist.length;i++){
	String content="好评！";
	int status=1;
	int checkstatus=0;
	String op="";
	 if(!Tools.isNull(contents[i])){
		 content=contents[i];
	 }else{
		 nocontentcount++;
		 checkstatus=1;
		 status=0;
		 op="0";
		 if(scores[i].equals("1")){
			 content="不喜欢"; 
		 }else if(scores[i].equals("2")){
			 content="一般"; 
		 }else if(scores[i].equals("3")){
			 content="喜欢"; 
		 }else if(scores[i].equals("4")){
			 content="很喜欢"; 
		 }else if(scores[i].equals("5")){
			 content="非常喜欢"; 
		 }
	 }
	
		//System.out.print(URLDecoder.decode(request.getParameter("gdsname"),"UTF-8"));
		Comment comment=new Comment();
		// comment.setSessionid(sessionid);
		 comment.setGdscom_odrid(orderid);
		 comment.setGdscom_mbrid(new Long(lUser.getId()));
		 comment.setGdscom_uid(lUser.getMbrmst_uid());
		 comment.setGdscom_gdsid(pidlist[i]);
		 comment.setGdscom_gdsname(pnamelist[i]);
		 comment.setGdscom_content(content);
		 comment.setGdscom_createdate(new Date());
		 comment.setGdscom_status(new Long(status));
		 comment.setGdscom_level(new Long(scores[i]));
		 comment.setGdscom_operator(op);
		 comment.setGdscom_replydate(null);
		 comment.setGdscom_checkStatue(new Long(checkstatus));
		 comment.setGdscom_replyContent("");
		 comment.setGdscom_replyStatus(new Long(0));
		 comment.setGdscom_pic1("");
		 comment.setGdscom_pic2("");
		 comment.setGdscom_pic3("");
		 comment=(Comment)Tools.getManager(Comment.class).create(comment);
		 
		 //添加d1购物评价
		 if(i+1==pidlist.length){
			 try{
				 D1Comment d1=new D1Comment();
				 d1.setSessionid(sessionid);
				 d1.setCommenttime(new Date());
				 d1.setGdscom_base(base);
				 d1.setGdscom_mbrid(new Long(lUser.getId()));
				 d1.setGdscom_msn(msn);
				 d1.setGdscom_odrid(orderid);
				 d1.setGdscom_other(other);
				 d1.setGdscom_service(service);
				 d1.setGdscom_speed(speed);
				 d1.setGdscom_uid(lUser.getMbrmst_uid());
				 d1=(D1Comment)Tools.getManager(D1Comment.class).create(d1);
				 

			 }catch(Exception e){
				 
			 }
		 }
		 if(comment!=null){
			j++;
			
			if(j==pidlist.length){
				if(Tools.isNull(Tools.getCookie(request,"PINGAN"))){
	    		  //积分操作
	    		  ArrayList<UserScore> scorelist=getUserCommentScore(lUser.getId()) ;
	    		  int plscore=5*nocontentcount+10*(pidlist.length-nocontentcount);
	    			 OrderScore score= new OrderScore();
	     			 score.setGdscomscore_createtime(new Date());
	     			 score.setGdscomscore_mbrid(new Long(lUser.getId()));
	     			 score.setGdscomscore_orderid(orderid);
	     			 score.setGdscomscore_score(new Long(plscore));
	     			 score=(OrderScore)Tools.getManager(OrderScore.class).create(score);
	     			 if(score!=null){
	     				//如果当月有评论积分，修改当月数据
	     	    		  if(scorelist!=null && scorelist.size()>0){
	     	    			  UserScore userscore= scorelist.get(0);
	     	    			  userscore.setUsrscore_allscr(userscore.getUsrscore_allscr().floatValue()+plscore);
	     	    			  userscore.setUsrscore_createdate(new Date());
	     	    			  userscore.setUsrscore_realscr(userscore.getUsrscore_realscr().floatValue()+plscore);
	     	    			  userscore.setUsrscore_scr(userscore.getUsrscore_scr().floatValue()+plscore);
	     	    			 Tools.getManager(userscore.getClass()).clearListCache(userscore);
	     	    			if(Tools.getManager(userscore.getClass()).update(userscore, true)){
	     	    				//response.sendRedirect("commentsucess.jsp?orderid="+request.getParameter("orderid")+"&sessionid="+sessionid)	;		
	     	    			}
	     	    		  }
	     	    			//没有，添加新积分记录
	     	    		  else{
	     	    			 Calendar ca = Calendar.getInstance();
		     	    		    int year = ca.get(Calendar.YEAR);//获取年份
		     	    		    int month=ca.get(Calendar.MONTH)+1;//获取月份
		     	    		   UserScore userscore= new UserScore();
		  	    			  userscore.setUsrscore_allscr(new Float(plscore));
		  	    			  userscore.setUsrscore_buymoney(new Float(0));
		  	    			  userscore.setUsrscore_createdate(new Date());
		  	    			  userscore.setUsrscore_jlper("0");
		  	    			  userscore.setUsrscore_lxmonth(new Long(0));
		  	    			  userscore.setUsrscore_mbrid(new Long(lUser.getId()));
		  	    			  userscore.setUsrscore_month(month+"");
		  	    			  userscore.setUsrscore_rcmscr(new Float(0));
		  	    			  userscore.setUsrscore_realscr(new Float(plscore));
		  	    			  userscore.setUsrscore_scr(new Float(plscore));
		  	    			  userscore.setUsrscore_tktvalue(new Float(0));
		  	    			  userscore.setUsrscore_type(new Long(4));
		  	    			  userscore.setUsrscore_year(year+"");
	  	    			userscore=(UserScore)Tools.getManager(UserScore.class).create(userscore);
	  	    			if(userscore!=null){
	  	    				//response.sendRedirect("commentsucess.jsp?orderid="+request.getParameter("orderid")+"&sessionid="+sessionid)	;		
	  	    			}
	     	    		  }
	     			 }
			}
				//if(lUser.getId().equals("482263") || lUser.getId().equals("3")){
					//response.sendRedirect("test.jsp?orderid="+request.getParameter("orderid")+"&sessionid="+sessionid)	;		
				//}else{
				response.sendRedirect("commentsucess.jsp?orderid="+orderid+"&sessionid="+sessionid)	;		
				//}
			}
	     		
				
		 }else{
			 out.print("0");
		 }
}
}
}
}
		  }
	 }
}
%>