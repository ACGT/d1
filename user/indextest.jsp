<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%><%@include file="/ShowOrder/myshow.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——<%= lUser.getMbrmst_uid() %></title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
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
             <%
             if(UserScoreHelper.getRealScore(lUser.getId())>200){
            	 %>
            	  <div style="width:980px; margin:0px auto; text-align:center; font-size:22px; line-height:28px; margin-bottom:10px;"><a href="/jifen/index.jsp" target="_blank">您的积分已超过200，15元换甜甜之吻耳饰品，39元换7双纯棉袜>> </a> </div>
             
            <% }
             %>
            
             
     <%@include file="left.jsp" %>
     
     <%
        
     
     %>
      <!--右侧-->
   <div class="mbr_right">
		  <div class="mbr_right_first">
					 <div class="mbr_info">
					        <% if(lUser.getMbrmst_specialtype()==0){ %>
							<img src="http://images.d1.com.cn/images2012/New/hyimg.jpg" />
							<%} 
					        else
					        {
					        	UserVip uv=(UserVip)Tools.getManager(UserVip.class).get(lUser.getId());
					        	if(uv!=null)
					        	{  %>
					        	<img src="http://images.d1.com.cn/images2012/New/bjimg.jpg" />
					        	
					        		
					         <%	}
					        	else
					        	{%>
					        		<img src="http://images.d1.com.cn/images2012/New/vipimg.jpg" />
					        <%}
					        }
							%> 
					        
						    
							<div class="mbr_info_detail">
							 您好：
							 <%
							 String showmsg = Tools.getCookie(request,"showmsg");
							 if(!Tools.isNull(showmsg) && lUser.getMbrmst_uid().endsWith("caibei") && lUser.getMbrmst_name().trim().equals("QQ彩贝")){
								%>
									<%=URLDecoder.decode(showmsg,"GBK") %>
								<%}else{ %>
							 <%= lUser.getMbrmst_uid() %>
							<% if(lUser.getMbrmst_specialtype()==0){ %>
							（普通会员）
							<%} }%> 
							
							 <br/>
							 <%  
							    int countxf=0;
							    Double summoney=0d;
							    Double y_summoney=0d;
							    ArrayList<OrderBase> list1=new ArrayList<OrderBase>();
							    ArrayList<OrderBase> list2=new ArrayList<OrderBase>();
							    ArrayList<OrderBase> list3=new ArrayList<OrderBase>();
							    list1=OrderHelper.getTotalOrderListIn4Months(lUser.getId());
							    list2=OrderHelper.getOrderHistoryListByMbrid(lUser.getId(), 1000);
							    list3.addAll(list1);
							    list3.addAll(list2);
							    for(OrderBase ob:list3)
							    {
							    	if(ob.getOdrmst_orderstatus()==3||ob.getOdrmst_orderstatus()==31||ob.getOdrmst_orderstatus()==5||ob.getOdrmst_orderstatus()==51||ob.getOdrmst_orderstatus()==6||ob.getOdrmst_orderstatus()==61)
							    	{
							    		countxf++;
							    		summoney+=ob.getOdrmst_acturepaymoney();
							    		//获得本年度第一天
							    		Calendar c = Calendar.getInstance();
										c.set(c.get(Calendar.YEAR), 0, 1);
										c.set(Calendar.HOUR_OF_DAY, 0);
										c.set(Calendar.MINUTE, 0);
										c.set(Calendar.SECOND, 0);
										Date d = c.getTime();	
										
										Calendar c1 = Calendar.getInstance();
										Date d2 = c1.getTime();
							    		if(ob.getOdrmst_orderdate().after(d)&&ob.getOdrmst_orderdate().before(d2))
							    		{
							    			y_summoney+=ob.getOdrmst_acturepaymoney();
							    		}
							    	}
							    }
							 %>
							 
							 消费笔数：<span><b><%= countxf %></b></span>&nbsp;&nbsp;&nbsp;&nbsp;预存款：<span><b><%= PrepayHelper.getPrepayBalance(lUser.getId()) %></b></span>元<br/>
							 消费总额：<span><b><%= Tools.getDouble(summoney,2) %></b><font color="#333">元</font>&nbsp;&nbsp;<a href="/help/helpnew.jsp?code=05" target="_blank">会员制度</a>&nbsp;&nbsp;<font color="#333">好消息：</font><a href="http://www.d1.com.cn/html/baijinnotice.jsp" target="_blank">D1优尚会员级别将永久保留</a></span><br/>
							 <% if(summoney<2000&&lUser.getMbrmst_specialtype()==0)
							    {
							       if(summoney<500)
							       {  %>
							    	   <span style=" font-size:12px;">(再消费<%=Tools.getDouble(500-summoney,2) %>元，升级为VIP会员；再消费<%= Tools.getDouble(2000-summoney,2) %>元，升级为白金会员)</span><br/>
							     <% }
							       else 
							       {%>
							    	    <span style=" font-size:12px;">(再消费<%= Tools.getDouble(2000-summoney,2) %>元，升级为白金会员)</span><br/>
							   
							       <%}
							    %>
							    
								  
							    
							   <% }
								 
								 %>
						    年度消费总额：<span><b><%= Tools.getDouble(y_summoney,2)  %></b><font color="#333">元</font></span>
						    <%if((session.getAttribute("d1lianmengsubad") !=null 
						    && ("201203jfcx".equals(session.getAttribute("d1lianmengsubad"))
						    ||"201203smsjfcx".equals(session.getAttribute("d1lianmengsubad"))
						    )||(int)(UserScoreHelper.getRealScore(lUser.getId())+0.5)>=200)){%>

							<a href="/jifen/index.jsp" target="_blank">积分当钱花！D1优尚网新版上线用户专享！</a>
							<%} %><br>
							<% if (Tools.isNull(chePingAn)){%> 
							 您的积分：<span><b><%= (int)(UserScoreHelper.getRealScore(lUser.getId())+0.5) %></b><font color="#333">分，</font><a href="/help/helpnew.jsp?code=0104" target="_blank">积分规则</a>&nbsp;&nbsp;<a href="/jifen/index.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/New/user/mbr_jfhg.jpg" /></a></span><br/>
							<%}%>
							
							</div>
					</div>
					 <div class="ysad">
						 <img src="http://images.d1.com.cn/images2012/New/user/ysgg.jpg" width="219" height="38" />
						 <div class="adinfo">
						 <%
				       		//会员公告
				       	    ArrayList<Promotion> recommendList = PromotionHelper.getBrandListByCode("2717" , 5);
				           	if(recommendList != null && !recommendList.isEmpty()){
				           		int size = recommendList.size();
					       		%>
					           	<ul class="news_list"><%
					           		for(int i=0;i<size;i++){
					           			Promotion recommend = recommendList.get(i);
					           			String titiel = Tools.clearHTML(recommend.getSplmst_name());
					           	%>
					           		<li>■<a href="<%=StringUtils.encodeUrl(recommend.getSplmst_url()) %>" target='_blank' title="<%=titiel %>"<%if(i==1){ %> style="color:#ad4456"<%} %>> <%=Tools.substring(titiel, 32) %></a></li><%
					           		} %>
					           	</ul><%
					           	} %>
							
						 </div>
			        </div>
			 </div>
	<div class="clear"></div>
		<br/>
		   <table width="769"  border="0" cellspacing="0" cellpadding="0">
		   <tr><td>
		   <span style="color:#f00; font-size:14px;">
		       亲爱的D1优尚网客户： <br/>
 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;您好！ 2012年国庆中秋期间，我们的服务及发货时间略有变更，具体说明详见<a href="http://www.d1.com.cn/html/synotice.jsp" target="_blank">《D1优尚网2012年国庆假期服务说明》</a>
<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D1优尚网全体员工祝您节日愉快，阖家幸福！感谢您对我们长久以来的关注与支持！<br/>　　 
<br/>　　　　　　　　　　　　　　　　　　　　　　
<span style=" float:right;">D1优尚网&nbsp;敬<br/>
全国客户服务电话：400-680-8666
</span>
		   
		   </span>
		   
		   </td></tr>
		   <tr><td height="10"></td></tr></table>
		    <%
		           ArrayList<OrderBase> result=new ArrayList<OrderBase>();
				   ArrayList<OrderBase> list=new ArrayList<OrderBase>();
				   ArrayList<OrderBase> rlist=new ArrayList<OrderBase>();
				   //list=OrderHelper.getOrderHistoryListByMbrid(lUser.getId(), 1000);
				   rlist=OrderHelper.getTotalOrderListIn4Months(lUser.getId());
				   if(rlist!=null&&rlist.size()>0)
				   {
					   int j=0;
					   for(int i=0;i<rlist.size()&&j<10;i++)
					   {
						   OrderBase ob=rlist.get(i);
							if(ob.getOdrmst_orderstatus()>=0&&ob.getOdrmst_orderstatus()!=5&&ob.getOdrmst_orderstatus()!=51&&ob.getOdrmst_orderstatus()!=6&&ob.getOdrmst_orderstatus()!=61)
							{
								result.add(ob);
							    j++;
							}
					   }
					  if(j<10)
					  {
						  /* list=OrderHelper.getOrderHistoryListByMbrid(lUser.getId(), 1000);
						   if(list!=null&&list.size()>0)
						   {
							   for(int i=0;i<list.size()&&j<10;i++)
							   {
								   OrderBase ob=list.get(i);
									   if(ob.getOdrmst_orderstatus()>0&&ob.getOdrmst_orderstatus()!=5&&ob.getOdrmst_orderstatus()!=51&&ob.getOdrmst_orderstatus()!=6&&ob.getOdrmst_orderstatus()!=61)
										{
											result.add(ob);
										    j++;
										}
							   }
						   } */
					  }
				 }
					   
			%>	   
		   
		   <%
		      if(result!=null&&result.size()>0)
		      {%>
		    
		    	 <table width="769"  border="0" cellspacing="0" cellpadding="0" class="t" style=" border:solid 1px #c2c2c2; border-bottom:none;">  
		    	  <tr><td colspan="6" style=" background:url(http://images.d1.com.cn/images2012/New/user/inorderbg.jpg);  border-bottom:solid 1px #b33b57; text-align:left;" height="33">
		    	  <span style=" color:#a25663; font-size:14px;"><b>&nbsp;&nbsp;进行中的订单：</b></span></td></tr>
		    	  <tr style=" color:#a25663;" height="33" ><td class="d1" width="101">订单号</td><td width="335" class="d1">商品名称/编号</td><td class="d1" width="81">金额</td><td class="d1" width="86">支付方式</td><td class="d1" width="86">订单状态</td><td class="d1">操作</td></tr>
		          </table>
		          
		          <table width="769"  border="0" cellspacing="1" cellpadding="0"  class="t">
		          
		          <% for(OrderBase ob:result)
		          {
		               String flag="1";
		               %>  
		             		   <tr height="90"><td width="100"><a href="/user/orderdetail.jsp?orderid=<%= ob.getId() %>" target="_blank"><%= ob.getId() %></a></td>
		             		   <td style=" padding-left:6px;" width="335">
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
		             		    	 for(OrderItemBase obsub:ilist)
			             			 {
		             		    		 count++;
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
			    				     %>
			             		    		  <span style=" display:block; height:<%=h%>px; width:325px; margin-left:2px;">
					<span style="float:left;width:60px;">
					<table>
					<tr><td ><img src="http://images.d1.com.cn/<%= p.getGdsmst_smallimg()  %>" width="50" height="50" style=" float:left; vertical-align:bottom"/></td></tr>
					<% if(ishshowsd){
			    			 %>
			    			<tr><td height="26" valign="middle">  
			    		 <a href="/ShowOrder/showorder.jsp?odtlid=<%=obsub.getId() %>"  target="_blank"><img src="http://images.d1.com.cn/images2012/sd/sd.jpg" border="0"  title="每晒一件商品并通过审核将额外获得30积分"  alt="每晒一件商品并通过审核将额外获得30积分"/></a></td></tr>
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
			             		    		  %>
			             		    		  <span style=" display:block; border-bottom:dashed 1px #ccc; height:<%=h%>px; width:325px; margin-left:2px;">
					<span style="float:left;width:60px;">
			             		    		 <table>
					<tr><td><img src="http://images.d1.com.cn/<%= p.getGdsmst_smallimg()  %>" width="50" height="50" style=" float:left; vertical-align:bottom"/></td></tr>
					<% if(ishshowsd){
			    			 %>
			    			<tr><td height="26" valign="middle">  
			    		 <a href="/ShowOrder/showorder.jsp?odtlid=<%=obsub.getId() %>"  target="_blank"><img src="http://images.d1.com.cn/images2012/sd/sd.jpg" border="0"  title="每晒一件商品并通过审核将额外获得30积分"  alt="每晒一件商品并通过审核将额外获得30积分"/></a></td></tr>
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
			             		    		  %>
			             		    		  <span style="float:left;width:60px;height:<%=h%>px;">
			             		    		 <table>
					<tr><td><img src="http://images.d1.com.cn/<%= p.getGdsmst_smallimg()  %>" width="50" height="50" style=" float:left; vertical-align:bottom"/></td></tr>
					<% if(ishshowsd){
			    			 %>
			    			<tr><td height="26" valign="middle">  
			    		 <a href="/ShowOrder/showorder.jsp?odtlid=<%=obsub.getId() %>"  target="_blank"><img src="http://images.d1.com.cn/images2012/sd/sd.jpg" border="0"  title="每晒一件商品并通过审核将额外获得30积分"  alt="每晒一件商品并通过审核将额外获得30积分"/></a></td></tr>
					 <%} %>
					</table>
					  
			    						        	 </span>
			             		    		  <div class="sptitle" style=" display:block;padding-top:5px; width:233px;  overflow:hidden"><a href="/product/<%= obsub.getOdrdtl_gdsid() %>" target="_blank"><%= p.getGdsmst_gdsname() %></a>
			             		    		   <br/><%= p.getId() %>&nbsp;&nbsp;
			             		    		   <%  if(obsub.getOdrdtl_sku1().length()>0) out.print("<font color='#444'>[&nbsp;"+p.getGdsmst_skuname1()+"："+obsub.getOdrdtl_sku1()+"&nbsp;]</font>"); %>
			             		    		  </div>
			             		    		  <% }
			             		    	 }			             				   
			             			   }
			             			   
		             		    	 
		             		     }
		             		     
		             		 
		             		    %>
		             		    </td>
		             		 <td width="80"><span><b>￥<%=OrderHelper.getOrderTotalMoney(ob.getId()) %></b></span></td>
		             		  <td><%= getPayMethod(ob.getOdrmst_paytype().toString())%>                          </td>
                             <td width="85">
                             <%= getOrderStatuByPaytype(ob.getOdrmst_paytype().toString(),ob.getOdrmst_orderstatus().toString())   %>
                             </td>
                             <td width="85"><%= getOpreatBypayandstatus(ob.getOdrmst_paytype().toString(),ob.getOdrmst_orderstatus().toString(),ob.getId(),flag) %></td>
		             		 
		             		  </tr>
		   
		         <%
		         }
		       }
		   
		   %>		   
		   
		   <tr><td colspan="6" style=" text-align:right; padding-right:10px;" height="40" ><a href="/user/selforder.jsp" target="_blank" class="a">查看全部订单>></a></td></tr>
		   </table>
		   
		   
		   <table width="769"  border="0" cellspacing="0" cellpadding="0"><tr><td height="50"></td></tr></table>
	  </div>
	  <!-- 右侧结束 -->
         
     </div>
     <% //if ((int)(UserScoreHelper.getRealScore(lUser.getId())+0.5)>=200) {%>
							<script type="text/javascript" language="javascript">
							//alert("恭喜您，您的积分超过200积分了！可以参与积分超值惊喜换购活动");
								//window.open ('/jifen/znjfdh.jsp');
							</script>
							<%// }%>
    <div class="clear"></div>
    <!--中间内容结束-->
    <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
</body>
</html>

