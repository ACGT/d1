<%@ page contentType="text/html; charset=GBK"%><%@include file="/html/headerg.jsp" %>
<%@include file="../public_email.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>
<%
	String id = request.getParameter("id");
	ActIndex act_list = GetActindexList(id);
	if(act_list != null){
		if(act_list.getActindex_name() != null){
			out.print(act_list.getActindex_name());
		}
	}
	String subad = "";
%>
</title>
</head>
<!-- 头部开始 -->
<%@include file="/html/mail_header.jsp"%>
<!-- 头部结束 -->
<center>

<%
String act_id = request.getParameter("id");

act_list = (ActIndex)Tools.getManager(ActIndex.class).get(id);
if(act_list != null && act_list.getActindex_subad() != null){
	subad = act_list.getActindex_subad();
	//System.out.println("22222==="+subad);
}
String content = GetActindexContent(act_id,subad);
if(content != null && content != ""){
	//System.out.println("11111==="+subad);
	out.print(content);
}else{
	//System.out.println("3333==="+subad);
	content = GetMy2013glistnocode(act_id);
	out.print(content);
}
%>

</center>
<%@include file="/html/mail_tail.jsp"%>
</body>
</html>