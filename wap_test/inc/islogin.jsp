<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.util.Tools,com.d1.helper.UserHelper,java.net.URLEncoder"%>
<%
if(UserHelper.getLoginUser(request,response) == null){
	String urlwriter = Tools.addOrUpdateParameter(request,null,null);
	if(urlwriter==null) urlwriter = URLEncoder.encode("/mindex.jsp","UTF-8");
	else{
		if(urlwriter.endsWith("?")){
			urlwriter = urlwriter.substring(0,urlwriter.length()-1);
		}
		
		if(urlwriter.indexOf("/wap/f_succ.jsp?")>=0&&urlwriter.substring(0,16).equals("/wap/f_succ.jsp?"))
		{
			String newstr="";
			newstr=urlwriter.substring(19,urlwriter.length());
			newstr="/wap/goods.jsp?productid="+newstr;
			urlwriter=URLEncoder.encode(newstr,"UTF-8");
			
		}
		else
		{
		urlwriter=URLEncoder.encode(urlwriter,"UTF-8");
		}
	}
	response.sendRedirect("/wap/login.jsp?url="+urlwriter);
	return;
}
%>