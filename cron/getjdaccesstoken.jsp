<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp"%>
<%
String code=request.getParameter("code");
String state=request.getParameter("state");
String appkey="3CE1352FB4E8F1F90D215D3F17938D17";
String appsecret="ba4bdb36428c46af8106f47e73f84742";
String redirect_uri="http://www.d1.com.cn/cron/getjdaccesstoken.jsp";
String error=request.getParameter("error");
if(!Tools.isNull(code)){
	String url="https://auth.360buy.com/oauth/token?grant_type=authorization_code&client_id="+appkey+"&redirect_uri="+redirect_uri+"&code="+code+"&state="+state+"&client_secret="+appsecret;
	response.sendRedirect(url);
}else{
	if(!Tools.isNull(error) && "access_denied".equals(error)){
		out.print("用户取消授权");
	}else{
		String url="https://auth.360buy.com/oauth/authorize?response_type=code&client_id="+appkey+"&redirect_uri="+redirect_uri+"&state=d1jd&scope=read";
		response.sendRedirect(url);
	}
	
}

/**
{
  "access_token": "274e9ca8-7534-452b-90d8-45848f8cc732",
  "code": 0,
  "expires_in": 31103999,
  "refresh_token": "6b3a633d-c776-4ba8-931c-71dd7a8fe19a",
  "scope": "read",
  "time": "1357633462952",
  "token_type": "bearer"
}
**/
%>