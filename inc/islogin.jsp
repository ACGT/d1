<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.Tools,com.d1.helper.UserHelper,java.net.URLEncoder"%><%
if(UserHelper.getLoginUser(request,response) == null){
	String urlwriter = Tools.addOrUpdateParameter(request,null,null);
	if(urlwriter==null) urlwriter = URLEncoder.encode("/index.jsp","UTF-8");
	else{
		if(urlwriter.endsWith("?")){
			urlwriter = urlwriter.substring(0,urlwriter.length()-1);
		}
		urlwriter=URLEncoder.encode(urlwriter,"UTF-8");
	}
	response.sendRedirect("/login.jsp?url="+urlwriter);
	return;
}
%>