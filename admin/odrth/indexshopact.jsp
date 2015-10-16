<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<link href="/admin/odradmin/images/odrlist.css" rel="stylesheet" type="text/css"  />

<script type="text/javascript" src="/res/js/DatePicker/WdatePicker.js"></script>
<link type="text/css" href="/res/js/DatePicker/skin/whyGreen/datepicker.css" rel="stylesheet" />

<title>商户促销活动管理</title>
<script type="text/javascript">
function actgetlist(obj){
	var req_name=$('#req_name').val();
    var req_type=$('#req_type option:selected').val();  
    var req_status=$('#req_status option:selected').val();  
    var req_shopcode=$('#req_shopcode').val();
	var req_stime=$('#req_stime').val();
	var req_etime=$('#req_etime').val();


$.get("/admin/ajax/getactlistd1.jsp",{"req_name":req_name,"req_type":req_type,"req_status":req_status,"req_stime":req_stime
	,"req_etime":req_etime,"req_shopcode":req_shopcode,"m":new Date().getTime()},function(data){
	$('#actlist').html(data);
});
}

function acttbok(actid,flag){
    $.ajax({
		type: "get",
		dataType: "json",
		url: '/admin/ajax/upacttbokd1.jsp',
		cache: false,
		data: {actid:actid,flag:flag},
		error: function(XmlHttpRequest){
		},success: function(json){
			$.alert(json.message);
			$('#actok'+actid).hide();
			if(flag=='1'){
				$('#actstatus'+actid).html('审核通过');
			}else{
			$('#actstatus'+actid).html('不通过');
		}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
</script>

</head>
<table width="980" border="0" cellspacing="0" cellpadding="0" align="center">

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
    </select></td>
    <td>审核状态：</td>
    <td><select name="req_status" id="req_status">
      <option value="0">等审核</option>
	   <option value="1">已审核</option>
    </select></td>
    <td>商户号：</td>
    <td width="81"><input name="req_shopcode" type="text" class="text" id="req_shopcode" size="12"></td>
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