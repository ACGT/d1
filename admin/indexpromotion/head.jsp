<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%>
<script type="text/javascript" src="search.js"></script>
<%
String txtpromotionid="";
if(!Tools.isNull(request.getParameter("txtpromotionid"))){
	txtpromotionid=request.getParameter("txtpromotionid");
}

%>
 <table width="980" border="0" cellspacing="0" cellpadding="0">
 <tr height="15px"> <td></td></tr>
  
    <tr>
      <td>推荐位ID： <input type="text" id="txtpromotionid" name="txtpromotionid"  value="<%=txtpromotionid%>"/>
      <input type="button" onclick="search()" value="搜 索"/></td>

    </tr>
    <tr height="15px"> <td colspan="2"></td></tr>
  </table>