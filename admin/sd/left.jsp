<%@ page contentType="text/html; charset=UTF-8"%><%@page import="com.d1.util.Tools"%><%@include file="/admin/chkrgt.jsp"%>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<script src="/res/js/DatePicker/WdatePicker.js" type="text/javascript"></script>    
<script src="/res/js/jquery-1.3.2.min.js"></script> 
<%String start="";
String end ="";
String rackcode="";
String gdsid="";
String isshow="";
String issh="";
if(!Tools.isNull(request.getParameter("txtStart"))){
	start=request.getParameter("txtStart");
}
if(!Tools.isNull(request.getParameter("txtEnd"))){
	end=request.getParameter("txtEnd");
}
if(!Tools.isNull(request.getParameter("txtrackcode"))){
	rackcode=request.getParameter("txtrackcode");
}
if(!Tools.isNull(request.getParameter("txtgdsid"))){
	gdsid=request.getParameter("txtgdsid");
}
if(!Tools.isNull(request.getParameter("isshow"))){
	isshow=request.getParameter("isshow");
}
if(!Tools.isNull(request.getParameter("issh"))){
	issh=request.getParameter("issh");
}
if(Tools.isNull(start) && Tools.isNull(end)){
	start= Tools.getDate();
}
if(!Tools.isNull(start)){
	start=start+" 00:00:00";
}
if(!Tools.isNull(end)){
	end=end+" 23:59:59";
}%>
<a href="add.jsp" target="rtop">晒单添加</a><br><br>
<form id="search1" name="search1" method="post" action="search.jsp" target="rtop">
<input type="hidden" name="addtype" value="0"></input>
<table cellpadding="0" cellspacing="0" style="line-height:30px;font-size:12px;width:100%">
<tr>
<td style="border-left:solid 1px #999999;border-top:solid 1px #999999">晒单时间</td><td style="border-top:solid 1px #999999">
<input type="text" name="txtStart" id="txtStart" value="<%=start %>"  class="Wdate" style="width:100px;" onfocus="var txtEnd=$dp.$('txtEnd');WdatePicker({onpicked:function(){},maxDate:'#F{$dp.$D(\'txtEnd\')}'})" /> </td>
</tr>
<tr><td style="border-left:solid 1px #999999">至</td><td><input type="text" name="txtEnd" id="txtEnd" value="<%=end %>" class="Wdate" style="width:100px;" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'txtStart\')}'})" />
  </td></tr>
  <tr><td style="border-left:solid 1px #999999">商品分类</td><td><input type="text" name="txtrackcode" id="txtrackcode" value="<%=rackcode %>" style="width:100px;"/></td></tr>
  <tr><td style="border-left:solid 1px #999999">商品编号</td><td><input type="text" name="txtgdsid" id="txtgdsid" value="<%=gdsid %>" style="width:100px;"/></td></tr>
 
  
   <tr><td style="border-left:solid 1px #999999">审核状态</td><td><select id="issh" name="issh">
  <option value="">==请选择==</option>
    <option value="0" <%if("0".equals(issh)) {%> selected="selected"<%} %>>未审核</option>
  <option value="1" <%if("1".equals(issh)) {%> selected="selected"<%} %>>审核通过显示</option>
   <option value="3" <%if("3".equals(issh)) {%> selected="selected"<%} %>>审核通过不显示</option>
 <option value="2" <%if("2".equals(issh)) {%> selected="selected"<%} %>>审核未通过</option>
  </select></td></tr>
  <tr><td style="border-left:solid 1px #999999">审核人</td><td><input type="text" name="txtcheckuser" id="txtcheckuser"  style="width:100px;"/></td></tr>
 
  <tr><td style="border-left:solid 1px #999999">审核时间</td><td><input type="text" name="txtcheckdates" id="txtcheckdates" class="Wdate" style="width:100px;" onfocus="var txtcheckdatee=$dp.$('txtcheckdatee');WdatePicker({onpicked:function(){},maxDate:'#F{$dp.$D(\'txtcheckdatee\')}'})""/></td></tr>
 <tr><td style="border-left:solid 1px #999999">至</td><td><input type="text" name="txtcheckdatee" id="txtcheckdatee"  class="Wdate" style="width:100px;" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'txtcheckdates\')}'})" />
  <tr><td colspan="2" align="center" style="border-left:solid 1px #999999"><input type="submit"  value="查询"/></td></tr>
</table>
</form>
