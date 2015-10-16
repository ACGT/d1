<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>FEEL MIND 为你缔造时尚休闲形象</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/magazine.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

</head>

<body>
<div id="wrapper">
	<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
 
    <!-- 中间内容 -->
       <div class="center">
           <div class="left">
              <img src="http://images.d1.com.cn/Index/YouShang(2).jpg" style=" margin:0px;"></img>
              <div class="ys_list" style="margin-top:-3px;">
               <%
                  ArrayList<Promotion> list=new ArrayList<Promotion>();
                  list=PromotionHelper.getBrandListByCode("2776", 100);
                  StringBuilder sb=new StringBuilder();
                  StringBuilder sb1=new StringBuilder();
                  if(list!=null&&list.size()>0)
                  {
                	  sb.append("<dl>");
                	  sb1.append("<select class=\"nselect\" id=\"titleselect\">");
                	  sb1.append("<option value=''>---请选择---</option>");
                	  for(Promotion p:list)
                	  {
                		  if(p!=null)
                		  {
                			  String title="";
                			  if(p.getSplmst_name().length()>0)
                			  {
                				  title=Tools.clearHTML(p.getSplmst_name());
                			  }
                			  
                			  sb.append("<dt><a href=\""+StringUtils.encodeUrl(p.getSplmst_url())+"\" target=\"_blank\"><img src=\""+p.getSplmst_picstr()+"\" alt=\""+title+"\" width=\"180\" height=\"225\"></a></dt>");
                			  sb.append("<dd><a href=\""+StringUtils.encodeUrl(p.getSplmst_url())+"\" target=\"_blank\">"+title+"</a></dd>");
                			  String newtitle=title.substring(0,title.indexOf("期")+1);
                			  sb1.append("<option value=\""+StringUtils.encodeUrl(p.getSplmst_url())+"\">"+newtitle+"</option>");
                		  }
                	  }
                	  sb.append("</dl>");
                	  sb1.append("</select>");
                  }
                  out.print(sb);
              %>
              </div>
           
           </div>
           
           <div  class="right" >
               <table style="width:769px;">
               <tr>
               <td><span style=" font-size:20px; color:#000;"><b>《优品尚志》2012FEB 第十期--为你缔造时尚休闲形象</b></span></td>
               <td style=" text-align:right;"> <%= sb1%></td>
               </tr>
               </table>
               <div class="Content">
             <!-- ImageReady Slices (feel mind.psd) -->
<table id="__01" width="751" height="6840" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="15">
			<a href="http://www.d1.com.cn/product/01718251" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_01.jpg" width="750" height="147" alt=""></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="147" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<a href="http://www.d1.com.cn/product/01718251" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_02.jpg" width="750" height="181" alt=""></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="181" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<a href="http://www.d1.com.cn/product/01718251" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_03.jpg" width="750" height="176" alt=""></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="176" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<a href="http://www.d1.com.cn/product/01718251" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_04.jpg" width="750" height="223" alt=""></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="223" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<img src="http://images.d1.com.cn/magazine/man/feel-mind_05.jpg" width="750" height="73" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="73" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="http://images.d1.com.cn/magazine/man/feel-mind_06.jpg" width="338" height="149" alt=""></td>
		<td colspan="4" rowspan="5">
			<a href="http://www.d1.com.cn/product/01720192" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_07.jpg" alt="" width="160" height="749" border="0"></a></td>
		<td colspan="4" rowspan="5">
			<a href="http://www.d1.com.cn/product/01720191" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_08.jpg" alt="" width="252" height="749" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="149" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<a href="http://www.d1.com.cn/product/01720191" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_09.jpg" alt="" width="338" height="175" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="175" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<a href="http://www.d1.com.cn/product/01720191" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_10.jpg" alt="" width="338" height="147" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="147" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<a href="http://www.d1.com.cn/product/01720191" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_11.jpg" alt="" width="338" height="189" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="189" alt=""></td>
	</tr>
	<tr>
		<td colspan="7" rowspan="2">
			<a href="http://www.d1.com.cn/product/01720191" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_12.jpg" alt="" width="338" height="379" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="89" alt=""></td>
	</tr>
	<tr>
		<td colspan="5" rowspan="2">
			<a href="http://www.d1.com.cn/product/01720186" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_13.jpg" alt="" width="194" height="420" border="0"></a></td>
		<td colspan="3" rowspan="2">
			<a href="http://www.d1.com.cn/product/01720200" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_14.jpg" alt="" width="218" height="420" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="290" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<a href="http://www.d1.com.cn/product/01720191"><img src="http://images.d1.com.cn/magazine/man/feel-mind_15.jpg" alt="" width="338" height="130" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="130" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<img src="http://images.d1.com.cn/magazine/man/feel-mind_16.jpg" width="750" height="131" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="131" alt=""></td>
	</tr>
	<tr>
		<td rowspan="2">
			<a href="http://www.d1.com.cn/product/01720190" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_17.jpg" alt="" width="220" height="367" border="0"></a></td>
		<td colspan="9" rowspan="2">
			<a href="http://www.d1.com.cn/product/01720189" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_18.jpg" alt="" width="184" height="367" border="0"></a></td>
		<td colspan="5">
			<img src="http://images.d1.com.cn/magazine/man/feel-mind_19.jpg" width="346" height="186" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="186" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<a href="http://www.d1.com.cn/product/01720189" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_20.jpg" alt="" width="346" height="181" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="181" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<a href="http://www.d1.com.cn/product/01720189" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_21.jpg" alt="" width="750" height="153" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="153" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<a href="http://www.d1.com.cn/product/01720189" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_22.jpg" alt="" width="750" height="170" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="170" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<a href="http://www.d1.com.cn/product/01720189" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_23.jpg" alt="" width="318" height="185" border="0"></a></td>
		<td colspan="11" rowspan="2">
			<a href="http://www.d1.com.cn/product/01720189" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_24.jpg" alt="" width="432" height="366" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="185" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<a href="http://www.d1.com.cn/product/01720189" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_25.jpg" alt="" width="318" height="181" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="181" alt=""></td>
	</tr>
	<tr>
		<td colspan="3" rowspan="2">
			<a href="http://www.d1.com.cn/product/01720188" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_26.jpg" alt="" width="317" height="284" border="0"></a></td>
		<td colspan="8" rowspan="3">
			<a href="http://www.d1.com.cn/product/01720201" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_27.jpg" alt="" width="181" height="381" border="0"></a></td>
		<td colspan="4">
			<a href="http://www.d1.com.cn/product/01720159" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_28.jpg" alt="" width="252" height="183" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="183" alt=""></td>
	</tr>
	<tr>
		<td colspan="4" rowspan="2">
			<a href="http://www.d1.com.cn/product/01720201" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_29.jpg" alt="" width="252" height="198" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="101" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/magazine/man/feel-mind_30.jpg" width="317" height="97" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="97" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<a href="http://www.d1.com.cn/html/gdsshow.asp?gdsid=01719626"><img src="http://images.d1.com.cn/magazine/man/feel-mind_31.jpg" alt="" width="750" height="148" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="148" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/magazine/man/feel-mind_32.jpg" width="320" height="186" alt=""></td>
		<td colspan="10">
			<img src="http://images.d1.com.cn/magazine/man/feel-mind_33.jpg" width="430" height="186" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="186" alt=""></td>
	</tr>
	<tr>
		<td colspan="5" rowspan="2">
			<a href="http://www.d1.com.cn/html/gdsshow.asp?gdsid=01719626" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_34.jpg" alt="" width="320" height="354" border="0"></a></td>
		<td colspan="10">
			<a href="http://www.d1.com.cn/html/gdsshow.asp?gdsid=01719626" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_35.jpg" alt="" width="430" height="199" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="199" alt=""></td>
	</tr>
	<tr>
		<td colspan="10">
			<a href="http://www.d1.com.cn/html/gdsshow.asp?gdsid=01719626" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_36.jpg" alt="" width="430" height="155" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="155" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<img src="http://images.d1.com.cn/magazine/man/feel-mind_37.jpg" width="750" height="143" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="143" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<img src="http://images.d1.com.cn/magazine/man/feel-mind_38.jpg" width="750" height="169" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="169" alt=""></td>
	</tr>
	<tr>
		<td colspan="8">
			<a href="http://www.d1.com.cn/product/01720186" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_39.jpg" alt="" width="349" height="354" border="0"></a></td>
		<td colspan="5">
			<a href="http://www.d1.com.cn/product/01720187" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_40.jpg" alt="" width="194" height="354" border="0"></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01720188" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_41.jpg" alt="" width="207" height="354" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="354" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="2">
			<a href="http://www.d1.com.cn/product/01720200" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_42.jpg" alt="" width="302" height="470" border="0"></a></td>
		<td colspan="13">
			<a href="http://www.d1.com.cn/product/01720159" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_43.jpg" alt="" width="448" height="118" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="118" alt=""></td>
	</tr>
	<tr>
		<td colspan="12">
			<a href="http://www.d1.com.cn/product/01720200" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_44.jpg" alt="" width="269" height="352" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01720201" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_45.jpg" alt="" width="179" height="352" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="352" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<img src="http://images.d1.com.cn/magazine/man/feel-mind_46_1.jpg" width="750" height="36" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="36" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<img src="http://images.d1.com.cn/magazine/man/feel-mind_47.jpg" width="750" height="111" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="111" alt=""></td>
	</tr>
	<tr>
		<td colspan="9">
			<img src="http://images.d1.com.cn/magazine/man/feel-mind_48.jpg" width="376" height="111" alt=""></td>
		<td colspan="5" rowspan="2">
			<a href="http://www.d1.com.cn/product/01720195" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_49.jpg" alt="" width="195" height="267" border="0"></a></td>
		<td rowspan="2">
			<a href="http://www.d1.com.cn/product/01720194" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_50.jpg" alt="" width="179" height="267" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="111" alt=""></td>
	</tr>
	<tr>
		<td colspan="9" rowspan="2">
			<a href="http://www.d1.com.cn/product/01718253" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_51.jpg" alt="" width="376" height="227" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="156" alt=""></td>
	</tr>
	<tr>
		<td colspan="6">
			<img src="http://images.d1.com.cn/magazine/man/feel-mind_52.jpg" width="374" height="71" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="71" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<a href="http://www.d1.com.cn/product/01718251" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_53.jpg" alt="" width="320" height="297" border="0"></a></td>
		<td colspan="10">
			<a href="http://www.d1.com.cn/product/01720270" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_54.jpg" alt="" width="430" height="297" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="297" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">		  <img src="http://images.d1.com.cn/magazine/man/feel-mind_55.jpg" alt="" width="320" height="343" border="0" usemap="#Map"></td>
		<td colspan="10">
			<a href="http://www.d1.com.cn/product/01720270"><img src="http://images.d1.com.cn/magazine/man/feel-mind_56.jpg" alt="" width="430" height="343" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="343" alt=""></td>
	</tr>
	<tr>
		<td colspan="6">
			<a href="http://www.d1.com.cn/product/01718256" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_57.jpg" alt="" width="322" height="275" border="0"></a></td>
		<td colspan="9">
			<a href="http://www.d1.com.cn/product/01718258" target="_blank"><img src="http://images.d1.com.cn/magazine/man/feel-mind_58.jpg" alt="" width="428" height="275" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="275" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<img src="http://images.d1.com.cn/magazine/man/feel-mind_59.jpg" width="750" height="78" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="78" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="220" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="82" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="15" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="2" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="2" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="16" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="11" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="27" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="28" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="94" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="34" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="11" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="28" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="179" height="1" alt=""></td>
		<td></td>
	</tr>
</table>
<!-- End ImageReady Slices -->
 
<map name="Map"><area shape="rect" coords="43,16,147,229" href="http://www.d1.com.cn/product/01720196" target="_blank">
<area shape="rect" coords="156,83,311,294" href="http://www.d1.com.cn/product/01720197" target="_blank">
</map>

               
               </div>
           </div>
       
       </div>
       
    
    <!-- 中间内容结束 -->
    <div class="clear"></div>
    <%@include file="/inc/foot.jsp" %>

	
</div>
</body>
</html>	
<script type="text/javascript">
$(document).ready(function() {   
	
		 $("#titleselect").change(function(){   
              location.href=$("#titleselect option:selected").val();
		 })   
	 });
</script>