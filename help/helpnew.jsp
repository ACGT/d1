<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <%
  String code="";
  if(request.getParameter("code")!=null){
	  code= request.getParameter("code");
	  if(code.trim().length()==0){
		  code="0101";
	  }
	  if(code.trim().equals("0401")){
		  response.sendRedirect("http://www.d1.com.cn/mem.jsp");
	  }
	  if(!Tools.isMath(code)){
		  out.print("你的数据不合法！");
	  }
	  else{
		  String titlestr="";
			for (int i=1 ; i<=code.length()/2;i++){
				HelpCode helpCode=HelpCodeHelper.getHelpThemeByCode(code.substring(0,i*2));
				
				titlestr+=helpCode.getHelpcode_name();
				}%>
<head>
<title><%=Tools.clearHTML(titlestr) %> - D1优尚网帮助中心</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/help.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
</head>
<body>
<%@include file="/inc/head.jsp"%>
<center>
<div class="center1">
  <%@include file="menunew.jsp"%>

		 <div class="right2">
	        <div class="right2_top">
			<span ><a href="http://help.d1.com.cn"><img src="http://images.d1.com.cn/images2012/New/help/9.jpg" align="top" /></a></span>
			<%
			for (int i=1 ; i<=code.length()/2;i++){
				HelpCode helpCode=HelpCodeHelper.getHelpThemeByCode(code.substring(0,i*2));
				
						%>
				
				<span><img src="http://images.d1.com.cn/images2012/New/help/10.jpg" align="top" /></span>
				<span><a href="http://help.d1.com.cn/hphelpnew.htm?code=<%=helpCode.getId()%>" class="a"><%=helpCode.getHelpcode_name()%></a></span>
				<%}%>

	
			  </div>
			 <%
			  ArrayList<HelpCode> list2=HelpCodeHelper.getHelpObject(code);
				if(list2!=null){
					for(HelpCode helpCode2:list2){%>
						 <div class="right2_head"><%=helpCode2.getHelpcode_name()%></div>
						 
					<%
					ArrayList<HelpContent> helpContentList=HelpContentHelper.getHelpContentByCode(helpCode2.getId());
					 if(helpContentList!=null){
						 for(HelpContent helpContent:helpContentList){
							
							 %>
				<div class="neirong1">
		         <div class="neirong1_head"><%=helpContent.getHlepmst_title()%></div>
				 <div class="neirong1_neirong"><%=helpContent.getHelpmst_text().replace("\n","<br/>")%></div>
		 		 </div>
						<% }
					 }
					}
				}
	%>
	     
		
		
		 
					
	</div>

	   <%}
  }
   
  %>
  
</div>
</center>
<div style="clear:both;"></div>
<center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>
