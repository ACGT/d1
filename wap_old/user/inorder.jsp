<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—进行中的订单</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/wap.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
</head>
<body>
<!-- 头部 -->
<%@ include file="../inc/head.jsp" %>
<!-- 头部结束 -->
<div style=" margin-bottom:15px;">
   <div style=" background:#FFDEAD; padding:3px; width:100%;">
    <a href="/mindex.jsp">首页</a>><a href="index.jsp">我的优尚</a>>查看物流
    <br/>
    </div>
    <% 
    
	ArrayList<OrderBase> result=new ArrayList<OrderBase>();
	result=OrderHelper.getTotalOrderListIn4Months(lUser.getId());
	ArrayList<OrderBase> result_end=new ArrayList<OrderBase>();
	
	for(OrderBase ob:result)
	{
		if(ob.getOdrmst_orderstatus().longValue()==3||ob.getOdrmst_orderstatus().longValue()==31)
		{
			result_end.add(ob);
		}
	}
	
    if(result_end==null||result_end.size()==0){
         
    	    out.print("<br/><font color='red'>您当前没有正在配送的订单!</font>");
    	  }
    else
    {%>
    	您共有<%=result_end.size()%>张正在配送的订单<br/>
    	<table width="100%">
    	<tr><th>订单号</th><th>订购时间</th><th>订单状态</th></tr>
    	<%
			
			
			if(result_end!=null&&result_end.size()>0){
				
				for(OrderBase be:result_end){
					
			%>
			<tr><td><a href="transportdetail.jsp?orderid=<%= be.getId()%>"><%= be.getId() %></a></td><td><%= be.getOdrmst_orderdate() %></td><td>已配送</td></tr>
    	
    <%          }
			}	
    }
      %>
    
  </table>
    
  
</div>



<!-- 尾部 -->
<%@ include file="../inc/userfoot.jsp" %>
<!-- 尾部结束 -->

</body>
</html>
