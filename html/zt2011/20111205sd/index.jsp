<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>美妆圣诞狂欢派对 满减买赠齐登场 -D1优尚</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style type="text/css">
<!--
body {
	background-color: #FFF;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
<style type="text/css">
.actbg1{position:absolute;width:160px;height:424;z-index:999;left:0px;}
.actbg2{
	position:absolute;
	width:160px;
	height:424;
	z-index:999;
	left:820px;
}
.showmenu1 {
	background-image: url(http://images.d1.com.cn/zt2011/20111205sd/tj_03_1.jpg);
	background-repeat: no-repeat;
	background-position: left top;
	height:68px;
}
.showmenu2 {
	background-image: url(http://images.d1.com.cn/zt2011/20111205sd/cz_03_1.jpg);
	background-repeat: no-repeat;
	background-position: left top;
	height:68px;
}
.showmenu3 {
	background-image: url(http://images.d1.com.cn/zt2011/20111205sd/mz_03_1.jpg);
	background-repeat: no-repeat;
	background-position: left top;
	height:68px;
}
#jptjbt {
	height: 68px;
	width: 980px;
}

.jptjbts1 {
	height: 68px;
	width: 330px;
	float:left;
}
.jptjbts2 {
	height: 68px;
	width: 350px;
	float:left;
}

.jptjbts3 {
	height: 68px;
	width: 300px;
	float:left;
}
.nonehot {
	DISPLAY: none
}
.blockhot {
	DISPLAY: block;
}
-->
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<SCRIPT language="JavaScript" type="text/javascript">
function actad(s_id){

  document.getElementById("showmenu").className="showmenu"+s_id;
  for(j=1;j<6;j++){
   if(j==s_id){
	//document.getElementById("ad"+j).className="blocknot"; //内容不显示
	document.getElementById("showcn"+j).className="blocknot"; //内容不显示
   }
   else
   {
	//document.getElementById("ad"+j).className="nonehot"; //内容不显示
	document.getElementById("showcn"+j).className="nonehot"; //内容不显示

   }
  }
  
  i=s_id;
}
</script>
<center>
<table id="__01" width="980" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/zt2011/20111205sd/cz_01.jpg" width="673" height="444" alt=""></td>
		<td colspan="4">
			<a href="/product/01415718" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/cz_02.jpg" alt="" width="307" height="444" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="9">
			<div class="showmenu1" id="showmenu" align="center">
		<DIV class=left id=jptjbt>
<DIV class="jptjbts1" onMouseOver="actad(1)"></DIV>
<DIV class=jptjbts2 onMouseOver="actad(2)"></DIV>
<DIV class=jptjbts3 onMouseOver="actad(3)"></DIV>
</DIV>
</div>
		</td>
	</tr>
	<tr>
	  <td colspan="9">
	  <div id="showcn1" class="nonehot">
<table  width="980" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><% request.setAttribute("code","7160");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../gdsrcm0306.jsp"   /></td>
	</tr>
</table>
</div>
	  <div id="showcn2" >
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
		<td colspan="3">
			<a href="/product/01414295" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/cz_04.jpg" alt="" width="391" height="270" border="0"></a></td>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2011/20111205sd/cz_05.jpg" width="283" height="270" alt=""></td>
		<td colspan="3">
			<a href="/product/01405797" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/cz_06.jpg" alt="" width="306" height="270" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="/product/01412947" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/cz_07_1.jpg" alt="" width="327" height="280" border="0"></a></td>
		<td colspan="5">
			<img src="http://images.d1.com.cn/zt2011/20111205sd/cz_08_1.jpg" width="364" height="280" alt=""></td>
		<td colspan="2">
			<a href="/product/01409520" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/cz_09_1.jpg" alt="" width="289" height="280" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="/product/01415594" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/cz_10_1.jpg" alt="" width="263" height="355" border="0"></a></td>
		<td colspan="3">
			<a href="/product/01415939" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/cz_11_1.jpg" alt="" width="257" height="355" border="0"></a></td>
		<td colspan="4">
			<a href="/product/01408793" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/cz_12_1.jpg" alt="" width="243" height="355" border="0"></a></td>
		<td>
			<a href="/product/01408492" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/cz_13.jpg" alt="" width="217" height="355" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="9">
			<img src="http://images.d1.com.cn/zt2011/20111205sd/cz_14.jpg" width="980" height="49" alt=""></td>
	</tr>
	<tr>
		<td height="34" colspan="9"><% request.setAttribute("code","7161");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../gdsrcm0306.jsp"   />
		</td>
	</tr>
		<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="263" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="64" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="64" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="129" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="153" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="1" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="17" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="72" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="217" height="1" alt=""></td>
	</tr>
</table>
</div>

<div id="showcn3" class="nonehot">
<table  width="980"  border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<a href="http://www.d1.com.cn/html/brand/brand13.htm" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/mz_04.jpg" alt="" width="327" height="390" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/html/brand/brand21.htm" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/mz_05.jpg" alt="" width="326" height="390" border="0"></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/html/brand/brand18.htm" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/mz_06.jpg" alt="" width="327" height="390" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/html/brand/brand121.htm" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/mz_07.jpg" alt="" width="327" height="380" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/html/brand/brand28.htm" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/mz_08.jpg" alt="" width="326" height="380" border="0"></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/html/brand/brand35.htm" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/mz_09.jpg" alt="" width="327" height="380" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/html/result.asp?productsort=014&productbrand=美宝莲" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/mz_10.jpg" alt="" width="327" height="378" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/html/brand/brand34.htm" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/mz_11.jpg" alt="" width="326" height="378" border="0"></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/html/brand/brand111.htm" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/mz_12.jpg" alt="" width="327" height="378" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/html/result.asp?productsort=014&productname=我的美丽日记" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/mz_13.jpg" alt="" width="327" height="380" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/html/result.asp?productsort=014&productname=相宜本草" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/mz_14.jpg" alt="" width="326" height="380" border="0"></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/html/result.asp?productsort=014&productname=芳草集" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/mz_15.jpg" alt="" width="327" height="380" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/html/result.asp?productsort=014&productname=骨胶原" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/mz_16.jpg" alt="" width="327" height="409" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/html/result.asp?productsort=014&productname=膜法世家" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/mz_17.jpg" alt="" width="326" height="409" border="0"></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/html/result.asp?productsortflag=0&productsort=014001&productname=韩伊" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111205sd/mz_18.jpg" alt="" width="327" height="409" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="327" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="326" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="35" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="292" height="1" alt=""></td>
	</tr>
</table>
</div>

	  </td>
    </tr>

	
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="263" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="64" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="64" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="129" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="153" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="1" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="17" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="72" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111205sd/分隔符.gif" width="217" height="1" alt=""></td>
	</tr>
</table>
</center>
<center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>