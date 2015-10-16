<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网-充值升级为白金</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" language="javascript">
function addCartsjbj()
{
   	$.ajax({
   		type: "get",
		dataType: "json",
		url: '/html/sjbj/sjbjhy.jsp',
		cache: false,
		data: {},
		error: function(XmlHttpRequest){
			alert("加入购物车出错，请稍后重试");
		},success: function(json){
			if(json.success){
				$.alert(json.message+"<a href=\"/flow.jsp\" target=\"_blank\" style=\"border:none; color:#f00;\">去购物车结算</a>");
			}
		},beforeSend: function(){
		},complete: function(){
		}
   	});
}
</script>
<body style="background:#fff;">
<!--头部-->
<%@include file="/inc/head.jsp" %>
<!-- 头部结束-->
<div style="margin:0px auto;width:980px;">
<table id="__01" width="980" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/images2012/index2012/13january/sjbj_01.jpg" width="980" height="228" alt=""></td>
	</tr>
	<tr>
		<td style="background:url('http://images.d1.com.cn/images2012/index2012/13january/sjbj_02.jpg'); width:590px; height:188px;font-size:16px; font-family:'微软雅黑';color:#f00; text-align:center;">
			<%
			if(lUser!=null)
			{
				if(UserHelper.isPtVip(lUser))
				{
					out.print("<br/><br/><br/>您目前是白金会员");
				}
				else if(UserHelper.isVip(lUser))
				{
					out.print("<br/><br/><br/>您目前是VIP会员");
				}
				else
				{
					out.print("<br/><br/><br/>您目前是普通会员");
				
				}
			}
			%>
			
			</td>
		<td>
		<% 
		if(lUser!=null&&UserHelper.isPtVip(lUser))
   {%>
			<a href="http://www.d1.com.cn/html/bjdxlist.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/13january/sjbj_0311.jpg" width="390" height="188" alt="" style="border:none;"/></a>
  <%}
   else
   {
	   %>
  
			<a href="javascript:void(0)" onclick="addCartsjbj()"><img src="http://images.d1.com.cn/images2012/index2012/13january/sjbj_03.jpg" width="390" height="188" alt="" style="border:none;"/></a></td>
	<%} %>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/images2012/index2012/13january/sjbj_041.jpg" width="980" height="162" alt=""></td>
	</tr>
	
</table>

</div>

<div class="clear"></div>
<!-- 尾部 -->
<%@include file="/inc/foot.jsp" %>
<!-- 尾部结束 -->
</div>
</body>
</html>

