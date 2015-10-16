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
    String strsrc=request.getParameter("src");
    String strwid=request.getParameter("wid");
    String strfbt=request.getParameter("fbt");
    String strurl=request.getParameter("url");
    
    Tools.setCookie(response,"d1.com.cn.srcurl",httpurl,(int)(Tools.DAY_MILLIS/1000*10));//10天过期
    Tools.setCookie(response,"YIGAO",strwid+"|"+strfbt,(int)(Tools.DAY_MILLIS/1000*3));//10天过期
    IntfUtil.KillsCookies(response, "YIGAO");
    if (strurl!=null)
    {
        strurl=strurl.replace("*", "&");
    }

    if ("/inf/yigao.jsp".equals(strurl))
    {
    	strurl="http://www.d1.com.cn";
    }
    response.sendRedirect(strurl);
%>