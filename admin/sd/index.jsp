<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.bean.*,com.d1.helper.*,java.util.ArrayList"%><%@include file="/admin/chkrgt.jsp"%>

<%
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "checkshoworder");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}

%>
<html>

<head>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>晒单后台</title>

</head>
<%
//session.setAttribute("admin_mng", "ppzhang");
//ArrayList<AdminPower> list= AdminPowerHelper.getAwardByGdsid(session.getAttribute("admin_mng").toString(),"11");
//if(list==null || list.size()==0){
//	out.print("您没有此权限！");
//	return;
//}
 %>
<frameset cols="200,*">
 <frameset rows="60%,*">
 <frame name="left" target="rtop" src="left.jsp">
   <frame name="left2" target="rtop2" src="left2.jsp">
 </frameset>
  
  <frameset rows="51%,*">
    <frame name="rtop" target="rbottom" src="search.jsp">
    <frame name="rbottom" src="up.jsp">
  </frameset>
  <noframes>
  <body>

  <p>此网页使用了框架，但您的浏览器不支持框架。</p>

  </body>
  </noframes>
</frameset>
</html>