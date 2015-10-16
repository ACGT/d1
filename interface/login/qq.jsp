<%@ page contentType="text/html; charset=UTF-8" import="com.qq.connect.*,com.qq.util.*" %><%@include file="../../inc/header.jsp"%><%
RequestToken requesttoken = new RequestToken();

String request_token = requesttoken.getRequestToken();
String httpurl=request.getHeader("Referer");
if(Tools.isNull(httpurl))httpurl=request.getHeader("referer");
//System.out.println("d1gjlQQ:"+httpurl);
if(!Tools.isNull(request.getParameter("referurl"))){
httpurl=request.getParameter("referurl");
}
if(!Tools.isNull(httpurl)&&(httpurl.startsWith("http://www.d1.com.cn")||httpurl.startsWith("http://m.d1.com.cn"))){
session.setAttribute("QQReferer",httpurl);
}
if(!Tools.isNull(request_token)){
	Map<String, String> tokens = ParseString.parseTokenString(request_token);
	if(tokens != null){
		String oauth_token_secret = tokens.get("oauth_token_secret");
		HttpSession sessionh = request.getSession();
		sessionh.setAttribute("resToken",oauth_token_secret);
		
		RedirectToken redirecttoken = new RedirectToken();
		String gourl=redirecttoken.getRedirectURL(tokens);
		if(httpurl.startsWith("http://m.d1.com.cn")){
			gourl=gourl.replace("www.d1.com.cn", "m.d1.com.cn");
		}
		if(httpurl.startsWith("http://m.d1.cn")){
			gourl=gourl.replace("www.d1.com.cn", "m.d1.cn");
		}
		response.sendRedirect(gourl);	
	}else{
		out.print("出错了!");
	}
}else{
	out.print("出错了!");
}
%>