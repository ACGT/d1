<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%
String chePingAn1 = Tools.getCookie(request,"PINGAN");
String flags="2";
ArrayList<Promotion> index_plist=new ArrayList<Promotion>();
ArrayList<PromotionProduct> index_pplist=new ArrayList<PromotionProduct>();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！">
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买">
<title>D1优尚网-时尚网上购物商城,在线销售化妆品、名表、饰品、女装、男装等个人扮靓物品</title>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js?"+System.currentTimeMillis())%>"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/autotab.js?"+System.currentTimeMillis())%>"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/rollImageKP.js?"+System.currentTimeMillis())%>"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/index201309.js?"+System.currentTimeMillis())%>"></script>
<link type="text/css" rel="stylesheet" href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/index201309.css?"+System.currentTimeMillis())%>" />

<script>
  var ws=window.screen.width;    
</script>
</head>

<body style="background:#f9f9f9;">

<div>
        <%
		    ArrayList<Promotion> ptoplist=PromotionHelper.getBrandListByCodeAndArea("3341",flags, 1);
		    if(ptoplist!=null&&ptoplist.size()>0)
		    {
		    	if(ptoplist.get(0)!=null)
		    	{%>
		    	<div align="center" style="background:url('<%= ptoplist.get(0).getSplmst_picstr()%>') center center;">
		    		<a href="<%= ptoplist.get(0).getSplmst_url().trim() %>" target="_blank" style="display:block; width:100%; height:60px;">
		          
		            </a>
		        </div>
		    	<%}
		    }		
            if(session.getAttribute("d1lianmengsubad")!=null&&session.getAttribute("d1lianmengsubad").toString().equals("p1304012tmkh")){%>
			<div  style="background:#fff; width:980px; margin:0px auto; "><img src="http://images.d1.com.cn/images2013/index/alipaybanner2.jpg" width="980" height="280" border="0" usemap="#alipaybanner2" />
            <map name="alipaybanner2" id="alipaybanner2"><area shape="rect" coords="17,152,527,270" href="/interface/login/alipay.jsp" target="_blank" /><area shape="rect" coords="560,135,883,198" href="http://help.d1.com.cn/hphelpnew.htm?code=0105" target="_blank"  /></map>
            </div>
	       <%} else if(session.getAttribute("d1lianmengsubad")!=null&&session.getAttribute("d1lianmengsubad").toString().startsWith("ptenpay")){%>
			<div  style="background:#fff; width:980px; margin:0px auto; "><img src="http://images.d1.com.cn/images2013/index/tenpaybanner2.jpg" width="980" height="280" border="0" usemap="#tenpaybanner2" />
            <map name="tenpaybanner2" id="tenpaybanner2"><area shape="rect" coords="17,152,527,270" href="/interface/login/qq.jsp" target="_blank"  /><area shape="rect" coords="560,135,883,198" href="http://help.d1.com.cn/hphelpnew.htm?code=0105" target="_blank"  /></map>
			</div>
			<%	}%> 
   <div class="clear"></div>
<%@include file="/inc/head1203.jsp" %>
<div class="clear"></div>
<!--主体部分-->
<% if (!Tools.isNull(chePingAn1)){%>
   	<!--  
	<div align="center" style="background-image:url(http://images.d1.com.cn/images2012/pingan/pinganbannerbg.jpg)"><a href="http://www.wanlitong.com/campaign/5/index.jsp?WT.mc_id=000009990080025H">
	<img src="http://images.d1.com.cn/images2012/pingan/pinganbanner.jpg" width="980" height="60" border="0"></a></div>
	-->
<%} %>
<!--首页轮播-->
<div id="imgrollys">
	    <div id="imgslideys" style=" background-color: transparent;">
		    <div id="imgRollOuterys">
		    <% ArrayList<Promotion> pttlist=new ArrayList<Promotion>();
		       pttlist=PromotionHelper.getBrandListByCode("3429", 15);
		       StringBuilder sbtt1219=new StringBuilder();
		       StringBuilder sbtt1219img=new StringBuilder();
		       if(pttlist!=null&&pttlist.size()>0)
		       {
		    	   for(int i=0;i<pttlist.size();i++)
		    	   {
		    		   Promotion ptt=pttlist.get(i);
		    		   if(ptt!=null)
		    		   {
		    			   out.print("<div  img_index=\""+i+"\" style=\"background:url('"+ptt.getSplmst_picstr()+"') no-repeat center center;\"><a href=\""+ptt.getSplmst_url()+"\" title=\""+Tools.clearHTML(ptt.getSplmst_name())+"\" target=\"_blank\"></a></div>");
		    		       sbtt1219.append("<a href=\""+ptt.getSplmst_url()+"\"  target=\"_blank\" img_index=\""+i+"\" >"+(i+1)+"</a>");
			    		   if(i==pttlist.size()-1)
			    		   {
			    			   sbtt1219img.append("\""+ptt.getSplmst_picstr()+"\"");
			    		   }
			    		   else
			    		   {
			    			   sbtt1219img.append("\""+ptt.getSplmst_picstr()+"\",");
			    		   }
		    		   }
		    	   }
		       }
		    %>
		    </div>
		    <p style="right:-<%=12*pttlist.size() %>px">
		    <% out.print(sbtt1219.toString()); %>
			</p>
		     <div class="imgrollboxys">
			     <div class="left" ></div>
			     <div class="right" ></div>
		     </div>
	     </div>
     </div>
<!--首页轮播结束-->
<!--网站提醒-->
    <div id="wztx_index" style="display:block;margin:0px auto; height:30px;color:#a0a0a0; line-height:30px; ">
	<div style=" height:100%; background:url(http://images.d1.com.cn/images2013/newindex/lb.jpg) no-repeat; float:right; padding-left:25px;">
	  <marquee behavior="alternate" onmouseover="this.stop()" onmouseout="this.start()" scrolldelay="300" ><a href=" http://www.d1.com.cn/jifen" target="_blank"><span style="color:#a0a0a0;">2013年7月1日之前的积分即将清零，兑换优惠券和好礼》》</span></a></marquee>
	</div>
	</div>
	<script>
	if(ws>=1200){
		  $('#wztx_index').css('width','1200px');	
		  $('#wztx_index div').css('width','940px');
	  }
	  else{
		  $('#wztx_index').css('width','980px'); 
		  $('#wztx_index div').css('width','720px');
	  }</script>
<!--网站提醒结束-->	
<!--活动广告-->
    <div id="hdgg_index" style="display:block; margin:0px auto; height:230px; overflow:hiden;">
	<script>GetIndex_hdgg(ws);</script>
	</div>
<!--活动广告结束--> 
<!--热门活动-->
<div class="rmhd_1" >
 
</div>
   <script>GetIndex_R(ws);</script>
	<div class="clear"> </div>
	
	<!--热门活动结束-->
	<!--服装类-->
	<div id="fz_index" style=" margin:0px auto; margin-top:10px;+margin-top:5px;">
	<div id="women_index">
	hhhh
	</div>
	<script>GetCloth(ws,'1','women_index');</script>	
	
	
	<!--搭配列表-->
	<div class="dplist" >
    <div style="width:100%; height:28px;">&nbsp;&nbsp;</div>
     <%  index_plist.clear();
         index_plist=PromotionHelper.getBrandListByCode("3433", 2);
	 
		  if(index_plist!=null&&index_plist.size()>0)
		  {
		  for(Promotion p:index_plist)
		  {%>
		   <dl style="background:url(<%= p.getSplmst_picstr()!=null&&p.getSplmst_picstr().length()>0?p.getSplmst_picstr():"http://images.d1.com.cn/images2013/newindex/dpbg.jpg" %>) no-repeat;">
		   <dt>
		   <%//获取搭配
		    Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(p.getSplmst_name());
		   if(gdscoll!=null)
		   {
		   %>
		   <a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%= gdscoll.getId() %>" target="_blank"><img id="dp1" src="<%= gdscoll.getGdscoll_bigimgurl()!=null?gdscoll.getGdscoll_bigimgurl():"" %>" usemap="map_dp_<%=gdscoll.getId() %>" width="344" height="496"  /></a>
		   <map name="map_dp_<%= gdscoll.getId() %>">
			 <area shape="rect" coords="0,0,200,515" href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%= gdscoll.getId() %>" target="_blank">
		   </map>
		   </dt>
		   <dd> 
		   <table width="100%">
		   <tr><td height="10"></td></tr>
		   <tr><td height="30" valign="middle">
			<font style="font-family:黑体; font-size:24px; color:#000;"><b><%= gdscoll.getGdscoll_title() %></b></font>
		   </td></tr>
		   <tr><td height="65" valign="top">
		   <font style="color:#626e69; line-height:15px;"><%= gdscoll.getGdscoll_tail() %></font>
		   </td></tr>
		   <tr><td height="50"></td></tr>
		   <tr>
		   <td style=" position:relative; ">
		   <div id="dp1" class="dp_div1" >
			   <div style="width:100%; height:265px; overflow:hidden;">
			   <ul>
			   <% ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid(gdscoll.getId());
			      if(gdlist!=null&&gdlist.size()>0)
			      {
			    	  for(Gdscolldetail gd:gdlist)
			    	  {
			    		  if(gd!=null&&gd.getGdscolldetail_flag()==1)
			    		  {
			    		      Product product=ProductHelper.getById(gd.getGdscolldetail_gdsid());
			    		      if(product!=null&&product.getGdsmst_validflag()==1&&product.getGdsmst_ifhavegds()==0)
			    		      {
			    		  %>
			    			 <li>
				              <a href="http://www.d1.com.cn/product/<%=gd.getGdscolldetail_gdsid() %>" target="_blank" ><img src="http://images.d1.com.cn<%= product.getGdsmst_otherimg3() %>" width="100" height="100">      </a>
				              <span class="dp_s1"><%= Tools.clearHTML(gd.getGdscolldetail_title()) %>&nbsp;<font style="color:#c52727;">￥<%= Tools.getFloat(product.getGdsmst_memberprice(),1) %></font></span>
			                  </li> 
			    		  <%  }
			    		  }
			    	  }
			      }
			   %>
			   
			   </ul>
			   </div>
		   </div>
		   <a href="javascript:void(0)" onclick="GetOtherDPDetail(this)" style="position:absolute; right:0px; bottom:-5px;display:block;width:137px;height:37px;overflow:hidden;">
		   <img src="http://images.d1.com.cn/images2013/newindex/dpbg.png" width="137" height="37"></a>
		   
		   </td></tr>
		 
		   </table>
		  
		   
		   </dd>
		   </dl>
		  <%}
		  }
		  }
		  %> 		  	   
          <div class="ad_gg">
          <%
		   index_plist.clear();
		   index_plist=PromotionHelper.getBrandListByCode("3435",1);
		   if(index_plist!=null&&index_plist.size()>0)
		   {
			   if(index_plist.get(0)!=null)
			   {%>
				   <a href="<%= index_plist.get(0).getSplmst_url()!=null?index_plist.get(0).getSplmst_url():"" %>" target="_blank" ><img src="<%= index_plist.get(0).getSplmst_picstr()!=null?index_plist.get(0).getSplmst_picstr():"" %>" width="345" height="210" /></a>
		       <%}
			  
		   }
		%>
		 
		  </div>
    </div>
	<!--搭配列表结束-->
	
	<div class="clear"></div>
	<!-- 男装 -->	
	<div id="men_index">
	hhhh
	</div>
	<script>GetCloth(ws,'2','men_index');</script>	
	<!--搭配列表-->
	<div class="dplist" >
    <div style="width:100%; height:28px;">&nbsp;&nbsp;</div>
		   <%  index_plist.clear();
         index_plist=PromotionHelper.getBrandListByCode("3434", 1);
	 
		  if(index_plist!=null&&index_plist.size()>0)
		  {
		  for(Promotion p:index_plist)
		  {%>
		   <dl style="background:url(<%= p.getSplmst_picstr()!=null&&p.getSplmst_picstr().length()>0?p.getSplmst_picstr():"http://images.d1.com.cn/images2013/newindex/dpbg.jpg" %>) no-repeat;">
		   <dt>
		   <%//获取搭配
		    Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(p.getSplmst_name());
		   if(gdscoll!=null)
		   {
		   %>
		   <a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%= gdscoll.getId() %>" target="_blank"><img id="dp1" src="<%= gdscoll.getGdscoll_bigimgurl()!=null?gdscoll.getGdscoll_bigimgurl():"" %>" usemap="map_dp_<%=gdscoll.getId() %>" width="344" height="496"  /></a>
		   <map name="map_dp_<%= gdscoll.getId() %>">
			 <area shape="rect" coords="0,0,200,515" href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%= gdscoll.getId() %>" target="_blank">
		   </map>
		   </dt>
		   <dd> 
		   <table width="100%">
		   <tr><td height="10"></td></tr>
		   <tr><td height="30" valign="middle">
			<font style="font-family:黑体; font-size:24px; color:#000;"><b><%= gdscoll.getGdscoll_title() %></b></font>
		   </td></tr>
		   <tr><td height="65" valign="top">
		   <font style="color:#626e69; line-height:15px;"><%= gdscoll.getGdscoll_tail() %></font>
		   </td></tr>
		   <tr><td height="50"></td></tr>
		   <tr>
		   <td style=" position:relative; ">
		   <div id="dp1" class="dp_div1" >
			   <div style="width:100%; height:265px; overflow:hidden;">
			   <ul>
			   <% ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid(gdscoll.getId());
			      if(gdlist!=null&&gdlist.size()>0)
			      {
			    	  for(Gdscolldetail gd:gdlist)
			    	  {
			    		  if(gd!=null&&gd.getGdscolldetail_flag()==1)
			    		  {
			    		      Product product=ProductHelper.getById(gd.getGdscolldetail_gdsid());
			    		      if(product!=null&&product.getGdsmst_validflag()==1&&product.getGdsmst_ifhavegds()==0)
			    		      {
			    		  %>
			    			 <li>
				              <a href="http://www.d1.com.cn/product/<%=gd.getGdscolldetail_gdsid() %>" target="_blank" ><img src="http://images.d1.com.cn<%= product.getGdsmst_otherimg3() %>" width="100" height="100">      </a>
				              <span class="dp_s1"><%= Tools.clearHTML(gd.getGdscolldetail_title()) %>&nbsp;<font style="color:#c52727;">￥<%= Tools.getFloat(product.getGdsmst_memberprice(),1) %></font></span>
			                  </li> 
			    		  <%  }
			    		  }
			    	  }
			      }
			   %>
			   
			   </ul>
			   </div>
		   </div>
		   <a href="javascript:void(0)" onclick="GetOtherDPDetail(this)" style="position:absolute; right:0px; bottom:-5px;display:block;width:137px;height:37px;overflow:hidden;">
		   <img src="http://images.d1.com.cn/images2013/newindex/dpbg.png" width="137" height="37"></a>
		   
		   </td></tr>
		 
		   </table>
		  
		   
		   </dd>
		   </dl>
		  <%}
		  }
		  }
		  %> 
		   		   
          <div class="ad_gg">
		    <%
		   index_plist.clear();
		   index_plist=PromotionHelper.getBrandListByCode("3436",2);
		   if(index_plist!=null&&index_plist.size()>0)
		   {
			   for(Promotion p:index_plist)
			   {%> 
				   <a href="<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>" target="_blank" ><img src="<%= p.getSplmst_picstr()!=null?p.getSplmst_picstr():"" %>" width="345" height="230" /></a>
		       <%}
			  
		   }
		%>
		 
		  </div>
    </div>
	<!--搭配列表结束-->
	<!-- 男装结束 -->
	</div>
	
	<script>
	if(ws>=1200){
		  $('#fz_index').css('width','1200px');
	  }
	  else{
		  $('#fz_index').css('width','980px');
	  }</script>
	<div class="clear"></div>
	<!--服装类结束-->
	<!--化妆品类-->
	<div class="zblist" >
	<div id="zp_index" >
	 <script>GetOtherproduct(ws,'1','zp_index');</script>
	</div>
	
	  <!--化妆品商品列表结束-->
	   <!--化妆品品牌-->
	   <div style=" width:330px; float:left;">
	    <div id="zppp" style=" widhth:100%;background:url(http://images.d1.com.cn/images2013/newindex/rmpp.jpg) no-repeat;">
		   <div style="height:43px; width:100%;">&nbsp;&nbsp;</div>
		   <div style=" background:#d2d2d2; padding:5px; overflow:hidden;">
		   <%
			   index_plist.clear();
			   index_plist=PromotionHelper.getBrandListByCode("3437",-1);
			   if(index_plist!=null&&index_plist.size()>0)
			   {
			      for(int i=0;i<index_plist.size();i++)
			      {
			    	  Promotion p=index_plist.get(i);
			    	  if(p!=null)
			    	  {%>
			    		  <a href="<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>" target="_blank" style="<% if(i%3==0) out.print("margin-right:2px;"); else  out.print("margin-right:0px;"); %>"><img src="<%= p.getSplmst_picstr()!=null?p.getSplmst_picstr():"" %>" width="103" height="40"/></a>  
			    	  <%}
			      }
			   }
		   %>
		     
		   </div>
		   
		</div>
		<div id="zpad" style="width:100%;">
		<%
		   index_plist.clear();
		   index_plist=PromotionHelper.getBrandListByCode("3438",2);
		   if(index_plist!=null&&index_plist.size()>0)
		   {
			   if(index_plist.get(0)!=null)
			   {%>
				   <a href="<%= index_plist.get(0).getSplmst_url()!=null?index_plist.get(0).getSplmst_url():"" %>" target="_blank" ><img src="<%= index_plist.get(0).getSplmst_picstr()!=null?index_plist.get(0).getSplmst_picstr():"" %>" width="330" height="146" /></a>
		       <%}
			   if(index_plist.get(1)!=null)
			   {%>
				   <a href="<%= index_plist.get(1).getSplmst_url()!=null?index_plist.get(1).getSplmst_url():"" %>" target="_blank" ><img src="<%= index_plist.get(1).getSplmst_picstr()!=null?index_plist.get(1).getSplmst_picstr():"" %>" width="330" height="146" /></a>
		       <%}
			   
		   }
		%>
		</div>
	   </div>
	   <!--化妆品品牌结束-->
	   
	</div>
	<!--化妆品类结束-->
	<div class="clear"></div>
	<!-- 内衣家居 -->
	<div  class="zblist" >
	<div id="nyjj_index">
	 <script>GetOtherproduct(ws,'2','nyjj_index');</script>
	</div>
	  
	   <div style=" width:330px; float:left;">	    
		<div style="width:100%;">
		<%
		   index_plist.clear();
		   index_plist=PromotionHelper.getBrandListByCode("3439",2);
		   if(index_plist!=null&&index_plist.size()>0)
		   {
			   if(index_plist.get(0)!=null)
			   {%>
				   <a href="<%= index_plist.get(0).getSplmst_url()!=null?index_plist.get(0).getSplmst_url():"" %>" target="_blank" ><img src="<%= index_plist.get(0).getSplmst_picstr()!=null?index_plist.get(0).getSplmst_picstr():"" %>" width="330" height="220" /></a>
		       <%}
			   if(index_plist.get(1)!=null)
			   {%>
				   <a href="<%= index_plist.get(1).getSplmst_url()!=null?index_plist.get(1).getSplmst_url():"" %>" target="_blank" ><img src="<%= index_plist.get(1).getSplmst_picstr()!=null?index_plist.get(1).getSplmst_picstr():"" %>" width="330" height="220" style="margin-top:10px;" /></a>
		       <%}
			   
		   }
		%>
		</div>
	   </div>
	 
	   
	</div>
	<!-- 内衣家居结束 -->
	<div class="clear"></div>
	<!-- 鞋品 -->
	<div class="zblist" >
	<div id="xp_index" >
	  <script>GetOtherproduct(ws,'3','xp_index');</script>
	</div>
	  
	   <div style=" width:330px; float:left;">	    
		<div style="width:100%;">
		<%
		   index_plist.clear();
		   index_plist=PromotionHelper.getBrandListByCode("3440",2);
		   if(index_plist!=null&&index_plist.size()>0)
		   {
			   if(index_plist.get(0)!=null)
			   {%>
				   <a href="<%= index_plist.get(0).getSplmst_url()!=null?index_plist.get(0).getSplmst_url():"" %>" target="_blank" ><img src="<%= index_plist.get(0).getSplmst_picstr()!=null?index_plist.get(0).getSplmst_picstr():"" %>" width="330" height="450" /></a>
		       <%}
			   
		   }
		%>
		</div>
	   </div>
	 
	   
	</div>
	<!-- 鞋品结束 -->
	<div class="clear"></div>
	<!-- 箱包皮具 -->
	<div class="zblist" >
	<div id="xbpj_index" >
	 <script>GetOtherproduct(ws,'4','xbpj_index');</script>
	</div>
	  
	   <div style=" width:330px; float:left;">	    
		<div style="width:100%;">
		<%
		   index_plist.clear();
		   index_plist=PromotionHelper.getBrandListByCode("3441",1);
		   if(index_plist!=null&&index_plist.size()>0)
		   {
			   if(index_plist.get(0)!=null)
			   {%>
				   <a href="<%= index_plist.get(0).getSplmst_url()!=null?index_plist.get(0).getSplmst_url():"" %>" target="_blank" ><img src="<%= index_plist.get(0).getSplmst_picstr()!=null?index_plist.get(0).getSplmst_picstr():"" %>" width="330" height="450" /></a>
		       <%}
			   
		   }
		%>
		</div>
	   </div>
	 
	   
	</div>
	<!-- 箱包皮具结束 -->
	<div class="clear"></div>
	<!-- 配件 -->
	<div  class="zblist">
	<div id="pj_index">
	<script>GetOtherproduct(ws,'5','pj_index');</script>
	</div>
	  
	   <div style=" width:330px; float:left;">	    
		<div style="width:100%;">
		<%
		   index_plist.clear();
		   index_plist=PromotionHelper.getBrandListByCode("3442",2);
		   if(index_plist!=null&&index_plist.size()>0)
		   {
			   if(index_plist.get(0)!=null)
			   {%>
				   <a href="<%= index_plist.get(0).getSplmst_url()!=null?index_plist.get(0).getSplmst_url():"" %>" target="_blank" ><img src="<%= index_plist.get(0).getSplmst_picstr()!=null?index_plist.get(0).getSplmst_picstr():"" %>" width="330" height="220" /></a>
		       <%}
			   if(index_plist.get(1)!=null)
			   {%>
				   <a href="<%= index_plist.get(1).getSplmst_url()!=null?index_plist.get(1).getSplmst_url():"" %>" target="_blank" ><img src="<%= index_plist.get(1).getSplmst_picstr()!=null?index_plist.get(1).getSplmst_picstr():"" %>" width="330" height="220" style="margin-top:10px;" /></a>
		       <%}
			   
		   }
		%>
		</div>
	   </div>
	 
	   
	</div>
	<!-- 配件结束 -->
	<div class="clear"></div>
	<!-- 饰品 -->
	<div class="zblist" >
	<div  id="sp_index">
	   <script>GetOtherproduct(ws,'6','sp_index');</script>	
	 </div> 
	   <div style=" width:330px; float:left;">	    
		<div style="width:100%;">
		<%
		   index_plist.clear();
		   index_plist=PromotionHelper.getBrandListByCode("3443",2);
		   if(index_plist!=null&&index_plist.size()>0)
		   {
			   if(index_plist.get(0)!=null)
			   {%>
				   <a href="<%= index_plist.get(0).getSplmst_url()!=null?index_plist.get(0).getSplmst_url():"" %>" target="_blank" ><img src="<%= index_plist.get(0).getSplmst_picstr()!=null?index_plist.get(0).getSplmst_picstr():"" %>" width="330" height="220" /></a>
		       <%}
			   if(index_plist.get(1)!=null)
			   {%>
				   <a href="<%= index_plist.get(1).getSplmst_url()!=null?index_plist.get(1).getSplmst_url():"" %>" target="_blank" ><img src="<%= index_plist.get(1).getSplmst_picstr()!=null?index_plist.get(1).getSplmst_picstr():"" %>" width="330" height="220" style="margin-top:10px;" /></a>
		       <%}
			   
		   }
		%>
		</div>
	   </div>
	 
	   
	</div>
	<!-- 饰品结束 -->
</div>

<!--主体部分结束-->

<div class="clear"></div>
<div class="wxadright"><img src="http://images.d1.com.cn/images2014/product/wixinp.jpg" width="100" height="150" /></div>
<div>
   <%@include file="/inc/foot.jsp" %>
</div>


</body>
</html>

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>

<script type="text/javascript" language="javascript">
  var t_rmhd;
  var n_rmfk =0;
  var count;
  $(document).ready(function() {
		if(ws>=1200){			  
			  $('.zblist').css('width','1200px');
		  }
		  else{
			  $('.zblist').css('width','980px');
		  }
        /*大图轮播*/
         var roll_images=[<%= sbtt1219img.toString()%>];
	     var imgrollbg=['#fff','#fff','#fff','#fff','#fff','#fff','#fff','#fff'];
	 	 var bg = imgrollbg || null;
	 	 new RollImage(roll_images, $("#imgRollOuterys"), $("#imgslideys>p>a"), null, $("#imgrollys .left"), $("#imgrollys .right"), bg).run(1);
         $("#imgrollys").hover(function ()
		  {
				$(this).find(".left,.right").fadeIn();
		  },
		  function ()
		  {
			    $(this).find(".left,.right").fadeOut();
		  });       
		  /*秒杀轮播*/
		  /*  count=$("#banner_list div").length; 
			$("#banner_list div:not(:first-child)").hide(); 			
			$("#banner li").hover(function() { 
				var i = $(this).text() - 1;//获取Li元素内的值，即1，2，3，4 
				n_rmfk = i; 
				if (i >= count) return; 			
				$(this).addClass('cur').siblings().removeClass('cur'); 
				$("#banner_list div").css('display','none');
		        $("#banner_list div").eq(i).fadeIn(1000); 
			}); 
			t_rmhd = setInterval("showAuto()", 3000); 
			$("#banner").hover(function(){clearInterval(t_rmhd)}, function(){t_rmhd = setInterval("showAuto()", 3000);}); 
			 */
            $(".imglist").find("img").lazyload({ effect: "show", placeholder: "http://images.d1.com.cn/Index/images/grey.gif",threshold : 200 });
		    $(".zblist").find("img").lazyload({ effect: "show", placeholder: "http://images.d1.com.cn/Index/images/grey.gif",threshold : 200 });
		 
	});
	/*秒杀轮播的图片展示*/
	function showAuto() 
	{ 	
		n_rmfk = n_rmfk >=(count - 1) ? 0 : ++n_rmfk;
		$("#banner_list div").css('display','none');
		$("#banner_list div").eq(n_rmfk).fadeIn(1000);
		$("#banner li").removeClass('cur');
		$("#banner li").eq(n_rmfk).addClass('cur');
	} 
      
</script>
