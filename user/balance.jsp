<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——预存款查询</title>
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
     
  <!--右侧-->

   <div class="mbr_right">

		<%
		  	
		 	 List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			 clist.add(Restrictions.eq("prepay_mbrid", new Long(lUser.getId())));
			 clist.add(Restrictions.eq("prepay_status", new Long(0)));
			 
			 List<Order> listOrder = new ArrayList<Order>();
			 listOrder.add(Order.desc("prepay_createdate"));
			 
			 List<BaseEntity> list = Tools.getManager(Prepay.class).getList(clist,listOrder,0,1000);
			
		  %>
		   <%
		   	if(list==null||list.size()==0){
		   %>
		   <div class="myyck2">

		  &nbsp;&nbsp;<span>我的预存款</span>
		  
		   <br/><br/>

		  &nbsp;&nbsp;您的账户里目前没有预存款

		  <br/><br/>

		  &nbsp;&nbsp;<a href="/help/helpnew.jsp?code=0504" target="_blank">如何获得预存款？</a><br/>

		  &nbsp;&nbsp;<a href="/help/helpnew.jsp?code=0504"  target="_blank">如何使用预存款？</a>
		  </div>
		  <%
		   	}
		   	else
		   	{%>
		   <div class="myyck1">

		  &nbsp;&nbsp;<span>我的预存款</span>

		   <br/><br/>

		  &nbsp;&nbsp;<font color="#333" style=" font-size:13px"><b>预存款金额：<font color="#dd0101">￥<%=PrepayHelper.getPrepayBalance(lUser.getId()) %></font></b></font>
		  </div>
		   	<%}
		  %>

		

		<table ><tr><td height="15"></td></tr></table>

		<%
		if(list!=null&&list.size()>0){
			int pageno1=1;
		%>
		<div class="ycklist">

		  <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="t" style=" border:solid 1px #c2c2c2; border-bottom:none;" >

				   <tr style=" color:#a25663;" height="33"><td class="d1"  width="200"><b>充值/使用类型</b></td><td  class="d1" width="150"><b>金额</b></td><td class="d1"><b>时间</b></td><td class="d1" width="140"><b>订单号</b></td></tr>

				   </table>

					<table width="769"  border="0" cellspacing="1" cellpadding="0"  class="t" >

					<%
					if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
					{
						if(Tools.isMath(request.getParameter("pageno1")))
						{
							pageno1=Tools.parseInt(request.getParameter("pageno1"));
						}
						
					}
						//for(BaseEntity b:list){
							for(int i=(pageno1-1)*15;i<list.size()&&i<pageno1*15;i++)
							{
							   Prepay p=(Prepay)list.get(i);
							  //Prepay p = (Prepay)b;
					%>
	                  <tr height="33"><td width="200">
                         <%  switch(Tools.parseInt(p.getPrepay_type().toString()))
                             {
		                         case 0:
		                        	 out.print("付款时多汇");
		                        	 break;
		                         case 1:
		                        	 out.print("缺货退款");
		                        	 break;
		                         case 2:
		                        	 out.print("购物消费");
		                        	 break;
		                         case 3:
		                        	 out.print("用户要求退回");
		                        	 break;
		                         case 4:
		                        	 out.print("用户取消订单");
		                        	 break;
		                         case 5:
		                        	 out.print("补偿客户");
		                        	 break;
		                         case 6:
		                        	 out.print("礼品卡");
		                        	 break;
		                         default:
		                        	 out.print("付款时多汇");
			                         break;
                         
                             }%>

                     </td><td width="150"><span><b>￥<%=Tools.getFloat(p.getPrepay_value(),2) %></b></span></td><td><%if(p.getPrepay_createdate()!=null)out.print(Tools.getFormatDate(p.getPrepay_createdate().getTime(), "yyyy-MM-dd HH:mm:ss"));else out.print("-"); %></td>
                     <td  width="140">
                     <%
                     if(p.getPrepay_odrid()!=null)
                     {%>
                    	 <a href="/user/orderdetail.jsp?orderid=<%=p.getPrepay_odrid()  %>" target="_blank" class="ycka"><%=p.getPrepay_odrid() %></a>
                     <%}
                     else out.print("----"); %>
                     </td></tr>
					  <%
						}
					  %>
                     <tr><td colspan="4" height="45">
                      <% 
				       //分页
					    
						String ggURL = Tools.addOrUpdateParameter(request,null,null);
						if(ggURL != null) 
							   {
							     ggURL.replaceAll("pageno1=[0-9]*","");
							   }
						//翻页
						 int totalLength1 = list!=null?list.size():0;
						 	
						  int PAGE_SIZE = 15;
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
					  %>
					  <span class="Pager" style="margin:0px auto; overflow:hidden;">
					           	<span>共<font class="rd"><%=pBean1.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean1.getCurrentPage() %></font>页</span>
					           	<a href="<%=pageURL1 %>pageno1=1">首页</a><%if(pBean1.hasPreviousPage()){%><a href="<%=pageURL1%>pageno1=<%=pBean1.getPreviousPage()%>">上一页</a><%}%><%
					           	for(int j=pBean1.getStartPage();j<=pBean1.getEndPage()&&j<=pBean1.getTotalPages();j++){
					           		if(j==currentPage1){
					           		%><span class="curr"><%=j %></span><%
					           		}else{
					           		%><a href="<%=pageURL1 %>pageno1=<%=j %>"><%=j %></a><%
					           		}
					           	}%>
					           	<%if(pBean1.hasNextPage()){%><a href="<%=pageURL1%>pageno1=<%=pBean1.getNextPage()%>">下一页</a><%}%>
					           	<a href="<%=pageURL1 %>pageno1=<%=pBean1.getTotalPages() %>">尾页</a>
					           </span>
                     </td></tr>
				   </table>

		<table width="769"  border="0" cellspacing="0" cellpadding="0" >

		   <tr><td>&nbsp;&nbsp;<a href="/help/helpnew.jsp?code=0504"  target="_blank" class="oa">如何获得预存款？</a><br/>

		  &nbsp;&nbsp;<a href="/help/helpnew.jsp?code=0504"  target="_blank" class="oa">如何使用预存款？</a></td></tr>

		<table>

		</div>
		<%
		}
		%>

		<table ><tr><td height="20"></td></tr></table>

  </div>
  
 
	  <!-- 右侧结束 -->
         
     </div>
    <div class="clear"></div>
    <!--中间内容结束-->
    <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
</body>
</html>

