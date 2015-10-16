<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%

String httpurl=request.getHeader("Referer");
if(Tools.isNull(httpurl))httpurl=request.getHeader("referer");
if (!Tools.isNull(httpurl)){
	try{
	       httpurl =java.net.URLDecoder.decode(httpurl,"UTF-8");
   }
   catch(Exception ex){
 	 // ex.printStackTrace();
	   response.sendRedirect("http://m.d1.cn");
   }
}
    String strwi=request.getParameter("wi");
    String strurl=request.getParameter("url");
    String strchannel=request.getParameter("channel");
    String strsrc=request.getParameter("src");
    String strcid=request.getParameter("cid");


    IntfUtil.setCookieWap(response,"d1.com.cn.srcurl",httpurl,(int)(Tools.DAY_MILLIS/1000*10));//10天过期
    IntfUtil.setCookieWap(response,"WapEQIFA",strsrc+"|"+strchannel+"|"+strcid+"|"+strwi,(int)(Tools.DAY_MILLIS/1000*10));//10天过期
    IntfUtil.KillsCookiesWap(response, "WapEQIFA");
    if (strurl!=null)
    {
        strurl=strurl.replace("*", "&");
    }
    if(!strurl.startsWith("http://m.d1.cn")){
      response.sendRedirect("http://m.d1.cn");
      return;
    }else{
    response.sendRedirect(strurl);
    return;
    }
%>