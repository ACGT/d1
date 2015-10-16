<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>OL如何打造早春魅力妆容</title>
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
               <td><span style=" font-size:20px; color:#000;"><b>《优品尚志》2012FEB 第九期--OL如何打造早春魅力妆容</b></span></td>
               <td style=" text-align:right;"> <%= sb1%></td>
               </tr>
               </table>
               <div class="Content">
              <!-- ImageReady Slices (美容杂志.psd) -->
<table id="__01" width="769" height="5134" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_01.jpg" width="769" height="206" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_02.jpg" width="769" height="144" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_03.jpg" width="769" height="225" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_04.jpg" width="769" height="216" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_05.jpg" width="769" height="181" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_06.jpg" width="769" height="234" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_07-1.jpg" alt="" width="769" height="451" border="0" usemap="#Map"></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_08.jpg" width="769" height="202" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_09.jpg" width="769" height="128" alt=""></td>
	</tr>
	<tr>
		<td colspan="2"><img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_10-1.jpg" alt="" width="769" height="536" border="0" usemap="#Map2">
		  <map name="Map2">
            <area shape="poly" coords="554,72,628,64,702,82,754,131,761,209,754,248,712,244,644,246,583,212,539,191,515,194" href="http://www.d1.com.cn/product/01415507" target="_blank">
            <area shape="poly" coords="534,201,577,220,623,247,662,280,657,319,647,336,622,370,600,380,555,378,535,378,512,367,482,353,457,337,438,317,438,290,437,264,458,226" href="http://www.d1.com.cn/product/01407926" target="_blank">
            <area shape="poly" coords="488,521" href="#">
		    <area shape="poly" coords="672,261,670,302" href="#">
            <area shape="poly" coords="672,262,719,274,723,291,732,317,738,340,746,370,746,390,748,444,743,502,725,509,695,510,651,513,613,514" href="http://www.d1.com.cn/product/01415139" target="_blank">
            <area shape="poly" coords="484,410" href="#">
		    <area shape="poly" coords="632,399,604,523,581,523,545,522,482,501,487,461,486,425,494,407,516,394,534,388" href="http://www.d1.com.cn/product/01415139" target="_blank">
          <area shape="rect" coords="330,63,514,175" href="http://www.d1.com.cn/product/01415507" target="_blank"><area shape="rect" coords="222,223,429,283" href="http://www.d1.com.cn/product/01407926" target="_blank">
          <area shape="rect" coords="321,367,477,481" href="http://www.d1.com.cn/product/01415139" target="_blank">
		  </map></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_11.jpg" width="769" height="194" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_12.jpg" width="769" height="114" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_13.jpg" alt="" width="769" height="560" border="0" usemap="#Map3"></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_14.jpg" width="769" height="119" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_15.jpg" width="769" height="167" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_16.jpg" alt="" width="453" height="577" border="0" usemap="#Map4"></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_17.jpg" width="316" height="577" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_18.jpg" width="769" height="175" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_19.jpg" width="769" height="99" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_20.jpg" width="769" height="177" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_21.jpg" width="769" height="130" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_22.jpg" width="769" height="102" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_23.jpg" width="769" height="157" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/cosmetics/mrzz_24.jpg" width="769" height="40" alt=""></td>
	</tr>
</table>
<!-- End ImageReady Slices -->
 
<map name="Map"><area shape="rect" coords="22,65,117,365" href="http://www.d1.com.cn/product/01401696" target="_blank"><area shape="rect" coords="119,40,209,181" href="http://www.d1.com.cn/product/01408474" target="_blank">
<area shape="rect" coords="120,187,257,361" href="http://www.d1.com.cn/product/01400287" target="_blank">
  <area shape="rect" coords="262,152,341,363" href="http://www.d1.com.cn/product/01413849" target="_blank">
    <area shape="rect" coords="344,221,503,359" href="http://www.d1.com.cn/product/01405745" target="_blank"><area shape="rect" coords="214,25,535,88" href="http://www.d1.com.cn/product/01408474" target="_blank">
<area shape="rect" coords="214,92,427,148" href="http://www.d1.com.cn/product/01401696" target="_blank">
<area shape="rect" coords="514,260,762,322" href="http://www.d1.com.cn/product/01405745" target="_blank"><area shape="rect" coords="365,363,581,419" href="http://www.d1.com.cn/product/01413849" target="_blank"><area shape="rect" coords="119,365,354,426" href="http://www.d1.com.cn/product/01400287" target="_blank">
</map>
 
<map name="Map3">
<area shape="poly" coords="244,299" href="#"><area shape="poly" coords="247,297,217,296,179,301,159,365,126,417,108,467,102,496,117,512,161,534,244,547,266,545,277,544" href="http://www.d1.com.cn/product/01408132" target="_blank">
<area shape="poly" coords="254,298,267,351,273,430,273,465,284,532,302,546,353,556,374,548,399,538,408,528,416,505,429,485,434,470,432,450,415,433,403,379,408,353,400,315,378,299,350,282" href="http://www.d1.com.cn/product/01416496" target="_blank">
<area shape="poly" coords="333,267" href="#"><area shape="poly" coords="336,275" href="#"><area shape="poly" coords="412,309" href="#"><area shape="poly" coords="414,356,423,399,432,430,437,457,441,481,435,524,463,532,469,517,478,471,494,417,494,378,499,342,499,321,499,307,502,280,509,241,490,241,465,241,447,237,403,221,379,221" href="http://www.d1.com.cn/product/01412966" target="_blank">
<area shape="poly" coords="515,250,515,279,505,298,506,370,502,434,489,493,485,529,506,542,542,542,571,528,546,323" href="http://www.d1.com.cn/product/01415882" target="_blank">
<area shape="rect" coords="317,13,617,88" href="http://www.d1.com.cn/product/01408132" target="_blank"><area shape="rect" coords="445,92,702,185" href="http://www.d1.com.cn/product/01416496" target="_blank">
<area shape="rect" coords="525,219,763,264" href="http://www.d1.com.cn/product/01412966" target="_blank">
<area shape="rect" coords="559,321,731,391" href="http://www.d1.com.cn/product/01415882" target="_blank">
</map>
<map name="Map4">
<area shape="poly" coords="15,270" href="#"><area shape="rect" coords="3,266,140,518" href="http://www.d1.com.cn/product/01414432" target="_blank">
<area shape="poly" coords="142,409,179,369,203,334,249,292,251,277,250,256,227,250,208,249,184,249,175,250,163,251,146,251" href="http://www.d1.com.cn/product/01414432" target="_blank">
<area shape="poly" coords="144,437" href="#"><area shape="poly" coords="147,440,174,413,203,393,225,366,245,338,258,326,254,357,251,387,250,422,250,452,260,482,242,499,213,500,188,500,172,499,162,499,148,502" href="http://www.d1.com.cn/product/01414432" target="_blank">
<area shape="rect" coords="265,296,344,566" href="http://www.d1.com.cn/product/01413705" target="_blank">
<area shape="rect" coords="261,161,427,292" href="http://www.d1.com.cn/product/01413705" target="_blank">
<area shape="rect" coords="14,26,183,120" href="http://www.d1.com.cn/product/01413705" target="_blank">
<area shape="rect" coords="197,27,449,120" href="http://www.d1.com.cn/product/01414432" target="_blank">
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