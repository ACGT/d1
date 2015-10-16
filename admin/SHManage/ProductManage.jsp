<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/inc/header.jsp"%><%@include file="/admin/chkshop.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商品管理</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

</head>
<body style="text-align:center;">
<%@include file="/admin/inc/shhead.jsp" %>
<br/>
<br/>
<table style="width:1000px; margin:0px auto;" border="0" cellpadding="0" cellspacing="0">
   <tr><td width="174" style="text-align:center;" valign="top">
     <%@include file="/admin/inc/SHleftPM.jsp" %>
   </td>
   <td width="926" valign="top">
   <iframe id="rightdisplay"  name="rightdisplay" src="" frameborder="0"  width="100%" SCROLLING="no" style="margin:0px; padding:0px;"
   onload="javascript:dyniframesize('rightdisplay')"
   >
   
   </iframe>
   </td>
   </tr>
</table>
</body>
</html>
<script>
function dyniframesize(down) { 
	var pTar = null; 
	if (document.getElementById){ 
	pTar = document.getElementById(down); 
	} 
	else{ 
	eval('pTar = ' + down + ';'); 
	} 
	if (pTar && !window.opera){ 
	//begin resizing iframe 
	pTar.style.display="block" 
	if (pTar.contentDocument && pTar.contentDocument.body.offsetHeight){ 
	//ns6 syntax 
	pTar.height = pTar.contentDocument.body.offsetHeight +20; 
	pTar.width = pTar.contentDocument.body.scrollWidth+20; 
	} 
	else if (pTar.Document && pTar.Document.body.scrollHeight){ 
	//ie5+ syntax 
		pTar.height = pTar.Document.body.scrollHeight; 
		pTar.width = pTar.Document.body.scrollWidth; 
	} 
	} 
	} 
</script>