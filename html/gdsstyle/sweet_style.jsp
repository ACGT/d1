<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>时尚穿衣课堂 我们都是甜美控</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style type="text/css">
dd,dt,dl{margin:0px;padding:0px;}
.imgdp {
	height: 480px;
	width: 240px;
	border: 1px solid #ffd7d2;
	overflow:hidden;
	background-repeat: no-repeat;
	background-position: -73px -20px;
	position:relative;
	margin:0px;
	padding:0px;
}
.imgdpt{position:absolute;
	background: #ffb4b4;
	color:#876070; 
	font-family:宋体;
	font-size:12px; 
	font-weight:800;
	line-height: 30px;
	verflow: hidden;
	bottom: 0px;
	width: 240px;
	filter: alpha(opacity=60);
	-moz-opacity: 0.6;
	opacity: 0.6;
	height: 95px;
	display: block;
	margin:0px;
	padding:0px;
	left:0px;
}

.dpprice{ 
	font-family:方正大黑简体;
	font-size:30px; 
	color:#876070; 
}
.dppricet{ 
	font-family:方正大黑简体;
	font-size:20px; 
	color:#876070; 
}
.hide_lr{
	margin-left:-45px;
	border: 1px solid #ffd7d2;
}

a{
	display:inline-block;
}
</style>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- Save for Web Slices (11月女装分会第3波.tif) -->
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<table id="__01" width="980" align="center" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="9"><a href="http://www.d1.com.cn/product/02004170" target="_blank"><img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_01.png" alt="" width="796" height="480" border="0"></a></td>
		<td colspan="2"><a href="http://www.d1.com.cn/product/02001938" target="_blank"><img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_02.png" alt="" width="184" height="480" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="11">
			<img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_03.png" width="980" height="100" alt=""></td>
	</tr>
	<tr>
		<td colspan="11">
			<!-- 推荐位开始9094 9095 9096 9097  -->
			 <%request.setAttribute("code", "9094");
  			   request.setAttribute("length", "6");
  			%>
  			<jsp:include page= "gdsrec_sweet2.jsp"   />
			<!-- 推荐位结束 -->
			</td>
	</tr>
	<tr><td colspan="11" bgcolor="cb1d46"> 
	<!-- 商品新品排序开始 -->
		<% request.setAttribute("type","1");
		request.setAttribute("length","4");
		request.setAttribute("sv","7");
		request.setAttribute("str","蕾丝");
		%>
     <jsp:include page= "gdsrec_sweet_goods.jsp"   />
	 <!-- 商品新品排序结束 -->
	</td></tr>
	<tr><td colspan="11" bgcolor="cb1d46">
	<!-- 商品销量排序开始 -->
		<% request.setAttribute("type","2");
		request.setAttribute("length","4");
		request.setAttribute("sv","7");
		request.setAttribute("str","蕾丝");
		%>
      <jsp:include page= "gdsrec_sweet_goods.jsp"   />
	<!--  商品销量排序结束 -->
	</td></tr>
	<tr>
		<td colspan="11">
			<img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_05.png" width="980" height="100" alt=""></td>
	</tr>
	<tr>
		<td colspan="11">
			<!--  <img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_06.png" width="980" height="574" alt=""></td>
	-->
	 		<%request.setAttribute("code", "9095");
  			   request.setAttribute("length", "6");
  			%>
  			<jsp:include page= "gdsrec_sweet2.jsp"   />
	</tr>
	<!-- 图案开始 -->
	<tr><td colspan="11" bgcolor="cb1d46"> 
	<!-- 商品新品排序开始 -->
		<% request.setAttribute("type","1");
		request.setAttribute("length","4");
		request.setAttribute("sv","3");
		request.setAttribute("str","图案");
		%>
      <jsp:include page= "gdsrec_sweet_goods.jsp"   />
	<!--  商品新品排序结束 -->
	</td></tr>
	<tr><td colspan="11" bgcolor="cb1d46">
	<!-- 商品销量排序开始 -->
		<% request.setAttribute("type","2");
		request.setAttribute("length","4");
		request.setAttribute("sv","3");
		request.setAttribute("str","图案");
		%>
      <jsp:include page= "gdsrec_sweet_goods.jsp"   />
	 <!-- 商品销量排序结束 -->
	</td></tr>
	<!-- 图案结束 -->
	<tr>
		<td colspan="11">
			<img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_07.png" width="980" height="100" alt=""></td>
	</tr>
	<tr>
	<td colspan="11">
			<%request.setAttribute("code", "9096");
  			   request.setAttribute("length", "6");
  			%>
  			<jsp:include page= "gdsrec_sweet2.jsp"   />
		</td>
	</tr>
	<!-- 荷叶边开始 -->
	<tr><td colspan="11" bgcolor="cb1d46"> 
	<!-- 商品新品排序开始 -->
		<% request.setAttribute("type","1");
		request.setAttribute("length","4");
		request.setAttribute("sv","7");
		request.setAttribute("str","荷叶边");
		%>
      <jsp:include page= "gdsrec_sweet_goods.jsp"   />
	<!--  商品新品排序结束 -->
	</td></tr>
	<tr><td colspan="11" bgcolor="cb1d46">
	<!-- 商品销量排序开始 -->
		<% request.setAttribute("type","5");
		request.setAttribute("length","4");
		request.setAttribute("sv","7");
		request.setAttribute("str","荷叶边");
		%>
      <jsp:include page= "gdsrec_sweet_goods.jsp"   />
	<!--  商品销量排序结束 -->
	</td></tr>
	<!-- 荷叶边结束 -->
	<tr style="width: 980px;height: 102px;">
		<td colspan="11">
			<img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_10.png" width="979" height="100" alt=""></td>
	</tr>
	<tr>
		<td colspan="11">
			<%request.setAttribute("code", "9097");
  			   request.setAttribute("len", "7");
  			%>
  			<jsp:include page= "gdsrec_sweet1.jsp"   />
		</td>
	</tr>
	<!-- 格纹条纹圆点开始 -->
	<tr><td colspan="11" bgcolor="cb1d46"> 
	<!-- 商品新品排序开始 -->
		<% request.setAttribute("type","1");
		request.setAttribute("length","4");
		request.setAttribute("sv","3");
		request.setAttribute("str","格纹条纹圆点");
		%>
      <jsp:include page= "gdsrec_sweet_goods.jsp"   />
	<!--  商品新品排序结束 -->
	</td></tr>
	<tr><td colspan="11" bgcolor="cb1d46">
	<!-- 商品销量排序开始 -->
		<% request.setAttribute("type","2");
		request.setAttribute("length","4");
		request.setAttribute("sv","3");
		request.setAttribute("str","格纹条纹圆点");
		%>
      <jsp:include page= "gdsrec_sweet_goods.jsp"   />
	 <!-- 商品销量排序结束 -->
	</td></tr>
	<!-- 格纹条纹圆点结束 -->
	<tr>
		<td colspan="11"><a href="http://www.d1.com.cn/html/women/ " target="_blank"><img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_12.png" alt="" width="980" height="121" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="cb1d46">
		<!-- 毛呢大衣开始 -->
		<% request.setAttribute("type","1");
		request.setAttribute("length","4");
		request.setAttribute("str","毛呢大衣");
		%>
       <jsp:include page= "gdsrec_sweet_goods.jsp"   />
		<!-- 毛呢大衣结束 -->
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="cb1d46">
		<!-- 羽绒服开始 -->
		<% request.setAttribute("type","1");
		request.setAttribute("length","4");
		request.setAttribute("str","羽绒服1");
		%>
      <jsp:include page= "gdsrec_sweet_goods.jsp"   />
		<!--  羽绒服结束 -->
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="cb1d46">
		<!-- 羽绒服开始 -->
		<% request.setAttribute("type","1");
		request.setAttribute("length","4");
		request.setAttribute("str","羽绒服2");
		%>
      <jsp:include page= "gdsrec_sweet_goods.jsp"   />
		<!--  羽绒服结束 -->
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="cb1d46">
		<!-- 裙子开始 -->
		<% request.setAttribute("type","1");
		request.setAttribute("length","4");
		request.setAttribute("str","裙子");
		%>
       <jsp:include page= "gdsrec_sweet_goods.jsp"   />
		 <!--裙子结束 -->
		</td>
	</tr>
	<tr>
		<td colspan="2"><a href="http://www.d1.com.cn/result.jsp?productsort=020002" target="_blank"><img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_14.png" alt="" width="145" height="134" border="0"></a></td>
		<td><a href="http://www.d1.com.cn/result.jsp?productsort=020010" target="_blank"><img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_15.png" alt="" width="160" height="134" border="0"></a></td>
		<td colspan="2"><a href="http://www.d1.com.cn/result.jsp?productsort=020004" target="_blank"><img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_16.png" alt="" width="151" height="134" border="0"></a></td>
		<td><a href="http://www.d1.com.cn/result.jsp?productsort=020013" target="_blank"><img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_17.png" alt="" width="143" height="134" border="0"></a></td>
		<td colspan="2"><a href="http://www.d1.com.cn/result.jsp?productsort=020007" target="_blank"><img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_18.png" alt="" width="140" height="134" border="0"></a></td>
		<td colspan="2"><a href="http://www.d1.com.cn/result.jsp?productsort=020015" target="_blank"><img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_19.png" alt="" width="125" height="134" border="0"></a></td>
		<td><a href="http://www.d1.com.cn/result.jsp?productsort=020008" target="_blank"><img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_20.png" alt="" width="116" height="134" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="4"><a href="http://www.d1.com.cn/zhuanti/201312/fg1204/" target="_blank"><img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_21.png" alt="" width="329" height="150" border="0"></a></td>
		<td colspan="3"><a href="http://www.d1.com.cn/zhuanti/201311/style1125/" target="_blank"><img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_22.png" alt="" width="322" height="150" border="0"></a></td>
		<td colspan="4"><a href="http://www.d1.com.cn/zhuanti/201310/nz1012/" target="_blank"><img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_23.png" alt="" width="329" height="150" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="11"><a href="http://www.d1.com.cn/" target="_blank"><img src="http://images.d1.com.cn/zt2013/1213/1212Sweetstyle_24.jpg" alt="" width="980" height="48" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/1213/&#x5206;&#x9694;&#x7b26;.gif" width="1" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/1213/&#x5206;&#x9694;&#x7b26;.gif" width="144" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/1213/&#x5206;&#x9694;&#x7b26;.gif" width="160" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/1213/&#x5206;&#x9694;&#x7b26;.gif" width="24" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/1213/&#x5206;&#x9694;&#x7b26;.gif" width="127" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/1213/&#x5206;&#x9694;&#x7b26;.gif" width="143" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/1213/&#x5206;&#x9694;&#x7b26;.gif" width="52" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/1213/&#x5206;&#x9694;&#x7b26;.gif" width="88" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/1213/&#x5206;&#x9694;&#x7b26;.gif" width="57" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/1213/&#x5206;&#x9694;&#x7b26;.gif" width="68" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/1213/&#x5206;&#x9694;&#x7b26;.gif" width="116" height="1" alt=""></td>
	</tr>
</table>
<%@include file="/inc/foot.jsp"%>
</body>
</html>