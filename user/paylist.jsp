<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——付款记录</title>
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
		    
            int pageno1=1;
		    ArrayList<OrderBase> list1=new ArrayList<OrderBase>();
		    ArrayList<OrderBase> list2=new ArrayList<OrderBase>();
		    ArrayList<OrderBase> list3=new ArrayList<OrderBase>();
		    list1=OrderHelper.getTotalOrderListIn4Months(lUser.getId());
		    list2=OrderHelper.getOrderHistoryListByMbrid(lUser.getId(), 1000);
		    
		    if(list1!=null&&list1.size()>0)
		    {
		    	for(OrderBase ob:list1)
		    	  {
		    		  if(ob.getOdrmst_orderstatus()==3||ob.getOdrmst_orderstatus()==31||ob.getOdrmst_orderstatus()==5||ob.getOdrmst_orderstatus()==51||ob.getOdrmst_orderstatus()==6||ob.getOdrmst_orderstatus()==61)
		    		  {
		    			  list3.add(ob);
		    		  }
		    	  }
		    }
		    if(list2!=null&&list2.size()>0)
		    {
		    	for(OrderBase ob:list2)
		   	  {
		    	  if(ob.getOdrmst_orderstatus()==3||ob.getOdrmst_orderstatus()==31||ob.getOdrmst_orderstatus()==5||ob.getOdrmst_orderstatus()==51||ob.getOdrmst_orderstatus()==6||ob.getOdrmst_orderstatus()==61)
		   		  {
		    		  list3.add(ob);
		    	  }
		    	  }
		    }
       if(list3!=null&&list3.size()>0)
       {  
       %>
       		<div class="mypayrecord1">

		  &nbsp;&nbsp;<span>付款记录</span>

		</div>

		<table ><tr><td height="15"></td></tr></table>

		<div class="paylist">

		  <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="paymethodlist" style=" border:solid 1px #c2c2c2; border-bottom:none; text-align:center;" >	   

		  <tr style=" color:#a25663;" height="33"><td   width="140">用途</td><td  width="100">支付金额</td><td width="250">支付方式</td><td >订单号</td><td  width="140">日期</td></tr>

		  </table>

		  <table width="769"  border="0" cellspacing="1" cellpadding="0"  class="t" >
		  <%  
		      
		      if(list3!=null&&list3.size()>0)
		      {
		    	  if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
					   {
						   pageno1=Tools.parseInt(request.getParameter("pageno1"));
					   }
                   for(int i=(pageno1-1)*15;i<list3.size()&&i<pageno1*15;i++)
                   {
		    		  OrderBase ob=list3.get(i); 
		    		  if(ob.getOdrmst_orderstatus()==3||ob.getOdrmst_orderstatus()==31||ob.getOdrmst_orderstatus()==5||ob.getOdrmst_orderstatus()==51||ob.getOdrmst_orderstatus()==6||ob.getOdrmst_orderstatus()==61)
		    		  {
		    			  %>
		    			  <tr  height="33"><td width="140">支付订单金额</td><td  width="100"><span><B>￥<%= Tools.getDouble(ob.getOdrmst_acturepaymoney(),2) %></B></span></td>
		    			  <td width="250"><%= getPayMethod(ob.getOdrmst_paytype().toString()) %> <%if(getPayMethod(ob.getOdrmst_paytype().toString())!="货到付款")   out.print(PayMethodHelper.getById(ob.getOdrmst_payid().toString()).getPaymst_name()); %></td><td >
		    			  <A href="/user/orderdetail.jsp?orderid=<%= ob.getId() %>" target="_blank"><%= ob.getId() %></A></td>
		    			  <td  width="140"><%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(ob.getOdrmst_orderdate()) %></td>
		    			  </tr>
		    			  
		    			  
		    			  <%
		    		  }
		    	  }
		      }
		      
		      
		      %>
				 </table>
		    <div style=" width:768px; height:45px; line-height:45px; text-align:center;">
		    <% 
				       //分页
					    
						String ggURL = Tools.addOrUpdateParameter(request,null,null);
						if(ggURL != null) 
							   {
							     ggURL.replaceAll("pageno1=[0-9]*","");
							   }
						//翻页
						 int totalLength1 = list3!=null?list3.size():0;
						 	
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
		    <br/>
		      </div>
	    </div>

		 
     <%   }
		 
		 else
		 {%>
			 <div class="mypayrecord2">

		  &nbsp;&nbsp;<span>付款记录</span>

		  <br/>

		  <font color="#333">&nbsp;&nbsp;<b>您目前还没有付款记录</b></font>

		  <br/>
         
			  
           </div>
			 
		 <%}
		 %>

		 

		 

		

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

