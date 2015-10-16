<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网帮助中心_D1优尚网优惠券使用说明</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/help.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
</head>
<body  bgcolor="#FFFFFF" text="#000000" topmargin="0">
<!-- 头部开始 -->

<%@include file="/inc/head.jsp"%>

<!-- 头部结束 -->
<center>
<div class="center1">
<%@include file="menunew.jsp"%>

  <div class="rightnew">
  <div class="right1"></div>
	<div class="right3">
	      <div class="rneirong1 neirong">
		      <ul >
			  <%
			  ArrayList<HelpCode> list1=HelpCodeHelper.getHelpObject("01");
				if(list1!=null){
					for(HelpCode helpCode:list1){%>
						  <li class="right2_li"><a href="http://help.d1.com.cn/hphelpnew.htm?code=<%=helpCode.getId()%>"  class="a2"><%=helpCode.getHelpcode_name()%></a></li>
					<%}
				}
	%>
	
			  </ul>
		  </div>
	      <div class="rneirong2 neirong">
		  <ul >
			<%
			  ArrayList<HelpCode> list2=HelpCodeHelper.getHelpObject("02");
				if(list2!=null){
					for(HelpCode helpCode2:list2){%>
						  <li class="right2_li"><a href="http://help.d1.com.cn/hphelpnew.htm?code=<%=helpCode2.getId()%>"  class="a2"><%=helpCode2.getHelpcode_name()%></a></li>
					<%}
				}
	%>
		    </ul>
		  </div>
		  <div class="rneirong3 neirong">
		  <ul >
			<%
			  ArrayList<HelpCode> list3=HelpCodeHelper.getHelpObject("03");
				if(list3!=null){
					for(HelpCode helpCode3:list3){%>
						  <li class="right2_li"><a href="http://help.d1.com.cn/hphelpnew.htm?code=<%=helpCode3.getId()%>"  class="a2"><%=helpCode3.getHelpcode_name()%></a></li>
					<%}
				}
	%>
		    </ul>
		  </div>
		  <div class="rneirong4 neirong">
		  <ul >
			<%
			  ArrayList<HelpCode> list4=HelpCodeHelper.getHelpObject("04");
				if(list4!=null){
					for(HelpCode helpCode4:list4){%>
						  <li class="right2_li"><a href="http://help.d1.com.cn/hphelpnew.htm?code=<%=helpCode4.getId()%>"  class="a2"><%=helpCode4.getHelpcode_name()%></a></li>
					<%}
				}
	%>
		    </ul>
		  </div>
		  <div class="neirong rneirong5 ">
		  <ul >
			<%
			  ArrayList<HelpCode> list5=HelpCodeHelper.getHelpObject("05");
				if(list5!=null){
					for(HelpCode helpCode5:list5){%>
						  <li class="right2_li"><a href="http://help.d1.com.cn/hphelpnew.htm?code=<%=helpCode5.getId()%>"  class="a2"><%=helpCode5.getHelpcode_name()%></a></li>
					<%}
				}
	%>
		    </ul>
		  </div>
		  <div class="rneirong6 neirong">
		  <ul >
			<%
			  ArrayList<HelpCode> list6=HelpCodeHelper.getHelpObject("06");
				if(list6!=null){
					for(HelpCode helpCode6:list6){%>
						  <li class="right2_li"><a href="http://help.d1.com.cn/hphelpnew.htm?code=<%=helpCode6.getId()%>"  class="a2"><%=helpCode6.getHelpcode_name()%></a></li>
					<%}
				}
	%>
		    </ul>
		  </div>
	</div>
</div>
</div>
</center>
<div style="clear:both;"></div>
<center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>