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
String act=request.getParameter("act");
String key1="sdfiejiewfjjs,@*#^$&";
String key2=request.getParameter("t");
String code=request.getParameter("code");
String usrid=request.getParameter("usrid");
SimpleDateFormat   df2=new   SimpleDateFormat("yyyyMMddHHmmss");  
java.util.Date   nowszf=new   java.util.Date();   
java.util.Date   dates=df2.parse(key2);
int mincount=(int)(nowszf.getTime()/60000-dates.getTime()/60000);
if ("login".equals(act))
{
	//out.println("key1"+key1+"---key2:"+key2+"---usrid"+usrid);
	String code1=MD5.to32MD5(key1+key2+usrid).toUpperCase();
	if(!Tools.isNull(key2) && !Tools.isNull(usrid)){
		String uid=request.getParameter("uid"); 
		//out.println(code1);
		//out.println("code:"+code);
		if(code.equals(code1)&&mincount<=5){
User user=UserHelper.getByUsername(uid.trim());
if(user!=null){
UserHelper.setLoginUserId(session,user.getId());
session.setAttribute("d1kf_userid", usrid);
IntfUtil.KillsCookies(response , "d1_kefu");
response.sendRedirect("http://www.d1.com.cn");
 }
}
}
}


%>
<form method=post>
<input type="text" name="uid" value=""/>
<input type="hidden" name="usrid" value="<%=usrid%>"/>
<input type="hidden" name="act" value="login"/>
<input type="hidden" name="t" value="<%=key2%>"/>
<input type="hidden" name="code" value="<%=code%>"/>
<input type=submit value="µÇÂ½"/>
</form>
<%	
%>
