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
    	strurl="www.d1.com.cn";
    }
    if(strurl.startsWith("http://www.d1.com.cn/market/1305/wydh"))
    {
    	strurl="http://www.d1.com.cn/market/1305/wydh/";
    }
    if(request.getQueryString()!=null&&request.getQueryString().indexOf("p612nv&url&url=")>=0){
    	strurl=request.getQueryString().substring(request.getQueryString().indexOf("url=")+4);
      }
    
    strid=strid.trim();
    strurl=strurl.trim();
    if(!Tools.isNull(strsubad)){
    	strsubad=strsubad.trim();
    }
    if("p111214jhtj".equals(strsubad)){
    	response.sendRedirect("http://www.d1.com.cn/html/index99.asp?id=p111214jhtj&md=d1_1111&url="+strurl);
    	return;
    }
    
    strurl=strurl.replace("@", "&");
    //strurl=new String(strurl.getBytes(),"GB2312");
    if("mqwyjf1209wy".equals(strsubad))
    {
    	strurl="http://www.d1.com.cn/market/1209/wydhkz/index.jsp";
    }
    if("mqwyjf1210pd".equals(strsubad)&&httpurl!=null&&(httpurl.startsWith("http://club.mail.163.com/jifen/lottery/list.do")
    		||httpurl.startsWith("http://club.mail.163.com/jifen/lottery/detail.do?from=otherBanner&id=4119")))
    {
    	strurl="http://www.d1.com.cn/product/03200048";
    }
    String strpingan=Tools.getCookie(request, "PINGAN");
    if(strsubad!=null&&strsubad.length()>=6&&"pingan".equals(strsubad.substring(0, 6)) || "1".equals(strpingan))
    {
    	response.sendRedirect(strurl);
    	return;
    }
    if (strurl!=null&&strurl.length()>=7&&!"http://".equals(strurl.substring(0,7)))
    {
    	strurl="http://"+strurl;
    }
   
    if ("main".equals(strurl))
    {
    	response.sendRedirect("http://www.d1.com.cn");
    	return;
    }
    if("linktech".equals(strsubad) || "lktdh".equals(strsubad))
    {
    	Tools.setCookie(response, "linktech_lmtype", strsubad, (int)Tools.DAY_MILLIS/1000);
    	response.sendRedirect(strurl);
    	return;
    }
    if (httpurl!=null && !httpurl.startsWith("http://www.d1.com.cn"))
    {
    	String strsrcurl=Tools.getCookie(request, "d1.com.cn.srcurl");
    	if(Tools.isNull(strsrcurl))
    	{
    	    Tools.setCookie(response,"d1.com.cn.srcurl",httpurl,(int)(Tools.DAY_MILLIS/1000*icookieday));
    	}
    }
   // System.out.println("d1gjlsubad:"+strsubad);
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
    
if(!"linktech".equals(strsubad))
{
    Lmclk lk = new Lmclk();
    lk.setLmclk_createdate(new Date());
    lk.setLmclk_uid(strid);
    lk.setLmclk_linkurl(strurl);
    lk.setLmclk_from(httpurl);
    lk.setLmclk_ip(straddr);
    lk.setLmclk_subad(strsubad);
    Tools.getManager(Lmclk.class).create(lk);
}
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
	response.sendRedirect(enstrurl);
	

%>