<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<%@include file="/admin/public.jsp"%>
<%

if(session.getAttribute("type_flag")!=null){
	//out.print("1111111111111111111");
	String userid = "";
	if(session.getAttribute("admin_mng") != null){
		userid = session.getAttribute("admin_mng").toString();
	}
	String powername = "d1odr_send";
	boolean is_power = chk_admpower(userid,powername);
	if(!is_power){
		out.print("对不起，您没有操作权限！");
		return;	
	}
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>订单管理</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/DatePicker/WdatePicker.js")%>"></script>
</head>
<body style="text-align:center;" style="overflow-x: hidden">
<%@include file="/admin/inc/shhead.jsp" %>
<br/>
<br/>
<table style="width:1000px; margin:0px auto;" border="0" cellpadding="0" cellspacing="0">
   <tr><td width="174" style="text-align:center;" valign="top">
     <%@include file="left.jsp" %>
   </td>
   <td width="826" valign="top">
   <iframe id="rightdisplay" src="odrlist.jsp?gg=1&req_odrstatus=2&act=list" height="600" frameborder="0" marginheight="0" marginwidth="0" frameborder="0" scrolling="auto"  width="100%">
</iframe> 
   </td>
   </tr>
</table>
</body>
</html>