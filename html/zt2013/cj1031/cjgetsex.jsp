<%@ page contentType="text/html; charset=GBK"%><%@page 
import="com.d1.*,
com.d1.bean.*,
com.d1.manager.*,
com.d1.helper.*,
com.d1.dbcache.core.*,
com.d1.util.*,
com.d1.service.*,
com.d1.search.*,
org.hibernate.criterion.*,
org.hibernate.*,
java.net.URLEncoder,
java.net.URLDecoder,
net.sf.json.JSONObject,
java.util.*,
java.text.*,
java.io.*"%>
<%
out.print("<a href=\"#\" onclick=\"sendhh2();\"><img src=\"http://images.d1.com.cn/zt2013/cj1311/sex.jpg\"  /></a>");
%>
<script type="text/javascript">

function sendhh2(){

    $.ajax({
		type: "get",
		dataType: "json",
		url: '/html/zt2013/cj1031/getsex.jsp',
		cache: false,
		error: function(XmlHttpRequest){
		},success: function(json){	
			//alert(json.code)
			if(parseInt(json.code)==1){
				$.load("提示",480,"myprize.jsp");
			}else{
				$.load("提示",480,"错误！！");
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
</script>