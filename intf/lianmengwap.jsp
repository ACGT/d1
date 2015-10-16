<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp"%>
<%!
public static void setCookie(HttpServletResponse response , String name , String value , int expireTime){
	Cookie userIdCookie = new Cookie(name, value);
	userIdCookie.setPath("/");
	userIdCookie.setDomain("d1.cn");
	userIdCookie.setMaxAge(expireTime);
	response.addCookie(userIdCookie);
}
%>
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
    String strid=request.getParameter("id");
    String strsubad=request.getParameter("subad");
    String strurl=request.getParameter("url");
    int icookieday=3;
   if(strid==null || strsubad==null)
   {
	   out.print("参数信息出错！");
		return;
   }
    if (strid.indexOf("d1_1030")>=0)
    {
    	session.setAttribute("rec8zn_uid", strid);
    }
    if("cps_hq".equals(strid))
    {
    	icookieday=15;
    }
    if(strurl==null)
    {
    	strurl="www.d1.cn";
    }
    
    if(request.getQueryString()!=null&&request.getQueryString().indexOf("p612nv&url&url=")>=0){
    	strurl=request.getQueryString().substring(request.getQueryString().indexOf("url=")+4);
      }
    
    strid=strid.trim();
    strurl=strurl.trim();
    if(!Tools.isNull(strsubad)){
    	strsubad=strsubad.trim();
    }
   
    strurl=strurl.replace("@", "&");
   
    if (httpurl!=null && !httpurl.startsWith("http://www.d1.cn"))
    {
    	String strsrcurl=Tools.getCookie(request, "d1.cn.srcurl");
    	if(Tools.isNull(strsrcurl))
    	{
    		setCookie(response,"d1.cn.srcurl",httpurl,(int)(Tools.DAY_MILLIS/1000*icookieday));
    	}
    }
    if (!"mq1203".equals(strsubad)){
        Tools.setCookie(response,"d1.com.cn.peoplercm","lianmeng_"+strid,(int)(Tools.DAY_MILLIS/1000*icookieday));
          }
        Tools.setCookie(response,"d1.com.cn.peoplercm.subad",strsubad,(int)(Tools.DAY_MILLIS/1000*icookieday));
        session.setAttribute("d1lianmengsubad", strsubad);
        if (!"mq1203".equals(strsubad)){
        	IntfUtil.KillsCookies(response, "lianmeng");
        }
        if ("mqjs1205".equals(strsubad)){
        Tools.setCookie(response,"rcmdusr_rcmid","156",(int)(Tools.DAY_MILLIS/1000*1));
        }
    setCookie(response,"d1.cn.peoplercm.subad",strsubad,(int)(Tools.DAY_MILLIS/1000*icookieday));
   
String enstrurl="";
if(strurl.indexOf("?")>=0){
String[] strurlarr=strurl.split("\\?");
enstrurl=strurlarr[0]+"?";
if(strurl.indexOf("&")>=0){
String[] strurlparm=strurlarr[1].split("\\&");
for(int i=0;i<strurlparm.length;i++){
	String[] parmarr= strurlparm[i].split("\\=");
	if(parmarr[1].getBytes().length == parmarr[1].length()){
		if(i>0){
	         enstrurl+="&";
		}
		 enstrurl+=parmarr[0]+"="+parmarr[1];
	}else{
		if(i>0){
	         enstrurl+="&";
		}
		enstrurl+=parmarr[0]+"="+ java.net.URLEncoder.encode(parmarr[1],"utf-8");
	}
}
}else{
	String[] parmarr= strurlarr[1].split("\\=");
	if(parmarr[1].getBytes().length == parmarr[1].length()){
	         enstrurl+=parmarr[0]+"="+parmarr[1];
	}else{
		enstrurl+=parmarr[0]+"="+ java.net.URLEncoder.encode(parmarr[1],"utf-8");
	}
}
}else{
	enstrurl=strurl;
}
Lmclk lk = new Lmclk();
lk.setLmclk_createdate(new Date());
lk.setLmclk_uid(strid);
lk.setLmclk_linkurl(strurl);
lk.setLmclk_from(httpurl);
lk.setLmclk_ip(straddr);
lk.setLmclk_subad(strsubad);
Tools.getManager(Lmclk.class).create(lk);
response.sendRedirect(enstrurl);
	

%>