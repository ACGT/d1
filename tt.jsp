<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp"%>
<%
String code = "135792468";//条形码内容
%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
+ request.getServerName() + ":" + request.getServerPort()
+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="javascript">
<!--
NS4 = (document.layers) ? 1 : 0;
visble_property_prefix = (NS4) ? "document.layers." : "";
visble_property_suffix = (NS4) ? ".visibility" : ".style.display";
visble_property_true = (NS4) ? "show" : "block";
visble_property_false = (NS4) ? "hide" : "none";
visble_property_printview = visble_property_prefix + "viewpanel" + visble_property_suffix;
function nowprint() {
window.print();
}
function window.onbeforeprint() {
eval_r(visble_property_printview + " = "" + visble_property_false + """);
}
function window.onafterprint() {
eval_r(visble_property_printview + " = "" + visble_property_true + """);
}
//-->
</script>
</head>
<body topmargin="0px" leftmargin="0px" rightmargin="0px"
bottommargin="0px">
<p>
<%
StringBuffer barCode = new StringBuffer();
barCode.append("<img src='");
barCode.append(request.getContextPath());
barCode.append("/CreateBarCode?data=");
barCode.append(code);
barCode
.append("&barType=CODE39&height=200&checkCharacter=n&checkCharacterInText=n'>");
//barCode.append("'>");
out.println(barCode.toString());
%>
<div id="viewpanel" align="center">
<input name="bequery" type="button" value="打  印"
style="cursor:hand;" onclick="nowprint();">
</div>
<div>
<img src="${path}CreateBarCode?data=123456789&barType=CODE39&checkCharacter=n&checkCharacterInText=n"/>
<%=barCode %>
</div>
<img src="${path}CreateBarCode?data=123545&height=50" >
<!--script>nowprint();</script-->
</body>
</html>