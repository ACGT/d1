<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%
float lastmoney=0f;
String type="3";
if(!Tools.isNull(request.getParameter("lastmoney"))){
	lastmoney=Tools.parseFloat(request.getParameter("lastmoney"));
}
if(!Tools.isNull(request.getParameter("type"))){
	type=request.getParameter("type");
}
%>
<script>
function back(){
	$.close();
}
function hidejaindao(){
	$("#btn1").attr('disabled',true);
	$("#s1").show();
}
</script>

 <div class="form">
<table cellpadding="0" cellspacing="0" >
<tr>
<td height="20px">&nbsp;</td>
</tr>
<tr>
<td valign="middle" align="center" style="font-size:15px;"><span ><%if("1".equals(type)){%>恭喜您已经获得韩国原装进口777美甲套装，再购买</span><span style="color:red;"><%=Tools.getDouble(lastmoney, 2) %></span>元即可获得【FEEL MIND】经典印第安刺绣棒球帽。 <%}else{ %>  <span> 再购买</span><span style="color:red;"><%=Tools.getDouble(lastmoney, 2) %></span> 元即可获得以下赠品。<%} %></td>
</tr>
<tr><td >
<div style=" padding-left:30px;padding-top:20px; float:left; padding-bottom:10px;">
<table cellpadding="0" cellspacing="0" style="border:solid 1px #FAB345; width:600px; line-height:26px;">
<tr style="background:#F4F4F4; font-size:14px; color:#CCCCCC;"><td colspan="2" style="border-bottom:solid 1px #CCCCCC;">商品</td><td style="border-bottom:solid 1px #CCCCCC;">市场价</td></tr>
<%
String pid="01411903";

	Product p=ProductHelper.getById(pid)	;
	float sprice=0;
	if(p!=null){
		sprice=p.getGdsmst_saleprice();
	}
	String imgurl=ProductHelper.getImageTo80(p);
	if("3".equals(type)){
	%>
	
	<tr style="background:#FFFFE5;"><td><a href="/product/<%=pid %>" target="_blank"><img src="<%=imgurl %>" border="0"/></a>
	</td><td>【FEEL MIND】经典印第安刺绣棒球帽（<a href="/product/03200002" target="_blank">红色</a> /<a href="/product/03200001" target="_blank">蓝色</a>）</td>
	
	<td ><%=sprice %></td></tr>
<%}else if("2".equals(type)) {
%>
<tr style="background:#FFFFE5;"><td><a href="/product/<%=pid %>" target="_blank"><img src="<%=imgurl %>" border="0"/></a>
	</td><td><a href="/product/<%=pid %>" target="_blank"><%=StringUtils.getCnSubstring( Tools.clearHTML(p.getGdsmst_gdsname().trim()),0,54)  %></a> </td>
	<td ><%=sprice %></td></tr>
<%}else if("1".equals(type)) {
	Product p2=ProductHelper.getById("03200002")	;
	float sprice2=0;
	if(p2!=null){
		sprice2=p2.getGdsmst_saleprice();
	}
	String imgurl2=ProductHelper.getImageTo80(p2);
	%>
	<tr style="background:#FFFFE5;"><td><a href="/product/<%=pid %>" target="_blank"><img src="<%=imgurl %>" border="0"/></a>
		</td><td><a href="/product/<%=pid %>" target="_blank"><%=StringUtils.getCnSubstring( Tools.clearHTML(p.getGdsmst_gdsname().trim()),0,54) %></a> </td>
		<td ><%=sprice %>&nbsp;&nbsp;&nbsp;&nbsp;<input id="btn1" type="button" attr="5157_0" value="获得" style="width:40px;height:25px;" onclick="addGiftCart(this);hidejaindao();"/> <span id="s1" style="color:red; display:none">已领取</span> </td></tr>
		
		<tr style="background:#FFFFE5;"><td><a href="/product/03200002" target="_blank"><img src="<%=imgurl2 %>" border="0"/></a>
	</td><td>【FEEL MIND】经典印第安刺绣棒球帽（<a href="/product/03200002" target="_blank">红色</a> /<a href="/product/03200001" target="_blank">蓝色</a>）</td>
	
	<td ><%=sprice2 %></td></tr>
	<%} %> 
</table>
</div>

</td></tr>
<tr><td>
<div style=" padding-left:140px;padding-top:20px;  float:left; padding-bottom:30px;"><a href="javascript:back();"><img src="http://images.d1.com.cn/images2012/3.png"  alt="返回购物车" border="0"/></a></div>
<div style="padding-right:140px;padding-top:20px;  float:right;padding-bottom:30px;"><a href="/flowCheck.jsp"><img src="http://images.d1.com.cn/images2012/4.png"  alt="立即结算" border="0"/></a></div>
</td></tr>


</table>
</div>
