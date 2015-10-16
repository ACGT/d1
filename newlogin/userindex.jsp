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
<style>
.ulvalidate{ list-style-type: none;}
.ulvalidate li{ float:left;padding-left:20px;}
.acco-safe s,.account .fl s{display:inline-block;*zoom:1;margin-right:3px;width:16px;height:16px; vertical-align:middle;line-height:100px;font-size:0;overflow:hidden;background:url(http://images.d1.com.cn/images2012/login/icon-veri-1.png) no-repeat}
.acco-safe a{margin-right:8px;color:#3051ae; text-decoration:underline; font-size:12px;}
.acco-safe .teln s{background-position:0 -17px}
.acco-safe .mail s{background-position:-17px 0}
.acco-safe .mailn s{background-position:-17px -17px}
.acco-safe .spsd s{background-position:-34px 0}
.acco-safe .spsdn s{background-position:-34px -17px}
.mbr_infoimg {float:left;};
.mbr_infoimg img{ border:solid 1px #c2c2c2; vertical-align:middle; float:left;}
</style>
</head>
<body>
    <!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
 <!-- 中间内容 -->
    <!-- 中间内容 -->
     <div class="center">
     <div style="width:980px; margin:0px auto;text-align:center;color:#f00; font-size:15px;">
     网购温馨提示：电话诈骗猖獗，接到任何购物网站通知中奖或低价促销电话，均为诈骗信息，D1优尚也从不通过电话进行促销，请提高警惕
     </div>
             <%
             if(UserScoreHelper.getRealScore(lUser.getId())>200){
            	 %>
            	  <div style="width:980px; margin:0px auto; text-align:center; font-size:22px; line-height:28px; margin-bottom:10px;"><a href="http://www.d1.com.cn/temai/" target="_blank">2012年7月1日之前的积分已清零，发表评论、晒单均可获得积分！兑换优惠券和好礼》》</a> </div>
             
            <% }
             %>
            
             
     <%@include file="/user/left.jsp" %>
      <!--右侧-->
   <div class="mbr_right">
		  <div class="mbr_right_first">
					 <div class="mbr_info">
					 <div class="mbr_infoimg">
					 <div>
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
							//判断是否进行邮箱、手机验证
							boolean isemailflag=false;boolean isphoneflag=false;boolean isdetail=false;
							if(lUser.getMbrmst_mailflag()!=null && lUser.getMbrmst_mailflag().longValue()==1){
								isemailflag=true;
							}if(lUser.getMbrmst_phoneflag()!=null && lUser.getMbrmst_phoneflag().longValue()==1){
								isphoneflag=true;
							}
							if(!Tools.isNull(lUser.getMbrmst_name()) && !Tools.isNull(lUser.getMbrmst_postcode())){
								isdetail=true;
							} %>
							</div>
							<div style="clear:both;padding-bottom:10px;"></div>
							<div style="padding-left:8px;">
								<div class="acco-safe">
								<%
								if(!isphoneflag){
								%>
								<a class="teln" href="/newlogin/valitel.jsp"><s></s>手机未验证</a><br/>
								<%}else{ %>
								<a  href="/newlogin/profile.jsp"><s></s>手机已验证</a><br/>
								<%} if(!isemailflag){%>
								<a class="mailn" href="/newlogin/valiemail.jsp" ><s></s>邮箱未验证</a><br/>
								<%}else{ %>
								<a class="mail" href="/newlogin/profile.jsp" ><s></s>邮箱已验证</a><br/>
								<%} if(isdetail){%>
								<a class="spsd" href="/newlogin/profile.jsp" ><s></s>个人信息已完善</a><br/>
								<%}else{ %>
								<a class="spsdn" href="/newlogin/profile.jsp" ><s></s>个人信息未完善</a><br/>
								<%} %>
								</div>
							</div>
							
					 </div>
					       
					        
						    
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
							    //list2=OrderHelper.getOrderHistoryListByMbrid(lUser.getId(), 1000);
							    list3.addAll(list1);
							    //list3.addAll(list2);
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
							 消费总额：<span><b><%= Tools.getDouble(summoney,2) %></b><font color="#333">元</font>&nbsp;&nbsp;<a href="/help/helpnew.jsp?code=05" target="_blank">会员制度</a></span><br/>
							<!--  
							 <% if(summoney<2000&&lUser.getMbrmst_specialtype()==0)
							    {
							       if(summoney<500)
							       {  %>
							    	   <span style=" font-size:12px;">(再消费<%=Tools.getDouble(500-summoney,2) %>元，升级为VIP会员,享受服饰95折；再消费<%= Tools.getDouble(2000-summoney,2) %>元，升级为白金会员,享受服饰88折)</span><br/>
							     <% }
							       else 
							       {%>
							    	    <span style=" font-size:12px;">(再消费<%= Tools.getDouble(2000-summoney,2) %>元，升级为白金会员,享受服饰88折)</span><br/>
							   
							       <%}
							    %>
							    
								  
							    
							   <% }
							 else
							 {
								 if(!UserHelper.isPtVip(lUser))
								 {%>
									 <span style=" font-size:12px;">(再消费<%= Tools.getDouble(2000-summoney,2) %>元，升级为白金会员,享受服饰88折)</span><br/>
							   
								 <%}
							 }
								 
								 %>
								 -->
						    年度消费总额：<span><b><%= Tools.getDouble(y_summoney,2)  %></b><font color="#333">元</font></span>
						    <br/>
							<% if (Tools.isNull(chePingAn)){%> 
							 您的积分：<span><b><%= (int)(UserScoreHelper.getRealScore(lUser.getId())+0.5) %></b><font color="#333">分，</font><a href="/help/helpnew.jsp?code=0104" target="_blank">积分规则</a>&nbsp;&nbsp;
							 <a href="http://www.d1.com.cn/jifen/" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/des/jfdhhl1.png" /></a></span><br/>
							<%}%>
							
							
							<%
							   // if(UserHelper.isPtVip(lUser))
                               // {%>
							    	<!--  <span><a href="http://www.d1.com.cn/html/bjdxlist.jsp" target="_blank">查看白金独享特价商品>></a></span>-->
                                <%//}
							   %>
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
	<%
	
	if(!isdetail || !isemailflag || !isphoneflag){
		%>	
			<div style=" background:#f6f6f6; float:left;width:769px; height:140px;margin-top:20px;">
	 <div style="padding-top:15px;padding-left:30px;">为了您的账户安全，请验证手机和邮箱。验证通过后可接收账户金额及订单状态的变动提醒，使用快速找回密码、发表评论等功能。</div>
	<div style="padding-top:35px;padding-left:30px;">
	<ul class="ulvalidate">
	<%if(!isemailflag){ %><li><a href="/newlogin/valiemail.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/login/zc_21.jpg" border="0"/></a></li><%} %>
	<%if(!isphoneflag){ %><li><a href="/newlogin/valitel.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/login/zc_23.jpg" border="0"/></a></li><%} %>
	<%if(!isdetail){ %><li><a href="/newlogin/profile.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/login/zc_25.jpg" border="0"/></a><br/>
	<span style="color:red;font-size:12px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;生日期间可收到生日礼物哦</span></li><%} %>
	</ul>
	</div>
	</div>
	<div class="clear"></div>
	<%}
	%>

	
		<br/>
<!-- 
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
 -->
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

