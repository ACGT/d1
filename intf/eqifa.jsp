<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp"%>
<%

String httpurl=request.getHeader("Referer");
if(Tools.isNull(httpurl))httpurl=request.getHeader("referer");
if(!Tools.isNull(httpurl)&&httpurl.indexOf("178mp.com")>=0){
response.sendRedirect("http://www.d1.com.cn");
}
else{
if (!Tools.isNull(httpurl)){
	try{
	       httpurl =java.net.URLDecoder.decode(httpurl,"UTF-8");
   }
   catch(Exception ex){
 	 // ex.printStackTrace();
	   response.sendRedirect("http://www.d1.com.cn");
   }
}
    String strwebsite_id=request.getParameter("website_id");
    String strurl=request.getParameter("url");
    String strsrc=request.getParameter("src");
   // if(strwebsite_id.startsWith("734096|")||strwebsite_id.startsWith("738207|")||strwebsite_id.startsWith("104566|")){
    //	 response.sendRedirect("http://www.d1.com.cn");
    //	return;
   // }
    if(strwebsite_id.startsWith("739491|")||strwebsite_id.startsWith("427571|")||strwebsite_id.startsWith("736988|")||
    		strwebsite_id.startsWith("104566|")||strwebsite_id.startsWith("741915|")){
    	return;
    }
    
    if (httpurl!=null&&httpurl.indexOf("http://shop.etao.com")>=0&&
    		strwebsite_id!=null&&strwebsite_id.startsWith("408293|")){
    	Tools.setCookie(response,"rcmdusr_rcmid","193",(int)(Tools.DAY_MILLIS/1000*1));
    }
    
    Tools.setCookie(response,"d1.com.cn.srcurl",httpurl,(int)(Tools.DAY_MILLIS/1000*10));//10天过期
    Tools.setCookie(response,"EQIFA",strwebsite_id,(int)(Tools.DAY_MILLIS/1000*10));//10天过期
    Tools.setCookie(response,"EQIFAsrc",strsrc,(int)(Tools.DAY_MILLIS/1000*10));//10天过期
    IntfUtil.KillsCookies(response, "EQIFA");
    if (strurl!=null)
    {
        strurl=strurl.replace("*", "&");
    }
    if ("/inf/eqifa.jsp".equals(strurl))
    {
    	strurl="http://www.d1.com.cn";
    }
    if(!strurl.startsWith("http://www.d1.com.cn")){
      response.sendRedirect("http://www.d1.com.cn");
      return;
    }else{
    response.sendRedirect(strurl);
    return;
    }
    }
%>