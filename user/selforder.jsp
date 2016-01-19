<%@page import="com.jd.ac.sdk.api.response.order.OrderDetailInfo"%>
<%@page import="com.jd.ac.sdk.api.response.order.OrderDetail"%>
<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/user/public.jsp"%><%@include file="/inc/islogin.jsp"%>
<%@include file="/ShowOrder/myshow.jsp"%>
<%!
/*public static class OrderBaseComparator implements Comparator<OrderBase>{

	@Override
	public int compare(OrderBase p0, OrderBase p1) {	
		
		if(p1.getOdrmst_oldodrid()!=null&&p0.getOdrmst_oldodrid()!=null&&p0.getOdrmst_oldodrid().hashCode() >p1.getOdrmst_oldodrid().hashCode()){
			return 1 ;
		}else if(p1.getOdrmst_oldodrid()!=null&&p0.getOdrmst_oldodrid()!=null&&p0.getOdrmst_oldodrid().hashCode()==p1.getOdrmst_oldodrid().hashCode()){
			return 0 ;
		}else{
			return -1 ;
		}
	}
}*/

public static class OrderBaseComparator implements Comparator<OrderBase>{

	@Override
	public int compare(OrderBase p0, OrderBase p1) {	
		
		if(p1.getOdrmst_orderdate()!=null&&p0.getOdrmst_orderdate()!=null&&p0.getOdrmst_orderdate().getTime() <p1.getOdrmst_orderdate().getTime()){
			return 1 ;
		}else if(p1.getOdrmst_orderdate()!=null&&p0.getOdrmst_orderdate()!=null&&p0.getOdrmst_orderdate().getTime()==p1.getOdrmst_orderdate().getTime()){
			return 0 ;
		}else{
			return -1 ;
		}
	}
}
%>
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
	 //getSelect();
	 
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
        
     <%@include file="left.jsp" %>
     
     <!-- 右侧 -->
     <div class="mbr_right">
		 <div class="choorder" style="height:40px;"><span>我的订单</span>
		 <%  int type=1;
		   if(request.getParameter("type")!=null&&request.getParameter("type").length()>0&&Tools.isMath(request.getParameter("type")))
		   {
			   type=Tools.parseInt(request.getParameter("type"));
		   } %>
		   <!-- 
		 <select id="selotime">
		 <option >四个月内</option>
		 <option value="selected">四个月前</option>
		 </select>
		  -->
		 </div>
		 <table width="769"  border="0" cellspacing="0" cellpadding="0"><tr><td height="30"></td></tr></table>
		 
		 <div class="orderlist">
	
		      <!-- 
		       <div id="tags" class="tags">
		      	       <a href="javascript:void(0)" >进行中</a><a href="javascript:void(0)" style=" margin-left:17px;">已完成</a><a href="javascript:void(0)"  style=" margin-left:17px;" >已取消</a>
		      	       <a href="/user/odrthlist.jsp"  style=" margin-left:25px; width: 80px;" >退换货订单</a>
			   </div>
			    -->
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
							  
							   inlist.add(oh);
							   /*
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
							   */
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
							   inlist.add(oh);
							   /*
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
							   */
						   }
					   }
				   }
				   Collections.sort(canclelist,new OrderBaseComparator());
				   Collections.sort(endlist,new OrderBaseComparator());
				   Collections.sort(inlist,new OrderBaseComparator());
				   
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
			 	   String stroldodrid="";
			    %>
			
			
			    <!-- 进行中的订单 -->
			    <div>
			    <%
		      if(inlist!=null&&inlist.size()>0)
		      {%>
			    
		    	 <table width="769"  border="0" cellspacing="0" cellpadding="0" class="t" style=" border:solid 1px #c2c2c2; border-bottom:none;">  
		    	  <tr style=" color:#a25663;" height="33" ><td class="d1" width="101">订单号</td><td width="335" class="d1">商品名称/编号</td><td class="d1">操作</td><td class="d1" width="81">金额</td><td class="d1" width="86">支付方式</td><td class="d1" width="86">订单状态</td></tr>
		          </table>
		          
		          <table width="769"  border="0" cellspacing="1" cellpadding="0"  class="t">
		          
		          <% 
		          int pbegin = (pBean1.getCurrentPage()-1)*PAGE_SIZE;
		          int pend = pbegin + PAGE_SIZE;
		          for(int t=pbegin; t<inlist.size()&&t<pend;t++ )
		          {
		        	  OrderBase ob = inlist.get(t);
		               String flag="1";
		               %>  
		             		   <tr height="90">
		             		   <td width="100">
		             		   		<a href="/user/orderdetail.jsp?orderid=<%= ob.getId() %>" target="_blank"><font color="red"><%= ob.getId() %></font></a>
		             		   		<br>
		             		   		<%
		             		   			java.text.DateFormat format1 = new java.text.SimpleDateFormat("yyyy-MM-dd");
		             		        	String s = format1.format(ob.getOdrmst_orderdate());
		             		        	out.println(s);
		             		        %>
		             		   </td>
		             		   <td style=" padding-left:6px;" width="335" align="left">
		             		   <%  
		             		    List<OrderItemBase> ilist=null;
		             		     switch(ob.getType())
		             		     {
		             			   case 1:
		             			   {
		             				  ilist=OrderItemHelper.getOdrdtlCacheByOrderId(ob.getId());
		             				  flag="1";
		             				  break;
		             			   }
		             			   case 2:
		             			   {
		             				  ilist=OrderItemHelper.getOdrdtlListByOrderId(ob.getId());
		             				 flag="2";
		             				  break;
		             			   }
		             			   case 3:
		             			   {
		             				   ilist=OrderItemHelper.getOdrdtRecentlByOrderId(ob.getId());
		             				  flag="3";
		             				   break;
		             			   }
		             			   case 0:
		             			   {
		             				   ilist=OrderItemHelper.getOdrdtHistorylByOrderId(ob.getId());
		             				   flag="4";
		             			       break;
		             			   }
		             			   default:
		             			   {
		             				  ilist=OrderItemHelper.getOdrdtlCacheByOrderId(ob.getId());
		             				  flag="1";
		             				  break;
		             			   }
		             		    }
		             			   
		             		     if(ilist!=null&&ilist.size()>0)
		             		     {
		             		    	 int count=0;
		             		    	 List<String> obsubidList = new ArrayList<String>();
		             		    	 for(OrderItemBase obsub:ilist)
			             			 {
		             		    		 count++;
		             		    		obsubidList.add(obsub.getId());
			             		    	  if(ilist.size()>1)
			             		    	  {
			             		    		  if(count==ilist.size())
			             		    		  {
			             		    		  %>
			             		    		  <br/>
			             		    		  <% Product p=ProductHelper.getById(obsub.getOdrdtl_gdsid());
			             		    		     if(p!=null)
			             		    		     {int h=60;
			             		    		    	boolean	ishshowsd=false;//是否显示晒单
			    				     				//发货或完成
			    				     				if(ob.getOdrmst_orderstatus()>=3 && obsub.getOdrdtl_shipstatus()>=1 && getMyShowByOrder(lUser.getId(),ob.getId(),obsub.getOdrdtl_gdsid(),obsub.getId())==0 ){
			    				     					ishshowsd=true;
			    				     					h=85;
			    				     				}
			             		    		    String  smallimg=p.getGdsmst_smallimg();	
			             		    		   if(smallimg!=null){
			             		    			  if(smallimg.startsWith("/shopimg/gdsimg")){
			             		    				 smallimg = "http://images1.d1.com.cn"+smallimg.trim();
			    				     						}else{
			    				     							smallimg = "http://images.d1.com.cn"+smallimg.trim();
			    				     						}
			             		    		   }
			    				     %>
			             		    		  <span style=" display:block; height:<%=h%>px; width:325px; margin-left:2px;">
					<span style="float:left;width:60px;">
					<table>
					<tr><td ><img src="<%=smallimg%>" width="50" height="50" style=" float:left; vertical-align:bottom"/></td></tr>
					<% if(ishshowsd){
			    			 %>
			    			<tr><td height="26" valign="middle">  
			    		 <!--  <a href="/ShowOrder/showorder.jsp?odtlid=<%=obsub.getId() %>"  target="_blank"><img src="http://images.d1.com.cn/images2012/sd/sd.jpg" border="0"  title="每晒一件商品并通过审核将额外获得30积分"  alt="每晒一件商品并通过审核将额外获得30积分"/></a>
			    		 -->
			    		 </td></tr>
					 <%} %>
					</table>
					  
			             		    		  
					</span>
			             		    		 
			             		    		   <span class="sptitle" style=" display:block; width:233px;  overflow:hidden"><a href="/product/<%= obsub.getOdrdtl_gdsid() %>" target="_blank"><%=p.getGdsmst_gdsname() %></a>
			             		    		   <br/><%= p.getId() %>&nbsp;&nbsp;
			             		    		   <%  if(obsub.getOdrdtl_sku1().length()>0) out.print("[&nbsp;"+p.getGdsmst_skuname1()+"："+obsub.getOdrdtl_sku1()+"&nbsp;]"); %></font>
			             		    		   <%=obsub.getOdrdtl_gdscount()+"件" %>
			             		    		   </span>
			             		    	      </span>
			             		    		 
			             		    	      <% } 
			             		    		   }
			             		    		   else
			             		    		   {  %>
			             		    		     <br/>
			             		    		  <% Product p=ProductHelper.getById(obsub.getOdrdtl_gdsid());
			             		    		  int h=60;   
			             		    		  if(p!=null)
			             		    		     {
			             		    		    	boolean	ishshowsd=false;//是否显示晒单
			    				     				//发货或完成
			    				     				if(ob.getOdrmst_orderstatus()>=3 && obsub.getOdrdtl_shipstatus()>=1 && getMyShowByOrder(lUser.getId(),ob.getId(),obsub.getOdrdtl_gdsid(),obsub.getId())==0 ){
			    				     					ishshowsd=true;
			    				     					h=85;
			    				     				}
			    				     				 String  smallimg=p.getGdsmst_smallimg();	
					             		    		   if(smallimg!=null){
					             		    			  if(smallimg.startsWith("/shopimg/gdsimg")){
					             		    				 smallimg = "http://images1.d1.com.cn"+smallimg.trim();
					    				     						}else{
					    				     							smallimg = "http://images.d1.com.cn"+smallimg.trim();
					    				     						}
					             		    		   }
			             		    		  %>
			             		    		  <span style=" display:block; height:<%=h%>px; width:325px; margin-left:2px;">
					<span style="float:left;width:60px;">
			             		    		 <table>
					<tr><td><img src="<%= smallimg  %>" width="50" height="50" style=" float:left; vertical-align:bottom"/></td></tr>
					<% if(ishshowsd){
			    			 %>
			    			<tr><td height="26" valign="middle">  
			    		<!--   <a href="/ShowOrder/showorder.jsp?odtlid=<%=obsub.getId() %>"  target="_blank"><img src="http://images.d1.com.cn/images2012/sd/sd.jpg" border="0"  title="每晒一件商品并通过审核将额外获得30积分"  alt="每晒一件商品并通过审核将额外获得30积分"/></a>
			    		-->
			    		</td></tr>
					 <%} %>
					</table>
					  
			    						        	 </span>
			             		    		   <span class="sptitle" style=" display:block; width:233px;  overflow:hidden"><a href="/product/<%= obsub.getOdrdtl_gdsid() %>" target="_blank"><%=Tools.clearHTML(p.getGdsmst_gdsname()).substring(0,Tools.clearHTML(p.getGdsmst_gdsname()).length()>40?40:Tools.clearHTML(p.getGdsmst_gdsname()).length()-1) %></a><br/>
			             		    		   <%= p.getId() %>&nbsp;&nbsp;
			             		    		   <%  if(obsub.getOdrdtl_sku1().length()>0) out.print("[&nbsp;"+p.getGdsmst_skuname1()+"："+obsub.getOdrdtl_sku1()+"&nbsp;]"); %></font>
			             		    		   <%=obsub.getOdrdtl_gdscount()+"件" %>
			             		    		   </span>
			             		    	      </span>
			             		    		    	 
			             		    		   <%  }
			             		    		     }
			             		    		    
			             		    	  }
			             		    	  else
			             		    	  { 
			             		    		  Product p=ProductHelper.getById(obsub.getOdrdtl_gdsid());
			             		    		     if(p!=null)
			             		    		     {
			             		    		    	 int h=60;
			             		    		    	boolean	ishshowsd=false;//是否显示晒单
			    				     				//发货或完成
			    				     				if(ob.getOdrmst_orderstatus()>=3 && obsub.getOdrdtl_shipstatus()>=1 && getMyShowByOrder(lUser.getId(),ob.getId(),obsub.getOdrdtl_gdsid(),obsub.getId())==0 ){
			    				     					ishshowsd=true;
			    				     					h=85;
			    				     				}
			    				     				 String  smallimg=p.getGdsmst_smallimg();	
					             		    		   if(smallimg!=null){
					             		    			  if(smallimg.startsWith("/shopimg/gdsimg")){
					             		    				 smallimg = "http://images1.d1.com.cn"+smallimg.trim();
					    				     						}else{
					    				     							smallimg = "http://images.d1.com.cn"+smallimg.trim();
					    				     						}
					             		    		   }
			             		    		  %>
			             		    		  <span style="float:left;width:60px;height:90px;">
			             		    		 <table>
					<tr><td><img src="<%= smallimg  %>" width="50" height="50" style=" float:left; vertical-align:bottom"/></td></tr>
					<% if(ishshowsd){
			    			 %>
			    			<tr><td height="26" valign="middle">  
			    		<!--   <a href="/ShowOrder/showorder.jsp?odtlid=<%=obsub.getId() %>"  target="_blank"><img src="http://images.d1.com.cn/images2012/sd/sd.jpg" border="0"  title="每晒一件商品并通过审核将额外获得30积分"  alt="每晒一件商品并通过审核将额外获得30积分"/></a>
			    		-->
			    		</td></tr>
					 <%} %>
					</table>
					  
			    						        	 </span>
			             		    		  <span class="sptitle" style=" display:block;padding-top:5px; width:233px; align:left; height:90px  overflow:hidden"><a href="/product/<%= obsub.getOdrdtl_gdsid() %>" target="_blank"><%= p.getGdsmst_gdsname() %></a>
			             		    		   <br/><%= p.getId() %>&nbsp;&nbsp;
			             		    		   <%  if(obsub.getOdrdtl_sku1().length()>0) out.print("[&nbsp;"+p.getGdsmst_skuname1()+"："+obsub.getOdrdtl_sku1()+"&nbsp;]"); %>
			             		    		   <%=obsub.getOdrdtl_gdscount()+"件" %>
			             		    		  </span>
			             		    		  <% }
			             		    	 }			             				   
			             			   
			             			   }
		             		     }
		             		    	 
		             		     
		             		 
		             		    %>
		             		    </td>
                             <td width="85" align="center">
                             <table border="0" width="100%">
                             <%
                             if(ilist!=null&&ilist.size()>0){
                             for(OrderItemBase obsub:ilist)
	             			 {
                            	
                             	long thtype = -1;
						     	long lstatus = -1;
						     	List<Order> olist=new ArrayList<Order>();
						     	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
						     	List<BaseEntity> listOdrShopTh = new ArrayList<BaseEntity>();
						     	OdrShopTh odrShopTh = null;
						     					     	
						     	if(!Tools.isNull(obsub.getOdrdtl_odrid())){
									   listRes.add(Restrictions.eq("odrshopth_odrid", obsub.getOdrdtl_odrid().toString()));
								}
						     	
						     	if(!Tools.isNull(obsub.getId())){
									   listRes.add(Restrictions.eq("odrshopth_subodrid", Long.parseLong(obsub.getId().toString())));
								}
						     	
						     	listOdrShopTh = Tools.getManager(OdrShopTh.class).getList(listRes, olist, 0, 500);
								
						     	if(listOdrShopTh!=null && listOdrShopTh.size()>0) {
						     		odrShopTh = (OdrShopTh)listOdrShopTh.get(0);
						     		thtype = odrShopTh.getOdrshopth_thtype().longValue(); 
						     		lstatus = odrShopTh.getOdrshopth_status().longValue();
						     	}
                             %>
                             <tr><td height="90" valign="middle" align="center" 
                             >
							 	<%= getthtkLink(ob.getId(),obsub.getId(),thtype,lstatus) %>
							 	<%
							 		if(thtype<0 && lstatus<0) {	
								 		out.println(getOrderStatuByPaytype1(ob.getId(),obsub.getId(), ob.getOdrmst_paytype().toString(),ob.getOdrmst_orderstatus().toString()));
							 		}
							 	%>
							 </td></tr>
							 <%}
                             }%>
							 </table>
							 </td>
		             		 

		             		 <td width="80"><span><font color="red"><b>￥<%=OrderHelper.getOrderTotalMoney(ob.getId()) %></b></font></span></td>
		             		  <td><%= getPayMethod(ob.getOdrmst_paytype().toString())%>                          </td>
                             <td width="85">
                             <%if(ob.getType()==3){out.println("系统自动关闭(未付款)");}else{ out.println(getOrderStatuByPaytype(ob.getOdrmst_paytype().toString(),ob.getOdrmst_orderstatus().toString())); }  %>
                             <%if(ob.getOdrmst_orderstatus().intValue()==31 || ob.getOdrmst_orderstatus().intValue()==3) {
	                          out.println("<a href=\"javascript:void(0)\" onclick=\"tipdialog("+ob.getId()+")\" class=\"a\">确认收货并评价</a>");
	                           }
                             if(ob.getOdrmst_orderstatus().intValue()>=3){
	                           %>
	                           <a href="/user/orderdetail.jsp?orderid=<%= ob.getId() %>" target="_blank"> 查看物流</a>
	                          <%}%>
                             <%if(ob.getType()!=3){ out.println(getOpreatBypayandstatus3(ob.getOdrmst_paytype().toString(),ob.getOdrmst_orderstatus().toString(),ob.getId(),String.valueOf(ob.getType())));} %>
                             </td>
		             		  </tr>
		   
		         <%
		         }
		       }
		   
		   %>		   
		   </table>
			    
			    
			    <% if(inlist!=null&&inlist.size()>0)
			       { %>
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
				      <tr style=" color:#a25663;" height="33"><td class="d1"  width="101">订单号</td><td  class="d1" width="101">收货人</td><td class="d1" width="101">订单金额</td><td class="d1" width="81">支付方式</td><td class="d1" width="121">订购时间</td> <td class="d1" width="81">订单状态</td><td class="d1">操作</td></tr>
				      </table>
				      <table width="769"  border="0" cellspacing="1" cellpadding="0" class="t" >
				      <% 
					      if(request.getParameter("pageno2")!=null&&request.getParameter("pageno2").length()>0)
						   {
							   pageno2=Tools.parseInt(request.getParameter("pageno2"));
						   }
				    	   long flagshow=0;
				    	   long flagshow2=0;
				    	 for(int i=(pageno2-1)*10;i<endlist.size()&&i<pageno2*10;i++)
				         //for(OrderHistory sub:endlist)
				    	
				         { flagshow=0;
				         flagshow2=0;
				        	 OrderBase sub=endlist.get(i);
				        	 if(sub==null)continue;
				        	 if(i+1<endlist.size()){
				           OrderBase sub2=endlist.get(i+1);
				          // System.out.println(sub.getId()+"======"+sub.getOdrmst_oldodrid()+"=========================="+sub2.getOdrmst_oldodrid());
				    		  if(sub!=null&&sub2!=null&&sub.getOdrmst_oldodrid()!=null&&sub2.getOdrmst_oldodrid()!=null&&sub.getOdrmst_oldodrid().equals(sub2.getOdrmst_oldodrid())){
				    			  if(Tools.isNull(stroldodrid)||!stroldodrid.equals(sub.getOdrmst_oldodrid())){
				    				  flagshow=1;
				    			  %>
				         <tr><td colspan="8" align="left" height="30" valign="bottom">&nbsp;&nbsp;尊敬的顾客，由于您的商品由不同商户提供，订单系统将原订单自动拆分为多个子订单并分开配送。</td></tr>
				         
				          <%}} }%>
				    	  <tr height="70"  ><td width="100" ><a href="/user/orderdetail.jsp?orderid=<%= sub.getId() %>" target="_blank"> <span style="color:#ec5658"><%= sub.getId()%></span></a>
				    	  <br>
				    	   <%
				    	  if(flagshow==1||(stroldodrid!=null&&stroldodrid.equals(sub.getOdrmst_oldodrid()))){
				    		  flagshow2=1;
					    	  out.print("<span style=\"color:#ff0000;font-size:10px\">子订单号</span>");
					    	  }
				    	  %>
				    	  </td><td width="100"><%= sub.getOdrmst_rname() %></td>
				    	  <td width="100"><span><b>￥<%= OrderHelper.getOrderTotalMoney(sub.getId()) %></b></span></td>
				    	  <td width="80">
                           <%= getPayMethod(sub.getOdrmst_paytype().toString())%>
                          </td><td width="120"><%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(sub.getOdrmst_orderdate())  %></td>
                          <td width="80">
                          <%= getOrderStatuByPaytype(sub.getOdrmst_paytype().toString(),sub.getOdrmst_orderstatus().toString())   %>
                          </td>
                          <td><%= getOpreatBypayandstatus1(sub.getOdrmst_paytype().toString(),sub.getOdrmst_orderstatus().toString(),sub.getId(),String.valueOf(sub.getType())) %></td></tr>
						  
				    	  
				        <% 
				        if(flagshow==0&&flagshow2!=1){
				        	out.println("<tr><td colspan=\"8\" style=\"height:2px;background-color:#cccccc\"></td></tr>");
				        }
				        stroldodrid=sub.getOdrmst_oldodrid();
				        }  
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
				      <tr style=" color:#a25663;" height="33"><td class="d1"  width="100">订单号</td><td  class="d1" width="101">收货人</td><td class="d1" width="101">订单金额</td><td class="d1" width="81">支付方式</td><td class="d1" width="121">订购时间</td> <td class="d1" width="81">订单状态</td><td class="d1">操作</td></tr>
				      </table>
				      <table width="769"  border="0" cellspacing="1" cellpadding="0" class="t" >
				      <%
					      if(request.getParameter("pageno3")!=null&&request.getParameter("pageno3").length()>0)
						   {
							   pageno3=Tools.parseInt(request.getParameter("pageno3"));
						   }
				    	 long flagshow=0;
				    	 long flagshow2=0;
				    	 for(int i=(pageno3-1)*10;i<canclelist.size()&&i<pageno3*10;i++)
				         //for(OrderHistory sub:canclelist)
				    	 { 
				        
				    		 flagshow=0;
				    		 flagshow2=0;
				    		 OrderBase sub=canclelist.get(i);
				    		 if(sub==null)continue;
				    		 if(i+1<canclelist.size()){
				           OrderBase sub2=canclelist.get(i+1);
				    		  if(sub!=null&&sub2!=null&&sub.getOdrmst_oldodrid()!=null&&sub2.getOdrmst_oldodrid()!=null&&sub.getOdrmst_oldodrid().equals(sub2.getOdrmst_oldodrid())){
				    			  if(Tools.isNull(stroldodrid)||!stroldodrid.equals(sub.getOdrmst_oldodrid())){
				    				  flagshow=1;
				         %>
				         <tr><td colspan="8" align="left" height="30" valign="bottom">&nbsp;&nbsp;尊敬的顾客，由于您的商品由不同商户提供，订单系统将原订单自动拆分为多个子订单并分开配送。</td></tr>
				         
				          <%}} }%>
				    	  <tr height="70"  ><td width="100" ><a href="/user/orderdetail.jsp?orderid=<%= sub.getId() %>" target="_blank"><span style="color:#ec5658"> <%= sub.getId()%></span></a>
				    	  <br>
				    	   <%
				    	  if(flagshow==1||(stroldodrid!=null&&stroldodrid.equals(sub.getOdrmst_oldodrid()))){
				    		  flagshow2=1;
					    	  out.print("<span style=\"color:#ff0000;font-size:10px\">子订单号</span>");
					    	  }
				    	  %>
				    	  </td>
				    	  <td width="100"><%= sub.getOdrmst_rname() %></td>
				    	  <td width="100"><span><b>￥<%= OrderHelper.getOrderTotalMoney(sub.getId()) %></b></span></td>
				    	  <td width="80">
                           <%= getPayMethod(sub.getOdrmst_paytype().toString())%>
                          </td><td width="120"><%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(sub.getOdrmst_orderdate())  %></td>
                          <td width="80">
                          <%= getOrderStatuByPaytype4(sub.getOdrmst_id(),sub.getOdrmst_paytype().toString(),sub.getOdrmst_orderstatus().toString())   %>
                          <%=sub.getOdrmst_orderstatus().intValue() %>
                          
                          </td>
                          <td><%= getOpreatBypayandstatus1(sub.getOdrmst_paytype().toString(),sub.getOdrmst_orderstatus().toString(),sub.getId(),String.valueOf(sub.getType())) %></td></tr>
						  
				    	  
				        <% 
				        if(flagshow==0&&flagshow2!=1){
				        	out.println("<tr><td colspan=\"8\" style=\"height:2px;background-color:#cccccc\"></td></tr>");
				        }
				        stroldodrid=sub.getOdrmst_oldodrid();
				        
				        }  
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

