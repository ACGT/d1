<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%><%!
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
<title>D1优尚网-会员专区—取消订单</title>
<style type="text/css">
body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, hr, pre, form,
	fieldset, input, textarea, p, label, blockquote, th, td, button, span {
	padding: 0;
	margin: 0;
}

body {
	background: #fff;
	font: 14px Arial, "微软雅黑";
	color: #4b4b4b;
	padding-bottom: 15px;
	line-height: 18px;
	padding-left: 4px;
}

ol, ul {
	list-style: none;
}

a {
	text-decoration: none;
	color: #4169E1
}

a:hover {
	color: #aa2e44
}

.clear {
	clear: both;
	font-size: 1px;
	line-height: 0;
	height: 0px;
	*zoom: 1;
}

img {
	border: none;
}

.top {
	margin-top: 3px;
}

.top ul li {
	float: left;
	border-bottom: solid 1px #000;
}

.top ul li a {
	color: #000;
}

.top ul li a:hover {
	color: #aa2e44;
}

.newli {
	padding-left: 8px;
}
</style>
</head>
<body>
	<!-- 头部 -->
	<%@ include file="../inc/head.jsp"%>
	<!-- 头部结束 -->
	<%
String msg="";
String orderid="";
String flags="";
String from ="";
if(!Tools.isNull(request.getParameter("orderid"))  && !Tools.isNull(request.getParameter("flag")) && !Tools.isNull(request.getParameter("from"))){
	orderid=request.getParameter("orderid");
	flags=request.getParameter("flag");
	from=request.getParameter("from");
	if ("post".equals(request.getMethod().toLowerCase())) {
		int flag=Integer.parseInt(flags);
		msg=cancelorder(request.getParameter("orderid"), flag, lUser.getId());
		if(Tools.isNull(msg)){
			if("1".equals(from)){
				response.sendRedirect("myorder.jsp");
			}else if("2".equals(from)){
				response.sendRedirect("myorder_history.jsp");
			}
			
		}
	}
}else{
	msg="参数错误";
}

%>

	<div style="margin-bottom: 15px;">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>><a href="index.jsp">我的优尚</a>>取消订单 <br />
		</div>
		<span style="color: red;">您确定要取消该订单吗？</span><br />

		<form action="confirmcancelorder.jsp" method="post">
			<input type="hidden" name="orderid" value="<%=orderid%>"></input>
			<input type="hidden" name="flag" value="<%=flags%>"></input>
			<input type="hidden" name="from" value="<%=from%>"></input>
			<input type="submit" value="确定"></input>
			<% if("1".equals(from)){%>
			<a href="myorder.jsp">返回</a>
			<%}else if("2".equals(from)){%>
			<a href="myorder_historyjsp">返回</a>

			<%}%>
		</form>


	</div>



	<!-- 尾部 -->
	<%@ include file="../inc/userfoot.jsp"%>
	<!-- 尾部结束 -->

</body>
</html>

