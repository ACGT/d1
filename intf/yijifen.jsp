<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%
if((!Tools.isNull( request.getParameter("source"))) && (!Tools.isNull( request.getParameter("thkey")))){
	 StringBuffer httpurl = request.getRequestURL();
	 String strurl="";
	    Tools.setCookie(response,"d1.com.cn.srcurl",httpurl.toString(),(int)(Tools.DAY_MILLIS/1000*3));//3天过期
	    Tools.setCookie(response,"yijifen",request.getParameter("source")+"|"+request.getParameter("thkey"),(int)(Tools.DAY_MILLIS/1000*3));//3天过期
	    IntfUtil.KillsCookies(response, "yijifen");
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
