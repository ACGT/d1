<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%@include file="/admin/chkshop.jsp"%>
<%String odrthid = request.getParameter("odrthid"); %>
<style>
.hhsend{ font-size:12px;}
</style>
<table width="450" border="0" cellspacing="0" cellpadding="0" class="hhsend">
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="88" height="30" align="center">快递公司：</td>
    <td width="262">
    <input type="hidden" name="odrthid" id="odrthid" value="<%=odrthid%>">
	<select name="shipname" id="shipname" class="text">
<option value="EMS">EMS</option>
<option value="宅急送">宅急送</option>
<option value="圆通速递">圆通速递</option>
<option value="韵达快运">韵达快运</option>
<option value="顺丰快递">顺丰快递</option>
<option value="申通快递">申通快递</option>
<option value="中通快递">中通快递</option>
<option value="优速快递">优速快递</option>
<option value="天天快递">天天快递</option>
<option value="国通快递">国通快递</option>
<option value="汇通快递">汇通快递</option>
<option value="全峰快递">全峰快递</option>
<option value="百世汇通">百世汇通</option>
<option value="其它快递">其它快递</option>
        </select>
	</td>
  </tr>
  <tr>
    <td height="30" align="center">快递单号：</td>
    <td><input type="text" name="shipcode" id="shipcode" />
    
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="提交" onclick="sendhh();" /><span id="spStatus"></span></td>
  <div id="div_Checkcodemsg"></div>
  
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<script type="text/javascript">
var $status = $("#spStatus");
function sendhh(){

	var odrthid="";
	var shipname="";
	var shipcode="";
	odrthid=$('#odrthid').val();
	shipcode=$('#shipcode').val();
	shipname=$("#shipname").find("option:selected").text();
	if($("#shipcode").val() == ""){
		$('#div_Checkcodemsg').html(' <span style="color:#ff0000"> 请输入您的快递单号 </span>');
		$("#shipcode").focus();
		return;
	}
	
    $.ajax({
		type: "get",
		dataType: "json",
		url: '/admin/ajax/shophhsend.jsp',
		cache: false,
		data: {odrthid:odrthid,shipcode:shipcode,shipname:shipname},
		error: function(XmlHttpRequest){
		},success: function(json){	
			//alert(json.code)
			if(parseInt(json.code)==1){
				$.load("提示",480,"/admin/ajax/hhsendok.jsp");
			}else{
				$('#div_Checkcodemsg').html(' <span style="color:#ff0000"> '+json.message+' </span>');
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
</script>