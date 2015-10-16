<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<%

if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "indexclick");
	   if(aplist==null||aplist.size()<=0){
		  out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>首页访问量</title>
	<frameset cols="250,*" >
	  <frame name="left" src="/admin/HitLog/index.jsp" noresize>
	  <frame name="right" src="/admin/HitLog/getdata.jsp" >
	  <!--<frame name="right" src="sprckblank.asp">-->
	  </frameset>
	  <noframes>
	  <body>
 
	  <p>此网页使用了框架，但您的浏览器不支持框架。</p>
 
	  </body>
	  </noframes>
	</frameset>
</html>