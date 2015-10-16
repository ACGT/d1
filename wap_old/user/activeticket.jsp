<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—我的优惠券</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/wap.css")%>" rel="stylesheet" type="text/css" media="screen" />
</head>
<body>
<!-- 头部 -->
<%@ include file="../inc/head.jsp" %>
<!-- 头部结束 -->
<div style=" margin-bottom:15px;">
   <div style=" background:#FFDEAD; padding:3px; width:100%;">
    <a href="/mindex.jsp">首页</a>><a href="index.jsp">我的优尚</a>><a href="ticket.jsp">我的优惠券</a> >激活优惠券
    <br/>
    </div>
    
    
        <%
    String msg="";
    if ("post".equals(request.getMethod().toLowerCase())) {
    	if(!Tools.isNull(request.getParameter("ticketcode"))){
    		String pwd = "www.d1.com.cn";//密码
    		HashMap<String,Object> map2 = TicketHelper.drawTicket(request,response,request.getParameter("ticketcode"),pwd,"-1");
    		if(map2.get("ticket") == null){
    			if(map2.get("failreason")!=null){
    				msg=map2.get("failreason").toString();
    			}else{
    				msg="优惠券码错误，请核对后再次输入！";
    			}
				//return;
    		}else{
    			msg="激活优惠券成功！";
    			//return;
    		}
    	}else{
    		msg="请输入优惠券号码!";
    	}
    }
    %>
    <span style="color:red;"><%=msg %></span><br/>
     <form action="activeticket.jsp" method="post">
   优惠券码:<input type="text" id="ticketcode"  name="ticketcode"/><br/>
		      <input type="submit"  id="activetickets" style="width:70px; height:26px; " value="激活" /> 
</form>
 <br/>
     <a href="ticket.jsp">查看我的优惠券>></a>
      <br/>
    返回 <a href="index.jsp">我的优尚</a>
</div>



<!-- 尾部 -->
<%@ include file="../inc/userfoot.jsp" %>
<!-- 尾部结束 -->
</body>
</html>

