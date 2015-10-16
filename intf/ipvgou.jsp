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
    String strsource=request.getParameter("source");
    String strunionParams=request.getParameter("unionParams");
    String strurl=request.getParameter("url");
    
    Tools.setCookie(response,"d1.com.cn.srcurl",httpurl,(int)(Tools.DAY_MILLIS/1000*3));//3天过期
    Tools.setCookie(response,"IPVGOU",strsource+"||"+strunionParams,(int)(Tools.DAY_MILLIS/1000*3));//3天过期
    IntfUtil.KillsCookies(response, "IPVGOU");
    if(!Tools.isNull(strurl))
    {
    strurl=strurl.replace("*", "&");
    }
    if ("/inf/ipvgou.jsp".equals(strurl))
    {
    	strurl="http://www.d1.com.cn";
    	  response.sendRedirect(strurl);
    	  return;
    }
   if ("http://".equals(strurl.substring(0,7)))
    {
    	strurl="http://"+strurl;
    }
   response.sendRedirect(strurl);

   
%>