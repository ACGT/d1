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
	    		 dataType: "json",
	    			url: 'gettkt.jsp',
	    			cache: false,
                 data:{ code: code },
                 error: function(XmlHttpRequest){
                   //  $.alert('修改信息失败！');
                 },success: function(json){
                 	 if(json.code==1){
                 		$.alert(json.message);
                 	 }else {//成功
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
<p style="font-size:26px; font-weight:bold;color:black;text-align:center">请输入兑换码，点击“确定”后将获得100元服装类优惠券！</p><br/>
<p align="center"><input type="text" name="gdsdh_code" id=gdsdh_code class="cardnocs" /></p>
<p style="height:30px;">&nbsp;</p>
<p align="center">
<a href="javascript:CheckForm();"  ><img src="http://images.d1.com.cn/market/btnok.jpg" border="0"></img></a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="javascript:cancel();"><img src="http://images.d1.com.cn/market/btncancel.jpg" border="0"></img></a>
<a id="a1" href="163getsucess.html?height=240;width=500" title="兑换优惠券" class="thickbox">&nbsp;</a>
</p>
<p style="height:50px; padding-left:100px;">&nbsp;</p>
<div style="padding-left:150px; line-height:30px;">
<p  style="font-size:22px; font-weight:bold;color:red;" >100元服装优惠券使用说明：</p>
<p  style="font-size:14px; font-weight:bold;">1、该优惠券面值为100元，购买服装类商品可以抵扣订单金额的15%（特价商品除外）</p>
<p style="font-size:14px; font-weight:bold;">2、该优惠券可以购买男女服装、男女箱包围巾、男女鞋子。</p>
<p style="font-size:14px; font-weight:bold;">3、本次未消费完的，卡内余额在有效期内下次仍可继续使用。</p>
<p  style="font-size:14px; font-weight:bold;">4、有效截止日期为：2013年2月28日</p>
<p  style="font-size:14px; font-weight:bold;">5、兑换完成可以点击“我的优惠券”查询。</p>
<p  style="font-size:14px; font-weight:bold;">6、<a href="http://help.d1.com.cn/hphelpnew.htm?code=0105" target="_blank">优惠券使用说明>></a></p>
<p style="height:50px;">&nbsp;</p>
</div>

</div>
</td>
</tr>
</table>
<div align="center" style=" color:#ff0000; font-size:14px;"></div>
<%@include file="/inc/foot.jsp" %>
</body>
</html>
