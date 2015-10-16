<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>恋爱ING  pk  大牌妆品</title>
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
               <td><span style=" font-size:20px; color:#000;"><b>《优品尚志》2012JAN 第七期--恋爱ING  pk  大牌妆品</b></span></td>
               <td style=" text-align:right;"> <%= sb1%></td>
               </tr>
               </table>
               <div class="Content">
                 <!-- ImageReady Slices (ym769.psd) -->
<table id="__01" width="770" height="2001" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="10">
			<img src="http://images.d1.com.cn/magazine/cosmetics//ym769_01.jpg" width="769" height="144" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="144" alt=""></td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="http://images.d1.com.cn/magazine/cosmetics//ym769_02.jpg" width="769" height="160" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="160" alt=""></td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="http://images.d1.com.cn/magazine/cosmetics//ym769_03.jpg" width="769" height="156" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="156" alt=""></td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="http://images.d1.com.cn/magazine/cosmetics/ym769_04_1.jpg" width="769" height="215" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="215" alt=""></td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="http://images.d1.com.cn/magazine/cosmetics//ym769_05.jpg" width="769" height="89" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="89" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/magazine/cosmetics//ym769_06.jpg" width="400" height="252" alt=""></td>
		<td colspan="4">
			<a href="http://www.d1.com.cn/html/gdsshow.asp?gdsid=01416455" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//ym769_07.jpg" alt="" width="183" height="252" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/html/gdsshow.asp?gdsid=01412956" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//ym769_08.jpg" alt="" width="186" height="252" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="252" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/magazine/cosmetics//ym769_09.jpg" width="400" height="110" alt=""></td>
		<td colspan="5">
			<a href="http://www.d1.com.cn/html/gdsshow.asp?gdsid=01409318" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//ym769_10.jpg" alt="" width="369" height="110" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="110" alt=""></td>
	</tr>
	<tr>
		<td colspan="8">
			<a href="http://www.d1.com.cn/html/gdsshow.asp?gdsid=01416545" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//ym769_11.jpg" alt="" width="556" height="80" border="0"></a></td>
		<td colspan="2" rowspan="2">
			<a href="http://www.d1.com.cn/html/gdsshow.asp?gdsid=01413962" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//ym769_12.jpg" alt="" width="213" height="154" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="80" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<a href="http://www.d1.com.cn/html/gdsshow.asp?gdsid=01416545" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//ym769_13.jpg" alt="" width="461" height="74" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/html/gdsshow.asp?gdsid=01413962" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//ym769_14.jpg" alt="" width="95" height="74" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="74" alt=""></td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="http://images.d1.com.cn/magazine/cosmetics//ym769_15.jpg" width="769" height="102" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="102" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/01406745" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//ym769_16.jpg" alt="" width="302" height="83" border="0"></a></td>
		<td colspan="7">
			<img src="http://images.d1.com.cn/magazine/cosmetics//ym769_17.jpg" width="467" height="83" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="83" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01406745" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//ym769_18.jpg" alt="" width="191" height="80" border="0"></a></td>
		<td colspan="2" rowspan="2">
			<a href="http://www.d1.com.cn/product/01407774" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//ym769_19.jpg" alt="" width="118" height="165" border="0"></a></td>
		<td colspan="6" rowspan="3">
			<img src="http://images.d1.com.cn/magazine/cosmetics//ym769_20.jpg" width="460" height="199" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="80" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01407774" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//ym769_21.jpg" alt="" width="191" height="85" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="85" alt=""></td>
	</tr>
	<tr>
		<td colspan="4" rowspan="2">
			<a href="http://www.d1.com.cn/product/01413161" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//ym769_22.jpg" alt="" width="309" height="122" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="34" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="3">
			<a href="http://www.d1.com.cn/product/01400009" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//ym769_23.jpg" alt="" width="145" height="218" border="0"></a></td>
		<td colspan="4" rowspan="3">
			<img src="http://images.d1.com.cn/magazine/cosmetics//ym769_24.jpg" width="315" height="218" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="88" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01413161" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//ym769_25.jpg" alt="" width="137" height="75" border="0"></a></td>
		<td colspan="3" rowspan="2">
			<a href="http://www.d1.com.cn/product/01400009" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//ym769_26.jpg" alt="" width="172" height="130" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="75" alt=""></td>
	</tr>
	<tr>
		<td rowspan="2">
			<a href="http://www.d1.com.cn/product/01406377" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//ym769_27.jpg" alt="" width="137" height="136" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="55" alt=""></td>
	</tr>
	<tr>
		<td colspan="9">
			<a href="http://www.d1.com.cn/product/01406377" target="_blank"><img src="http://images.d1.com.cn/magazine/cosmetics//ym769_28.jpg" alt="" width="632" height="81" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="81" alt=""></td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="http://images.d1.com.cn/magazine/cosmetics//ym769_29.jpg" width="769" height="37" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="1" height="37" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="137" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="54" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="111" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="7" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="91" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="54" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="7" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="95" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="27" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/cosmetics//分隔符.gif" width="186" height="1" alt=""></td>
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