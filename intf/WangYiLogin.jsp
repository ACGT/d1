<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
if((!Tools.isNull( request.getParameter("unionId"))) && (!Tools.isNull( request.getParameter("userId")))){
	 StringBuffer httpurl = request.getRequestURL();
	 String strurl="";
	    Tools.setCookie(response,"d1.com.cn.srcurl",httpurl.toString(),(int)(Tools.DAY_MILLIS/1000*3));//3天过期
	    Tools.setCookie(response,"wangyi",request.getParameter("unionId")+"|"+request.getParameter("userId"),(int)(Tools.DAY_MILLIS/1000*3));//3天过期
	    IntfUtil.KillsCookies(response, "wangyi");
	    if(!Tools.isNull( request.getParameter("url")))
	    {
	        strurl=URLDecoder.decode(request.getParameter("url"));
	    }
	    if (strurl.indexOf("http")>=0)
	    {
	    	response.sendRedirect(strurl);
	    }else{
	    	 response.sendRedirect("http://www.d1.com.cn");
	    }
	   
}

%>