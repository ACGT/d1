<%@page import="com.d1.util.Tools"%>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<script src="/res/js/DatePicker/WdatePicker.js" type="text/javascript"></script>    
<script src="/res/js/jquery-1.3.2.min.js"></script> 
手动添加晒单

<form id="search2" name="search2" method="post" action="search.jsp" target="rtop">
<input type="hidden" name="addtype" value="1"></input>
<table cellpadding="0" cellspacing="0" style="line-height:30px;font-size:12px;width:100%">
<tr>
<td style="border-left:solid 1px #999999;border-top:solid 1px #999999">添加时间</td><td style="border-top:solid 1px #999999">
<input type="text" name="txtaddtimes" id="txtaddtimes"  class="Wdate" style="width:100px;" onfocus="var txtaddtimee=$dp.$('txtaddtimee');WdatePicker({onpicked:function(){},maxDate:'#F{$dp.$D(\'txtaddtimee\')}'})" /> </td>
</tr>
<tr><td style="border-left:solid 1px #999999">至</td><td><input type="text" name="txtaddtimee" id="txtaddtimee"  class="Wdate" style="width:100px;" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'txtaddtimes\')}'})" />
  </td></tr>

  <tr><td style="border-left:solid 1px #999999">商品编号</td><td><input type="text" name="txtgdsid" id="txtgdsid"  style="width:100px;"/></td></tr>
  <tr><td style="border-left:solid 1px #999999">添加人：</td><td><input type="text" name="txtadduser" id="txtadduser"  style="width:100px;"/></td>
  <tr><td style="border-left:solid 1px #999999">审核状态</td><td><select id="issh" name="issh">
  <option value="">==请选择==</option>
    <option value="0" >未审核</option>
  <option value="1">审核通过显示</option>
   <option value="3" >审核通过不显示</option>
 <option value="2">审核未通过</option>
  </select></td></tr>
   
  <tr><td colspan="2" align="center" style="border-left:solid 1px #999999"><input type="submit"  value="查询"/></td></tr>
</table>
</form>
