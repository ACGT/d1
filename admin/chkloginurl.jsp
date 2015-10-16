<%@ page contentType="text/html; charset=gb2312"%>
<%@page 
import="com.d1.*,
com.d1.bean.*,
com.d1.manager.*,
com.d1.helper.*,
com.d1.dbcache.core.*,
com.d1.util.*,
com.d1.service.*,
com.d1.search.*,
org.hibernate.criterion.*,
org.hibernate.*,
java.net.URLEncoder,
java.net.URLDecoder,
net.sf.json.JSONObject,
java.util.*,
java.text.*,
java.io.*"%><%
	String key1="sdfiejiewfjjs,*#^$&";
	String key2=request.getParameter("t");//时间
	//String key2 = "20131126180925";
	String code=request.getParameter("code");//加密串，防止盗链
	String usrid=request.getParameter("usrid");//用户id
	String shop_code=request.getParameter("shop_code");//商户编号
	//System.out.println("后台用户："+URLDecoder.decode(request.getParameter("gurl")));
	String urlwriter=URLDecoder.decode(request.getParameter("gurl"));
	SimpleDateFormat df2 = new SimpleDateFormat("yyyyMMddHHmmss");  
	java.util.Date nowszf = new java.util.Date();   
	java.util.Date dates = df2.parse(key2);
	int mincount = (int)(nowszf.getTime()/60000-dates.getTime()/60000);
	//System.out.println("====code:"+code);
	String code1=MD5.to32MD5(key1+key2+usrid).toUpperCase();
	//System.out.println("====code1:"+code1+"-----"+mincount);
	if(!Tools.isNull(key2)&&code.equals(code1)&&mincount<=5){
		session.setAttribute("admin_mng", usrid);
		session.setAttribute("shopadmin","shop"+shop_code);//用于shhead.jsp页面判断是否登录
		session.setAttribute("shopcodelog",shop_code);
		session.setAttribute("unique_code",usrid+shop_code);//在操作数据时，作为查询依据
		session.setAttribute("type_flag", 1);//区分是否是商户登陆  值为1代表由后台进入商户后台
		urlwriter=urlwriter.replace("@","&");
		
		response.sendRedirect(urlwriter);
	}else{
		response.sendRedirect("http://www.d1.com.cn");
			
	}


%>
