<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/user/public.jsp"%><%@include file="/inc/islogin.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的订单——<%= lUser.getMbrmst_uid() %></title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/orderdetailsub.css")%>" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/user/orderajax.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/flow/flowDone.js")%>"></script>
 <script type="text/javascript">
 $(document).ready(function() {   
	 getSelect();
	 
		 $("#selotime").change(function(){   
			   switch($("#selotime option:selected").text())
			   {
				   case "四个月内":
					   {
					   location.href="/user/selforder.jsp?type=1";
					   break;
					   }
				   case "四个月前":
				   {
					   location.href="/user/selforder.jsp?type=2";
					   break;
				   }
				   default:
					   {
					   location.href="/user/selforder.jsp?type=1";
				   	   break;
					   }
			   }
			  
			 })   
	 });

    function getSelect()
    {
    	var url=location.href;
    	if(url.indexOf('?')>0)
    	{
    	   	if(url.substr(url.indexOf('?'),6)=="?type=")
    	   		{
    	   		  if(url.substr(url.indexOf("?type=")+6,1)=="2")
    	   			  {
    	   		   		$('#selotime')[0].selectedIndex = 1;
    	   			  }
    	   		  else
    	   			 {
    	   			    //alert(url.substr(url.indexOf("?type=")+6,1));
    	   			 	$('#selotime')[0].selectedIndex = 0;
    	   			 } 
    	   			 
    	   		}
    	   	else
    	   		{
    	   		  $('#selotime')[0].selectedIndex = 0;
    	   		}
    	}
    	else
    		{
    		$('#selotime')[0].selectedIndex = 0;
    		}
    	
    }
  
</script>
</head>
<body>
    <!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
     <!-- 中间内容 -->
     <div class="center">
        
     <%@include file="left1.jsp" %>
     
     <!-- 右侧 -->
     <div class="mbr_right">
		 <div class="choorder"><span>我的订单</span>
		 <%  int type=1;
		   if(request.getParameter("type")!=null&&request.getParameter("type").length()>0&&Tools.isMath(request.getParameter("type")))
		   {
			   type=Tools.parseInt(request.getParameter("type"));
		   } %>
		 <select id="selotime">
		 <option >四个月内</option>
		 <option value="selected">四个月前</option>
		 </select>
		 </div>
		 <table width="769"  border="0" cellspacing="0" cellpadding="0"><tr><td height="30"></td></tr></table>
		 
		 <div class="orderlist">
	
		      
		       <div id="tags" class="tags">
		      	       <a href="javascript:void(0)" >进行中</a><a href="javascript:void(0)" style=" margin-left:17px;">已完成</a><a href="javascript:void(0)"  style=" margin-left:17px;" >已取消</a>
			   		   <a href="/user/odrthlist.jsp"  style=" margin-left:25px; width: 80px;" >退换货订单</a>
			   </div>
			   
			   <div id="content_list">
				  <%
				   ArrayList<OrderBase> list=new ArrayList<OrderBase>();
				   ArrayList<OrderBase> rlist=new ArrayList<OrderBase>();
				   ArrayList<OrderBase> endlist=new ArrayList<OrderBase>();
				   ArrayList<OrderBase> canclelist=new ArrayList<OrderBase>();
				   ArrayList<OrderBase> inlist=new ArrayList<OrderBase>();
				   
				   
				   if(type==1)
				   {
					   rlist=OrderHelper.getTotalOrderListIn4Months(lUser.getId());
					   if(rlist!=null&&rlist.size()>0)
					   {
						   
						   for(OrderBase oh:rlist)
						   {
							   if(oh.getOdrmst_orderstatus()<0)
							   {
								   canclelist.add(oh);
							   }
							   else if(oh.getOdrmst_orderstatus()==5||oh.getOdrmst_orderstatus()==6||oh.getOdrmst_orderstatus()==51||oh.getOdrmst_orderstatus()==61)
							   {
								   endlist.add(oh);
							   }
							   else
							   {
								   inlist.add(oh);
							   }
						   }
					   }
				   }
				   else
				   {
				       list=OrderHelper.getOrderHistoryListByMbrid(lUser.getId(), 1000);
				       if(list!=null&&list.size()>0)
					   {
						   
						   for(OrderBase oh:list)
						   {
							   if(oh.getOdrmst_orderstatus()<0)
							   {
								   canclelist.add(oh);
							   }
							   else if(oh.getOdrmst_orderstatus()==5||oh.getOdrmst_orderstatus()==6||oh.getOdrmst_orderstatus()==51||oh.getOdrmst_orderstatus()==61)
							   {
								   endlist.add(oh);
							   }
							   else
							   {
								   inlist.add(oh);
							   }
						   }
					   }
				   }
				   
				   
				   int pageno1=1;
				   int pageno2=1;
				   int pageno3=1;
				   
				   //分页
				   String ggURL = Tools.addOrUpdateParameter(request,null,null);
				   //String ggURL = "/user/selforder.jsp?";
			       if(ggURL != null) 
			    	   {
			    	     ggURL.replaceAll("pageno1=[0-9]*","");
			    	     ggURL.replaceAll("pageno2=[0-9]*","");
			    	     ggURL.replaceAll("pageno3=[0-9]*","");
			    	   }
			      //翻页
			        int totalLength1 = (inlist != null ?inlist.size() : 0);
			        int totalLength2 = (endlist != null ?endlist.size() : 0);
			        int totalLength3 = (canclelist != null ?canclelist.size() : 0);
					
					int PAGE_SIZE = 10 ;
			 	    int currentPage1 = 1 ;
			 	    int currentPage2 = 1 ;
			 	    int currentPage3 = 1 ;
			 	    String pg1 ="1";
			 	    String pg2 ="1";
			 	    String pg3 ="1";
			 	    if(request.getParameter("pageno1")!=null)
			 	    {
			 	    	pg1= request.getParameter("pageno1");
			 	    }
			 	   if(request.getParameter("pageno2")!=null)
			 	    {
			 	    	pg2= request.getParameter("pageno2");
			 	    }
			 	  if(request.getParameter("pageno3")!=null)
			 	    {
			 	    	pg3= request.getParameter("pageno3");
			 	    }
			 	    if(StringUtils.isDigits(pg1))currentPage1 = Integer.parseInt(pg1);
			 	    if(StringUtils.isDigits(pg2))currentPage2 = Integer.parseInt(pg2);
			 	    if(StringUtils.isDigits(pg3))currentPage3 = Integer.parseInt(pg3);
			 	    PageBean pBean1 = new PageBean(totalLength1,PAGE_SIZE,currentPage1);
			 	    PageBean pBean2 = new PageBean(totalLength2,PAGE_SIZE,currentPage2);
			 	    PageBean pBean3 = new PageBean(totalLength3,PAGE_SIZE,currentPage3);
			 	   
			 	    int end1 = pBean1.getStart()+PAGE_SIZE;
			 	    if(end1 > totalLength1) end1 = totalLength1;
			 	    int end2 = pBean2.getStart()+PAGE_SIZE;
			 	    if(end2 > totalLength2) end2 = totalLength2;
			 	    int end3 = pBean3.getStart()+PAGE_SIZE;
			 	    if(end3 > totalLength3) end3 = totalLength3;
					
					String pageURL1 = ggURL.replaceAll("pageno1=[^&]*","");
					String pageURL2 = ggURL.replaceAll("pageno2=[^&]*","");
					String pageURL3 = ggURL.replaceAll("pageno3=[^&]*","");
			 	    if(!pageURL1.endsWith("&")) pageURL1 = pageURL1 + "&";
			 	    if(!pageURL2.endsWith("&")) pageURL2 = pageURL2 + "&";
			 	    if(!pageURL3.endsWith("&")) pageURL3 = pageURL3 + "&";
			 	
			    %>
			
			
			    <!-- 进行中的订单 -->
			    <div style="display:none">
			    <% if(inlist!=null&&inlist.size()>0)
			       { %>
			    	  <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="t" style=" border:solid 1px #c2c2c2; border-bottom:none;" >
				      <tr style=" color:#a25663;" height="33"><td class="d1"  width="131">订单号</td><td  class="d1" width="101">收货人</td><td class="d1" width="101">订单金额</td><td class="d1" width="81">支付方式</td><td class="d1" width="151">订购时间</td> <td class="d1" width="81">订单状态</td><td class="d1">操作</td></tr>
				      </table>
				      <table width="769"  border="0" cellspacing="1" cellpadding="0" class="t" >
				      <% //for(OrderHistory sub:inlist)
				      if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
					   {
						   pageno1=Tools.parseInt(request.getParameter("pageno1"));
					   }
				    	 //for(int i=0;i<15;i++)
				    	 for(int i=(pageno1-1)*10;i<inlist.size()&&i<pageno1*10;i++)
				         { 
				    		  OrderBase sub=inlist.get(i);
				         %>
				    	  <tr height="80"  ><td width="130" ><a href="/user/orderdetailtest.jsp?orderid=<%= sub.getId() %>" target="_blank"> <%= sub.getId()%></a></td><td width="100"><%= sub.getOdrmst_rname() %></td><td width="100">
				    	  <span><b>￥<%= OrderHelper.getOrderTotalMoney(sub.getId()) %></b></span></td>
				    	  <td width="80">
                           <%= getPayMethod(sub.getOdrmst_paytype().toString())%>
                          </td><td width="150"><%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(sub.getOdrmst_orderdate())  %></td>
                          <td width="80">
                          <%= getOrderStatuByPaytype(sub.getOdrmst_paytype().toString(),sub.getOdrmst_orderstatus().toString())   %>
                          </td>
                          <td valign="middle">
                         
                          <%= getOpreatBypayandstatus1(sub.getOdrmst_paytype().toString(),sub.getOdrmst_orderstatus().toString(),sub.getId(),String.valueOf(sub.getType())) %></td></tr>
						  
				    	  
				        <% }  
				      %>
				       
                            <!-- 分页 -->
						    <%
					           if(pBean1.getTotalPages()>1){
					           %>
					           <tr>
					   <td colspan="7" height="45">
					           <span class="GPager" style="margin:0px auto; overflow:hidden;">
					           	<span>共<font class="rd"><%=pBean1.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean1.getCurrentPage() %></font>页</span>
					           	<a href="<%=pageURL1 %>pageno1=1">首页</a><%if(pBean1.hasPreviousPage()){%><a href="<%=pageURL1%>pageno1=<%=pBean1.getPreviousPage()%>">上一页</a><%}%><%
					           	for(int i=pBean1.getStartPage();i<=pBean1.getEndPage()&&i<=pBean1.getTotalPages();i++){
					           		if(i==currentPage1){
					           		%><span class="curr"><%=i %></span><%
					           		}else{
					           		%><a href="<%=pageURL1 %>pageno1=<%=i %>"><%=i %></a><%
					           		}
					           	}%>
					           	<%if(pBean1.hasNextPage()){%><a href="<%=pageURL1%>pageno1=<%=pBean1.getNextPage()%>">下一页</a><%}%>
					           	<a href="<%=pageURL1 %>pageno1=<%=pBean1.getTotalPages() %>">尾页</a>
					           </span> </td>
				     </tr><%}%>	
                         
                     
				      </table>
			    <%  }	
			    %>
				 </div>
				  <!-- 已完成 -->
				  <div style="display:none">
				  <% if(endlist!=null&&endlist.size()>0)
			       { %>
			    	  <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="t" style=" border:solid 1px #c2c2c2; border-bottom:none;">
				      <tr style=" color:#a25663;" height="33"><td class="d1"  width="131">订单号</td><td  class="d1" width="101">收货人</td><td class="d1" width="101">订单金额</td><td class="d1" width="81">支付方式</td><td class="d1" width="151">订购时间</td> <td class="d1" width="81">订单状态</td><td class="d1">操作</td></tr>
				      </table>
				      <table width="769"  border="0" cellspacing="1" cellpadding="0" class="t" >
				      <% 
					      if(request.getParameter("pageno2")!=null&&request.getParameter("pageno2").length()>0)
						   {
							   pageno2=Tools.parseInt(request.getParameter("pageno2"));
						   }
				    	   
				    	 for(int i=(pageno2-1)*10;i<endlist.size()&&i<pageno2*10;i++)
				         //for(OrderHistory sub:endlist)
				    	
				         { 
				        	 OrderBase sub=endlist.get(i);
				         %>
				    	  <tr height="70"  ><td width="130" ><a href="/user/orderdetailtest.jsp?orderid=<%= sub.getId() %>" target="_blank"> <%= sub.getId()%></a></td><td width="100"><%= sub.getOdrmst_rname() %></td>
				    	  <td width="100"><span><b>￥<%= OrderHelper.getOrderTotalMoney(sub.getId()) %></b></span></td>
				    	  <td width="80">
                           <%= getPayMethod(sub.getOdrmst_paytype().toString())%>
                          </td><td width="150"><%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(sub.getOdrmst_orderdate())  %></td>
                          <td width="80">
                          <%= getOrderStatuByPaytype(sub.getOdrmst_paytype().toString(),sub.getOdrmst_orderstatus().toString())   %>
                          </td>
                          <td><%= getOpreatBypayandstatus1(sub.getOdrmst_paytype().toString(),sub.getOdrmst_orderstatus().toString(),sub.getId(),String.valueOf(sub.getType())) %></td></tr>
						  
				    	  
				        <% }  
				      %>
				       
					   <!-- 分页 -->
						    <%
					           if(pBean2.getTotalPages()>1){
					           %>
					           <tr>
					   <td colspan="7">  
					           <span class="GPager" style="margin:0px auto; overflow:hidden;">
					           	<span>共<font class="rd"><%=pBean2.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean2.getCurrentPage() %></font>页</span>
					           	<a href="<%=pageURL2 %>pageno2=1">首页</a><%if(pBean2.hasPreviousPage()){%><a href="<%=pageURL2%>pageno2=<%=pBean2.getPreviousPage()%>">上一页</a><%}%><%
					           	for(int i=pBean2.getStartPage();i<=pBean2.getEndPage()&&i<=pBean2.getTotalPages();i++){
					           		if(i==currentPage2){
					           		%><span class="curr"><%=i %></span><%
					           		}else{
					           		%><a href="<%=pageURL2 %>pageno2=<%=i %>"><%=i %></a><%
					           		}
					           	}%>
					           	<%if(pBean2.hasNextPage()){%><a href="<%=pageURL2%>pageno1=<%=pBean2.getNextPage()%>">下一页</a><%}%>
					           	<a href="<%=pageURL2 %>pageno2=<%=pBean2.getTotalPages() %>">尾页</a>
					           </span>  </td>
				     </tr><%}%>	
				      </table>
			    <%  }	
			    %>
				   </div>
			  <!-- 已取消订单 -->
				   <div style="display:none">
				   <% if(canclelist!=null&&canclelist.size()>0)
			       { %>
			    	  <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="t" style=" border:solid 1px #c2c2c2; border-bottom:none;">
				      <tr style=" color:#a25663;" height="33"><td class="d1"  width="131">订单号</td><td  class="d1" width="101">收货人</td><td class="d1" width="101">订单金额</td><td class="d1" width="81">支付方式</td><td class="d1" width="151">订购时间</td> <td class="d1" width="81">订单状态</td><td class="d1">操作</td></tr>
				      </table>
				      <table width="769"  border="0" cellspacing="1" cellpadding="0" class="t" >
				      <%
					      if(request.getParameter("pageno3")!=null&&request.getParameter("pageno3").length()>0)
						   {
							   pageno3=Tools.parseInt(request.getParameter("pageno3"));
						   }
				    	 
				    	 for(int i=(pageno3-1)*10;i<canclelist.size()&&i<pageno3*10;i++)
				         //for(OrderHistory sub:canclelist)
				    	 { 
				    		 OrderBase sub=canclelist.get(i);
				         %>
				    	  <tr height="70"  ><td width="130" ><a href="/user/orderdetailtest.jsp?orderid=<%= sub.getId() %>" target="_blank"> <%= sub.getId()%></a></td>
				    	  <td width="100"><%= sub.getOdrmst_rname() %></td>
				    	  <td width="100"><span><b>￥<%= OrderHelper.getOrderTotalMoney(sub.getId()) %></b></span></td>
				    	  <td width="80">
                           <%= getPayMethod(sub.getOdrmst_paytype().toString())%>
                          </td><td width="150"><%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(sub.getOdrmst_orderdate())  %></td>
                          <td width="80">
                          <%= getOrderStatuByPaytype(sub.getOdrmst_paytype().toString(),sub.getOdrmst_orderstatus().toString())   %>
                          </td>
                          <td><%= getOpreatBypayandstatus1(sub.getOdrmst_paytype().toString(),sub.getOdrmst_orderstatus().toString(),sub.getId(),String.valueOf(sub.getType())) %></td></tr>
						  
				    	  
				        <% }  
				      %>
				
					    <!-- 分页 -->
						    <%
					           if(pBean3.getTotalPages()>1){
					           %>
					           <tr>
					   <td colspan="7">  
					           <span class="GPager" style="margin:0px auto; overflow:hidden;">
					           	<span>共<font class="rd"><%=pBean3.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean3.getCurrentPage() %></font>页</span>
					           	<a href="<%=pageURL3 %>pageno3=1">首页</a><%if(pBean3.hasPreviousPage()){%><a href="<%=pageURL3%>pageno3=<%=pBean3.getPreviousPage()%>">上一页</a><%}%><%
					           	for(int i=pBean3.getStartPage();i<=pBean3.getEndPage()&&i<=pBean3.getTotalPages();i++){
					           		if(i==currentPage3){
					           		%><span class="curr"><%=i %></span><%
					           		}else{
					           		%><a href="<%=pageURL3 %>pageno3=<%=i %>"><%=i %></a><%
					           		}
					           	}%>
					           	<%if(pBean3.hasNextPage()){%><a href="<%=pageURL3%>pageno3=<%=pBean3.getNextPage()%>">下一页</a><%}%>
					           	<a href="<%=pageURL3 %>pageno3=<%=pBean3.getTotalPages() %>">尾页</a>
					           </span>
					           </td>
				     </tr>
					           <%}%>	
				      </table>
			    <%  }	
			    %>
				   </div>
				  
				   
		      </div>
		 </div>
		   <table width="769"  border="0" cellspacing="0" cellpadding="0"><tr><td height="50"></td></tr></table>
	  </div>
     
     <!-- 右侧结束 -->
     </div>
     <!-- 中间内容结束 -->
     <div class="clear"></div>
      <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
</body>
</html>

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/order.js")%>"> </script>

