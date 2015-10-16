<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="del.js"></script>
<%
String txtstart="";String txtend="";String txtgdsid="";
if(!Tools.isNull(request.getParameter("txtstart"))){
	txtstart=request.getParameter("txtstart");
}
if(!Tools.isNull(request.getParameter("txtend"))){
	txtend=request.getParameter("txtend");
}
if(!Tools.isNull(request.getParameter("txtgdsid"))){
	txtgdsid=request.getParameter("txtgdsid");
}
%>
 <table width="980" border="0" cellspacing="0" cellpadding="0">
 <tr height="15px"> <td colspan="2"></td></tr>
    <tr>
      <td width="310">开始时间：
        <input type="text" id="txtstart" name="txtstart" style="width:200px;" value="<%=txtstart%>"/>
      </td>
      <td align="left">结束时间： <input type="text" id="txtend" name="txtend" style="width:200px;"   value="<%=txtend%>"/></td>
    </tr>
    <tr>
      <td  colspan="2">商品编号： <input type="text" id="txtgdsid" name="txtgdsid"  value="<%=txtgdsid%>"/>
      <input type="button" onclick="search()" value="搜 索"/></td>

    </tr>
    <tr height="15px"> <td colspan="2"></td></tr>
  </table>