<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/user/public.jsp"%><%@include file="/inc/islogin.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的订单——<%= lUser.getMbrmst_uid() %></title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet" media="screen"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/user/orderajax.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/flow/flowDone.js")%>"></script>

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
     
		 <div class="choorder" style="height:40px;"><span>我的订单</span> </div>

		 <table width="769"  border="0" cellspacing="0" cellpadding="0"><tr><td height="10"></td></tr></table>
	
		 <div class="ohlist">
	           <div id="tags" class="tags1">
		        <a  href="javascript:compelete();" >已完成</a><a href="javascript:cancles();"  >已取消</a> </div>
			   
			   <div id="content_list">
				  <%
				   ArrayList<OrderBase> list=new ArrayList<OrderBase>();
				   ArrayList<OrderBase> rlist=new ArrayList<OrderBase>();
				   ArrayList<OrderBase> endlist=new ArrayList<OrderBase>();
				   ArrayList<OrderBase> canclelist=new ArrayList<OrderBase>();
				   ArrayList<OrderBase> inlist=new ArrayList<OrderBase>();
				  
				       list=OrderHelper.getOrderHistoryListByMbrid(lUser.getId(), 1000);
				       if(list!=null&&list.size()>0)
					   {
						   
						   for(OrderBase oh:list)
						   {
							   if(oh.getOdrmst_orderstatus()==5||oh.getOdrmst_orderstatus()==6||oh.getOdrmst_orderstatus()==51||oh.getOdrmst_orderstatus()==61)
							   {
								   endlist.add(oh);
							   }
							   else
							   {
								   canclelist.add(oh);
							   }
						   }
					   }
			
				   int pageno1=1;
				   int pageno2=1;
				
				   
				   //分页
				   String ggURL = Tools.addOrUpdateParameter(request,null,null);
				   //String ggURL = "/user/selforder.jsp?";
			       if(ggURL != null) 
			    	   {
			    	     ggURL.replaceAll("pageno1=[0-9]*","");
			    	     ggURL.replaceAll("pageno2=[0-9]*","");
			    	 
			    	   }
			      //翻页
			        int totalLength1 = (endlist != null ?endlist.size() : 0);
			        int totalLength2 = (canclelist != null ?canclelist.size() : 0);
					
					int PAGE_SIZE = 10 ;
			 	    int currentPage1 = 1 ;
			 	    int currentPage2 = 1 ;
			 
			 	    String pg1 ="1";
			 	    String pg2 ="1";
			 	 
			 	    if(request.getParameter("pageno1")!=null)
			 	    {
			 	    	pg1= request.getParameter("pageno1");
			 	    }
			 	   if(request.getParameter("pageno2")!=null)
			 	    {
			 	    	pg2= request.getParameter("pageno2");
			 	    }
			 	 
			 	    if(StringUtils.isDigits(pg1))currentPage1 = Integer.parseInt(pg1);
			 	    if(StringUtils.isDigits(pg2))currentPage2 = Integer.parseInt(pg2);
			 
			 	    PageBean pBean1 = new PageBean(totalLength1,PAGE_SIZE,currentPage1);
			 	    PageBean pBean2 = new PageBean(totalLength2,PAGE_SIZE,currentPage2);
			 	
			 	   
			 	    int end1 = pBean1.getStart()+PAGE_SIZE;
			 	    if(end1 > totalLength1) end1 = totalLength1;
			 	    int end2 = pBean2.getStart()+PAGE_SIZE;
			 	    if(end2 > totalLength2) end2 = totalLength2;
			 	  
			 	 
					
					String pageURL1 = ggURL.replaceAll("pageno1=[^&]*","");
					String pageURL2 = ggURL.replaceAll("pageno2=[^&]*","");
				
			 	    if(!pageURL1.endsWith("&")) pageURL1 = pageURL1 + "&";
			 	    if(!pageURL2.endsWith("&")) pageURL2 = pageURL2 + "&";
			 	
			 	
			    %>
			
			
				  <!-- 已完成 -->
				  <div  style="display:none;">
				  <% if(endlist!=null&&endlist.size()>0)
			       { %>
			    	  <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="t" style=" border:solid 1px #c2c2c2; border-bottom:none;">
				      <tr style=" color:#a25663;" height="33"><td class="d1"  width="131">订单号</td><td  class="d1" width="101">收货人</td><td class="d1" width="101">订单金额</td><td class="d1" width="81">支付方式</td><td class="d1" width="151">订购时间</td> <td class="d1" width="81">订单状态</td><td class="d1">操作</td></tr>
				      </table>
				      <table width="769"  border="0" cellspacing="1" cellpadding="0" class="t" >
				      <% 
					      if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
						   {
							   pageno1=Tools.parseInt(request.getParameter("pageno1"));
						   }
				    	   
				    	 for(int i=(pageno1-1)*10;i<endlist.size()&&i<pageno1*10;i++)
				         //for(OrderHistory sub:endlist)
				    	
				         { 
				        	 OrderBase sub=endlist.get(i);
				         %>
				    	  <tr height="70"  ><td width="130" ><a href="/user/orderdetail.jsp?orderid=<%= sub.getId() %>" target="_blank"> <%= sub.getId()%></a></td><td width="100"><%= sub.getOdrmst_rname() %></td>
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
					           if(pBean1.getTotalPages()>1){
					           %>
					           <tr>
					   <td colspan="7">  
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
					           </span>  </td>
				     </tr><%}%>	
				      </table>
			    <%  }	
			    %>
				   </div>
			  <!-- 已取消订单 -->
				   <div style="display:none;">
				   <% if(canclelist!=null&&canclelist.size()>0)
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
				    	 
				    	 for(int i=(pageno2-1)*10;i<canclelist.size()&&i<pageno2*10;i++)
				         //for(OrderHistory sub:canclelist)
				    	 { 
				    		 OrderBase sub=canclelist.get(i);
				         %>
				    	  <tr height="70"  ><td width="130" ><a href="/user/orderdetail.jsp?orderid=<%= sub.getId() %>" target="_blank"> <%= sub.getId()%></a></td>
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
					           	<%if(pBean2.hasNextPage()){%><a href="<%=pageURL2%>pageno2=<%=pBean2.getNextPage()%>">下一页</a><%}%>
					           	<a href="<%=pageURL2 %>pageno2=<%=pBean2.getTotalPages() %>">尾页</a>
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

