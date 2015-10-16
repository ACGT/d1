<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp"%>
<%@page import="
com.d1.bean.ProductExpPrice"%>
<%

String httpurl=request.getHeader("Referer");
if(Tools.isNull(httpurl))httpurl=request.getHeader("referer");
    String straddr=request.getRemoteAddr();
    String strsubad=request.getParameter("id");
    String strurl=request.getParameter("url");
    String strmd=request.getParameter("md");
 
 
    if (strmd==null)
    {
    	strmd=request.getParameter("subad");
    }
     int i=1;
    if (Tools.isNull(strsubad))
    {
    	Tools.outJs(out,"参数出错!","http://www.d1.com.cn");
		return;
    }
    if (strurl!=null)
    {
       strurl=strurl.replace("@", "&");
    }
    int icookieday=3;
    String strpingan=Tools.getCookie(request, "PINGAN");
    if(!"1".equals(strpingan) ||(strsubad.length()>6&& !"pingan".equals(strsubad.substring(0, 6)))  )
    {
    	   if (httpurl!=null && httpurl.indexOf("d1.com.cn")<0)
    	    {
    	    	String strsrcurl=Tools.getCookie(request, "d1.com.cn.srcurl");
    	    	if(Tools.isNull(strsrcurl) || "null".equals(strsrcurl))
    	    	{
    	    	    Tools.setCookie(response,"d1.com.cn.srcurl",httpurl,(int)(Tools.DAY_MILLIS/1000*icookieday));
    	    	}
    	    }
    	   //Tools.setCookie(response,"d1.com.cn.peoplercm","lianmeng_"+strmd,(int)(Tools.DAY_MILLIS/1000*icookieday));
    	    Tools.setCookie(response,"d1.com.cn.peoplercm.subad",strsubad,(int)(Tools.DAY_MILLIS/1000*icookieday));
    	    //session.setAttribute("d1lianmengsubad", strsubad);
    	    
    	    //IntfUtil.KillsCookies(response, "lianmeng");
    	    if(strmd==null){
    	    	strmd="error";
    	    }
    	    if(strurl==null){
    	    	strurl="error";
    	    }
    	    if(!"linktech".equals(strsubad))
    	    {
    	        Lmclk lk = new Lmclk();
    	        lk.setLmclk_createdate(new Date());
    	        lk.setLmclk_uid(strmd);
    	        lk.setLmclk_linkurl(strurl);
    	        lk.setLmclk_from(httpurl);
    	        lk.setLmclk_ip(straddr);
    	        lk.setLmclk_subad(strsubad);
    	        Tools.getManager(Lmclk.class).create(lk);
    	    }
    }
    ProductExpPrice rcmdusr=(ProductExpPrice)Tools.getManager(ProductExpPrice.class).findByProperty("rcmdusr_uid", strsubad);
   // System.out.println("------------------------------"+rcmdusr.getRcmdusr_uid());	
    if(rcmdusr==null 
    	|| System.currentTimeMillis()<rcmdusr.getRcmdusr_startdate().getTime() 
    	|| System.currentTimeMillis()>rcmdusr.getRcmdusr_enddate().getTime()
    	){response.sendRedirect(strurl);return;}
    	Tools.setCookie(response,"rcmdusr_uid",strsubad,(int)(Tools.DAY_MILLIS/1000*icookieday));
 	    Tools.setCookie(response,"rcmdusr_rcmid",rcmdusr.getRcmdusr_rcmid().toString(),(int)(Tools.DAY_MILLIS/1000*icookieday));
 	    rcmdusr.setRcmdusr_count(rcmdusr.getRcmdusr_count()+1);
 	    Tools.getManager(ProductExpPrice.class).update(rcmdusr, false);
  
	response.sendRedirect(strurl);
	

%>