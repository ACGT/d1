<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/html/indexpublic.jsp"%>

<%if ("mqwyjf1203q".equals(session.getAttribute("d1lianmengsubad"))){
	session.removeAttribute("d1lianmengsubad");
	response.sendRedirect("http://www.d1.com.cn/zhuanti/20120328WangYi/index.jsp");
	return;
} 

%>
<%
//head
String chePingAn1 = Tools.getCookie(request,"PINGAN");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>D1优尚网-时尚网上购物商城,在线销售化妆品、名表、饰品、女装、男装等个人扮靓物品</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/autotab.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/index2012711.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/index2012.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css" media="screen" />
<style type="text/css">
.allhd2{ position:fixed; _position: absolute;  right:0px; bottom:0px;  width: 121px;font-size:12px; _top:expression(documentElement.scrollTop+documentElement.clientHeight-this.offsetHeight);
             overflow:hidden; z-index:200000; display:block; background: url("http://images.d1.com.cn/images2012/index2012/indexqchdfloat2.png") no-repeat; 
            }
</style>
</head>
<body>
<div>
<%
		if(session.getAttribute("headShow") !=null && session.getAttribute("jifenurl") !=null && !Tools.isNull(session.getAttribute("jifenurl").toString())  && !Tools.isNull(session.getAttribute("headShow").toString())){
			%>	
			<div class="mod_top_banner">
	<div class="main_area">
		<div class='sale_tip'><%=session.getAttribute("headShow").toString() %></div>
		<div class='login_status'>
			
			<a class='my_caibei' href="<%=session.getAttribute("jifenurl").toString()%>">我的彩贝积分</a>
		</div>
	</div>
</div>
		<%}
		%>   

   <!-- 头部 -->
<%@include file="/inc/head.jsp" %>

<div style="background:url('http://images.d1.com.cn/images2012/index2012/qchd7bg.JPG'); +margin-top:10px;"  align="center"><img src="http://images.d1.com.cn/images2012/index2012/banner0730.jpg" border="0" usemap="#Mapbanner0727"/></div>
<map name="Mapbanner0727">
<area shape="rect" coords="-2,0,705,60" href="/html/zt2012/0730ay/index.jsp" target="_blank">
<area shape="rect" coords="709,2,978,60" href="/html/zt2012/20120727ay/index.jsp" target="_blank">
</map>
    <div style="clear:both;"></div>
   <!-- 头部结束 -->
   <!-- page开始 -->
   	<% if (!Tools.isNull(chePingAn1)){%>
	<div align="center" style="background-image:url(http://images.d1.com.cn/images2012/pingan/pinganbannerbg.jpg)"><a href="http://www.wanlitong.com/campaign/5/index.jsp?WT.mc_id=000009990080025H">
	<img src="http://images.d1.com.cn/images2012/pingan/pinganbanner.jpg" width="980" height="60" border="0"></a></div>
	<%} %>
	<div id="page" class="allindex">
	<!-- 首页全场活动 -->
<!--
	  <div class="allhd2" id="allhd">
	   
	     <table width="121">
	<tr><td height="105"><a href="http://www.d1.com.cn/zhuanti/20120718qchd/qchd.jsp" target="_blank"><div style="height:105px;width:121px;">&nbsp;</div></a></td></tr>   
 
 <tr><td ><a href="http://www.d1.com.cn/zhuanti/20120718zp/zp.jsp" target="_blank"><div style="height:330px;width:121px;">&nbsp;</div></a></td></tr>

 </table>
 <a href="javascript:void(0)" onclick="closeallhd();" style="position:absolute;top:0px;left:97px; top:10px;">

		<img src="http://images.d1.com.cn/images2012/index2012/X.png" width="10" hight="10" style="position:absolute;margin-left:2px; margin-top:4px; "/>
		</a>     
	    
	 
	  </div>  -->
    <!-- 首页全场活动结束 -->
	
	
    <!-- 主体 -->
	<div id="center">
	   <table width="100%" height="840" cellspacing="0" cellpadding="0" border=0 >
	        <tr>
	        <td rowspan="5" width="270" style="overflow:hidden; vertical-align:top; padding-top:28px;">
	            
	             <table width="100%">
	               <tr><td height=135><div class="aleeshe" >
	                   <span <% String lsstr=getLogo("2865"); if(lsstr.length()>0) { %> style="background:url('<%= lsstr %>') no-repeat bottom left;" <%} %>>
	                      <a <% String urlstr=getLogoUrl("2865"); if(urlstr.length()>0) { %> href="<%= urlstr %>" <%} %>  target="_blank"  style="width:121px; height:135px; position:absolute;"></a>
	                      <div>
	                        <div id="sdiv2012_1" class="sdiv2012_1" style="height:48px; _height:45px; padding:0px;" onmouseover="overcate(this,'1')" onmouseout="outcate(this,'1')">
	                            <a href="http://aleeishe.d1.com.cn/"  target="_blank" >
	                             <img id="simg1" src="http://images.d1.com.cn/images2012/index2012/logo/logo_01.jpg" style="z-index:10001;"/>
	                             </a>
	                        </div>
	                        <div id="catdiv_1" onmouseover="overcate('#sdiv2012_1','1')" onmouseout="outcate('#sdiv2012_1','1')" style=" height:auto; ">
	                          <table style="width:100%; height:354px; ">
	                               <tr><td>
	                                   <table class="table2012" >	  
	                                      <tr><td style="text-align:left; " ><a href="http://www.d1.com.cn/brand/aleeishe/index.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/inxls.png"/></a></td></tr>
	                                      <tr><td height="10"></td></tr>                                
	                                       <tr><td height="25"><font style="font-size:13px; font-weight:bold;">小栗舍服装</font></td></tr>
	                                       <tr><td style="border-bottom:dashed 1px #959595;">
	                                       <%= getCKey("2888")  %>
	                                       </td></tr>
	                                       <tr><td height="5"></td></tr>
	                                       <tr><td height="25"><font style="font-size:13px; font-weight:bold;">小栗舍配饰</font></td></tr>
	                                       <tr><td style="border-bottom:dashed 1px #959595;">
	                                       <%= getCKey("2889")  %> </td></tr>
	                                      
	                                   </table>
	                                   <div style="width:230px; margin:0px auto; margin-top:10px; margin-bottom:10px; padding:0px;">
	                                    <%= getimg("2892",1,230,155) %></div>
	                               </td>
	                               
	                               <td width="207" style="background:#fff4f7; ">
	                                  <table style="text-align:left; width:190px; margin:0px auto;">
	                                    <%=getimglist1("2891",3) %> 
	                                  </table>
	                               
	                               </td></tr>
	                          </table>
	                        </div>
	                         
	                          
	                          <ul>
	                         <%=getxl("2870",4)  %>  
	                      </ul>
	                     </div>
	                     
	                     
	                   </span>
	               </div></td></tr>
	               <tr><td height=157><div class="feelmind" >
	             
	                <span <% String lsstr1=getLogo("2866"); if(lsstr1.length()>0) { %> style="background:url('<%= lsstr1 %>') no-repeat bottom left;" <%} %>>
	                 <a <% String urlstr1=getLogoUrl("2866"); if(urlstr1.length()>0) { %> href="<%= urlstr1 %>" <%} %>  target="_blank"  style="width:82px; height:150px; position:absolute;"></a>
	                <div>
	                          <div id="sdiv2012_2" class="sdiv2012_2" style="height:28px; _height:25px; padding:0px; padding-top:12px;" onmouseover="overcate(this,'2')" onmouseout="outcate(this,'2')">
	                            <a href="http://feelmind.d1.com.cn/" onmouseover="" target="_blank">
	                             <img  id="simg2" src="http://images.d1.com.cn/images2012/index2012/logo/logo_02.jpg" style="z-index:10001;"/>
	                             </a>
	                          </div>
	                        <div id="catdiv_2" onmouseover="overcate('#sdiv2012_2','2')" onmouseout="outcate('#sdiv2012_2','2')" style="height:426px;">
	                          <table style="width:100%; height:100%; ">
	                               <tr><td>
	                                   <table class="table2012"  >	
	                                    <tr><td style="text-align:left " ><a href="http://www.d1.com.cn/brand/feelmind/index.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/infm.png"/></a></td></tr>                                       
	                                     <tr><td height="8"></td></tr>
	                                       <tr><td height="25"><font style="font-size:13px; font-weight:bold;">FEEL MIND男装</font></td></tr>
	                                       <tr><td style="border-bottom:dashed 1px #959595;">
	                                        <%= getCKey("2893")  %>
	                                       </td></tr>
	                                       <tr><td height="5"></td></tr>
	                                       <tr><td height="25"><font style="font-size:13px; font-weight:bold;">FEEL MIND女装</font></td></tr>
	                                       <tr><td style="border-bottom:dashed 1px #959595;">
	                                        <%= getCKey("2894")  %> </td></tr>
	                                         <tr><td height="5"></td></tr>
	                                       <tr><td height="25"><font style="font-size:13px; font-weight:bold;">FEEL MIND情侣装</font></td></tr>
	                                       <tr><td style="border-bottom:dashed 1px #959595;">
	                                        <%= getCKey("3020")  %> </td></tr>
	                                   </table>
	                                   <div style="width:230px; margin:0px auto; margin-top:10px; margin-bottom:10px; padding:0px;">
	                                   <%= getimg("2897",1,230,155) %>
	                                   </div>
	                               </td>
	                               
	                               <td width="207" style="background:#b0c3ed;">
	                                  <table style="text-align:left; width:190px; margin:0px auto;">
	                                    
	                                         <%=getimglist2("2896",4) %> 
	                                  </table>
	                               
	                               </td></tr>
	                          </table>
	                        </div>
	                          <ul>
	                         <%=getxl("2873",4)  %>  
	                      </ul>
	                  </div>   
	                     </span>
	             
	               </div></td></tr>
	               <tr><td height=156><div class="srm" >
	               <span <% String lsstr2=getLogo("2867"); if(lsstr2.length()>0) { %> style="background:url('<%= lsstr2 %>') no-repeat bottom left;" <%} %>>
	                 <a <% String urlstr2=getLogoUrl("2867"); if(urlstr2.length()>0) { %> href="<%= urlstr2 %>" <%} %>  target="_blank"  style="width:80px; height:150px; position:absolute;"></a>
	                 
	                <div>
	                          <div id="sdiv2012_3" class="sdiv2012_3" style="height:39px; _height:35px; padding:0px; padding-top:4px;" onmouseover="overcate(this,'3')" onmouseout="outcate(this,'3')">
	                            <a href="http://sheromo.d1.com.cn/" onmouseover="" target="_blank">
	                             <img id="simg3" src="http://images.d1.com.cn/images2012/index2012/logo/logo_03.jpg" style="z-index:10001;"/>
	                             </a>
	                          </div>
	                        <div id="catdiv_3" onmouseover="overcate('#sdiv2012_3','3')" onmouseout="outcate('#sdiv2012_3','3')" style="height:390px;">
	                          <table style="width:100%; height:100%; ">
	                               <tr><td>
	                                   <table class="table2012" >	
	                                    <tr><td style="text-align:left " ><a href="http://www.d1.com.cn/brand/sheromo/index.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/insrm.png"/></a></td></tr>
	                                                                             
	                                       <tr><td height="25"><font style="font-size:13px; font-weight:bold;">上装</font></td></tr>
	                                       <tr><td style="border-bottom:dashed 1px #959595;">
	                                       <%= getCKey("2898")  %>
	                                       </td></tr>
	                                       <tr><td height="5"></td></tr>
	                                       <tr><td height="25"><font style="font-size:13px; font-weight:bold;">下装</font></td></tr>
	                                       <tr><td style="border-bottom:dashed 1px #959595;">
	                                       <%= getCKey("2899")  %>  </td></tr>
	                                       <tr><td height="5"></td></tr>
	                                       <tr><td height="25"><font style="font-size:13px; font-weight:bold;">配饰</font></td></tr>
	                                       <tr><td style="border-bottom:dashed 1px #959595;">
	                                       <%= getCKey("2900")  %>  </td></tr>
	                                   </table>
	                                   <div style="width:230px; margin:0px auto; margin-top:10px; margin-bottom:10px; padding:0px;">
	                                  <%= getimg("2903",1,230,155) %></div>
	                               </td>
	                               
	                               <td width="207" style="background:#d5ac96;">
	                                  <table style="text-align:left; width:190px; margin:0px auto;">
	                                         <%=getimglist1("2902",3) %> 
	                                  </table>
	                               
	                               </td></tr>
	                          </table>
	                        </div>
	                         <ul>
	                          <%=getxl("2877",4)  %>  
	                      </ul>
	                     </div>
	                     </span>
	               </div></td></tr>
	               <tr><td height=148><div class="zp" >
	                  <span <% String lsstr3=getLogo("2868"); if(lsstr3.length()>0) { %> style="background:url('<%= lsstr3 %>') no-repeat bottom left;" <%} %>>
	                 <a <% String urlstr3=getLogoUrl("2868"); if(urlstr3.length()>0) { %> href="<%= urlstr3 %>" <%} %>  target="_blank"  style="width:118px; height:150px; position:absolute;"></a>
	                 
	                <div>
	                            <div id="sdiv2012_4" class="sdiv2012_4" style="height:39px; _height:35px; padding:0px; padding-top:4px;" onmouseover="overcate(this,'4')" onmouseout="outcate(this,'4')">
	                            <a href="http://www.d1.com.cn/html/cosmetic/" onmouseover="" target="_blank">
	                             <img id="simg4" src="http://images.d1.com.cn/images2012/index2012/logo/logo_04.jpg" style="z-index:10001;"/>
	                             </a>
	                          </div>
	                        <div id="catdiv_4" onmouseover="overcate('#sdiv2012_4','4')" onmouseout="outcate('#sdiv2012_4','4')">
	                          <table style="width:100%; height:100%; ">
	                               <tr><td>
	                                   <table class="table2012" height="335">
	                                   <tr><td height="5"></td></tr>
	                                         <tr><td style="text-align:left " ><a href="http://www.d1.com.cn/html/cosmetic/" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/incosmetic.png"/></a></td></tr>
	                                                                       
	                                       <tr><td height="25"><font style="font-size:13px; font-weight:bold;">面部护理</font></td></tr>
	                                       <tr><td style="border-bottom:dashed 1px #959595; padding-bottom:4px;">
	                                        <%= getCKey("2910")  %>
	                                       </td></tr>
	                                       <tr><td height="7"></td></tr>
	                                       <tr><td height="25"><font style="font-size:13px; font-weight:bold;">彩妆香水</font></td></tr>
	                                       <tr><td style="border-bottom:dashed 1px #959595; padding-bottom:4px;">
	                                       <%= getCKey("2911")  %></td></tr>
	                                           <tr><td height="7"></td></tr>
	                                            <tr><td height="25"><font style="font-size:13px; font-weight:bold;">男士护肤</font></td></tr>
	                                       <tr><td style="border-bottom:dashed 1px #959595; padding-bottom:4px;">
	                                        <%= getCKey("2912")  %>
	                                       </td></tr>
	                                   </table>
	                                   <div style="width:230px; margin:0px auto; margin-top:10px; margin-bottom:10px; padding:0px;">
	                                   <%= getimg("2915",1,230,155) %> </div>
	                               </td>
	                               
	                               <td width="215" style="background:#eaa4c6; text-align:center; padding-top:5px; padding-bottom:5px;">
	                                  <table style="text-align:left; height:25px; margin:0px auto;">
	                                     <tr><td height="5"></td></tr>
	                                    <tr><td style="border-bottom:dashed 1px #959595; padding-bottom:4px;">
	                                        <ul id="newhzpul" >
	                                        <%=   getimglist("2913",12)%>
	                                              </ul>
	                                    </td></tr>
	                                     <tr><td height="35" style="padding-left:5px;"><b>本周爆款</b></td></tr>
	                                     <tr><td style=" text-align:center;"><%= getimg("2914",1,190,155) %></td></tr>
	                                 
	                                  </table>
	                               
	                               </td></tr>
	                          </table>
	                        </div>
	                          <ul>
	                         <%=getxl("2881",4)  %>  
	                      </ul>
	                     </div>
	                     </span>
	               </div></td></tr>
	               <tr><td height=162><div class="mp" >
	                               <span <% String lsstr4=getLogo("2869"); if(lsstr4.length()>0) { %> style="background:url('<%= lsstr4 %>') no-repeat bottom left;" <%} %>>
	                 <a <% String urlstr4=getLogoUrl("2869"); if(urlstr4.length()>0) { %> href="<%= urlstr4 %>" <%} %>  target="_blank"  style="width:118px; height:145px; position:absolute;"></a>
	                
	               
	                <div>
	                          <div id="sdiv2012_5" class="sdiv2012_5" style="height:39px; _height:35px; padding:0px; padding-top:4px;" onmouseover="overcate(this,'5')" onmouseout="outcate(this,'5')">
	                           <img id="simg5" src="http://images.d1.com.cn/images2012/index2012/logo/logo_05.jpg" style="z-index:10001;"/>
	                          </div>
	                        <div id="catdiv_5" onmouseover="overcate('#sdiv2012_5','5')" onmouseout="outcate('#sdiv2012_5','5')">
	                          <table style="width:100%; height:100%; ">
	                               <tr><td>
	                                   <table class="table2012" >	 
	                                    <tr><td height="7"></td></tr>                                      
	                                       <tr><td height="25"><a href="http://www.d1.com.cn/html/women/"><img src="http://images.d1.com.cn/images2012/index2012/inwomen.png"/></a></td></tr>
	                                       <tr><td style="border-bottom:dashed 1px #959595;">
	                                       <%= getCKey("2904")  %>
	                                       </td></tr>
	                                       <tr><td height="5"></td></tr>
	                                       <tr><td height="25"><a href="http://www.d1.com.cn/html/men/"><img src="http://images.d1.com.cn/images2012/index2012/inmen.png"/></a></td></tr>
	                                       <tr><td style="border-bottom:dashed 1px #959595;">
	                                      <%= getCKey("2905")  %>
	                                       </td></tr>
	                                        <tr><td height="5"></td></tr>
	                                       <tr><td height="25"><a href="http://www.d1.com.cn/html/ornament/"><img src="http://images.d1.com.cn/images2012/index2012/inmb.png"/></a></td></tr>
	                                       <tr><td style="border-bottom:dashed 1px #959595;">
	                                      <%= getCKey("2906")  %>
	                                       </td></tr>
	                                        <tr><td height="5"></td></tr>
	                                       <tr><td height="25"><a href="http://www.d1.com.cn/html/watch/"><img src="http://images.d1.com.cn/images2012/index2012/inwatch.png"/></a></td></tr>
	                                       <tr><td style="border-bottom:dashed 1px #959595;">
	                                      <%= getCKey("2907")  %>
	                                       </td></tr>
	                                   </table>
	                                   <div style="width:230px; margin:0px auto; margin-top:10px; margin-bottom:10px; padding:0px;">
	                                  <%= getimg("2909",1,230,155) %> </div>
	                               </td>
	                               
	                               <td width="207" style="background:#d1d1d1;">
	                                  <table style="text-align:left; width:190px; margin:0px auto;">
	                                      <%=getimglist1("2908",5) %> 
	                                     
	                                  </table>
	                               
	                               </td></tr>
	                          </table>
	                        </div>
	                        <ul>
	                        <%=getxl("2884",4)  %>  
	                      </ul>
	                     </div>
	                     </span>
	               </div></td></tr>
	            </table>
	            
	            
	            
	            
	            
	        </td>
	        <td height="4"></td></tr>
	        <tr><td height="20" style="overflow:hidden; padding-left:5px;">
	        <ul class="newsul" id="scrollnews">
	       <%= getScrollNews("2922")%> 
	               <div class="clear"></div></td></tr>
	        <tr>
	        <td height="336" style="padding-left:4px; padding-top:5px; +padding-top:0px;" width="710">
	        <div class="scrollimglist" >
	        <script>ShowCenter1(<%= ScrollImg("2887") %>,<%= ScrollText("2887") %>)</script>
	        </div>
	        </td>
	        </tr>
	        <tr><td>
	        <!-- 新品速递 -->
	           <table>
	               <tr  height="12" style="+height:7px;"><td width="4"></td><td colspan="2"></td></tr>
	               <tr><td></td>
	               <td><img src="http://images.d1.com.cn/images2012/index2012/JULY/xpsd1.jpg"/></td>
	               <td>
	               <div id="xpsdfocus">
	               <%
	               ArrayList<Promotion> plist = new ArrayList<Promotion>();
	       		   List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	       		   clist.add(Restrictions.eq("splmst_code", new Long("3187")));
	       		   List<Order> olist = new ArrayList<Order>();
	       		   olist.add(Order.desc("splmst_createdate"));
	       		   List<BaseEntity> b_list = Tools.getManager(Promotion.class).getList(clist, olist, 0, 20);
	       		   if(b_list!=null){
	       			  for(BaseEntity be:b_list){
	       				plist.add((Promotion)be);
	       			}
	       		  }
	                  if(plist!=null&&plist.size()>0)
	                  {
	                	  int i=0;
	                	  %>
	                	  <ul class="xpsd">
	                	  <%for(Promotion p:plist)
	                	  {
	                		  if(p!=null)
	                		  {
	                			  i++;
	                			  if(i==1){%>
	                				  <li><a href="<%= p.getSplmst_url()!=null&&p.getSplmst_url().length()>0?p.getSplmst_url():"http://www.d1.com.cn" %>" target="_blank">
	                				  <img src="<%= p.getSplmst_picstr() %>" width="165" height="70"/></a>
	                				  <img src="http://images.d1.com.cn/images2012/index2012/JULY/new-corner-1.png" style="position:absolute; top:0px; left:0px;"/>
	                				  </li>
	               
	                			  <%}
	                			  else
	                			  {%>
	                				   <li><a href="<%= p.getSplmst_url()!=null&&p.getSplmst_url().length()>0?p.getSplmst_url():"http://www.d1.com.cn" %>" target="_blank">
	                				  <img src="<%= p.getSplmst_picstr() %>" width="165" height="70"/></a>
	                				  </li>
	                			  <%}
	                		  }
	                	  }%>
	                     </ul>
	                <%  }
	               %>
	                </div>
	                </td>
	                <td> <a href="javascript:void(0)" id="testarrow" ><img src="http://images.d1.com.cn/images2012/index2012/JULY/arrow.png"/></a>
	             </td>
	               </tr>
	           </table>
	           <!-- 新品速递结束 -->
	        </td></tr>
	        <tr><td>
	           <table width=100% >
	             <tr height="25" width="100%"><td colspan="2"></td></tr>
	              <tr>
	                 <td style="padding-left:130px;" width="610"><%=getKeyWord("2916") %></td><td width="100" style=" text-align:right; +margin-left:35px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	              </tr>
	              <tr height="300px;">
	              <td  style="padding-left:20px; padding-top:7px; width:380px; " >
	                 <ul class="index_rqbk">
	                 <%=  getImglist("2917",4) %>  
	                    </ul>
	              </td>
	              <td width="319" style="padding-top:6px;">
	                 <%= getimg("2918",1,291,306) %> </td></tr>
	           </table>
	           <!--右侧弹出层-->
				<div id="opciones">
				  <div class="wbgz1" >
					  <table cellpadding="0" cellspacing="0" width="80%" style=" margin:0px auto; text-align:center;">
					  <tr><td height="87" style=" border:none;"></td></tr>
					  	<tr><td height="60"><a href="http://weibo.com/d1ys" target="_blank"><img src="http://images.d1.com.cn/Index/images/sinawb.jpg" /></a><br/><span>新浪微博</span></td></tr>
					  	<tr><td height="60"><a href="http://t.sohu.com/people?dm=d1youshang" target="_blank"><img src="http://images.d1.com.cn/Index/images/sohuwb.jpg" /></a><br/><span>搜狐微博</span></td></tr>
					  	<tr><td height="63" style=" border:none;"><a href="http://t.qq.com/d1_com_cn/?pref=qqcom.mininav" target="_blank"><img src="http://images.d1.com.cn/Index/images/txwbnew.jpg" /></a><br/><span>腾讯微博</span></td></tr>
					  </table>
				  </div>
				</div>
	<!--右侧弹出层结束-->
	        </td></tr>
	        <tr><td colspan="2" height="15"></td></tr>
	   </table>
	   	   <!-- 热门分类 -->
	   <div class="hotclass">
	        <img src="http://images.d1.com.cn/images2012/index2012/JULY/3.png"/>
     
       <table style="border-bottom:solid 1px #e1e1e1;margin:0px auto; " cellspcing="0" cellpadding="0" border="0">
          <tr><td colspan="4" style="border:solid 1px #e1e1e1; border-bottom:none; padding:1px; ">
              <span><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030" target="_blnak">FEEL MIND<br/>品&nbsp;质&nbsp;男&nbsp;装</a></span>
              <span><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020" target="_blnak">FEEL MIND<br/>休&nbsp;闲&nbsp;女&nbsp;装</a></span>
              <span><a href="http://aleeishe.d1.com.cn" target="_blnak">小栗舍<br/>甜&nbsp;美&nbsp;女&nbsp;装</a></span>
              <span><a href="http://sheromo.d1.com.cn/" target="_blnak">诗若漫<br/>魅&nbsp;力&nbsp;女&nbsp;装</a></span>
              <span><a href="http://yousoo.d1.com.cn/" target="_blnak">YOUSOO<br/>闪&nbsp;耀&nbsp;饰&nbsp;品</a></span>
              <span><a href="http://www.d1.com.cn/html/cosmetic/" target="_blnak">D1推荐<br/>美&nbsp;容&nbsp;护&nbsp;肤</a></span>
              <span style="margin-right:0px;"><a href="http://www.d1.com.cn/html/watch/" target="_blnak">D1推荐<br/>时&nbsp;尚&nbsp;腕&nbsp;表</a></span>
          </td></tr>
          <tr><%=getHotClass("3156") %>
           <%=getHotClass("3157") %>
          </tr>
           <tr><%=getHotClass("3158") %>
           <%=getHotClass("3159") %>
          </tr>
           <tr><%=getHotClass("3160") %>
           <%=getHotClass("3161") %>
          </tr>
           <tr><%=getHotClass("3162") %>
           <%=getHotClass("3163") %>
          </tr>
           <tr><%=getHotClass("3164") %>
           <%=getHotClass("3165") %>
          </tr>
           <tr><%=getHotClass("3166") %>
          <%=getHotClass("3168") %>
          </tr>
            <tr>
           <%=getHotClass("3169") %>
            <%=getHotClass("3171") %>
          </tr>
          
            <tr><%=getHotClass("3172") %>
           <%=getHotClass("3173") %>
          </tr>
            <tr><%=getHotClass("3174") %>
           <%=getHotClass("3175") %>
          </tr>
       
       </table>
     
	   </div>
	    <!-- 热门分类结束-->	   
	    
	   <script type="text/javascript" src="/inc/getTag2.jsp"></script>	
	   <script type="text/javascript" src="/inc/getProduct.jsp"></script>
	   
	   
	   <div class="clear"></div>
	   
         <!-- 会员积分-->
        <div class="content">
         <div class="layout_box menmber">
            <h2><a href="/jifen/" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/June/index6_47.jpg"/></a></h2><%
            List<PromotionProduct> recommendProList = null;
            recommendProList = PromotionProductHelper.getPromotionProductByCode("6771" , 100);
            if(recommendProList != null && !recommendProList.isEmpty()){
            	int size = recommendProList.size();
            	int count = 0;
            %>
            <ul class="goods_list"><%
            	for(int i=0;i<size&&count<5;i++){
            		PromotionProduct recommend = recommendProList.get(i);
            		Product product = ProductHelper.getById(recommend.getSpgdsrcm_gdsid());
            		if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
            		String title = Tools.clearHTML(recommend.getSpgdsrcm_gdsname());
            		//Award award = AwardHelper.getByProductId(product.getId());
            		List<Award> awardlist = AwardHelper.getAwardByGdsid(product.getId(),1);
            		if(awardlist == null) continue;
            		for(Award award:awardlist){
            %>
            	<li><dl>
            		<dt><a href="/jifen/index.jsp" title="<%=title %>" target="_blank"><img src="http://images.d1.com.cn/<%=product.getGdsmst_otherimg3() %>" alt="<%=title %>" width="120" height="120"/></a></dt>
            		<dd class="name"><a href='/jifen/index.jsp' title="<%=title %>" target='_blank'><%=title %></a></dd>
            		<dd><strong><%=Tools.longValue(award.getAward_value()) %>积分</strong><del>￥<%=product.getGdsmst_saleprice() %></del></dd>
            	</dl></li><%
            		}
            		count++;
            	} %>
            	
            </ul><%
            } %>
        </div>
        <div class="right_side about_us">
          <div class="layout_box">
            <h2><img src="http://images.d1.com.cn/images2012/index2012/June/index6_49.jpg""/></h2><%
            ArrayList<Promotion> recommendList=new ArrayList<Promotion>();
            recommendList = PromotionHelper.getBrandListByCode("2742" , 7);
            if(recommendList != null && !recommendList.isEmpty()){
            	int size = recommendList.size();
            %>
            <ul class="news_list"><%
            	for(int i=0;i<size;i++){
            		Promotion recommend = recommendList.get(i);
            		String title = Tools.clearHTML(recommend.getSplmst_name());
            %>
            	<li><a href="<%=StringUtils.encodeUrl(recommend.getSplmst_url()) %>" target='_blank' title="<%=title %>"<%if(i==1){ %> style="color:#ad4456"<%} %>><%=title %></a></li><%
            	} %>
            </ul><%
            } %>
          </div>
          
        </div>
        </div>
        <!-- 会员积分结束-->
		<div class="clear"></div>
	
	   
	</div>
	
    <!-- 主体结束 -->
     <!-- 
    <div style="width:980px; margin:0px auto;  margin-top:10px;">
    <a href="http://quan.163.com/activity/ds.do?from=D1" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/JULY/wy.jpg"/></a>
    </div>
    <!-- 网易结束 -->
  

    </div>
    </div>
	   <div class="clear"></div>
   <%@include file="/inc/footindex.jsp" %>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>

<script type="text/javascript">
function closeSC(){
	$("#sc").animate({width:"339"},1000,function(){});$("#sc").animate({height:"0"},1000,function(){});
	$("#sc").slideUp();
}

function closeallhd()
{
    $("#allhd").css("display","none");	
}
function openSc()
{
	
	$("#sc").animate({height:"234"},1000,function(){});
	//$("#sc").css("display","block");
	//$("#sc").slideUp();
	}


   function allover()
   {
	   if($("#white").css('display')=='none'||$("#smenu").css('display')=='none')
   	   {
		   $("#white").css("display","block");
		   $("#smenu").css("display","block");
   	   
   	   }
   	 
   }
   function allout()
   {
   	
	   if($("#white").css('display')=='block'||$("#smenu").css('display')=='block')
   	   {
		   $("#white").css("display","none");
		   $("#smenu").css("display","none");
   	   
   	   } 
   }
  


  $(document).ready(function() {

	    startmarquee(19,30,3000,0);
	    openSc();
	    xpsdscroll("#testarrow");
		$(".newgdscoll").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
        $(".likeall1").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
	});
 </script>
</body>
</html>