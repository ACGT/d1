<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>商品兑换-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/thickbox.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/thickbox_plus.js")%>"></script>

<script type="text/javascript">
function CheckForm(){
	var code=$('#gdsdh_code').val();
	var codelen=$.trim(code).length;
	  if (codelen==0){
			$.alert('请填写兑换码!');
	        return;
	    }else{
	    	 $.ajax({
                 type: "post",
                 dataType: "text",
                 contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                 url: "/ajax/html/getTicket_wangyi.jsp",
                 cache: false,
                 data:{
                	 code: code
     		      },error: function(XmlHttpRequest, textStatus, errorThrown){
                   //  $.alert('修改信息失败！');
                 },success: function(msg){
                 	 if(msg==1){
                 		$.alert("该兑换码不存在！");
                 	 }else if(msg==2){
                 		$.alert("该兑换码已经兑换过！"); 
                 	 }
                 	else if(msg==3){
                 		$.alert("该兑换活动已经结束！"); 
                 	 }else if(msg==0){//成功
                 		$("#a1").click();
                 	 }
                 }
                 }
         	)
	    	
	    }
   
   
}

function cancel(){
	$("#gdsdh_code").val('');
}
</script>
<style type="text/css">
<!--
.cardnocs {
	border: 1px solid #CCCCCC;
	height: 36px;
	width: 300px;
	line-height:36px;
	font-size:18px;
}
-->
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<p style="height:20px;">&nbsp;</p>
<table width="70%" cellpadding="0" cellspacing="0" align="center" style="background:#FFF6F7; border:1px solid #FFBDBE;">
<tr>
<td valign="top">
<div style="padding:20px;">
<p style="font-size:26px; font-weight:bold;color:black;text-align:center">请输入兑换码，点击“确定”后将获得150元购物优惠券！</p><br/>
<p align="center"><input type="text" name="gdsdh_code" id=gdsdh_code class="cardnocs" /></p>
<p style="height:30px;">&nbsp;</p>
<p align="center">
<a href="javascript:CheckForm();"  ><img src="http://images.d1.com.cn/market/btnok.jpg" border="0"></img></a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="javascript:cancel();"><img src="http://images.d1.com.cn/market/btncancel.jpg" border="0"></img></a>
<a id="a1" href="163getsucess.html?height=180;width=500" title="兑换优惠券" class="thickbox">&nbsp;</a>
</p>
<p style="height:50px;">&nbsp;</p>
<p align="center" style="font-size:22px; font-weight:bold;color:red;" >150元优惠券分为2张，双重实惠都归您</p>
<p align="center" style="font-size:16px; font-weight:bold;">1、100元全场优惠券，减免购物金额的15%，减完为止。</p>
<p align="center" style="font-size:16px; font-weight:bold;">2、50元服装券，全场购买服装满200即可减免50元。&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
<p style="height:50px;">&nbsp;</p>
</div>
</td>
</tr>
</table>
<div align="center" style=" color:#ff0000; font-size:14px;"></div>
<%@include file="/inc/foot.jsp" %>
</body>
</html>
