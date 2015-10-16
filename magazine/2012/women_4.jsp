<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>你好！苏格兰系列，感受异域风情</title>
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
               <td><span style=" font-size:20px; color:#000;"><b>《优品尚志》2012JAN 第四期--苏格兰系列，感受异域风情</b></span></td>
               <td style=" text-align:right;"> <%= sb1%></td>
               </tr>
               </table>
               <div class="Content">
               <!-- Save for Web Slices (圣诞杂志.psd) -->
<table width="769" height="6560" border="0" cellpadding="0" cellspacing="0" id="__01">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/1223aleeishe/images/women_4_01.jpg" width="769" height="705" alt=""></td>
	</tr>
	<tr>
		<td><img src="http://images.d1.com.cn/zt2011/1223aleeishe/images/women_4_02.jpg" alt="" width="769" height="652" border="0" usemap="#Map"></td>
	</tr>
	<tr>
		<td><a href="http://www.d1.com.cn/product/01719906" target="_blank"><img src="http://images.d1.com.cn/zt2011/1223aleeishe/images/women_4_03.jpg" alt="" width="769" height="652" border="0"></a></td>
	</tr>
	<tr>
		<td><img src="http://images.d1.com.cn/zt2011/1223aleeishe/images/women_4_04.jpg" alt="" width="769" height="651" border="0" usemap="#Map2"></td>
	</tr>
	<tr>
		<td><img src="http://images.d1.com.cn/zt2011/1223aleeishe/images/women_4_05.jpg" alt="" width="769" height="651" border="0" usemap="#Map3"></td>
	</tr>
	<tr>
		<td><img src="http://images.d1.com.cn/zt2011/1223aleeishe/images/women_4_06.jpg" alt="" width="769" height="649" border="0" usemap="#Map4"></td>
	</tr>
	<tr>
		<td><img src="http://images.d1.com.cn/zt2011/1223aleeishe/images/women_4_07.jpg" alt="" width="769" height="650" border="0" usemap="#Map5"></td>
	</tr>
	<tr>
		<td><img src="http://images.d1.com.cn/zt2011/1223aleeishe/images/women_4_08.jpg" alt="" width="769" height="652" border="0" usemap="#Map6"></td>
	</tr>
	<tr>
		<td><a href="http://www.d1.com.cn/product/01719924" target="_blank"><img src="http://images.d1.com.cn/zt2011/1223aleeishe/images/women_4_09.jpg" alt="" width="769" height="653" border="0"></a></td>
	</tr>
	<tr>
		<td><a href="http://www.d1.com.cn/product/01719936" target="_blank"><img src="http://images.d1.com.cn/zt2011/1223aleeishe/images/women_4_10.jpg" alt="" width="769" height="645" border="0"></a></td>
	</tr>
</table>
<!-- End Save for Web Slices -->
 
<map name="Map">
  <area shape="rect" coords="2,112,268,648" href="http://www.d1.com.cn/product/01719899" target="_blank">
  <area shape="rect" coords="500,3,768,647" href="http://www.d1.com.cn/product/01719898" target="_blank">
</map>
 
<map name="Map2">
  <area shape="rect" coords="2,110,267,648" href="http://www.d1.com.cn/product/01719900" target="_blank">
  <area shape="rect" coords="503,3,767,647" href="http://www.d1.com.cn/product/01719901" target="_blank">
</map>
 
<map name="Map3">
  <area shape="rect" coords="3,2,267,650" href="http://www.d1.com.cn/product/01719902" target="_blank">
  <area shape="rect" coords="504,112,767,649" href="http://www.d1.com.cn/product/01719903" target="_blank">
</map>
 
<map name="Map4">
  <area shape="rect" coords="1,112,266,644" href="http://www.d1.com.cn/product/01719897" target="_blank">
  <area shape="rect" coords="501,3,766,645" href="http://www.d1.com.cn/product/01719896" target="_blank">
</map>
 
<map name="Map5">
  <area shape="rect" coords="2,1,268,647" href="http://www.d1.com.cn/product/01719908" target="_blank">
  <area shape="rect" coords="504,113,765,646" href="http://www.d1.com.cn/product/01719909" target="_blank">
</map>
 
<map name="Map6">
  <area shape="rect" coords="2,114,268,646" href="http://www.d1.com.cn/product/01719920" target="_blank">
  <area shape="rect" coords="503,3,766,647" href="http://www.d1.com.cn/product/01719921" target="_blank">
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