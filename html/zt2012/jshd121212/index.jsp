<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/jquery-1.3.2.min.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>

<title>金山圣诞迎新年--D1优尚网</title>
<style type="text/css">
.jslist{padding:0px; margin:0px; width:980px; list-style:none; }
.jslist li{ margin-left:15px; _margin-left:13px;  float:left;margin-bottom:10px;}

.jslist1{padding:0px;margin:0px; list-style:none; }
.jslist1 li{float:left;width:490px; height:223px; overflow:hidden;}
.jslist1 li a{ padding:0px;margin:0px;}

.newlist1 {width:980px;overflow:hidden; margin:0px auto; background-color:#FAA83C; }
.newlist1 ul {width:980px;padding:0 0 0px; padding-left:4px;  padding-top:15px; padding-bottom:15px;}
.newlist1 li {float:left; margin-right:4px;overflow:hidden; width:240px; overflow:hidden; margin-bottom:5px;  }
.newlist1 p {text-align:left; }
.retime a{text-decoration:none; }
.lf{ padding-top:7px; background-color:#FAA83C; over-flow:hidden; }
</style>
<script language="javascript">
function getticket(flags){
	$.ajax({
		 type: "POST",
		 dataType: "json",
		 data:{flag:flags},
		 url: "/html/zt2012/jshd121212/getjsticket.jsp",
		 success: function(json) {
			 $.alert(json.message);
		 }
		
		});
}
</script>
</head>

<body>
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->

<div style="width:980px; margin:0px auto;">
<table  width="980" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2">
			<img id="jssdj_01" src="http://images.d1.com.cn/zt2012/jshd121212/jssdj_01.jpg" width="980" height="226" alt="" /></td>
	</tr>
	<tr>
		<td colspan="2">
			<img id="jssdj_02" src="http://images.d1.com.cn/zt2012/jshd121212/jssdj_02.jpg" width="980" height="211" alt="" /></td>
	</tr>
	<tr>
		<td colspan="2">
			<img id="jssdj_03" src="http://images.d1.com.cn/zt2012/jshd121212/jssdj_03.jpg" width="980" height="65" alt="" /></td>
	</tr>
	<tr>
		<td>
			<img id="jssdj_04" src="http://images.d1.com.cn/zt2012/jshd121212/jssdj_04.jpg" width="490" height="1" alt="" /></td>
		<td rowspan="2">
			<a href="javascript:void(0)" onclick="getticket('2')"><img id="jssdj_05" src="http://images.d1.com.cn/zt2012/jshd121212/jssdj_05.jpg" width="490" height="278" alt="" /></a></td>
	</tr>
	<tr>
		<td>
			<a href="javascript:void(0)" onclick="getticket('1')"><img id="jssdj_06" src="http://images.d1.com.cn/zt2012/jshd121212/jssdj_06.jpg" width="490" height="277" alt="" /></a></td>
	</tr>
	<tr>
		<td colspan="2">
			<img id="jssdj_07" src="http://images.d1.com.cn/zt2012/jshd121212/jssdj_07.jpg" width="980" height="76" alt="" /></td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="#FAA83C" >
		<%
		    ArrayList<Promotion> promotionlist=PromotionHelper.getBrandListByCode("3302",20);
		    if(promotionlist!=null&&promotionlist.size()>0)
		    {
		    	out.print("<ul class=\"jslist\">");
		    	for(Promotion p:promotionlist)
		    	{
		    		if(p!=null)
		    		{%>
		    			<li>
		    			    <a href="<%= p.getSplmst_url() %>" target="_blank"><img src="<%= p.getSplmst_picstr() %>" width="226" height="304"/></a>
		    			</li>
		    		<%}
		    	}
		    	out.print("</ul>");
		    }
		
		%>
		
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<img id="jssdj_09" src="http://images.d1.com.cn/zt2012/jshd121212/jssdj_09.jpg" width="980" height="64" alt="" /></td>
	</tr>
	<tr>
	<td colspan="2" bgcolor="#FAA83C" >
		<%
		    ArrayList<Promotion> promotionlist1=PromotionHelper.getBrandListByCode("3303",4);
		    if(promotionlist1!=null&&promotionlist1.size()>0)
		    {
		    	out.print("<ul class=\"jslist1\">");
		    	for(Promotion p1:promotionlist1)
		    	{
		    		if(p1!=null)
		    		{%>
		    			<li>
		    			    <a href="<%= p1.getSplmst_url() %>" target="_blank"><img src="<%= p1.getSplmst_picstr() %>" /></a>
		    			</li>
		    		<%}
		    	}
		    	out.print("</ul>");
		    }
		
		%>
		</td>
    </tr>
	
	<tr>
		<td colspan="2">
			<img id="jssdj_14" src="http://images.d1.com.cn/zt2012/jshd121212/jssdj_14.jpg" width="980" height="65" alt="" /></td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="#FAA83C">
		  	<%
		request.setAttribute("code", "8303");
		%>
		<jsp:include   page= "list.jsp"   />	
		</td>
	</tr>
</table>

</div>



<!-- 尾部开始 -->
<%@include file="/inc/foot.jsp"%>
<!-- 尾部结束 -->
</body>
</html>
