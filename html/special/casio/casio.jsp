<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
public static String casioimg(String code){
	String retstr="";
ArrayList<Promotion> list=PromotionHelper. getBrandListByCode(code,1);
if(list!=null){
	for(Promotion promotion:list){
		if(!promotion.getSplmst_url().equals("#")){
		retstr=retstr+"<a href=\""+PromotionHelper.getPathUrl(0,StringUtils.encodeUrl(promotion.getSplmst_url()))+"\" target=\"_blank\">";
	}  
	retstr=retstr+"<img src=\""+promotion.getSplmst_picstr()+"\"  alt=\""+promotion.getSplmst_name() +"\">";
	if(!promotion.getSplmst_url().equals("#")){
		retstr=retstr+"</a>";
	}
	
}
}
return retstr;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="description" content="Casio卡西欧手表，卡西欧运动手表，卡西欧PRG手表，卡西欧登山手表，卡西欧太阳能手表，卡西欧指针手表，卡西欧G-shock商务手表，4.5折正品特价,假一罚二，免费咨询电话400-680-8666">
<meta name="keywords" content="Casio卡西欧手表,卡西欧运动手表,PRG,登山,指针,G-shock商务">
<title>casio卡西欧手表—全场4.5折起,假一罚二—登山手表、指针手表、太阳能手表、G-shock手表、日本原产</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/special.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style>

</style>
</head>
<body  BGCOLOR=#FFFFFF >
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<div style="width:980px; margin:0px auto;">
<table id="__01" width="980" aglin="center" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/casio/casio1205_01.jpg" width="980" height="64" alt=""></td>
	</tr>
	<tr>
		<td><%=casioimg("3054") %></td>
	</tr>
	<tr>
		<td height="10"> </td>
	</tr>
	<tr>
		<td><%=casioimg("3055") %></td>
	</tr>
	<tr>
		<td height="10"> </td>
	</tr>
	<tr>
		<td><%=casioimg("3056") %></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/casio/casio1205_05.jpg" width="980" height="59" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/casio/casio1205_06.jpg" width="980" height="1" alt=""></td>
	</tr>
	<tr>
		<td> <div class="cc">
 <% request.setAttribute("code", "7670");
		   request.setAttribute("num", "8");
		   %>
			<jsp:include page="/sales/showlist2.jsp" flush="true" /> 
   </div></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/casio/casio1205_08.jpg" width="980" height="58" alt=""></td>
	</tr>
	<tr>
		<td> <div class="cc">
 <% request.setAttribute("code", "7671");
		   request.setAttribute("num", "8");
		   %>
			<jsp:include page="/sales/showlist2.jsp" flush="true" /> 
   </div></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/casio/casio1205_10.jpg" width="980" height="55" alt=""></td>
	</tr>
	<tr>
		<td> <div class="cc">
 <% request.setAttribute("code", "7672");
		   request.setAttribute("num", "8");
		   %>
			<jsp:include page="/sales/showlist2.jsp" flush="true" /> 
   </div></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/casio/casio1205_12.jpg" width="980" height="56" alt=""></td>
	</tr>
	<tr>
		<td> <div class="cc">
 <% request.setAttribute("code", "7673");
		   request.setAttribute("num", "8");
		   %>
			<jsp:include page="/sales/showlist2.jsp" flush="true" /> 
   </div></td>
	</tr>
</table>
</div>
<!-- 尾部开始 -->
<%@include file="/inc/foot.jsp"%>
<!-- 尾部结束 -->
</body>
</html>