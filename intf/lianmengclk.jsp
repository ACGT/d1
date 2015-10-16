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
    String straddr=request.getRemoteAddr();
    String strid="d1_1111";
    String strsubad=request.getParameter("subad");
    String strurl=request.getParameter("url");
    int icookieday=3;
   if(strid==null || strsubad==null)
   {
	   out.print("参数信息出错！");
		return;
   }
    if(strurl==null)
    {
    	strurl="www.d1.com.cn";
    }
    strid=strid.trim();
    strurl=strurl.trim();
    if(!Tools.isNull(strsubad)){
    	strsubad=strsubad.trim();
    }
     
    strurl=strurl.replace("@", "&");
     if (strurl!=null&&strurl.length()>=7&&!"http://".equals(strurl.substring(0,7)))
    {
    	strurl="http://"+strurl;
    }
   
     Tools.setCookie(response,"d1.com.cn.peoplercm.subad",strsubad,(int)(Tools.DAY_MILLIS/1000*icookieday));

    Lmclk lk = new Lmclk();
    lk.setLmclk_createdate(new Date());
    lk.setLmclk_uid(strid);
    lk.setLmclk_linkurl(strurl);
    lk.setLmclk_from(httpurl);
    lk.setLmclk_ip(straddr);
    lk.setLmclk_subad(strsubad);
    Tools.getManager(Lmclk.class).create(lk);


	response.sendRedirect(strurl);
	

%>