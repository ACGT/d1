<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<html>
<head>
</head>
<body>
<%
if ("post".equals(request.getMethod().toLowerCase())) {//提交了
	 if(Tools.isNull(request.getParameter("txturl"))){
			Tools.outJs(out,"url不能为空！","back");
			return;
		}
 if(Tools.isNull(request.getParameter("txtsubad"))){
		Tools.outJs(out,"subad不能为空！","back");
		return;
 }
 if(Tools.isNull(request.getParameter("txttitle"))){
		Tools.outJs(out,"title不能为空！","back");
		return;
	}
 if(Tools.isNull(request.getParameter("txturl2"))){
		Tools.outJs(out,"跳转链接不能为空！","back");
		return;
	}
 String url=request.getParameter("txturl");
 String url2=request.getParameter("txturl2");
 String title=request.getParameter("txttitle");
 title=URLEncoder.encode(title,"utf-8");
 String url1=url+"?id=d1_1111&subad="+request.getParameter("txtsubad")+"&sex="+request.getParameter("txtsex")+"&title="+title+"&url="+url2;

response.sendRedirect(url1);

}
%>
<form id="form1" name="form1" method="post" action="mail.jsp">
<table width="980" border="0" cellspacing="0" cellpadding="0"  >
  <tr height=26>
    <td align="center" width="120">邮件链接：</td>
    <td align="left" style="text-align:left;">
    <input type="text" name="txturl"  style="width:400px"/>

   
    </td>
  </tr>
  <tr height=26>
    <td align="center" width="120">subad：</td>
    <td><input type="text" name="txtsubad" /></td>
  </tr>
  <tr height=26>
    <td align="center" width="120">title：</td>
    <td><input type="text" name="txttitle" /></td>
  </tr>
  <tr height=26>
    <td align="center" width="120">sex</td>
    <td><input type="text" name="txtsex" /></td>
  </tr>
   <tr height=26>
    <td align="center" width="120">跳转链接：</td>
    <td align="left" style="text-align:left;">
    <input type="text" name="txturl2"  style="width:400px"/>
	</td>
  </tr>
  <tr height=26>
    <td colspan="2" align="center" ><input type="submit" /></td>

  </tr>
</table>

</form>
</body>

</html>