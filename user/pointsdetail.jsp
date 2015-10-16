<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%>
<%!
public static ArrayList<UserScore> getUserScoreInfo(String mbrid){
	ArrayList<UserScore> rlist = new ArrayList<UserScore>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("usrscore_mbrid", new Long(mbrid)));
	clist.add(Restrictions.eq("usrscore_type", new Long(9)));
	List<Order> olist= new ArrayList<Order>();
	olist.add(Order.desc("usrscore_createdate"));
	List<BaseEntity> list = Tools.getManager(UserScore.class).getList(clist, olist, 0, 1000);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((UserScore)be);
	}
	return rlist ;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——积分详情</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
</head>
<body>
    <!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
     <!-- 中间内容 -->
     <div class="center">
        
     <%@include file="left.jsp" %>
     <!-- 右侧 -->
       <div class="mbr_right">
       <%
       String flag="";int w=250;int cols=4;
       if(request.getParameter("type")!=null&&request.getParameter("type").length()>0)
       {
     	  flag=request.getParameter("type");
       }
       %>
         <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="paymethodlist" style=" border:solid 1px #c2c2c2; border-bottom:none;" >	   

		  <tr style=" color:#a25663;" height="33"><td   width="160">订单号</td>
		  <%if("8".equals(flag)){
			  w=130;cols=5;
			  %>
			  <td width="120">商品编号</td>
		 <% }%>
		  <td  width="120">积分</td><td width="<%=w%>">获取类型</td><td>获取时间</td></tr>

		  </table>
		  

		  <table width="769"  border="0" cellspacing="1" cellpadding="0"  class="t" >
             <%
                  int record=0;
                  String pdate="";
                  Date sdate =new Date();
                  Date predate =new Date();
                  
                  if(request.getParameter("pointsdate")!=null&&request.getParameter("pointsdate").length()>0)
                  {
                	  pdate=request.getParameter("pointsdate");
                  }
                 
                  if(pdate.length()>0)
                  {
                	  SimpleDateFormat df= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
                	  sdate= df.parse(pdate); 
                  }
                  //获取一个月前的时间
                    SimpleDateFormat df1= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
                    Calendar c=Calendar.getInstance();
					c.setTime(sdate);
					c.add(Calendar.MONTH,-1); //将当前日期加一个月
					c.add(Calendar.DATE,1);
					SimpleDateFormat df2= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
                    String prdate=df1.format(c.getTime());
					predate=df2.parse(prdate);
					if(flag.equals("9")){
						 ArrayList<UserScore> list=getUserScoreInfo(lUser.getId());
						 if(list!=null&&list.size()>0)
						 {
						 record++;%>
						<tr height="33">
	                	   <td width="160"></td>	          
	                	   <td  width="120"><span><B>1000</B></span></td>
	                	   <td width="250">白金会员赠送积分</td>
	                	   <td ><%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(list.get(0).getUsrscore_createdate()) %></td>
	                	</tr>  
						 <%}
					}
					else
					{
					if(!flag.equals("8"))
					{	
				if(!flag.equals("4"))
				{
					if(!flag.equals("5"))
					{
						if(!flag.equals("6"))
						{
		                  //根据订单时间和会员号获取订单号
		                  ArrayList<OrderBase> list1=new ArrayList<OrderBase>();
		                  ArrayList<OrderBase> list2=new ArrayList<OrderBase>();
		                  list1=OrderHelper.getOrderListIn4MonthsBytime(lUser.getId(),sdate, predate);
		                  list2=OrderHelper.getOrderHistoryListByMbridAndDate(lUser.getId(), sdate, predate);
		                  if(list1!=null&&list1.size()>0)
		                  {
		                    for(OrderBase ob:list1)
		                    {
		                  %>
		                        	   <% 
			                	   Double sumpoints=new Double(0);  
		                	       if(ob.getOdrmst_orderstatus()==5||ob.getOdrmst_orderstatus()==51||ob.getOdrmst_orderstatus()==3||ob.getOdrmst_orderstatus()==31||ob.getOdrmst_orderstatus()==6||ob.getOdrmst_orderstatus()==61)
		                	       { 
			                		   record++;
			                	     ArrayList<OrderItemBase> ollist=OrderItemHelper.getOdrdtlListByOrderId(ob.getId());
			
			         	    	     
			                	     if(ollist!=null&&ollist.size()>0)
			                	      {
			                	    	 
			                	    	  for(OrderItemBase olb:ollist)
			                	    	  {
			                	    		  sumpoints+=olb.getOdrdtl_spendcount();
			                	    	  }
			                	      }
			                	   }
		                	       if(sumpoints>0f)
		                	       {
		                	      
		                	   %>
		                	<tr height="33">
		                	   <td width="160"><a href="/user/orderdetail.jsp?orderid=<%= ob.getId() %>"><%= ob.getId() %></a></td>
		          
		                	   <td  width="120"><span><B><%=sumpoints.toString() %></B></span></td>
		                	   <td width="250">购物</td>
		                	   <td ><%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(ob.getOdrmst_orderdate()) %></td>
		                	</tr>  
		                  <%  }
		                    }
		                  }
		                  if(list2!=null&&list2.size()>0)
		                  {
		                	  for(OrderBase ob:list2)
		                	  {
		                	   Double sumpoints=new Double(0);  
		                   	   if(ob.getOdrmst_orderstatus()==5||ob.getOdrmst_orderstatus()==51||ob.getOdrmst_orderstatus()==3||ob.getOdrmst_orderstatus()==31||ob.getOdrmst_orderstatus()==6||ob.getOdrmst_orderstatus()==61)
		                   	   {
		          	    		 record++;
		          	    		 List<OrderItemBase> ollist=OrderItemHelper.getOdrdtHistorylByOrderId(ob.getId());
		          	    		
			             	     if(ollist!=null&&ollist.size()>0)
			             	      {
			             	    	  for(OrderItemBase olb:ollist)
			             	    	  {
			             	    		  sumpoints+=olb.getOdrdtl_spendcount();
			             	    	  }
			             	      }
			             	     if(sumpoints>0)
			             	     {
		                	  %>
		                	   <tr height="33">
		                	   <td width="160"><a href="/user/orderdetail.jsp?orderid=<%= ob.getId() %>"><%= ob.getId() %></a></td>
		                	
		                	 
		             	      <td  width="120"><span><B><%=ProductGroupHelper.getRoundPrice(sumpoints.floatValue()) %></B></span></td>
		                	   <td width="250">购物</td>
		                	   <td ><%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(ob.getOdrmst_orderdate()) %></td>
		                	</tr>  
		             	     <%
		                	  }
		                   	   }
		                	  }
		                  }
						}
						else
						{
							ArrayList<ZhuFu> list=new ArrayList<ZhuFu>();
							List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
							clist.add(Restrictions.eq("znzhufu_mbrid", new Long(lUser.getId())));
							List<Order> olist=new ArrayList<Order>();
							olist.add(Order.desc("znzhufu_createdate"));
							List<BaseEntity> b_list = Tools.getManager(ZhuFu.class).getList(clist, olist, 0, 100);
							for(BaseEntity be:b_list)
							{
								if(be!=null)
								{
									list.add((ZhuFu)be);
								}
							}

		           		    //out.print(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cnew.getTime()));
		           		    if(list!=null&&list.size()>0)
		           		    {
		           		    	for(ZhuFu zf:list)
		           		    	{ 
		           		    		
		           		    		if( zf!=null)
		           		    			{record++;
		           		    	%>
		           		         <tr height="33">
		                	      <td width="160">----</td>
		                	      <td  width="120"><span><B>50</B></span></td>
		                	   <td width="250">祝福积分</td>
		                	   <td ><%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(zf.getZnzhufu_createdate()) %></td>
		                	</tr>  
		           		    <%	}
		           		    	}
		           		    }
						}

					}
					else
					{
					    ArrayList<OrderScore> list=new ArrayList<OrderScore>();
	           		    sdate.setMinutes(sdate.getMinutes()+3);
	           		    Calendar cnew = Calendar.getInstance();
		           		cnew.set(Calendar.YEAR,2010);
		           		cnew.set(Calendar.MONTH,0);
		           		cnew.set(Calendar.DATE,1);
		           		cnew.set(Calendar.HOUR_OF_DAY,0);
		           		cnew.set(Calendar.MINUTE,0);
		           		cnew.set(Calendar.SECOND,0);

	           		    //out.print(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cnew.getTime()));
	           		    list=OrderScoreHelper.getOrderScoresBymbridAnddate(lUser.getId(),sdate,cnew.getTime());
	           		    if(list!=null&&list.size()>0)
	           		    {
	           		    	for(OrderScore od:list)
	           		    	{ 
	           		    		
	           		    		if( od!=null && od.getGdscomscore_status()!=null&&od.getGdscomscore_status().longValue()==1)
	           		    			{record++;
	           		    	%>
	           		         <tr height="33">
	                	      <td width="160"><a href="/user/orderdetail.jsp?orderid=<%= od.getGdscomscore_orderid() %>"><%= od.getGdscomscore_orderid() %></a></td>
	                	      <td  width="120"><span><B><%=ProductGroupHelper.getRoundPrice((float)od.getGdscomscore_score()) %></B></span></td>
	                	   <td width="250">微博分享</td>
	                	   <td ><%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(od.getGdscomscore_createtime()) %></td>
	                	</tr>  
	           		    <%	}
	           		    	}
	           		    }
					}
				}
				else 
				{
           		    ArrayList<OrderScore> list=new ArrayList<OrderScore>();
           		    sdate.setMinutes(sdate.getMinutes()+3);
           		    Calendar cnew = Calendar.getInstance();
	           		cnew.set(Calendar.YEAR,2010);
	           		cnew.set(Calendar.MONTH,0);
	           		cnew.set(Calendar.DATE,1);
	           		cnew.set(Calendar.HOUR_OF_DAY,0);
	           		cnew.set(Calendar.MINUTE,0);
	           		cnew.set(Calendar.SECOND,0);

           		    //out.print(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cnew.getTime()));
           		    list=OrderScoreHelper.getOrderScoresBymbridAnddate(lUser.getId(),sdate,cnew.getTime());
           		    
           		    if(list!=null&&list.size()>0)
           		    {
           		    	for(OrderScore od:list)
           		    	{ 
           		    		if(od.getGdscomscore_status()!=null&&od.getGdscomscore_status().longValue()!=1)
           		    			{record++;
           		    	%>
           		         <tr height="33">
                	      <td width="160"><a href="/user/orderdetail.jsp?orderid=<%= od.getGdscomscore_orderid() %>"><%= od.getGdscomscore_orderid() %></a></td>
                	      <td  width="120"><span><B><%=ProductGroupHelper.getRoundPrice((float)od.getGdscomscore_score()) %></B></span></td>
                	   <td width="250">购买评价</td>
                	   <td ><%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(od.getGdscomscore_createtime()) %></td>
                	</tr>  
           		    <%	}
           		    	}
           		    }
				
				}
           		

				}				else { 
           		    ArrayList<MyShow> list=new ArrayList<MyShow>();
           		    sdate.setMinutes(sdate.getMinutes()+3);
           		    Calendar cnew = Calendar.getInstance();
	           		cnew.set(Calendar.YEAR,2010);
	           		cnew.set(Calendar.MONTH,0);
	           		cnew.set(Calendar.DATE,1);
	           		cnew.set(Calendar.HOUR_OF_DAY,0);
	           		cnew.set(Calendar.MINUTE,0);
	           		cnew.set(Calendar.SECOND,0);

           		    //out.print(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cnew.getTime()));
           		    list=ShowOrderHelper.getSdScoresBymbridAnddate(lUser.getId(),sdate,cnew.getTime());
           		    
           		    if(list!=null&&list.size()>0)
           		    {
           		    	for(MyShow show:list)
           		    	{ 
           		    		record++;
           		    	%>
           		         <tr height="33">
                	       <td width="160"><a href="/user/orderdetail.jsp?orderid=<%=show.getMyshow_odrid() %>"><%= show.getMyshow_odrid() %></a></td>
                	      <td width="120"><a href="/product/<%=show.getMyshow_gdsid() %>"><%= show.getMyshow_gdsid() %></a></td>
                	      <td  width="120"><span><B><%=ProductGroupHelper.getRoundPrice((float)show.getMyshow_score()) %></B></span></td>
                	   <td width="130">晒单积分</td>
                	   <td ><%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(show.getMyshow_createdate()) %></td>
                	</tr>  
           		    <%	
           		    	}
           		    }
				}	
			 }
                 if(record<=0)
                     {%>
                	 <tr><td colspan="<%=cols %>" height="100" style=" font-size:15px; font-weight:bold; color:#a25663;">您没有任何获得积分记录</td></tr>
                	 
                 <% }                	
                	%>
                	
				   </table>
				   <br/>
				    &nbsp;&nbsp;<a href="points.jsp"><font style=" color:#f00; font-size:13px; font-weight:bold;">返回我的积分</font></a>
         </div>
        
         <div class="clear"></div> 

     <!-- 右侧结束 -->     
     
     
     </div>
     <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
</body>
</html>