<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%><%
String chePingAn = Tools.getCookie(request,"PINGAN");
%><style>
.f_r a{margin:0 0 0 6px;}
</style>
<div id="header" style="width:887px;height: 43px;">
	<p class="user_help">
		<span class="f_r"><a href="/help/" target=_blank>帮助中心</a></span>	
		<span class="ShowWelcome" id="ShowWelcome">&nbsp;</span></p>
    <div class="clear"></div>
</div>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/head.js")%>"></script>