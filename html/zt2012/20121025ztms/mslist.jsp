<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
    int id=1;
    if(request.getParameter("id")!=null&&request.getParameter("id").length()>0&&Tools.isNumber(request.getParameter("id")))
    {
    	id=Tools.parseInt(request.getParameter("id"));
    }
    String code="8172";
    String img="http://images.d1.com.cn/zt2012/20121025ztms/xsq_06.jpg";
    String title="男装";
    if(id==2)
    {
    	code="8173";
    	img="http://images.d1.com.cn/zt2012/20121025ztms/xsq_08.jpg";
    	title="女装";
    }
    else if(id==3)
    {
    	code="8174";
    	img="http://images.d1.com.cn/zt2012/20121025ztms/xsq_10.jpg";
    	title="化妆品";
    }
    else if(id==4)
    {
    	code="8175";
    	img="http://images.d1.com.cn/zt2012/20121025ztms/xsq_12.jpg";
    	title="饰品";
    }
    else{
    	code="8172";
    	img="http://images.d1.com.cn/zt2012/20121025ztms/xsq_06.jpg";
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>72小时<%= title %>限时抢购-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
</head>

<body>
<%@include file="/inc/head.jsp" %>

<table style="width:980px; margin:0px auto;">
   <tr><td><img src="<%= img%>"/></td></tr>
   <tr><td style="background:#ccc;"><% request.setAttribute("code",code);
		request.setAttribute("length","50");%>
        <jsp:include   page= "/html/qc.jsp"   /></td></tr>
      
</table>
<img src="http://images.d1.com.cn/zt2012/20121025ztms/2.jpg" usemap="#Map" style="position:fixed;right:0px; bottom:20px; z-index:100000;margin:0px auto;" />
<map name="Map" id="Map"><area shape="rect" coords="3,2,64,110" href="http://www.d1.com.cn/html/zt2012/20121025ztms/mslist.jsp?id=1" target="_blank"/>
<area shape="rect" coords="1,114,58,212" href="http://www.d1.com.cn/html/zt2012/20121025ztms/mslist.jsp?id=2" target="_blank"/>
<area shape="rect" coords="3,215,59,301" href="http://www.d1.com.cn/html/zt2012/20121025ztms/mslist.jsp?id=3" target="_blank"/>
<area shape="rect" coords="2,306,69,440" href="http://www.d1.com.cn/html/zt2012/20121025ztms/mslist.jsp?id=4" target="_blank"/>
</map>





<%@include file="/inc/foot.jsp" %>
</body>
</html>
