<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/user/public.jsp"%><%@include file="/inc/islogin.jsp"%>
<%@include file="/ShowOrder/myshow.jsp"%>
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
		 <!--  
	           <div id="tags" class="tags1">
	           
		        <a  href="javascript:compelete();" >已完成</a><a href="javascript:cancles();"  >已取消</a> </div>
			   -->
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
							   endlist.add(oh);
							   /*
							   if(oh.getOdrmst_orderstatus()==5||oh.getOdrmst_orderstatus()==6||oh.getOdrmst_orderstatus()==51||oh.getOdrmst_orderstatus()==61)
							   {
								   endlist.add(oh);
							   }
							   else
							   {
								   canclelist.add(oh);
							   }
							   */
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
				  <div>
				  <% if(endlist!=null&&endlist.size()>0)
			       { %>
			    	  <table width="770"  border="0" cellspacing="0" cellpadding="0" class="t" style=" border:solid 1px #c2c2c2; border-bottom:none;">  
		    	  <tr style=" color:#a25663;" height="33" ><td class="d1" width="101">订单号</td><td width="335" class="d1">商品名称/编号</td><td width="78" class="d1">操作</td>
		    	  <td class="d1" width="81">金额</td><td class="d1" width="86">支付方式</td><td class="d1" width="87">订单状态</td>
		    	  </tr>
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
		             		   <tr height="90"><td width="100"><a href="/user/orderdetail.jsp?orderid=<%= ob.getId() %>" target="_blank"><%= ob.getId() %></a></td>
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
			             		    		   <br/><font color="#333"><%= p.getId() %>&nbsp;&nbsp;
			             		    		   <%  if(obsub.getOdrdtl_sku1().length()>0) out.print("<font color='#444'>[&nbsp;"+p.getGdsmst_skuname1()+"："+obsub.getOdrdtl_sku1()+"&nbsp;]</font>"); %></font>
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
			             		    		   <span class="sptitle" style=" display:block; width:233px;  overflow:hidden"><a href="/product/<%= obsub.getOdrdtl_gdsid() %>" target="_blank"><%=Tools.clearHTML(p.getGdsmst_gdsname()).substring(0,Tools.clearHTML(p.getGdsmst_gdsname()).length()>40?40:Tools.clearHTML(p.getGdsmst_gdsname()).length()-1) %></a><br/><font color="#333">
			             		    		   <%= p.getId() %>&nbsp;&nbsp;
			             		    		   <%  if(obsub.getOdrdtl_sku1().length()>0) out.print("<font color='#444'>[&nbsp;"+p.getGdsmst_skuname1()+"："+obsub.getOdrdtl_sku1()+"&nbsp;]</font>"); %></font>
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
			             		    		   <%  if(obsub.getOdrdtl_sku1().length()>0) out.print("<font color='#444'>[&nbsp;"+p.getGdsmst_skuname1()+"："+obsub.getOdrdtl_sku1()+"&nbsp;]</font>"); %>
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
                             int c=0;
                             for(OrderItemBase obsub:ilist)
	             			 {
                            	c++;
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
							 	<%= getOpreatBypayandstatus2(ob.getOdrmst_paytype().toString(),ob.getOdrmst_orderstatus().toString(),ob.getId(),obsub.getId(),String.valueOf(ob.getType()),thtype,lstatus) %>
							 </td></tr>
							 <%} %>
							 </table>
							 </td>
		             		 

		             		 <td width="80"><span><b>￥<%=OrderHelper.getOrderTotalMoney(ob.getId()) %></b></span></td>
		             		  <td><%= getPayMethod(ob.getOdrmst_paytype().toString())%>                          </td>
                             <td width="85">
                             <%= getOrderStatuByPaytype(ob.getOdrmst_paytype().toString(),ob.getOdrmst_orderstatus().toString())   %>
                             </td>
		             		  </tr>
		   
		         <%
		         }	   
		   %>		   
		   </table>
					  <table width="769"  border="0" cellspacing="1" cellpadding="0" class="t" >
				       
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

