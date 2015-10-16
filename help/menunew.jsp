<%@ page contentType="text/html; charset=UTF-8"%>
<div class="left1">
    <div class="lefthead1"></div>
	  <%
	  ArrayList<HelpCode> list=HelpCodeHelper.getHelpTheme();
	  if(list!=null){
		  for(HelpCode helpCode:list){
			
			  %>
			  	<div class="list1"><a href="http://help.d1.com.cn/hphelpnew.htm?code=<%=helpCode.getId()%>" class="a1"><%=helpCode.getHelpcode_name()%></a></div>
		<% 
		ArrayList<HelpCode> list2=HelpCodeHelper.getHelpObject(helpCode.getId());
		if(list2!=null){
			 for(int i=0;i<list2.size();i++){
				 HelpCode helpCode2=list2.get(i);
				 if(helpCode2.getId().equals("0401"))
				 {%>
					 <div class="leftneirong" ><a href="http://help.d1.com.cn/hpmem.htm" class="a">会员密码取回</a></div>
		
				 <%}
				 else
				 {
			 %>
			  <div class="leftneirong" ><a href="http://help.d1.com.cn/hphelpnew.htm?code=<%=helpCode2.getId()%>" class="a"><%=helpCode2.getHelpcode_name()%></a></div>
		   <%} %>
		<% if(i==(list2.size()-1)){
			%>
			<div class="leftneirong1"></div>	
		<%}
			 }
		}
		  }
	  }
     %>


</div>