<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%><%@include file="/admin/chkrgt.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head2012.css")%>" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript">
function search(){
	 var start_time = $('#start_time').val();
	 var end_time = $('#end_time').val();
	 var orderstatus = $('#orderstatus').val();
	// var isticket = $('#isticket').val();
	 var url = "ydyhorder.jsp?start_time="+encodeURIComponent($('#start_time').val())+"&end_time="+encodeURIComponent($('#end_time').val())+"&orderstatus="+encodeURIComponent($('#orderstatus').val());
	    top.location.href=url;
}
</script>
<style type="text/css">
td{
border-bottom:solid 1px #999999;
border-left:solid 1px #999999;
line-height:26px;
}
</style>
</head>
<body>

<%
String start_time="";String end_time="";String orderstatus="";String isticket="";
if(!Tools.isNull(request.getParameter("start_time"))){
	start_time=request.getParameter("start_time");
}
if(!Tools.isNull(request.getParameter("end_time"))){
	end_time=request.getParameter("end_time");
}
if(!Tools.isNull(request.getParameter("orderstatus"))){
	orderstatus=request.getParameter("orderstatus");
}
if(!Tools.isNull(request.getParameter("isticket"))){
	isticket=request.getParameter("isticket");
}
%>
<table width="200px">
<tr><td colspan="2" style="color:red;">格式为：yyyy-MM-dd HH:mm:ss  如：2012-5-31 12:10:11
或yyyyMMdd  如：20120531</td></tr>
<tr><td style="border-top:solid 1px #999999;">订单时间:</td><td style="border-top:solid 1px #999999;"><input type="text" name="start_time" id="start_time" value="<%=start_time%>"/></td></tr>
<tr><td>至</td><td><input type="text" name="end_time" id="end_time" value="<%=end_time%>"/></td></tr>
<tr><td>订单状态</td><td><select name="orderstatus" id="orderstatus">
<option value="">==请选择==</option>
<option value="1" <%if("1".equals(orderstatus)){ %>selected="selected"<%} %>>正式</option>
<option value="0" <%if("0".equals(orderstatus)){ %>selected="selected"<%} %>>非正式</option>

</select></td></tr>

<tr><td colspan="2" align="center"> <input type="button" onclick="search()" value="搜 索"/></td></tr>
</table>
</body>
</html>