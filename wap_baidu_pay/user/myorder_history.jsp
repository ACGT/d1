<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%><%@include
	file="../inc/islogin.jsp"%>
<%!
static String cancelorder(String orderid,int flag,String userid){
	 if(orderid!=null&&orderid.length()>0&&flag>=0){
	    	OrderBase ob;
	    	ArrayList<OrderItemBase> list=new ArrayList<OrderItemBase>();
		    switch(flag)
		    {
			    case 1:
			    case 2:
			    case 3:
			    {
			    	ob=OrderHelper.getById(orderid.trim());
			    	list=OrderItemHelper.getOdrdtlListByOrderId(orderid.trim());
			    	break;
			    }
			    case 4:
			    {
			    	ob=OrderHelper.getHistoryById(orderid.trim());
			    	list=OrderItemHelper.getOdrdtlListByOrderId(orderid.trim());
			    	break;
			    }
			   
			    default:
			    {
			    	ob=OrderHelper.getById(orderid.trim());
			    	list=OrderItemHelper.getOdrdtlListByOrderId(orderid.trim());
			    	break;
			    }
		    
		    }
		    if(ob!=null&&ob.getOdrmst_mbrid().toString().equals(userid)&&ob.getOdrmst_orderstatus().longValue()==0)
		    {
		    	
		          try{   		
		 
			        OrderService os = (OrderService)Tools.getService(OrderService.class);
			    	os.cancelOrder(ob);
			    	ob.setOdrmst_ourmemo(ob.getOdrmst_ourmemo()+"<br/>"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())+"用户自行取消<br/>");
			    	ob.setOdrmst_canceldate(new Date());
					Tools.getManager(ob.getClass()).update(ob, false);
		          }
		          catch(Exception ex)
		          {
		        	  return (ex.getMessage()+"取消订单失败！");
		          }
		   
		  
		    	if(list!=null&&list.size()>0)
		    	{
		    		for(OrderItemBase oib:list)
		    		{
		    			if(oib!=null)
		    			{
		    				if(oib.getOdrdtl_tuancardno()!=null&&oib.getOdrdtl_tuancardno().length()>0)
			    			{
			    				Tuandh t=TuandhHelper.getTuandhByCardno(oib.getOdrdtl_tuancardno().trim());
			    				if(t!=null)
			    				{
				    				t.setTuandh_status(new Long(0));
				    				t.setTuandh_odrid("");
				    				t.setTuandh_memo(t.getTuandh_memo()+orderid);
				    				
				    				Tools.getManager(Tuandh.class).update(t, false);
			    				}
			    			}
		    			}
		    			
		    		}
		    	}
		    	
		    }
		     else
		    {
	           return "您无权进行此项操作";
		    }
		  
	    }
	    else
	    {
	    	return "参数不正确";
	    }
	 return "";
}

%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—四个月之前订单</title>
<style type="text/css">
body {
	line-height: 21px;
	background: #fff;
	padding-left: 4px;
	color: #333
}

a {
	text-decoration: none;
	color: #4169E1
}

a:hover {
	color: #aa2e44
}

img {
	border: none;
}
</style>
</head>
<body>
	<!-- 头部 -->
	<%@ include file="../inc/head.jsp"%>
	<!-- 头部结束 -->
	<div style="margin-bottom: 15px;">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>><a href="index.jsp">我的优尚</a>>我的四个月前订单 <br />
		</div>
		<% 
    String msg="";
    if(!Tools.isNull(request.getParameter("orderid"))  && !Tools.isNull(request.getParameter("flag"))){
    	int flag=Integer.parseInt(request.getParameter("flag"));
    	msg=cancelorder(request.getParameter("orderid"), flag, lUser.getId());
    }
	ArrayList<OrderBase> result=new ArrayList<OrderBase>();
	result=OrderHelper.getOrderHistoryListByMbrid(lUser.getId(), 1000);
	int pageno1=1;
	   
	   
	   //分页
	   String ggURL = Tools.addOrUpdateParameter(request,null,null);
	   
   if(ggURL != null) 
	   {
	     ggURL.replaceAll("pageno1=[0-9]*","");
	    }
//翻页
  int totalLength1 =(result != null ?result.size() : 0);
  	
		int PAGE_SIZE = 10 ;
	    int currentPage1 = 1 ;
	    
	    String pg1 ="1";
	    
	    if(request.getParameter("pageno1")!=null)
	    {
	    	pg1= request.getParameter("pageno1");
	    }
	   
	    if(StringUtils.isDigits(pg1))currentPage1 = Integer.parseInt(pg1);
	   
	    PageBean pBean1 = new PageBean(totalLength1,PAGE_SIZE,currentPage1);
	    
	   
	    int end1 = pBean1.getStart()+PAGE_SIZE;
	    if(end1 > totalLength1) end1 = totalLength1;
	    
		
		String pageURL1 = ggURL.replaceAll("pageno1=[^&]*","");
		
	    if(!pageURL1.endsWith("&")) pageURL1 = pageURL1 + "&";
	    
	
    if(result==null||result.size()==0){
         
    	    out.print("<br/><font color='red'>您四个月之前没有下过订单!</font><a href=\"/wap/user/myorder.jsp\">请查看四个月内订单</a>");
    	  }
    else
    {
    	out.println("<span style='color:red;'>"+msg+"</span><br/>");
    	out.print("<table>");
    	if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
		   {
			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
		   }
    	for(int i=(pageno1-1)*5;i<pageno1*5&&i<result.size();i++)
    	{
    	   OrderBase ob=result.get(i);
    	   if(ob!=null)
    	   {
    	%>
		<tr>
			<td align="right">订单号：</td>
			<td><a href="orderdetail.jsp?orderid=<%= ob.getId() %>"><%= ob.getId() %></a></td>
		</tr>
		<tr>
			<td>订购时间：</td>
			<td><%= new SimpleDateFormat("yyyy-MM-dd HH:mm").format(ob.getOdrmst_orderdate()) %></td>
		</tr>
		<tR>
			<td>应付金额：</td>
			<td><%= OrderHelper.getOrderTotalMoney(ob.getId()) %>元</td>
		</tR>
		<tr>
			<td>订单状态：</td>
			<td><%= getOrderStatuByPaytype(ob.getOdrmst_paytype().toString(),ob.getOdrmst_orderstatus().toString())   %></td>
		</tr>
		<tr style="border-bottom: solid 1px #00f;">
			<td colspan="2" align="left">
				<% if(ob.getOdrmst_orderstatus().longValue()!=-1&&ob.getOdrmst_orderstatus().longValue()!=-2&&ob.getOdrmst_orderstatus().longValue()!=-3) 
    		{
    			Comment comment = getCommentbyOrderId(ob.getId());
    		   %> <%
    			if(ob.getOdrmst_orderstatus().longValue()==5||ob.getOdrmst_orderstatus().longValue()==51||ob.getOdrmst_orderstatus().longValue()==61||ob.getOdrmst_orderstatus().longValue()==6)
    			{
    			    if(comment==null)
    			    {
    			 %> <a
				href="/wap/comment/addcomment1.jsp?orderid=<%= ob.getId() %>">我要评论>></a>
				<%  }
    			    
    			}
    			else if(ob.getOdrmst_orderstatus().longValue()==1||ob.getOdrmst_orderstatus().longValue()==2)
    			{
    				out.print("库房备货中");
    			}
    			else if(ob.getOdrmst_orderstatus().longValue()==3||ob.getOdrmst_orderstatus().longValue()==31)
    			{%> <a
				href="/wap/comment/addcomment1.jsp?orderid=<%= ob.getId() %>">确认收货并评价>></a>
				<%}
    			else
    			{
    				out.print(" <a href=\"confirmcancelorder.jsp?orderid="+ob.getId()+"&from=1&flag="+String.valueOf(ob.getType())+"\"  class=\"a\">取消订单>></a>");
    			}
    			%> <%	}
    		%>
			</td>
		</tr>
		<%}
    	}
    	out.print("</table>");
    }
      %>

		<% 
	   //分页
	    if(pBean1.getTotalPages()>1){%>
		<form action="myorder_history.jsp">
			<br />
			<a
				href="<%=pageURL1%>pageno1=<%=pBean1.getNextPage()==-1?pBean1.getTotalPages():pBean1.getNextPage()%>">下页</a>
			<input type="text" style="width: 50px;" id="page" name="pageno1"
				value="<%=pageno1%>"></input>/<%=pBean1.getTotalPages() %>页
			<input type="submit" value="跳&nbsp;转"
				style="width: 80px; height: 20px;"></input>
			<br />
			<a
				href="<%=pageURL1%>pageno1=<%=pBean1.getPreviousPage()==-1?1:pBean1.getPreviousPage()%>">返回上一页>></a>
		</form>
		<%}
	    %>


	</div>



	<!-- 尾部 -->
	<%@ include file="../inc/userfoot.jsp"%>
	<!-- 尾部结束 -->

</body>
</html>
