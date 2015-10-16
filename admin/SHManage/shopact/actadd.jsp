<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkshop.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="/admin/odradmin/images/odrlist.css" rel="stylesheet" type="text/css"  />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

<script type="text/javascript" src="/res/js/DatePicker/WdatePicker.js"></script>
<link type="text/css" href="/res/js/DatePicker/skin/whyGreen/datepicker.css" rel="stylesheet" />
<script type="text/javascript" src="/admin/SHManage/images/shopajax.js?2.2"></script>

<style type="text/css">
<!--
.actt {
	font-size: 14px;
	font-weight: bold;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #999999;
}
-->
</style>
<script type="text/javascript">
function showpp(){
var req_type=$('#req_type option:selected').val();  
  if(req_type=="1"){
	  $("#tr_ppcode").show();
	  $("#tr_brandcode").hide();
  }else if(req_type=="2"){
	  $("#tr_brandcode").show();
	  $("#tr_ppcode").hide();
  }else{
	  $("#tr_ppcode").hide();
  }
}
</script>
<title>满减促销</title>
</head>
<body style="text-align:left;" style="overflow-x: hidden">
<%@include file="/admin/inc/shhead.jsp" %>
<br/>
<br/>
<table style="width:1000px; margin:0px auto;" border="0" cellpadding="0" cellspacing="0">
   <tr><td width="174" style="text-align:left;" valign="top">
     <%@include file="left.jsp" %>
   </td>
   <td width="826" valign="top">
<table width="820" border="0" cellspacing="0" cellpadding="0" style="line-height:35px;">
  
  <tr>
    <td align="left">&nbsp;</td>
    <td colspan="2" align="left" class="actt">&nbsp;&nbsp;满减促销</td>
  </tr>
  <tr>
    <td align="left">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td>您可自定促销，促销的修改提交之后XXXXX生效<br />
满减促销与参加的网站秒杀促销活动重叠，可能会导致购买商品时价格过低，请谨慎设置！</td>
  </tr>
  <tr>
    <td width="28" align="left">&nbsp;</td>
    <td width="198" align="left">活动名称：</td>
    <td width="707"><input type="text" name="req_name" id="req_name" />
      &nbsp;<br />
	（XX个汉字内,活动开始后促销名称不能修改。该名称会显示在前台页面，请仔细斟酌!)	</td>
  </tr>
   <tr>
    <td align="left">&nbsp;</td>
    <td align="left">活动类型：</td>
    <td><select name="req_type" id="req_type"  onChange= "showpp()">
      <option value="0">满减活动</option>
      <%if(shopcode.equals("00000000")){ %>
       <option value="1">推荐位满减</option>
       <%} %>
       <option value="2">品牌满减</option>
    </select>
    </td>
  </tr>

  <tr id="tr_ppcode" style="display: none;width:100%">
    <td align="left">&nbsp;</td>
    <td align="left">推荐位号：</td>
    <td><input type="text" name="req_ppcode"  size="50" id="req_ppcode" />&nbsp;如多个用“，”隔开格式123,234</td>
  </tr>
   <tr id="tr_brandcode" style="display: none;width:100%">
    <td align="left">&nbsp;</td>
    <td align="left">品牌编号：</td>
    <td><input type="text" name="req_brandcode"  size="50" id="req_brandcode" /></td>
  </tr>
   <tr>
    <td align="left">&nbsp;</td>
    <td align="left">活动状态：</td>
    <td><select name="req_status" id="req_status">
      <option value="0">未开启</option>
       <option value="1">已开启</option>
    </select>
    </td>
  </tr>
   <tr>
    <td rowspan="2" align="left">&nbsp;</td>
    <td rowspan="2" align="left">活动时间：</td>
    <td>开始时间：<input type="text" name="req_sdate" id="req_sdate" onFocus="WdatePicker({isShowClear:true,readOnly:true,skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})"/>&nbsp;格式2013-11-12 10:00:00</td>
  </tr>
  <tr>
    <td>结束时间：<input type="text" name="req_edate" id="req_edate" onFocus="WdatePicker({isShowClear:true,readOnly:true,skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />&nbsp;格式2013-11-15 23:59:59</td>
  </tr>
  <tr>
    <td align="left">&nbsp;</td>
    <td align="left">规则说明：</td>
    <td>1. 最多可以设置三级满减 <br />
      2. 满额金额不含运费。 <br />
      3. 满额优惠不以倍数计算。如满100元减5元。如果顾客满200元，且未达到第二阶金额，也只减5元。 <br />
      4. 请至少提前XXXX设置 <br />
      5. 促销开始后，只能修改结束时间，其他均不能修改。 <br />
      6. 促销修改提交之后XXXX生效。 <br />
    7. 促销取消后XXXXX生效。 <br />
    阶梯一 为金额最低，阶梯三 为金额最高。如果只定义一重减免，<br />
    请写在阶梯一上。例如：100-50  200-100  300-150。<br />
    如果只定义一重满减，在阶梯一上写：200-100<br />
    </td>
  </tr>
  <tr>
    <td rowspan="3" align="left">&nbsp;</td>
    <td rowspan="3" align="left">促销设置：</td>
    <td>第一阶：购物金额满：
    <input name="req_snum1" id="req_snum1" type="text" size="10" />
    减
    <input name="req_enum1" id="req_enum1"  type="text" size="10" /></td>
  </tr>
  <tr>
    <td>第二阶：购物金额满：
      <input name="req_snum2" id="req_snum2"  type="text" value="0" size="10" />
减
<input name="req_enum2" id="req_enum2"  type="text" size="10" value="0"  /></td>
  </tr>
  <tr>
    <td>第三阶：购物金额满：
      <input name="req_snum3" id="req_snum3"  type="text" value="0"  size="10" />
减
<input name="req_enum3" id="req_enum3"  type="text" size="10" value="0"  /></td>
  </tr>
   <tr>
    <td align="left">&nbsp;</td>
    <td align="left">不参加的商品ID用“，”隔开</td>
    <td><textarea name="req_memo" cols="70" rows="5" id="req_memo"></textarea></td>
  </tr>
  <tr>
    <td align="left">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td><input type="submit" name="Submit" onClick="actadd(this);" value="&nbsp;提&nbsp;&nbsp;交&nbsp;" /></td>
  </tr>
  
  
  <tr>
    <td align="left">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
  </td>
   </tr>
</table>
</body>
</html>