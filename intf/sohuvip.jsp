<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp"%>
<%

String httpurl=request.getHeader("Referer");
if(Tools.isNull(httpurl))httpurl=request.getHeader("referer");
if (!Tools.isNull(httpurl)){
	try{
	       httpurl =java.net.URLDecoder.decode(httpurl,"UTF-8");
   }
   catch(Exception ex){
 	  ex.printStackTrace();
   }
}
    String struserid=request.getParameter("userid");
    String strcode=request.getParameter("code");
    String strurl=request.getParameter("urld1");
    String strsohukey="viP%D1@#*sohu";
    if (struserid!=null)
    {
    if (struserid.indexOf("@vip.sohu.com")>=0)
    {
    	if (MD5.to32MD5(struserid+strsohukey).equals(strcode))
    	{
    		Tools.setCookie(response,"d1.com.cn.srcurl",httpurl,(int)(Tools.DAY_MILLIS/1000*3));//3天过期
    	    Tools.setCookie(response,"SOHUVIP","SohuVip|"+struserid,(int)(Tools.DAY_MILLIS/1000*3));//3天过期
    	    IntfUtil.KillsCookies(response, "SOHUVIP");
    	    strurl=strurl.replace("*", "&");
    	    if ("/inf/sohuvip.jsp".equals(strurl))
    	    {
    	    	strurl="http://www.d1.com.cn";
    	    }
    	   response.sendRedirect(strurl);
    	   return;
    	}
    }
    }
    response.sendRedirect("http://www.d1.com.cn");
    
   
%>