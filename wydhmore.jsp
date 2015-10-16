<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%
BufferedReader br = new BufferedReader(new InputStreamReader((ServletInputStream)request.getInputStream(),"UTF-8"));  
String line = null;  
StringBuilder sb = new StringBuilder();  
while((line = br.readLine())!=null){  
    sb.append(line);  
}  
System.out.println("收到信息：：：：：：：：："+sb.toString());
String odrid=request.getParameter("odrid");
if(odrid.equals(sb.toString())){
	response.sendRedirect("http://www.d1.com.cn");
}

%>
