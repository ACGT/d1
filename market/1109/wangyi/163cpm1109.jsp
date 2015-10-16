<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>商品兑换-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">
function CheckForm(obj){
	var code=$('#gdsdh_code').val();
	  if (code == ""){
			$.alert('请填写兑换码!');
	        return;
	    }
    $('#imageField').attr('attr',code);
    $.inCart(obj,{ajaxUrl:'/ajax/flow/wydhInCard.jsp',width:400,align:'center'});
}
</script>
<style type="text/css">
<!--
.cardnocs {
	border: 1px solid #CCCCCC;
	height: 36px;
	width: 240px;
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
<!-- ImageReady Slices (wangyi2012321.psd) -->
<table id="__01" width="980"  border="0" cellpadding="0" cellspacing="0" align="center">
	    <%
	  StringBuilder sb = new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode("2857" , (int)21);
	if(recommendList != null && !recommendList.isEmpty()){
		%>
	<tr>
	  <td colspan="5">
	
	  <table width="980"  border="0" cellpadding="0" cellspacing="0">
	<% int i=0;
		for(Promotion p:recommendList)
		{
			if (i==0 || (float)i/3==(int)i/3){
			sb.append("<tr>");
			}
			sb.append("<td width=\"326\" height=\"230\"><a href=\"")
				.append(p.getSplmst_url().trim()).append("\">")
				.append("<img src=\"").append(p.getSplmst_picstr()==null?"":p.getSplmst_picstr()).append("\"  border=\"0\" />")
				.append("</a></td>");
			i++;
          if ((float)i/3==(int)i/3){
			sb.append("</tr>");
			}
			
  }
		if ((float)i/3!=(int)i/3){
			  for(int k=1;k<=(3-(i%3));k++){
				  sb.append("<td></td>"); 
			  }
			  sb.append("</tr>");
		  }
  out.print(sb.toString());
 
  %>
</table>

</td>
  </tr>
  <%
	
	}
	  %>
	  <tr>
		<td colspan="5">
	  <img src="http://images.d1.com.cn/market/1311/wydhny/maozi_01.jpg" border="0"/>
	  <a href="http://www.d1.com.cn/product/01516824" target="_blank"><img src="http://images.d1.com.cn/market/1311/wydhny/maozi_02.jpg" border="0" /></a>
	  </td></tr>
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/market/1203/wydh//wydh120321_04.jpg" width="980" height="53" alt=""></td>
	</tr>
	<tr>
		<td height="47" colspan="5" background="http://images.d1.com.cn/market/1203/wydh//wydh120321_05.jpg"><table width="100%" height="47" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="35%">&nbsp;</td>
            <td width="28%"><input type="text" name="gdsdh_code" id=gdsdh_code class="cardnocs"></td>
            <td width="37%">&nbsp;</td>
          </tr>
        </table></td>
	</tr>

	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/market/1203/wydh//wydh120321_06.jpg" width="370" height="73" alt=""></td>
		<td>
			<input type="image" name="imageField" id=imageField onclick="CheckForm(this);" src="http://images.d1.com.cn/market/1203/wydh//wydh120321_07.jpg"></td>
		<td colspan="2" background="http://images.d1.com.cn/market/1203/wydh//wydh120321_08.jpg"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="20%">&nbsp;</td>
            <td width="68%"><!-- <a href="/market/1109/wangyi/163getticket.jsp" target="_blank" style=" font-size:12px; color:#000000; text-decoration:underline">对商品不满意?可以更换为全场优惠券&gt;&gt;</a>--></td>
            <td width="12%">&nbsp;</td>
          </tr>
        </table></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1203/wydh/分隔符.gif" width="353" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1203/wydh/分隔符.gif" width="17" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1203/wydh/分隔符.gif" width="194" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1203/wydh/分隔符.gif" width="115" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1203/wydh/分隔符.gif" width="301" height="1" alt=""></td>
	</tr>
</table>
<!-- End ImageReady Slices -->
<div align="center" style=" color:#ff0000; font-size:14px;"></div>
<%@include file="/inc/foot.jsp" %>
</body>
</html>