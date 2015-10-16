<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>生成优惠券</title>
<script src="/res/js/DatePicker/WdatePicker.js" type="text/javascript"></script>    
<script src="/res/js/jquery-1.3.2.min.js"></script> 
<script type="text/javascript">
function showdiscount(v){
	if(v==0){
		$("#tr1").show();
	}else{
		$("#tr1").hide();
		$("#txtdiscount").val('');
	}
}
</script>
</head>
<%

if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "mkt_tktcrt");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}

%>
<body>
<p style="color:red;">时间默认为0点。如果希望结束日期的当天能使用，请将有效期往后一天</p>
<form method=post id="form1"  action="addTkt.jsp">
<p style="color:red;">分类号：000代表全场，017代表服装</p>
<table>
<tr>
<td>券头：<input type=text name="txttitle" /></td>
<td>优惠券金额：<input type=text name="txtvalue" id="txtvalue" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/></td>
<td>商品金额：<input type=text name="txtgdsvalue" id="txtgdsvalue" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/></td>
</tr>
<tr>
<td>商品分类：<input type=text name="txtrackcode" id="txtrackcode"/></td>
<td>优惠券类型：<select name="txttype" onchange="showdiscount(this.value);">
		<option value="0">百分比减免</option>
		<option value="1" selected>直减券</option>
	</select></td>
	<td>生成张数：<input type=text name="txtnum" id="txtnum" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/></td>
</tr>
<tr>

<td>有效期至：<input type=text name="txtEnd" id="txtEnd" class="Wdate" onfocus="var date=new Date();WdatePicker({minDate:date})"/></td>
<td >备注：<input type=text name="txtmemo" id="txtmemo"/></td><td id="tr1" style="display:none">折扣比例：<input type=text name="txtdiscount" id="txtdiscount"/></td>
</tr>

<tr><td colspan="3">券限制：每个用户限使用<input type=text name="txtmaxcount" id="txtmaxcount" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/>张
商户号：<input type=text name="shopcode" id="shopcode" value="00000000"/>
<input type="checkbox" name="typetkt" value="1">通用算法生成券</input>&nbsp;&nbsp;
<input type="checkbox" name="cb2" value="2">限新客</input>&nbsp;
<input type="checkbox" name="cb3" value="1">不参加网盟返利</input></td></tr>
<tr><td colspan="3"><input type="submit" value="提交" /></td></tr>
</table>
</form>
<div style="padding-top:20px;">&nbsp;</div>

<p>商品兑换码：</p>
<form method=post id="form1" action="addTuandh.jsp">
<p style="color:red;">多个商品时，商品编号为空，商品编号填到“备注2”，商品之间用英文,隔开。</p>
<table>
<tr>
<td>券头：<input type=text name="txttitle2" /></td>
<td>商品编号：<input type=text name="txtgdsid" id="txtgdsid" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/></td>
<td>生成张数：<input type=text name="txtnum2" id="txtnum2" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/></td>
</tr>
<tr>
<td>有效期至：<input type=text name="txtEnd2" id="txtEnd2" class="Wdate"  onfocus="var date=new Date();WdatePicker({minDate:date})"/></td>
<td>备注1：<input type=text name="txtmemo1" id="txtmemo1"/><span style="color:red;">此项会显示在商品名称之前</span></td>
<td>备注2：<input type=text name="txtmemo2" id="txtmemo2"/></td>
</tr>
<tr id="tr1" >
<td colspan="3">兑换平台：<select name="mid">
<option value="">==请选择==</option>
<option value="4">网易活动兑换</option>
<option value="8">网易积分抽奖</option>
<option value="6">当当兑换</option>
<option value="9">财付通领奖台兑换</option>
<option value="10">赶集网兑换</option>
<option value="11">QQ团兑换</option>
<option value="14">艺龙兑换</option>
<option value="15">搜狐积分兑换</option>
<option value="17">平安兑换</option>
<option value="41">PPS兑换</option>
<option value="47">139兑换</option>
<option value="53">滴滴打车兑换</option>
</select>&nbsp;&nbsp;
<input type="checkbox" name="typetkt" value="1">通用算法生成券</input>&nbsp;&nbsp;
<input type="checkbox" name="shipfee" value="1">是否包邮</input>&nbsp;&nbsp;
运费：<input type=text name="fee" id="fee" value="0" /></td>
兑换价：<input type=text name="dhprice" id="dhprice"/>&nbsp;单个订单最大兑换量：<input type=text name="dhmaxcount" id="dhmaxcount" value="1"/>
</td>

</tr>

<tr><td colspan="3"><input type="submit" value="提交" /></td></tr>
</table>
</form>
</body>
</html>