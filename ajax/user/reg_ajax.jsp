<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp"%><%
String act = request.getParameter("act");
if("is_email".equals(act)){//检查Email
	String email = request.getParameter("email");
	if(email!= null && email.length()<64){
		if(Tools.isEmail(email)){
			User user = UserHelper.getByUsername(email);
			if(user == null){
				out.print("true");
				return;
			}
		}
	}
	
	out.print("false");
}else if("is_code".equals(act)){//检查验证码
	String code = request.getParameter("code");
	if(!Tools.isNull(code) && code.length() == 4){
		String vImageCode = (String)session.getAttribute("USER_IMAGE_CHECK_CODE");
		if(code.equals(vImageCode)){
			out.print("true");
			return;
		}
	}
	out.print("false");
}
%>