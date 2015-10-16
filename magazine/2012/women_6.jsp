<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>春假7日搭配手册</title>
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
               <td><span style=" font-size:20px; color:#000;"><b>《优品尚志》2012JAN 第六期--春假7日搭配手册</b></span></td>
               <td style=" text-align:right;"> <%= sb1%></td>
               </tr>
               </table>
               <div class="Content">
              <!-- ImageReady Slices (zazhi.psd) -->
<table id="__01" width="770" height="4906" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="23">
			<img src="http://images.d1.com.cn/magazine/women/nvzazhi_01.jpg" width="769" height="234" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="234" alt=""></td>
	</tr>
	<tr>
		<td colspan="23">
			<img src="http://images.d1.com.cn/magazine/women/nvzazhi_02.jpg" width="769" height="212" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="212" alt=""></td>
	</tr>
	<tr>
		<td colspan="23">
			<img src="http://images.d1.com.cn/magazine/women/nvzazhi_03.jpg" width="769" height="133" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="133" alt=""></td>
	</tr>
	<tr>
		<td colspan="23">
			<img src="http://images.d1.com.cn/magazine/women/nvzazhi_04.jpg" width="769" height="128" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="128" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01719946" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_05.jpg" alt="" width="187" height="357" border="0"></a></td>
		<td colspan="6" rowspan="3">
			<a href="http://www.d1.com.cn/html/01719924.htm" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_06.jpg" alt="" width="124" height="642" border="0"></a></td>
		<td colspan="7" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719922" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_07.jpg" alt="" width="198" height="367" border="0"></a></td>
		<td colspan="8" rowspan="3">
			<a href="http://www.d1.com.cn/product/01719844" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_08.jpg" alt="" width="260" height="642" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="357" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="2">
			<a href="http://www.d1.com.cn/html/01719487.htm" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_09.jpg" alt="" width="187" height="285" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="10" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<a href="http://www.d1.com.cn/html/01719951.htm" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_10.jpg" alt="" width="198" height="275" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="275" alt=""></td>
	</tr>
	<tr>
		<td colspan="6" rowspan="3">
			<a href="http://www.d1.com.cn/html/01719898.htm" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_11.jpg" alt="" width="247" height="595" border="0"></a></td>
		<td colspan="7" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719456" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_12.jpg" alt="" width="185" height="443" border="0"></a></td>
		<td colspan="8">
			<a href="http://www.d1.com.cn/product/01719474" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_13.jpg" alt="" width="167" height="367" border="0"></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01516704" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_14.jpg" alt="" width="170" height="367" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="367" alt=""></td>
	</tr>
	<tr>
		<td colspan="3" rowspan="2">
			<a href="http://www.d1.com.cn/html/01719913.htm" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_15.jpg" alt="" width="84" height="228" border="0"></a></td>
		<td colspan="5" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719740" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_16.jpg" alt="" width="83" height="228" border="0"></a></td>
		<td colspan="2" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719740" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_17.jpg" alt="" width="170" height="228" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="76" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<a href="http://www.d1.com.cn/html/01719913.htm" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_18.jpg" alt="" width="185" height="152" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="152" alt=""></td>
	</tr>
	<tr>
		<td colspan="4" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719485" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_19.jpg" alt="" width="215" height="344" border="0"></a></td>
		<td colspan="7" rowspan="3">
			<a href="http://www.d1.com.cn/product/01719912" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_20.jpg" alt="" width="160" height="542" border="0"></a></td>
		<td colspan="8">
			<a href="http://www.d1.com.cn/product/01516204" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_21.jpg" alt="" width="161" height="324" border="0"></a></td>
		<td colspan="4" rowspan="3">
			<a href="http://www.d1.com.cn/html/01719897.htm" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_22.jpg" alt="" width="233" height="542" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="324" alt=""></td>
	</tr>
	<tr>
		<td colspan="8" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719781" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_23.jpg" alt="" width="161" height="218" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="20" alt=""></td>
	</tr>
	<tr>
		<td colspan="4"><a href="http://www.d1.com.cn/product/01719847" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_24.jpg" alt="" width="215" height="198" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="198" alt=""></td>
	</tr>
	<tr>
		<td colspan="5" rowspan="3">
			<a href="http://www.d1.com.cn/product/01719232" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_25.jpg" alt="" width="231" height="609" border="0"></a></td>
		<td colspan="7">
			<a href="http://www.d1.com.cn/product/01516125" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_26.jpg" alt="" width="174" height="384" border="0"></a></td>
		<td colspan="8" rowspan="3">
			<a href="http://www.d1.com.cn/product/01719837" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_27.jpg" alt="" width="182" height="609" border="0"></a></td>
		<td colspan="3" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719918" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_28.jpg" alt="" width="182" height="415" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="384" alt=""></td>
	</tr>
	<tr>
		<td colspan="7" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719836" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_29.jpg" alt="" width="174" height="225" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="31" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/01718951" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_30.jpg" alt="" width="182" height="194" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="194" alt=""></td>
	</tr>
	<tr>
		<td rowspan="3">
			<a href="http://www.d1.com.cn/product/01719926" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_31.jpg" alt="" width="164" height="570" border="0"></a></td>
		<td colspan="8" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719786" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_32.jpg" alt="" width="183" height="386" border="0"></a></td>
		<td colspan="9">
			<a href="http://www.d1.com.cn/product/01516717" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_33.jpg" alt="" width="182" height="285" border="0"></a></td>
		<td colspan="5" rowspan="3">
			<a href="http://www.d1.com.cn/product/01719432" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_34.jpg" alt="" width="240" height="570" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="285" alt=""></td>
	</tr>
	<tr>
		<td colspan="9" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719480" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_35.jpg" alt="" width="182" height="285" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="101" alt=""></td>
	</tr>
	<tr>
		<td colspan="8">
			<a href="http://www.d1.com.cn/product/01719932" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_36.jpg" alt="" width="183" height="184" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="184" alt=""></td>
	</tr>
	<tr>
		<td colspan="7" rowspan="3">
			<a href="http://www.d1.com.cn/html/01719906.htm" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_37.jpg" alt="" width="255" height="588" border="0"></a></td>
		<td colspan="7">
			<a href="http://www.d1.com.cn/html/01719923.htm" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_38.jpg" width="180" height="374" alt=""/></a></td>
		<td colspan="8" rowspan="3">
			<a href="http://www.d1.com.cn/product/01719441" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_39.jpg" alt="" width="170" height="588" border="0"></a></td>
		<td rowspan="2">
			<a href="http://www.d1.com.cn/product/01719941" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_40.jpg" alt="" width="164" height="387" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="374" alt=""></td>
	</tr>
	<tr>
		<td colspan="7" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719486" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_41.jpg" alt="" width="180" height="214" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="13" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01516744" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_42.jpg" alt="" width="164" height="201" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="201" alt=""></td>
	</tr>
	<tr>
		<td colspan="3" rowspan="2">
			<a href="http://www.d1.com.cn/product/01719841" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_43.jpg" alt="" width="192" height="425" border="0"></a></td>
		<td colspan="7" rowspan="3">
			<a href="http://www.d1.com.cn/product/01719782" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_44.jpg" alt="" width="171" height="652" border="0"></a></td>
		<td colspan="7">
			<a href="http://www.d1.com.cn/product/01516747" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_45.jpg" alt="" width="160" height="307" border="0"></a></td>
		<td colspan="6" rowspan="3">
			<a href="http://www.d1.com.cn/product/01719785" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_46.jpg" alt="" width="246" height="652" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="307" alt=""></td>
	</tr>
	<tr>
		<td colspan="7" rowspan="2">
			<a href="http://www.d1.com.cn/html/gdsshow.asp?gdsid=01716993" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_47.jpg" alt="" width="160" height="345" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="118" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/01719514" target="_blank"><img src="http://images.d1.com.cn/magazine/women/nvzazhi_48.jpg" alt="" width="192" height="227" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="1" height="227" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="164" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="23" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="5" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="23" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="16" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="16" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="8" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="56" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="36" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="16" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="12" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="30" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="27" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="3" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="74" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="7" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="7" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="6" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="7" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="51" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="12" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="6" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/women/分隔符.gif" width="164" height="1" alt=""></td>
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