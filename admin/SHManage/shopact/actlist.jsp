<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/admin/chkshop.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="/admin/odradmin/images/odrlist.css" rel="stylesheet" type="text/css"  />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="/res/js/DatePicker/WdatePicker.js"></script>
<link type="text/css" href="/res/js/DatePicker/skin/whyGreen/datepicker.css" rel="stylesheet" />
<script type="text/javascript" src="/admin/SHManage/images/shopajax.js"></script>

<title>无标题文档</title>


</head>
<%@include file="/admin/inc/shhead.jsp" %>
<br>
<br>
<table style="width:1000px; margin:0px auto;" border="0" cellpadding="0" cellspacing="0">
   <tr><td width="174" style="text-align:left;" valign="top">
     <%@include file="left.jsp" %>
   </td>
   <td width="826" valign="top">
<table width="806" border="0" cellspacing="0" cellpadding="0" align="center">

<input type="hidden" name="act" value="list" />
  <tr>
    <td height="30" colspan="7">&nbsp;</td>
  </tr>
  <tr>
    <td width="69" height="40">活动名称：</td>
    <td width="190"><input type="text" name="req_name"  id="req_name" class="text" /></td>
    <td width="83">开始时间：</td>
    <td width="179"><input type="text" name="req_stime" id="req_stime" class="text"  onFocus="WdatePicker({isShowClear:true,readOnly:true})"    /></td>
    <td width="75">至：</td>
    <td colspan="2"><input type="text" name="req_etime" id="req_etime" class="text" onFocus="WdatePicker({isShowClear:true,readOnly:true})"  /></td>
  </tr>
  <tr>
    <td height="40">活动类型：</td>
    <td>
    <select name="req_type" id="req_type">
      <option value="0">满减活动</option>
        <option value="1">推荐位满减</option>
         <option value="2">品牌满减</option>
    </select></td>
    <td>审核状态：</td>
    <td><select name="req_status" id="req_status">
      <option value="0">未开启</option>
	   <option value="1">已开启</option>
    </select></td>
    <td>&nbsp;</td>
    <td width="81">&nbsp;</td>
    <td width="129"><input type="image" name="imageField" onClick="actgetlist(this)" src="/admin/odradmin/images/search.jpg" /></td>
  </tr>

  <tr>
    <td height="30" colspan="7">&nbsp;</td>
  </tr>

  <tr>
    <td class="menuodrtd"  colspan="7">活动列表</td>
  </tr>
    <tr>
      <td height="2" colspan="7" bgcolor="#449ae7"></td>
    </tr>
    <tr>
      <td colspan="7">&nbsp;</td>
    </tr>
    <tr>
    <td colspan="7">
    <div id="actlist"></div>
    </td>
  </tr>
  <tr>
      <td colspan="7">&nbsp;</td>
    </tr>
</table>
</td>
   </tr>
</table>
</body>
</html>