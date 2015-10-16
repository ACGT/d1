<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>化妆品疯狂购-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/gdsscene.css")%>" rel="stylesheet" type="text/css" media="screen" />
<style type="text/css">
.newlist {width:980px;overflow:hidden; margin:0px auto; background-color:#f0f0f0; }
.newlist ul {width:980px;padding:0 0 0px; padding-left:4px;  padding-top:15px; padding-bottom:5px;}
.newlist li {float:left; margin-right:4px;overflow:hidden; width:240px; overflow:hidden; margin-bottom:5px;  }
.newlist p {text-align:left; }
.retime a{text-decoration:none; }
.lf{ padding-top:7px; background-color:#f0f0f0; over-flow:hidden; }

</style>
<script type="text/javascript">
function incart(obj){
	$.alert("该活动已结束");
	 //$.inCart(obj,{ajaxUrl:'Incart.jsp',width:450,align:'center'});
}
</script>

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<%
String start="2013-01-16";
java.text.DateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd");
long n1 = df.parse(start).getTime();
long n2 = df.parse(df.format(new Date())).getTime();
long diff = Math.abs(n2 - n1);

diff /= 3600 * 1000 * 24;
if(diff<=0){
	diff=1;
}

%>
<table id="__01" width="981" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="16">
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_01.jpg" alt="" name="hzp0116_01" width="980" height="358" border="0" usemap="#hzp0116_01Map" id="hzp0116_01" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="1" height="358" alt="" /></td>
	</tr>
	<tr>
		<td colspan="16">
		<a name="a1" id="a1"></a>
			<img id="hzp0116_02" src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_02.jpg" width="980" height="84" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="1" height="84" alt="" /></td>
	</tr>
	<tr>
		<td colspan="3" rowspan="3"><a href="http://www.d1.com.cn/product/01407682" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_03.jpg" alt="" width="211" height="386" border="0" id="hzp0116_03" /></a></td>
		<td colspan="2" rowspan="2"><a href="http://www.d1.com.cn/product/01407682" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_04.jpg" alt="" width="102" height="300" border="0" id="hzp0116_04" /></a></td>
		<td colspan="3"><a href="http://www.d1.com.cn/product/01407682" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_05.jpg" alt="" width="181" height="204" border="0" id="hzp0116_05" /></a></td>
		<td colspan="3" rowspan="3"><a href="http://www.d1.com.cn/product/01414912" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_06.jpg" alt="" width="212" height="386" border="0" id="hzp0116_06" /></a></td>
		<td colspan="3" rowspan="2"><a href="http://www.d1.com.cn/product/01414912" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_07.jpg" alt="" width="121" height="300" border="0" id="hzp0116_07" /></a></td>
		<td colspan="2"><a href="http://www.d1.com.cn/product/01414912" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_08.jpg" alt="" width="153" height="204" border="0" id="hzp0116_08" /></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="1" height="204" alt="" /></td>
	</tr>
	<tr>
		<td colspan="2" style="background:url('http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_09.jpg') no-repeat; color:#FFFFFF; "  valign="top" align="left"> 
		<div style="font-size:42pt; font-weight:bold; padding-left:10px; height:65px; ">
		<div style=" margin-top:-8px;">
		<%=30+diff-1 %>
		</div>
		</div>	</td>
		<td>
			<img id="hzp0116_10" src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_10.jpg" width="98" height="96" alt="" /></td>
		<td style="background:url('http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_11.jpg') no-repeat; color:#FFFFFF; "  valign="top" align="left"> <div style="font-size:42pt; font-weight:bold; padding-left:9px; padding-top:0px; "><div style=" margin-top:-8px;">
		<%=45+diff-1 %>
		</div></div>		</td>
		<td>
			<img id="hzp0116_12" src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_12.jpg" width="72" height="96" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="1" height="96" alt="" /></td>
	</tr>
	<tr>
		<td colspan="5"><a   href="###" attr="01407682" onclick="incart(this)" ><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_13.jpg" alt="" width="283" height="86" border="0" id="hzp0116_13" /></a></td>
		<td colspan="5"><a href="###" attr="01414912" onclick="incart(this)"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_14.jpg" alt="" name="hzp0116_14" width="274" height="86" border="0" id="hzp0116_14" /></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="1" height="86" alt="" /></td>
	</tr>
	<tr>
		<td rowspan="5"><a href="http://www.d1.com.cn/product/01410269" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_15.jpg" alt="" width="116" height="313" border="0" id="hzp0116_15" /></a></td>
		<td colspan="3"><a href="http://www.d1.com.cn/product/01410269" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_16.jpg" alt="" width="136" height="241" border="0" id="hzp0116_16" /></a></td>
		<td colspan="2" rowspan="5"><a href="http://www.d1.com.cn/product/01416566" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_17.jpg" alt="" width="120" height="313" border="0" id="hzp0116_17" /></a></td>
		<td colspan="2"><a href="http://www.d1.com.cn/product/01416566" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_18.jpg" alt="" width="122" height="241" border="0" id="hzp0116_18" /></a></td>
		<td rowspan="5"><a href="http://www.d1.com.cn/product/01417246" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_19.jpg" alt="" width="97" height="313" border="0" id="hzp0116_19" /></a></td>
		<td colspan="3"><a href="http://www.d1.com.cn/product/01417246" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_20.jpg" alt="" width="139" height="241" border="0" id="hzp0116_20" /></a></td>
		<td rowspan="5"><a href="http://www.d1.com.cn/product/01406371" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_21.jpg" alt="" width="89" height="313" border="0" id="hzp0116_21" /></a></td>
		<td colspan="3" rowspan="2"><a href="http://www.d1.com.cn/product/01406371"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_22.jpg" alt="" width="161" height="244" border="0" id="hzp0116_22" /></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="1" height="241" alt="" /></td>
	</tr>
	<tr>
		<td rowspan="2" style="background:url('http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_23.jpg') no-repeat; color:#FFFFFF; "  valign="top" align="center">
		 <div style="font-size:33px; font-weight:bold; padding-left:2px; padding-top:0px;height:45px; ">
		<div style=" margin-top:-5px;">
		<%=39+diff-1 %>
		</div>
		
		
		</div>		</td>
		<td colspan="2">
			<img id="hzp0116_24" src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_24.jpg" width="50" height="3" alt="" /></td>
		<td colspan="2" rowspan="2" style="background:url('http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_25.jpg') no-repeat; color:#FFFFFF; "  valign="top" align="left"> 
		<div style="font-size:33px; font-weight:bold; padding-left:25px; padding-top:2px; "><div style=" margin-top:-8px;">
		<%=50+diff-1 %>
		</div></div>		</td>
		<td rowspan="2"style="background:url('http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_26.jpg') no-repeat; color:#FFFFFF; "  valign="top" align="center"> 
		<div style="font-size:33px; font-weight:bold; padding-left:2px; padding-top:2px; "><div style=" margin-top:-8px;">
		<%=29+diff-1 %>
		</div></div>		</td>
		<td colspan="2">
			<img id="hzp0116_27" src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_27.jpg" width="51" height="3" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="1" height="3" alt="" /></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="3"><a href="http://www.d1.com.cn/product/01410269" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_28.jpg" alt="" width="50" height="69" border="0" id="hzp0116_28" /></a></td>
		<td colspan="2">
			<img id="hzp0116_29" src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_29.jpg" width="51" height="40" alt="" /></td>
		<td colspan="2" rowspan="2" style="background:url('http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_30.jpg') no-repeat; color:#FFFFFF; "  valign="top" align="center"> 
		<div style="font-size:33px; font-weight:bold; padding-left:2px; padding-top:0px; "><div style=" margin-top:-8px;">
		<%=75+diff-1 %>
		</div></div>		</td>
		<td rowspan="3"><a href="http://www.d1.com.cn/product/01406371" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_31.jpg" alt="" width="72" height="69" border="0" id="hzp0116_31" /></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="1" height="40" alt="" /></td>
	</tr>
	<tr>
		<td rowspan="2"><a href="###" attr="01410269" onclick="incart(this)"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_32.jpg" alt="" width="86" height="29" border="0" id="hzp0116_32" /></a></td>
		<td colspan="2" rowspan="2"><a href="###" attr="01416566" onclick="incart(this)"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_33.jpg" alt="" width="122" height="29" border="0" id="hzp0116_33" /></a></td>
		<td colspan="3" rowspan="2"><a href="###" attr="01417246" onclick="incart(this)"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_34.jpg" alt="" width="139" height="29" border="0" id="hzp0116_34" /></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="1" height="2" alt="" /></td>
	</tr>
	<tr>
		<td colspan="2"><a href="###" attr="01406371" onclick="incart(this)"><img src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_35.jpg" alt="" width="89" height="27" border="0" id="hzp0116_35" /></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="1" height="27" alt="" /></td>
	</tr>
	<tr>
		<td colspan="16"><a name="a2" id="a2"></a>
			<img id="hzp0116_36" src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_36.jpg" width="980" height="60" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="1" height="60" alt="" /></td>
	</tr>
	<tr>
		<td colspan="16"><% request.setAttribute("code","8407");
		request.setAttribute("length","50");%>
        <jsp:include   page= "/html/zt2011/20111104hzp/gdsrcm0305.jsp"   /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="1"  alt="" /></td>
	</tr>

  <tr>
		<td colspan="16"><a name="a3" id="a3"></a>
			<img id="hzp0116_38" src="http://images.d1.com.cn/zt2013/20130116hzp2/hzp0116_38.jpg" width="980" height="60" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="1" height="60" alt="" /></td>
	</tr>
	<tr>
		<td colspan="16"><% request.setAttribute("code","8408");
		request.setAttribute("length","50");%>
        <jsp:include   page= "/html/zt2011/gdsrcm0305.jsp"   /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="1" alt="" /></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="116" height="1" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="86" height="1" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="9" height="1" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="41" height="1" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="61" height="1" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="59" height="1" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="24" height="1" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="98" height="1" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="97" height="1" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="88" height="1" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="27" height="1" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="24" height="1" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="89" height="1" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="8" height="1" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="81" height="1" alt="" /></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130116hzp2/spacer.gif" width="72" height="1" alt="" /></td>
		<td></td>
	</tr>
</table>
<!-- End Save for Web Slices -->

<map name="hzp0116_01Map" id="hzp0116_01Map"><area shape="rect" coords="13,199,325,346" href="#a1" /><area shape="rect" coords="333,201,643,340" href="#a2" /><area shape="rect" coords="655,200,976,336" href="#a3" />
</map></center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>