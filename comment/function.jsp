<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/inc/islogin.jsp"%><%!

public static List getMyComment(Long mbrid,String orderid,String goodsid){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdscom_mbrid", mbrid));
	listRes.add(Restrictions.eq("gdscom_odrid", orderid));
	listRes.add(Restrictions.eq("gdscom_gdsid", goodsid));
	//listRes.add(Restrictions.eq("sessionid", sessionid));
	return Tools.getManager(Comment.class).getList(listRes, null, 0, 10);
}
public static int getMyCommentlen(Long mbrid,String orderid){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdscom_mbrid", mbrid));
	listRes.add(Restrictions.eq("gdscom_odrid", orderid));
	//listRes.add(Restrictions.eq("sessionid", sessionid));
	return Tools.getManager(Comment.class).getLength(listRes);
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

static ArrayList<OrderScore> getFxScore(String mbrid,String orderid){
	ArrayList<OrderScore> rlist = new ArrayList<OrderScore>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdscomscore_mbrid", new Long(mbrid)));
	clist.add(Restrictions.eq("gdscomscore_status", new Long(1)));
	clist.add(Restrictions.eq("gdscomscore_orderid", orderid));
	List<BaseEntity> list = Tools.getManager(OrderScore.class).getList(clist, null, 0, 10);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((OrderScore)be);
	}
	return rlist ;
}
static ArrayList<UserScore> getUserFxScore(String mbrid){
	ArrayList<UserScore> rlist = new ArrayList<UserScore>();
	Calendar ca = Calendar.getInstance();
    int year = ca.get(Calendar.YEAR);//获取年份
    int month=ca.get(Calendar.MONTH)+1;//获取月份
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("usrscore_mbrid", new Long(mbrid)));
	clist.add(Restrictions.eq("usrscore_type", new Long(5)));
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

if(request.getParameterValues("productid")!=null && request.getParameterValues("productname")!=null && request.getParameterValues("mark.markValue")!=null && request.getParameterValues("tcontent")!=null){
String [] pidlist= (String[])request.getParameterValues("productid");
String [] pnamelist= (String[])request.getParameterValues("productname");
String [] scores= (String[])request.getParameterValues("mark.markValue");
String [] contents= (String[])request.getParameterValues("tcontent");
String [] heightlist=(String[])request.getParameterValues("theight");
String [] weightlist=(String[])request.getParameterValues("tweight");
String [] complist=(String[])request.getParameterValues("hcomp");
String [] skulist=(String[])request.getParameterValues("hsku");
String speed= request.getParameter("hfspeed");
String base= request.getParameter("hfbase");
String service= request.getParameter("hfservice");
String msn= request.getParameter("hfmsn");
String other= request.getParameter("txtother");
String sessionid=Tools.getDBDate();
int j=0;
out.println(heightlist.length);
out.println(weightlist.length);
out.println(complist.length);
out.println(skulist.length);


if((pidlist.length==pnamelist.length) && (pidlist.length==scores.length) && (pidlist.length==contents.length)){
	int k=0;	
	
	if(k==pidlist.length){
		out.print("<script>alert('对不起，该商品您已评论过，请务重复评论');window.location.href='/user/comment.jsp';</script>");
	}else{	
		int nocontentcount=0;//没有填写评价内容的个数
	for(int i=0;i<pidlist.length;i++){
	String content="好评！";
	int status=1;
	int checkstatus=0;
	String op="";
	 if(!Tools.isNull(contents[i]) && !"您还没有填写评价内容哦！".equals(contents[i].trim())){
		 content=contents[i];
	 }else{//评论内容为空
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
		 comment.setGdscom_weight(weightlist[i]);
		 comment.setGdscom_height(heightlist[i]);
		 comment.setGdscom_comp(complist[i]);
		 comment.setGdscom_sku1(skulist[i]);
		 comment=(Comment)Tools.getManager(Comment.class).create(comment);
		
		//out.println("订单号："+orderid);
		//out.println("商品编号："+pidlist[i]);
		//out.println("sku："+skulist[i]);
		//out.println("身高："+heightlist[i]);
		//out.println("体重："+weightlist[i]);
		//out.println("是否合适："+complist[i]);
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
					//评论所得积分
					int plscore=5*nocontentcount+10*(pidlist.length-nocontentcount);
	    		  //积分操作
	    		  ArrayList<UserScore> scorelist=getUserCommentScore(lUser.getId()) ;
	    		
	    			 OrderScore score= new OrderScore();
	     			 score.setGdscomscore_createtime(new Date());
	     			 score.setGdscomscore_mbrid(new Long(lUser.getId()));
	     			 score.setGdscomscore_orderid(orderid);
	     			 score.setGdscomscore_score(new Long(plscore));
	     			 score.setGdscomscore_status(new Long(0));
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

if(!Tools.isNull(request.getParameter("commentid")) && !Tools.isNull(request.getParameter("fxtype")) && !Tools.isNull(request.getParameter("orderid"))){
	 Comment comment=CommentHelper.getById(request.getParameter("commentid"));
				//判断之前是否该平台分享过
				boolean blsina=Tools.isNull(comment.getGdscom_pic1())? false:true;
				boolean blsohu=Tools.isNull(comment.getGdscom_pic2())? false:true;
				boolean bltx=Tools.isNull(comment.getGdscom_pic3())? false:true;
				String fxtype=request.getParameter("fxtype");
				boolean iserror=false;//是否为非正规操作
				if(comment!=null){
					if("sina".equals(fxtype) && blsina) iserror=true;
					if("sohu".equals(fxtype) && blsohu) iserror=true;
					if("tx".equals(fxtype) && bltx) iserror=true;
					
					if(!iserror){
					
					if("sina".equals(fxtype) && !blsina){
						comment.setGdscom_pic1("1");
					}
					else if("sohu".equals(fxtype) && !blsohu){
						comment.setGdscom_pic2("1");
					}
					else if("tx".equals(fxtype) && !bltx){
						comment.setGdscom_pic3("1");
					}
					if(CommentHelper.manager.update(comment, false)){
						if(Tools.isNull(Tools.getCookie(request,"PINGAN"))){
						 ArrayList<OrderScore> scorelist=getFxScore(lUser.getId(),orderid) ;//是否存在分享积分
						
						int gdscount=getMyCommentlen(new Long(lUser.getId()),orderid); //获得订单商品数
						 ArrayList<UserScore> uscorelist=getUserFxScore(lUser.getId()) ;//获得用户在该月的分享积分
						 if(scorelist!=null && scorelist.size()>0){
							OrderScore orderscore=scorelist.get(0);//获得该订单的分享积分
							int oldscore=orderscore.getGdscomscore_score().intValue();
							if(oldscore<gdscount*15){//积分最多为商品数*60
							orderscore.setGdscomscore_score(new Long(oldscore+5));
							if(Tools.getManager(OrderScore.class).update(orderscore, false)){
								if(uscorelist!=null && uscorelist.size()>0){
									 UserScore userscore= uscorelist.get(0);
			    	    			
			    	    			  userscore.setUsrscore_allscr(userscore.getUsrscore_allscr().floatValue()+5);
			     	    			  userscore.setUsrscore_createdate(new Date());
			     	    			  userscore.setUsrscore_realscr(userscore.getUsrscore_realscr().floatValue()+5);
			     	    			  userscore.setUsrscore_scr(userscore.getUsrscore_scr().floatValue()+5);
			     	    			  
			    	    			  
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
				  	    			  userscore.setUsrscore_allscr(new Float(5));
				  	    			  userscore.setUsrscore_buymoney(new Float(0));
				  	    			  userscore.setUsrscore_createdate(new Date());
				  	    			  userscore.setUsrscore_jlper("0");
				  	    			  userscore.setUsrscore_lxmonth(new Long(0));
				  	    			  userscore.setUsrscore_mbrid(new Long(lUser.getId()));
				  	    			  userscore.setUsrscore_month(month+"");
				  	    			  userscore.setUsrscore_rcmscr(new Float(0));
				  	    			  userscore.setUsrscore_realscr(new Float(5));
				  	    			  userscore.setUsrscore_scr(new Float(5));
				  	    			  userscore.setUsrscore_tktvalue(new Float(0));
				  	    			  userscore.setUsrscore_type(new Long(5));
				  	    			  userscore.setUsrscore_year(year+"");
				  	    			userscore=(UserScore)Tools.getManager(UserScore.class).create(userscore);
				  	    			if(userscore!=null){
				  	    				out.print("1");
				  	    				return;
				  	    			}
								}
								
							}else{
								out.print("0");
							}
							}	
						}else{
							
							OrderScore orderscore=new OrderScore();
							orderscore.setGdscomscore_createtime(new Date());
							orderscore.setGdscomscore_orderid(orderid);
							orderscore.setGdscomscore_status(new Long(1));
							orderscore.setGdscomscore_score(new Long(5));
							orderscore.setGdscomscore_mbrid(new Long(lUser.getId()));
							orderscore=(OrderScore)Tools.getManager(OrderScore.class).create(orderscore);
							if(orderscore!=null){
								if(uscorelist!=null && uscorelist.size()>0){
									 UserScore userscore= uscorelist.get(0);
			   	    			
			   	    			 userscore.setUsrscore_allscr(userscore.getUsrscore_allscr().floatValue()+5);
				    			  userscore.setUsrscore_createdate(new Date());
				    			  userscore.setUsrscore_realscr(userscore.getUsrscore_realscr().floatValue()+5);
				    			  userscore.setUsrscore_scr(userscore.getUsrscore_scr().floatValue()+5);
				    			  
			   	    			  
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
				  	    			  userscore.setUsrscore_allscr(new Float(5));
				  	    			  userscore.setUsrscore_buymoney(new Float(0));
				  	    			  userscore.setUsrscore_createdate(new Date());
				  	    			  userscore.setUsrscore_jlper("0");
				  	    			  userscore.setUsrscore_lxmonth(new Long(0));
				  	    			  userscore.setUsrscore_mbrid(new Long(lUser.getId()));
				  	    			  userscore.setUsrscore_month(month+"");
				  	    			  userscore.setUsrscore_rcmscr(new Float(0));
				  	    			  userscore.setUsrscore_realscr(new Float(5));
				  	    			  userscore.setUsrscore_scr(new Float(5));
				  	    			  userscore.setUsrscore_tktvalue(new Float(0));
				  	    			  userscore.setUsrscore_type(new Long(5));
				  	    			  userscore.setUsrscore_year(year+"");
				  	    			userscore=(UserScore)Tools.getManager(UserScore.class).create(userscore);
				  	    			if(userscore!=null){
				  	    				out.print("1");
				  	    				return;
				  	    			}
								}
							}else{
								out.print("0");
							}
						}
					}
						else{
							out.print("1");
						}
					}
				}
				}
		  }
	  }
	 }
}
%>