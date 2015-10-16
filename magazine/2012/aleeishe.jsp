<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>糖果之旅·缤纷的意大利色彩</title>
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
               <td><span style=" font-size:20px; color:#000;"><b>《优品尚志》2012FEB 第十二期--糖果之旅·缤纷的意大利色彩</b></span></td>
               <td style=" text-align:right;"> <%= sb1%></td>
               </tr>
               </table>
               <div class="Content">
             <!-- Save for Web Slices (Untitled-1) -->
<table id="Table_01" width="769" height="8103" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><a href="http://www.d1.com.cn/product/01720269" target="_blank"><img src="http://images.d1.com.cn/magazine/women//aleeishe-0220_01_1.jpg" alt="" width="769" height="557" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/women//aleeishe-0220_02.jpg" alt="" width="769" height="541" border="0" usemap="#Map"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/women//aleeishe-0220_03.jpg" alt="" width="769" height="539" border="0" usemap="#Map2"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/women//aleeishe-0220_04.jpg" alt="" width="769" height="538" border="0" usemap="#Map3"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/women//aleeishe-0220_05.jpg" alt="" width="769" height="539" border="0" usemap="#Map4"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/women//aleeishe-0220_06.jpg" alt="" width="769" height="539" border="0" usemap="#Map5"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/women//aleeishe-0220_07.jpg" alt="" width="769" height="541" border="0" usemap="#Map6"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/women//aleeishe-0220_08.jpg" alt="" width="769" height="538" border="0" usemap="#Map7"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/women//aleeishe-0220_09.jpg" alt="" width="769" height="539" border="0" usemap="#Map8"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/women//aleeishe-0220_10.jpg" alt="" width="769" height="539" border="0" usemap="#Map9"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/women//aleeishe-0220_11.jpg" alt="" width="769" height="539" border="0" usemap="#Map10"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/women//aleeishe-0220_12.jpg" alt="" width="769" height="540" border="0" usemap="#Map11"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/women//aleeishe-0220_13.jpg" alt="" width="769" height="539" border="0" usemap="#Map12"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/women//aleeishe-0220_14.jpg" alt="" width="769" height="537" border="0" usemap="#Map13"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/women//aleeishe-0220_15.jpg" alt="" width="769" height="538" border="0" usemap="#Map14"></td>
	</tr>
</table>
<!-- End Save for Web Slices -->
 
<map name="Map">
  <area shape="rect" coords="42,10,177,392" href="http://www.d1.com.cn/product/01720232" target="_blank">
  <area shape="rect" coords="183,11,308,391" href="http://www.d1.com.cn/product/01720233" target="_blank">
  <area shape="rect" coords="318,10,446,390" href="http://www.d1.com.cn/product/01720231" target="_blank">
  <area shape="circle" coords="538,258,88" href="http://www.d1.com.cn/product/01720230" target="_blank">
</map>
 
<map name="Map2">
  <area shape="rect" coords="275,9,424,383" href="http://www.d1.com.cn/product/01720208" target="_blank">
  <area shape="rect" coords="432,9,578,379" href="http://www.d1.com.cn/product/01720207" target="_blank">
  <area shape="rect" coords="588,10,733,381" href="http://www.d1.com.cn/product/01720209" target="_blank">
</map>
 
<map name="Map3">
  <area shape="rect" coords="259,17,407,386" href="http://www.d1.com.cn/product/01720224" target="_blank">
  <area shape="rect" coords="25,18,249,386" href="http://www.d1.com.cn/product/01720223" target="_blank">
  <area shape="circle" coords="511,250,101" href="http://www.d1.com.cn/product/01720222" target="_blank">
</map>
 
<map name="Map4">
  <area shape="rect" coords="288,23,488,389" href="http://www.d1.com.cn/product/01720236" target="_blank">
  <area shape="rect" coords="502,22,761,533" href="http://www.d1.com.cn/product/01720235" target="_blank">
</map>
 
<map name="Map5">
  <area shape="rect" coords="216,6,403,393" href="http://www.d1.com.cn/product/01720220" target="_blank">
  <area shape="circle" coords="479,291,84" href="http://www.d1.com.cn/product/01720268" target="_blank">
  <area shape="circle" coords="113,306,88" href="http://www.d1.com.cn/product/01720219" target="_blank">
  <area shape="circle" coords="111,114,88" href="http://www.d1.com.cn/product/01720218" target="_blank">
</map>
 
<map name="Map6">
  <area shape="rect" coords="275,15,479,378" href="http://www.d1.com.cn/product/01720227" target="_blank">
  <area shape="rect" coords="492,5,761,393" href="http://www.d1.com.cn/product/01720228" target="_blank">
</map>
 
<map name="Map7">
  <area shape="rect" coords="2,36,327,379" href="http://www.d1.com.cn/product/01720269" target="_blank">
  <area shape="circle" coords="462,274,133" href="http://www.d1.com.cn/product/01720206" target="_blank">
</map>
 
<map name="Map8">
  <area shape="rect" coords="267,12,753,384" href="http://www.d1.com.cn/product/01720214" target="_blank">
</map>
 
<map name="Map9">
  <area shape="rect" coords="23,16,207,390" href="http://www.d1.com.cn/product/01720212" target="_blank">
  <area shape="rect" coords="216,17,390,389" href="http://www.d1.com.cn/product/01720213" target="_blank">
  <area shape="circle" coords="466,186,59" href="http://www.d1.com.cn/product/01720210" target="_blank">
  <area shape="circle" coords="466,324,61" href="http://www.d1.com.cn/product/01720211" target="_blank">
</map>
 
<map name="Map10">
  <area shape="rect" coords="277,18,752,393" href="http://www.d1.com.cn/product/01720229" target="_blank">
</map>
 
<map name="Map11">
  <area shape="rect" coords="261,11,467,391" href="http://www.d1.com.cn/product/01720241" target="_blank">
  <area shape="rect" coords="21,10,251,391" href="http://www.d1.com.cn/product/01720240" target="_blank">
  <area shape="circle" coords="551,251,78" href="http://www.d1.com.cn/product/01720239" target="_blank">
</map>
 
<map name="Map12">
  <area shape="rect" coords="273,12,508,392" href="http://www.d1.com.cn/product/01720242" target="_blank">
  <area shape="rect" coords="517,9,748,391" href="http://www.d1.com.cn/product/01720243" target="_blank">
</map>
 
<map name="Map13">
  <area shape="rect" coords="330,78,528,378" href="http://www.d1.com.cn/product/01720247" target="_blank">
  <area shape="rect" coords="13,8,292,524" href="http://www.d1.com.cn/product/01720248" target="_blank">
</map>
 
<map name="Map14">
  <area shape="rect" coords="280,11,637,524" href="http://www.d1.com.cn/product/01720251" target="_blank">
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