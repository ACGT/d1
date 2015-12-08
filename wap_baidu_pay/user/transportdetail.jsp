<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%>
<%!
public String getPsPhone(int psId)
{
	   String result="";
	   switch(psId)
	   {
		   case 3002:
			   result="11185";
			   break;
		   case 1011:
			   result="0571-82122222";
			   break;
		   case 4024:
			   result="010-83603381";
			   break;
		   case 2001:
			   result="400-6789000";
			   break;
		   default:
				   result="";
				   break;
	   }
	   return result;
}

%>
<%  
	String backurl = request.getParameter("url");
	if(Tools.isNull(backurl)){
		backurl = request.getHeader("referer");
		if(Tools.isNull(backurl)){
			backurl = "/";
		}
	}
	backurl=backurl.replace("#", "");
    String orderid="";
    if(request.getParameter("orderid")!=null&&request.getParameter("orderid").length()>0)
    {
    	orderid=request.getParameter("orderid");
    }
  
%>


<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—<%= orderid %></title>
<link
	href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>"
	type="text/css" rel="stylesheet" />
<link
	href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/wap.css")%>"
	rel="stylesheet" type="text/css" media="screen" />

</head>
<body>
	<!-- 头部 -->
	<%@ include file="../inc/head.jsp"%>
	<!-- 头部结束 -->
	<div style="margin-bottom: 15px; width: 100%">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>><a href="myorder.jsp">我的订单</a>><a
				href="inorder.jsp">查看物流</a>><%= orderid %>
			<br />
		</div>
		<% 
    
    OrderBase ob=OrderHelper.getById(orderid);
    if(ob!=null&&(ob.getOdrmst_orderstatus().longValue()==3||ob.getOdrmst_orderstatus().longValue()==31))
    {%>
		基本信息：<br /> 订单号：<%= orderid %><br /> 订购时间：<%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(ob.getOdrmst_orderdate()) %><br />
		发货时间：<%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(ob.getOdrmst_realshipdate()) %><br />
		配送公司：<%= ob.getOdrmst_d1shipmethod() %><br /> 配送公司电话：<% if(getPsPhone((int)Tools.longValue(ob.getOdrmst_d1shipid()))!=null) out.print(getPsPhone((int)Tools.longValue(ob.getOdrmst_d1shipid()))); %><br />
		当前状态：<% switch(Tools.parseInt(ob.getOdrmst_orderstatus().toString()))
    	             {
				    	case 0:
				    	{
				    		out.print("订单生成，等待处理");
				    		break;
				    	}
				    	case 1:
				    	
				    	{
				    		out.print("订单已确认，库房配货中");
				    		break;
				    	}
				    	case -1:
				    	case -2:
				    	case -3:
				    	{
				    		out.print("订单已取消");
				    		break;
				    	}
				    	case 3:
						case 31:
						{
							out.print("库房已发货");
							break;
						}
						case 5:
						case 51:
						case 6:
						case 61:
						{
							out.print("交易完成");
							break;
						}
						default:
						{
							out.print("订单生成，等待处理");
						}
    	            }
    	           %>
		<br />
		<%
    	          if(ob.getOdrmst_orderstatus().longValue()==3||ob.getOdrmst_orderstatus().longValue()==31)
    	          {
    	      %>
		<a href="">如果您已收到商品，请确认收货</a> <br /> 详情：<br />
		<%} %>



		<%              
    }
    
    else
    {
    	out.print("<br/><font color='red'>对不起，该订单不存在,或者该订单还没有发货！</font>");
    }
   %>


		<br /> <a href="<%= backurl%>">>>返回上一页</a>
	</div>



	<!-- 尾部 -->
	<%@ include file="../inc/userfoot.jsp"%>
	<!-- 尾部结束 -->
</body>
</html>
