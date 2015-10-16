<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<style type="text/css">
<!--

.STYLE2 {font-size: 24px;font-weight:bold;}
-->
</style>
<script type="text/javascript">
function closepage(){
	//$.close();
	window.location.href="/user/myshoworder.jsp";
}
</script>
 <div class="form">
 <%
String odrid=request.getParameter("odrid");
String gdsid=request.getParameter("gdsid");
String odtlid=request.getParameter("odtlid");
%>
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="3" align="center" valign="middle" style="height:100px;">
    <span class="STYLE2">晒单成功，通过审核后您将获得30积分！</span></td>
  </tr>
  <tr>
    <td width="170" align="center"><a href="/user/myshoworder.jsp?view=1" target="_blank"><img src="http://images.d1.com.cn/images2012/sd/an_21.jpg" width="98" height="34" border="0"/></a></td>
	<td width="150"><a href="/ShowOrder/fxsd.jsp?gdsid=<%=gdsid%>&odrid=<%=odrid%>&odtlid=<%=odtlid %>" target="_blank"><img src="http://images.d1.com.cn/images2012/sd/an_27.jpg" width="128" height="34" border="0"/></a></td>
     <td >
     <input type="image" height=34 width=98 src="http://images.d1.com.cn/images2012/sd/sdclose.jpg" align=absMiddle border=0 onclick="closepage();"/>
</td>
  </tr>
  <tr> <td colspan="3" style="height:20px;">&nbsp;</td></tr>
</table>
</div>
