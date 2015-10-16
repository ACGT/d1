<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp" %>
<html>
<head>
<meta name="description" content="Casio卡西欧手表，卡西欧运动手表，卡西欧PRG手表，卡西欧登山手表，卡西欧太阳能手表，卡西欧指针手表，卡西欧G-shock商务手表，4.5折正品特价,假一罚二，免费咨询电话400-680-8666">
<meta name="keywords" content="Casio卡西欧手表,卡西欧运动手表,PRG,登山,指针,G-shock商务">
<title>casio卡西欧手表—全场4.5折起,假一罚二—登山手表、指针手表、太阳能手表、G-shock手表、日本原产</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/special.css")%>" rel="stylesheet" type="text/css"/>

<style>

</style>
</head>
<body  BGCOLOR=#FFFFFF >
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<%
ArrayList<Promotion> list=PromotionHelper. getBrandListByCode("1663",1);
if(list!=null){
	for(Promotion promotion:list){
		if(!promotion.getSplmst_url().equals("#")){%>
		<a href="<%=PromotionHelper.getPathUrl(0,StringUtils.encodeUrl(promotion.getSplmst_url()))%>" target="_blank">
	<%} %>
	<img src="<%=promotion.getSplmst_picstr() %>"  alt="<%=promotion.getSplmst_name() %>">
	<% if(!promotion.getSplmst_url().equals("#")){%>
		</a>
	<%}
	
}
}
%>
<%@include file="casio_header.jsp"%>
<table width="1004" height="490" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="6">
		<table id="__01" width="1004" height="489" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td rowspan="5">
			<img src="http://images.d1.com.cn/images2011/html/casio/casio_hot_01.jpg" width="51" height="489" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2011/html/casio/casio_hot_02.jpg" width="883" height="1" alt=""></td>
		<td rowspan="5">
			<img src="http://images.d1.com.cn/images2011/html/casio/casio_hot_03.jpg" width="70" height="489" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2011/html/casio/casio_hot_04.jpg" width="883" height="42" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/gdsinfo/01506312.asp" target="_blank"><img src="http://images.d1.com.cn/images2011/html/casio/casio_hot_05.jpg" alt="" width="883" height="154" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/gdsinfo/01506312.asp" target="_blank"><img src="http://images.d1.com.cn/images2011/html/casio/casio_hot_06.jpg" alt="" width="883" height="131" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/gdsinfo/01506312.asp" target="_blank"><img src="http://images.d1.com.cn/images2011/html/casio/casio_hot_07.jpg" alt="" width="883" height="161" border="0"></a></td>
	</tr>
</table>
		</td>
	</tr>
</table>
<TABLE WIDTH=1004 BORDER=0 CELLPADDING=0 CELLSPACING=0>
	<tr>
		<td>
		<table width="1004" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="52" background="http://www.d1.com.cn/html/special/casio/images/cxolist_left.jpg" rowspan=2>
				</td>
				<td width="881" align=center>
					<img src="http://www.d1.com.cn/html/special/casio/images/cxo_bar1.jpg" alt=""></td>
				<td width="71" background="http://www.d1.com.cn/html/special/casio/images/cxolist_right.jpg" rowspan=2>
				</td>
			</tr>
			<tr>
				<td width="881">
   <div class="cc">
 <% request.setAttribute("code", "2068");
		   request.setAttribute("num", "16");
		   %>
			<jsp:include page="/sales/showlist2.jsp" flush="true" /> 
   </div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="1004" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="52" background="http://www.d1.com.cn/html/special/casio/images/cxolist_left.jpg" rowspan=2>
				</td>
				<td width="881" align=center>
					<img src="http://www.d1.com.cn/html/special/casio/images/cxo_bar11.jpg" alt=""></td>
				<td width="71" background="http://www.d1.com.cn/html/special/casio/images/cxolist_right.jpg" rowspan=2>
				</td>
			</tr>
			<tr>
				<td width="881">
   <div class="cc">
    <% request.setAttribute("code", "2069");
		   request.setAttribute("num", "16");
		   %>
			<jsp:include page="/sales/showlist2.jsp" flush="true" /> 

   </div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="1004" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="52" background="http://www.d1.com.cn/html/special/casio/images/cxolist_left.jpg" rowspan=2>
				</td>
				<td width="881" align=center>
					<img src="http://www.d1.com.cn/html/special/casio/images/cxo_bar2.jpg" alt=""></td>
				<td width="71" background="http://www.d1.com.cn/html/special/casio/images/cxolist_right.jpg" rowspan=2>
				</td>
			</tr>
			<tr>
				<td width="881">
   <div class="cc">
 <% request.setAttribute("code", "2070");
		   request.setAttribute("num", "16");
		   %>
			<jsp:include page="/sales/showlist2.jsp" flush="true" /> 
   </div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="1004" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="52" background="http://www.d1.com.cn/html/special/casio/images/cxolist_left.jpg" rowspan=2>
				</td>
				<td  width="881" align=center>
					<img src="http://www.d1.com.cn/html/special/casio/images/cxo_bar3.jpg" alt=""></td>
				<td width="71" background="http://www.d1.com.cn/html/special/casio/images/cxolist_right.jpg" rowspan=2>
				</td>
			</tr>
			<tr>
				<td width="881">
   <div class="cc">
 <% request.setAttribute("code", "2071");
		   request.setAttribute("num", "16");
		   %>
			<jsp:include page="/sales/showlist2.jsp" flush="true" /> 
   </div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</TABLE>
<%
String casiodimg1="";
String casiodimg2="";
String casiodlink1="";
String casiodlink2="";
ArrayList<Promotion> plist=PromotionHelper. getBrandListByCode("1846",2);
if(plist!=null){
	
	for(Promotion promotion:plist){
		if(promotion.getSplmst_seqview().toString().equals("1")){
			casiodimg1=promotion.getSplmst_picstr();
			casiodlink1=promotion.getSplmst_url();
		
		}
		else if(promotion.getSplmst_seqview().toString().equals("2")){
			casiodimg2=promotion.getSplmst_picstr();
			casiodlink2=promotion.getSplmst_url();
			
		}
	}
}
%>
<table width="1004" height="250" border="0" cellpadding="0"  cellspacing="0">
	<tr>
		<td><a href="<%=casiodlink1%>" target="_blank"><img src="<%=casiodimg1%>"></a></td>
	</tr>
	<tr>
		<td><a href="<%=casiodlink2%>" target="_blank"><img src="<%=casiodimg2%>"></a></td>
	</tr>
</table>

<table width="1004" height="322" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td rowspan="4">
			<img src="http://www.d1.com.cn/html/special/casio/images/cxonb_01.jpg" width="51" height="321" alt=""></td>
		<td>
			<img src="http://www.d1.com.cn/html/special/casio/images/cxonb_02.jpg" width="194" height="71" alt=""></td>
		<td>
			<img src="http://www.d1.com.cn/html/special/casio/images/cxonb_03.jpg" width="248" height="71" alt=""></td>
		<td>
			<img src="http://www.d1.com.cn/html/special/casio/images/cxonb_04.jpg" width="151" height="71" alt=""></td>
		<td colspan="2" rowspan="2">
			<a href="http://www.d1.com.cn/html/zhuanti/081202casio/dengshan.asp" target="_blank">
			<img src="http://www.d1.com.cn/html/special/casio/images/cxonb_05.jpg" width="291" height="175" alt="" border=0></a></td>
		<td rowspan="4">
			<img src="http://www.d1.com.cn/html/special/casio/images/cxonb_06.jpg" width="69" height="321" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/html/zhuanti/081202casio/dengshan.asp" target="_blank">
			<img src="http://www.d1.com.cn/html/special/casio/images/cxonb_07.jpg" width="194" height="104" alt="" border=0></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/html/zhuanti/081202casio/dengshan.asp" target="_blank">
			<img src="http://www.d1.com.cn/html/special/casio/images/cxonb_08.jpg" width="399" height="104" alt="" border=0></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/html/zhuanti/081202casio/dengshan.asp" target="_blank">
			<img src="http://www.d1.com.cn/html/special/casio/images/cxonb_09.jpg" width="194" height="78" alt="" border=0></a></td>
		<td>
			<a href="http://www.d1.com.cn/html/zhuanti/081202casio/dengshan.asp" target="_blank">
			<img src="http://www.d1.com.cn/html/special/casio/images/cxonb_10.jpg" width="248" height="78" alt="" border=0></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/html/zhuanti/081202casio/dengshan.asp" target="_blank">
			<img src="http://www.d1.com.cn/html/special/casio/images/cxonb_11.jpg" width="217" height="78" alt="" border=0></a></td>
		<td>
			<img src="http://www.d1.com.cn/html/special/casio/images/cxonb_12.jpg" width="225" height="78" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://www.d1.com.cn/html/special/casio/images/cxonb_13.jpg" width="194" height="68" alt=""></td>
		<td>
			<img src="http://www.d1.com.cn/html/special/casio/images/cxonb_14.jpg" width="248" height="68" alt=""></td>
		<td colspan="2">
			<img src="http://www.d1.com.cn/html/special/casio/images/cxonb_15.jpg" width="217" height="68" alt=""></td>
		<td>
			<img src="http://www.d1.com.cn/html/special/casio/images/cxonb_16.jpg" width="225" height="68" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://www.d1.com.cn/html/special/casio/images/分隔符.gif" width="51" height="1" alt=""></td>
		<td>
			<img src="http://www.d1.com.cn/html/special/casio/images/分隔符.gif" width="194" height="1" alt=""></td>
		<td>
			<img src="http://www.d1.com.cn/html/special/casio/images/分隔符.gif" width="248" height="1" alt=""></td>
		<td>
			<img src="http://www.d1.com.cn/html/special/casio/images/分隔符.gif" width="151" height="1" alt=""></td>
		<td>
			<img src="http://www.d1.com.cn/html/special/casio/images/分隔符.gif" width="66" height="1" alt=""></td>
		<td>
			<img src="http://www.d1.com.cn/html/special/casio/images/分隔符.gif" width="225" height="1" alt=""></td>
		<td>
			<img src="http://www.d1.com.cn/html/special/casio/images/分隔符.gif" width="69" height="1" alt=""></td>
	</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align=center>
<img src="http://www.d1.com.cn/html/special/casio/images/qa.gif" border=0>
		</td>
	</tr>
	<tr>
		<td align=center>
<img src="http://images.d1.com.cn/headimg/400_980.gif" border=0>
		</td>
	</tr>
</table>
<center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>