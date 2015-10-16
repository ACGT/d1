<%@ page contentType="text/html; charset=UTF-8" import="com.todaynic.client.mobile.*"%><%@include file="../../inc/header.jsp" %><%
String telephone="";
String code="";
String param="";
if(request.getParameter("phone")!=null&&request.getParameter("phone").length()>0)
{
    telephone=request.getParameter("phone");	
}
if(request.getParameter("code")!=null&&request.getParameter("code").length()>0)
{
    code=request.getParameter("code");	
}
if(request.getParameter("param")!=null&&request.getParameter("param").length()>0)
{
    param=request.getParameter("param");	
}

if(telephone.length()<=0){
	out.print("{\"success\":false,\"message\":\"该手机号不正确！\"}");
	return;
}
if(code!=null&&code.length()>0&&!Tools.isNumber(code))
{
	out.print("{\"success\":false,\"message\":\"手机验证码格式不正确！\"}");
	return;
	}
else
{
	if(param.equals("code"))
	{
		PhoneCode pd=PhoneCodeHelper.getPhoneCodeByTele(telephone);
		if(pd!=null)
		{
			if(!pd.getPhonecode_code().equals(code))
			{
				out.print("{\"success\":false,\"message\":\"手机验证码输入错误！\"}");
				return;
			}
			else
			{
				out.print("{\"success\":true,\"message\":\"验证成功！\"}");
				return;
			}
			
		}
		else
		{
			out.print("{\"success\":false,\"message\":\"该手机号没有获取验证码！\"}");
			return;
		}
	}
	if(param.equals("phone")){
		String phone = request.getParameter("phone");
		if(phone!= null){
			if(Tools.isMobile(phone)){
				User user = UserHelper.getByUsername(phone);
				if(user == null){
					out.print("{\"success\":false,\"message\":\"该手机号还没有注册为会员，请重新输入!\"}");
				    return;
				}
				else
				{
					out.print("{\"success\":true,\"message\":\"验证成功！\"}");
					return;
				}
			}
		}
		
	}
	
   
   
   
   
}


%>