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
    String stra_id=request.getParameter("a_id");
    String strm_id=request.getParameter("m_id");
    String strc_id=request.getParameter("c_id");
    String strl_id=request.getParameter("l_id");
    String strl_type1=request.getParameter("l_type1");
    String strrd=request.getParameter("rd");
    String strurl=request.getParameter("url");
    if(stra_id.equals("A100189845")){
    	return;
    }
    
    if (Tools.isNull(stra_id) || Tools.isNull(strm_id) || Tools.isNull(strc_id) || Tools.isNull(strl_id) || Tools.isNull(strl_type1) || Tools.isNull(strrd) || Tools.isNull(strurl))
    {
    	Tools.outJs(out,"LPMS:不能连接，请咨询网站负责人!","http://www.d1.com.cn");
		return;
    }
    else
    {
    	 Tools.setCookie(response,"d1.com.cn.srcurl",httpurl,(int)(Tools.DAY_MILLIS/1000*3));//3天过期
    	 response.setHeader("P3P", "CP=NOI DEVa TAIa OUR BUS UNI");
    	 Tools.setCookie(response,"LTINFO",stra_id+"|"+strc_id+"|"+strl_id+"|"+strl_type1+"|",(int)(Tools.DAY_MILLIS/1000*3));//3天过期
    	 IntfUtil.KillsCookies(response, "LTINFO");
    	 if(!strurl.startsWith("http://www.d1.com.cn")){
   	      response.sendRedirect("http://www.d1.com.cn");
   	      return;
   	    }else{
    	response.sendRedirect(strurl);
   	    }
   	
    }
    
%>