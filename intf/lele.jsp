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
    String strunionId=request.getParameter("unionId");
    String strsubUnionId=request.getParameter("subUnionId");
    
    Tools.setCookie(response,"d1.com.cn.srcurl",httpurl,(int)(Tools.DAY_MILLIS/1000*3));//3天过期
    Tools.setCookie(response,"LELE",strunionId,(int)(Tools.DAY_MILLIS/1000*3));//3天过期
    Tools.setCookie(response,"LELE_S",strsubUnionId,(int)(Tools.DAY_MILLIS/1000*3));//3天过期

    IntfUtil.KillsCookies(response, "LELE");

    String strturl="http://www.d1.com.cn";

    response.sendRedirect(strturl);
%>