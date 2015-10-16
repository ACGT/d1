<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>MINI FUR 时髦冬季 迷你皮草</title>
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
               <td><span style=" font-size:20px; color:#000;"><b>《优品尚志》2012JAN 第二期--MINI FUR 时髦冬季 迷你皮草</b></span></td>
               <td style=" text-align:right;"> <%= sb1%></td>
               </tr>
               </table>
               <div class="Content">
                 <!-- ImageReady Slices (mnpc469.tif) -->
<table id="__01" width="770"  border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="15">
			<img src="http://images.d1.com.cn/magazine/women/mnpc469_01.jpg" width="769" height="224" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="224" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<img src="http://images.d1.com.cn/magazine/women/mnpc469_02.jpg" width="769" height="289" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="289" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<img src="http://images.d1.com.cn/magazine/women/mnpc469_03.jpg" width="769" height="192" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="192" alt=""></td>
	</tr>
	<tr>
		<td colspan="14">
			<img src="http://images.d1.com.cn/magazine/women/mnpc469_04.jpg" width="585" height="83" alt=""></td>
		<td rowspan="2">
			<a href="http://www.d1.com.cn/product/01719429" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_05.jpg" alt="" width="184" height="323" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="83" alt=""></td>
	</tr>
	<tr>
		<td rowspan="2">
			<a href="http://www.d1.com.cn/product/01719897" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_06.jpg" alt="" width="171" height="438" border="0"></a></td>
		<td colspan="7" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719896" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_07.jpg" alt="" width="209" height="438" border="0"></a></td>
		<td colspan="6" rowspan="4">
			<a href="http://www.d1.com.cn/product/01719430" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_08.jpg" alt="" width="205" height="512" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="240" alt=""></td>
	</tr>
	<tr>
		<td rowspan="2">
			<a href="http://www.d1.com.cn/product/01719429" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_09.jpg" alt="" width="184" height="233" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="198" alt=""></td>
	</tr>
	<tr>
		<td colspan="8" rowspan="3">
			<a href="http://www.d1.com.cn/product/01719896" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_10.jpg" alt="" width="380" height="257" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="35" alt=""></td>
	</tr>
	<tr>
		<td rowspan="4">
			<a href="http://www.d1.com.cn/product/01719434" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_11.jpg" alt="" width="184" height="350" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="39" alt=""></td>
	</tr>
	<tr>
		<td colspan="6" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719431" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_12.jpg" alt="" width="205" height="309" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="183" alt=""></td>
	</tr>
	<tr>
		<td colspan="8" rowspan="3">
			<a href="http://www.d1.com.cn/product/01719896" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_13.jpg" alt="" width="380" height="246" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="126" alt=""></td>
	</tr>
	<tr>
		<td colspan="6" rowspan="3">
			<a href="http://www.d1.com.cn/product/01719431" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_14.jpg" alt="" width="205" height="225" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="2" alt=""></td>
	</tr>
	<tr>
		<td rowspan="2">
			<a href="http://www.d1.com.cn/product/01719434" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_15.jpg" alt="" width="184" height="223" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="118" alt=""></td>
	</tr>
	<tr>
		<td colspan="8">
			<a href="http://www.d1.com.cn/product/01719896" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_16.jpg" alt="" width="380" height="105" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="105" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<img src="http://images.d1.com.cn/magazine/women/mnpc469_17.jpg" width="769" height="70" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="70" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="4">
			<a href="http://www.d1.com.cn/product/01719902" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_18.jpg" alt="" width="173" height="486" border="0"></a></td>
		<td colspan="4" rowspan="4">
			<a href="http://www.d1.com.cn/product/01719903" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_19.jpg" alt="" width="128" height="486" border="0"></a></td>
		<td colspan="9">
			<img src="http://images.d1.com.cn/magazine/women/mnpc469_20.jpg" width="468" height="66" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="66" alt=""></td>
	</tr>
	<tr>
		<td colspan="6">
			<a href="http://www.d1.com.cn/product/01719902" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_21.jpg" alt="" width="230" height="125" border="0"></a></td>
		<td colspan="3" rowspan="2">
			<img src="http://images.d1.com.cn/magazine/women/mnpc469_22.jpg" width="238" height="295" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="125" alt=""></td>
	</tr>
	<tr>
		<td colspan="4" rowspan="3">
			<a href="http://www.d1.com.cn/product/01719902" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_23.jpg" alt="" width="104" height="509" border="0"></a></td>
		<td colspan="2" rowspan="3">
			<a href="http://www.d1.com.cn/product/01719920" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_24.jpg" alt="" width="126" height="509" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="170" alt=""></td>
	</tr>
	<tr>
		<td colspan="3" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719910" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_25.jpg" alt="" width="238" height="339" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="125" alt=""></td>
	</tr>
	<tr>
		<td colspan="6">
			<img src="http://images.d1.com.cn/magazine/women/mnpc469_26.jpg" width="301" height="214" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="214" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<img src="http://images.d1.com.cn/magazine/women/mnpc469_27.jpg" width="769" height="97" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="97" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="http://images.d1.com.cn/magazine/women/mnpc469_28.jpg" width="320" height="1" alt=""></td>
		<td colspan="8" rowspan="3">
			<a href="http://www.d1.com.cn/product/01718986" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_29-1.jpg" alt="" width="449" height="134" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="1" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/magazine/women/mnpc469_30.jpg" width="187" height="60" alt=""></td>
		<td colspan="4" rowspan="3">
			<a href="http://www.d1.com.cn/product/01719469" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_31.jpg" alt="" width="133" height="519" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="60" alt=""></td>
	</tr>
	<tr>
		<td colspan="3" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719469" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_32.jpg" alt="" width="187" height="459" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="73" alt=""></td>
	</tr>
	<tr>
		<td colspan="6">
			<a href="http://www.d1.com.cn/product/01720018" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_33.jpg" alt="" width="229" height="386" border="0"></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01718986" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_34.jpg" alt="" width="220" height="386" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="386" alt=""></td>
	</tr>
	<tr>
		<td colspan="5" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719955" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_35.jpg" alt="" width="282" height="346" border="0"></a></td>
		<td colspan="10">
			<img src="http://images.d1.com.cn/magazine/women/mnpc469_36.jpg" width="487" height="97" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="97" alt=""></td>
	</tr>
	<tr>
		<td colspan="6" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719486" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_37.jpg" alt="" width="222" height="366" border="0"></a></td>
		<td colspan="4" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719948" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_38.jpg" alt="" width="265" height="366" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="249" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/magazine/women/mnpc469_39.jpg" width="282" height="117" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="117" alt=""></td>
	</tr>
	<tr>
		<td colspan="4" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719212" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_40.jpg" alt="" width="205" height="294" border="0"></a></td>
		<td colspan="5" rowspan="2">
			<a href="http://www.d1.com.cn/product/01720031" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_41-1.jpg" alt="" width="196" height="294" border="0"></a></td>
		<td colspan="6">
			<a href="http://www.d1.com.cn/product/01720033" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_42.jpg" alt="" width="368" height="157" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="157" alt=""></td>
	</tr>
	<tr>
		<td colspan="6">
			<a href="http://www.d1.com.cn/product/01719471" target="_blank"><img src="http://images.d1.com.cn/magazine/women/mnpc469_43.jpg" alt="" width="368" height="137" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="137" alt=""></td>
	</tr>
	<tr>
		<td colspan="15">
			<img src="http://images.d1.com.cn/magazine/women/mnpc469_44.jpg" width="769" height="24" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="24" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="171" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="2" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="14" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="18" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="77" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="19" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="19" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="60" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="21" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="4" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="99" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="27" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="18" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="36" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="184" height="1" alt=""></td>
		<td></td>
	</tr>
</table>
<!-- End ImageReady Slices -->

                  
               
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