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
String key2=request.getParameter("t");
String code=request.getParameter("code");
String usrid=request.getParameter("usrid");
//System.out.println("��̨�û���"+URLDecoder.decode(request.getParameter("gurl")));
String urlwriter=URLDecoder.decode(request.getParameter("gurl"));
SimpleDateFormat   df2=new   SimpleDateFormat("yyyyMMddHHmmss");  
java.util.Date   nowszf=new   java.util.Date();   
java.util.Date   dates=df2.parse(key2);
int mincount=(int)(nowszf.getTime()/60000-dates.getTime()/60000);

	//System.out.println("request="+request.getQueryString().toString()+"key1"+key1+"---key2:"+key2+"---usrid"+usrid);
	String code1=MD5.to32MD5(key1+key2+usrid).toUpperCase();
           //System.out.println(key2+"-----"+code+"-----"+code1+"-----"+mincount);
		if(!Tools.isNull(key2)&&code.equals(code1)&&mincount<=5){
session.setAttribute("admin_mng", usrid);
urlwriter=urlwriter.replace("@","&");
response.sendRedirect(urlwriter);
}else{
			response.sendRedirect("http://www.d1.com.cn");
		
		}


%>
