<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>男装5大外套穿搭法</title>
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
               <td><span style=" font-size:20px; color:#000;"><b>《优品尚志》2012JAN 第一期--男装5大外套穿搭法</b></span></td>
               <td style=" text-align:right;"> <%= sb1%></td>
               </tr>
               </table>
               <div class="Content">
                  <table id="__01" width="770" height="4293" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="17">
			<img src="http://images.d1.com.cn/magazine/man/nkpb_01.jpg" width="769" height="163" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="163" alt=""></td>
	</tr>
	<tr>
		<td colspan="17">
			<img src="http://images.d1.com.cn/magazine/man/nkpb_02.jpg" width="769" height="193" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="193" alt=""></td>
	</tr>
	<tr>
		<td colspan="17">
			<img src="http://images.d1.com.cn/magazine/man/nkpb_03.jpg" width="769" height="223" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="223" alt=""></td>
	</tr>
	<tr>
		<td colspan="17">
			<img src="http://images.d1.com.cn/magazine/man/nkpb_04.jpg" width="769" height="219" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="219" alt=""></td>
	</tr>
	<tr>
		<td colspan="7" rowspan="3">
			<a href="http://www.d1.com.cn/gdsinfo/01718856.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_05.jpg" alt="" width="343" height="381" border="0"></a></td>
		<td colspan="6" rowspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01717868.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_06.jpg" alt="" width="229" height="255" border="0"></a></td>
		<td colspan="4">
			<a href="http://www.d1.com.cn/gdsinfo/01717868.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_07.jpg" alt="" width="197" height="213" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="213" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/magazine/man/nkpb_08.jpg" width="197" height="42" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="42" alt=""></td>
	</tr>
	<tr>
		<td colspan="10" rowspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01718415.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_09.jpg" alt="" width="426" height="268" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="126" alt=""></td>
	</tr>
	<tr>
		<td colspan="3" rowspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01718857.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_10.jpg" alt="" width="197" height="222" border="0"></a></td>
		<td colspan="4" rowspan="3">
			<a href="http://www.d1.com.cn/gdsinfo/01718856.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_11.jpg" alt="" width="146" height="301" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="142" alt=""></td>
	</tr>
	<tr>
		<td colspan="10" rowspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01719166.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_12.jpg" alt="" width="426" height="159" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="80" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/gdsinfo/01718856.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_13.jpg" alt="" width="197" height="79" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="79" alt=""></td>
	</tr>
	<tr>
		<td colspan="11">
			<a href="http://www.d1.com.cn/gdsinfo/01717867.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_14.jpg" alt="" width="413" height="312" border="0"></a></td>
		<td colspan="5" rowspan="5">
			<a href="http://www.d1.com.cn/gdsinfo/01718855.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_15.jpg" alt="" width="178" height="711" border="0"></a></td>
		<td rowspan="3">
			<a href="http://www.d1.com.cn/gdsinfo/01718854.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_16.jpg" alt="" width="178" height="599" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="312" alt=""></td>
	</tr>
	<tr>
		<td colspan="11">		  <a href="http://www.d1.com.cn/gdsinfo/01718264.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_17.jpg" alt="" width="413" height="239" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="239" alt=""></td>
	</tr>
	<tr>
		<td colspan="4" rowspan="3">
			<a href="http://www.d1.com.cn/gdsinfo/01718022.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_18.jpg" alt="" width="207" height="160" border="0"></a></td>
		<td colspan="7" rowspan="2">
			<img src="http://images.d1.com.cn/magazine/man/nkpb_19.jpg" width="206" height="55" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="48" alt=""></td>
	</tr>
	<tr>
		<td rowspan="2">
			<img src="http://images.d1.com.cn/magazine/man/nkpb_20.jpg" width="178" height="112" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="7" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<a href="http://www.d1.com.cn/gdsinfo/01718022.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_21.jpg" alt="" width="206" height="105" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="105" alt=""></td>
	</tr>
	<tr>
		<td rowspan="4">
			<a href="http://www.d1.com.cn/gdsinfo/01718865.asp"><img src="http://images.d1.com.cn/magazine/man/nkpb_22.jpg" alt="" width="173" height="579" border="0"></a></td>
		<td colspan="7" rowspan="5">
			<a href="http://www.d1.com.cn/gdsinfo/01718864.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_23.jpg" alt="" width="181" height="703" border="0"></a></td>
		<td colspan="4" rowspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01717867.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_24.jpg" alt="" width="216" height="274" border="0"></a></td>
		<td colspan="5">
			<a href="http://www.d1.com.cn/gdsinfo/01717867.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_25.jpg" alt="" width="199" height="213" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="213" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/magazine/man/nkpb_26.jpg" width="199" height="61" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="61" alt=""></td>
	</tr>
	<tr>
		<td colspan="9">
			<a href="http://www.d1.com.cn/gdsinfo/01718415.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_27.jpg" alt="" width="415" height="272" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="272" alt=""></td>
	</tr>
	<tr>
		<td colspan="9" rowspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01719167.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_28.jpg" alt="" width="415" height="157" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="33" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/gdsinfo/01718865.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_29.jpg" alt="" width="173" height="124" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="124" alt=""></td>
	</tr>
	<tr>
		<td colspan="6" rowspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01718852.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_30.jpg" alt="" width="237" height="338" border="0"></a></td>
		<td colspan="4">
			<a href="http://www.d1.com.cn/gdsinfo/01718852.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_31.jpg" alt="" width="166" height="262" border="0"></a></td>
		<td colspan="5" rowspan="6">
			<a href="http://www.d1.com.cn/gdsinfo/01719779.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_32.jpg" alt="" width="183" height="701" border="0" ></a></td>
		<td colspan="2" rowspan="5">
			<img src="http://images.d1.com.cn/magazine/man/nkpb_33.jpg" alt="" width="183" height="610" border="0" usemap="#Map"></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="262" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<a href="http://www.d1.com.cn/gdsinfo/01718862.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_34.jpg" alt="" width="166" height="76" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="76" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<a href="http://www.d1.com.cn/gdsinfo/01718862.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_35.jpg" alt="" width="212" height="113" border="0"></a></td>
		<td colspan="5" rowspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01718862.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_36.jpg" alt="" width="191" height="226" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="113" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<a href="http://www.d1.com.cn/gdsinfo/01717868.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_37.jpg" alt="" width="212" height="113" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="113" alt=""></td>
	</tr>
	<tr>
		<td colspan="10" rowspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01717868.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_38.jpg" alt="" width="403" height="137" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="46" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01719779.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_39.jpg" alt="" width="183" height="91" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="91" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="4">
			<a href="http://www.d1.com.cn/gdsinfo/01718858.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_40.jpg" alt="" width="192" height="563" border="0"></a></td>
		<td colspan="7" rowspan="5"><a href="http://www.d1.com.cn/gdsinfo/01718859.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_41.jpg" alt="" width="173" height="697" border="0"></a></td>
		<td colspan="5" rowspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01717868.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_42.jpg" alt="" width="215" height="280" border="0"></a></td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/gdsinfo/01717868.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_43.jpg" alt="" width="189" height="210" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="210" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/magazine/man/nkpb_44.jpg" width="189" height="70" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="70" alt=""></td>
	</tr>
	<tr>
		<td colspan="8">
			<a href="http://www.d1.com.cn/gdsinfo/01718415.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_45.jpg" alt="" width="404" height="264" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="264" alt=""></td>
	</tr>
	<tr>
		<td colspan="8" rowspan="2">
			<a href="http://www.d1.com.cn/gdsinfo/01718023.asp" target="_blank"><img src="http://images.d1.com.cn/magazine/man/nkpb_46.jpg" alt="" width="404" height="153" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="19" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/magazine/man/nkpb_47.jpg" width="192" height="134" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="1" height="134" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="173" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="19" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="5" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="10" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="5" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="25" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="106" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="11" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="11" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="38" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="10" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="157" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="2" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="8" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="6" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="5" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/magazine/man/分隔符.gif" width="178" height="1" alt=""></td>
		<td></td>
	</tr>
</table>

<map name="Map">
<area shape="poly" coords="14,470,58,465,77,428,102,384,122,371,108,337,67,313,21,326,7,350" href="http://www.d1.com.cn/gdsinfo/01719780.asp" target="_blank">
<area shape="poly" coords="70,463,84,423,107,384,138,376,155,378,161,408,169,443,174,491,170,524,131,532,112,528" href="http://www.d1.com.cn/gdsinfo/01719778.asp" target="_blank">
<area shape="poly" coords="11,603,99,604,138,597,130,564,120,541,114,532,85,511,63,469,24,477,4,484" href="http://www.d1.com.cn/gdsinfo/01719777.asp" target="_blank">
<area shape="poly" coords="18,517" href="#"></map>
<map name="Map2"><area shape="poly" coords="173,507" href="http://www.d1.com.cn/gdsinfo/01719779.asp"></map>
                  
               
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