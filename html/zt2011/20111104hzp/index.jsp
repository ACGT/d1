<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!
String showlistjifen(String code,int iAwardValue1, int iAwardValue2 ){
	StringBuffer str=new StringBuffer();
	ArrayList<Award> alist=AwardHelper.getAwardByGdsId(code,iAwardValue1,iAwardValue2);
	if(alist!=null){
	
		str.append("<div class=\"c3c\"> <ul>");
		for(Award award:alist){
			ArrayList<PromotionProduct> plist=PromotionProductHelper.getPProductByCodeGdsid(code,award.getAward_gdsid());
			if(plist!=null){
				PromotionProduct pp=plist.get(0);
				Product p=ProductHelper.getById(award.getAward_gdsid());
				String price="";
				
				String img="http://images.d1.com.cn"+p.getGdsmst_imgurl().trim();
				str.append("<li><div class=s1>");
				if(!"00000000".equals(award.getAward_gdsid())){
					price=ProductGroupHelper.getRoundPrice(p.getGdsmst_saleprice().floatValue());
					str.append("<a href=\"http://www.d1.com.cn/buy/jifen\"  target=\"_blank\"> <img src=");
					str.append(img);
					str.append(" width=200 height=200></a>");
				}else{
					 if(award.getAward_value().intValue()==500){
	    				 price="30";
	    			 }else if(award.getAward_value().intValue()==800){
	    				 price="50";
	    			 }
					str.append("<img src=");
					str.append(img);
					str.append("width=200 height=200></a>");
				}
				str.append("</div><div class=s2>");
				str.append(Tools.substring( StringUtils.replaceHtml(award.getAward_gdsname()),25));
				str.append("<BR>");
				str.append("市场价:");
				str.append(price);
				str.append("元<BR><span class=jf1>");
				str.append(award.getAward_value().intValue());
				str.append("积分");
				if(Tools.floatCompare(award.getAward_price().doubleValue(),0.0)==1){
					str.append("&nbsp;+&nbsp;");
					str.append(ProductGroupHelper.getRoundPrice(award.getAward_price().floatValue()));
					str.append("元");
				}
				str.append("</span></div><div class=s3>");
				str.append("<a href=\"###\" attr=\""+award.getId()+"\" onClick=\"op(this);");
				str.append("\" >");
				str.append("<img src=\"http://www.d1.com.cn/res/images/result/b4.gif\"></a></div></li>");
			}
			
		}
		str.append("</ul><div class=\"clear\"></div></div>");
	}
	return str.toString();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>积恵来啦 妆品积分大换购！-D1优尚</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="css.css" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/JavaScript">
function op(obj){
	if (window.confirm("确定要兑换此商品吗?一经兑换,不能恢复.")){
		addCart(obj);
	}
}
function addCart(obj){
	$.inCart(obj,{ajaxUrl:'/ajax/flow/listAwardInCart.jsp'});
}
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table id="__01" width="980" height="1962" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111104hzp/index_01.jpg" width="980" height="237" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111104hzp/index_02.jpg" width="980" height="161" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111104hzp/index_03.jpg" width="980" height="44" alt=""></td>
	</tr>
	<tr>
		<td height="101"><%if(Tools.isNull(Tools.getCookie(request,"PINGAN"))){
		out.print(showlistjifen("7025",0,0));
			
		}%></td>
	</tr>
	<tr>
		<td><a href="/product/01415789" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111104hzp/index_05.jpg" alt="" width="980" height="227" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111104hzp/index_06.jpg" width="980" height="42" alt=""></td>
	</tr>
	<tr>
		<td height="92"><%
		request.setAttribute("code","7006");%>
		<jsp:include   page= "gdsrcm0305.jsp"   />   	
		</td>
	</tr>
	<tr>
		<td>
			<a href="/product/01415869" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111104hzp/index_08.jpg" alt="" width="980" height="226" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111104hzp/index_09.jpg" width="980" height="42" alt=""></td>
	</tr>
	<tr>
		<td height="66"><%
		request.setAttribute("code","7008");%>
		<jsp:include   page= "gdsrcm0305.jsp"   /> </td>
	</tr>
	<tr>
		<td>
			<a href="/product/01413089" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111104hzp/index_11-1.jpg" alt="" width="980" height="227" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111104hzp/index_12.jpg" width="980" height="42" alt=""></td>
	</tr>
	<tr>
		<td height="85"><%
		request.setAttribute("code","7009");%>
		<jsp:include   page= "gdsrcm0305.jsp"   /> </td>
	</tr>
	<tr>
		<td>
			<a href="/product/01414799" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111104hzp/index_14.jpg" alt="" width="980" height="227" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111104hzp/index_15.jpg" width="980" height="42" alt=""></td>
	</tr>
	<tr>
		<td height="101"><%
		request.setAttribute("code","7010");%>
		<jsp:include   page= "gdsrcm0305.jsp"   /> </td>
	</tr>
</table>
</center>
<center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>