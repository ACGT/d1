<%@ page contentType="text/html; charset=UTF-8"%>
<script src="/res/js/DatePicker/WdatePicker.js" type="text/javascript"></script>    
<script src="/res/js/jquery-1.3.2.min.js"></script> 
<script src="js.js"></script> 
<form id="search" name="search" method="post" action="search.jsp" target="rtop">
<table>
<tr><td>上架时间：</td>
<td >
<input type="text" name="txtStart" id="txtStart"   class="Wdate" style="width:100px;" onfocus="var txtEnd=$dp.$('txtEnd');WdatePicker({onpicked:function(){},maxDate:'#F{$dp.$D(\'txtEnd\')}'})" /> </td>
</tr>
<tr><td>至</td><td><input type="text" name="txtEnd" id="txtEnd" class="Wdate" style="width:100px;" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'txtStart\')}'})" />
  </td></tr>
<tr>
<td>品牌：</td><td><select id="sbrand" name="sbrand" onchange="getGdsser(this)">
  <option value="">==请选择==</option>
    <option value="987" >FEEL MIND</option>
  <option value="1690" >AleeiShe 小栗舍 </option>
   <option value="1969" >诗若漫   </option>
  </select></td>
<td>系列：</td><td>
<select id="sgdsser" name="sgdsser"></select>
</td>
</tr>

</table>
</form>