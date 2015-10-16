<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——收货地址管理</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<link type="text/css" rel="Stylesheet" href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/flowCheck.css")%>" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/PublicFunction.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/flow/flowCheck.js")%>"></script>
<script type="text/javascript" >
 function update(){
	$("#tradd").hide();
	$("#trupdate").show();
 }
 
 function Cancel(){
		$('#hdnMbrcstID').val("0");
		$('#MbrcstAction').val("new_save_consignee");
	    ReSetMbrcst();
	    $("#tradd").show();
		$("#trupdate").hide();
	}
 function afterupdate(){
	 window.location.href="address.jsp"
 }
 
//删除收货人
 function DeleteMbrcst_user(addId){
 	if(!window.confirm('确认要删除该收货人吗?')) return;
 	$.post("/ajax/user/address_del.jsp",{"id":addId,"m":new Date().getTime()},function(json){
 		if(json.success){
 			$("#address_"+addId).remove();
 			var addList = $("input[type='radio'][name='rdoMbrcstList']");
 			if(addList.length==0){//刷新该页面。
 				window.location.href='/user/address.jsp';
 				return;
 			}else{//否则默认第一个选中。
 				addList.eq(0).attr("checked",true);
 			}
 			CancelMbrcst();
 		}else{
 			var spanMbrcstMsg = $('#spanMbrcstMsg');
 			spanMbrcstMsg.html(json.message);
             spanMbrcstMsg.fadeIn(iSpeed);
             setInterval(FadeOutMbrcstMsg, iInterVal);
 		}
 	},"json");
 }
</script>
</head>
<body>
    <!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
     <!-- 中间内容 -->
     <div class="center">
        
     <%@include file="left.jsp" %>
     
  <!--右侧-->

   <div class="mbr_right">

		<div class="myaddress">

		  &nbsp;&nbsp;<span>收货地址</span>

		</div>

		<table ><tr><td height="15"></td></tr></table>

		<div class="addresslist">

		  <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="t" style=" border:solid 1px #c2c2c2; border-bottom:none;" >

		   <tr><td colspan="4" style=" background:url(http://images.d1.com.cn/images2012/New/user/inorderbg.jpg);  border-bottom:solid 1px #b33b57; text-align:left;" height="33"><span style=" color:#a25663; font-size:14px;"><b>&nbsp;&nbsp;我的收货地址：</b></span></td></tr>

				   <tr style=" color:#a25663;" height="33"><td class="d1"  width="80">收货人</td><td  class="d1" width="300">详细地址</td><td class="d1">联系电话</td><td class="d1" width="140">操作</td></tr>

				   </table>

					<table width="769"  border="0" cellspacing="1" cellpadding="0"  class="t" >
					<%
						ArrayList<UserAddress> list = UserAddressHelper.getUserAddressList(lUser.getId());
					if(list!=null){
						for(UserAddress ua:list){
							if(ua.getMbrcst_countryid().intValue()!=100 && Tools.isNull( ua.getMbrcst_memo())){
								
							
							
					%>
				   <tr ><td width="80"  height="35" ><%=ua.getMbrcst_name()%></td><td width="300" style=" text-align:left;">&nbsp;<%=ua.getMbrcst_raddress()%> <%=ua.getMbrcst_rzipcode()%></td>
				   <td><%=ua.getMbrcst_rphone()%>
				   <%
				   if(!Tools.isNull(ua.getMbrcst_rtelephone())){
					   %>  
					   /<%=ua.getMbrcst_rtelephone()%>
				   <% }
				   %>
				   
				   </td>
				   <td width="140"><a href="javascript:void(0);" onclick="javascript:update();GetUpdMbrcst('<%=ua.getId() %>')">修改</a>&nbsp;&nbsp;<a href="javascript:void(0);" onclick="javascript:DeleteMbrcst_user('<%=ua.getId()%>')">删除</a></td></tr>
				   <%
							}
						}
					}
				   %>

			   </table>
		</div>

		<table ><tr><td height="20"></td></tr></table>

		    		<!-- Start:新增收货表单 -->
    		<form id="formAddr" method="post" action="address.jsp" onsubmit="return false;">
    		<input type="hidden" id="hdnMbrcstID" value="0" />
    		<input type="hidden" id="MbrcstAction" value="new_save_consignee" />
    		<div class="updateaddress" id="addaddress">
    		 <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="t" style=" border:solid 1px #c2c2c2; text-align:left;" id="tblAddEditMbrct">

		   <tr><td colspan="2" style=" background:url(http://images.d1.com.cn/images2012/New/user/inorderbg.jpg); text-align:left;" height="33"><span style=" color:#a25663; font-size:14px;"><b>&nbsp;&nbsp;输入新地址/修改地址：</b></span></td></tr>

		   <tr><td colspan="2" height="15"></td></tr>
     
        		<tr>
					<td width="120" style=" text-align:right;">
						<font color="#e53333">*</font>姓<span style="visibility:hidden">一二</span>名：
					</td>
					<td >
						<input type="text" maxlength="20" id="txtName" name="txtName" onblur="CheckName()"/>&nbsp;<span id="spanName"  style="color:#e53333;display:none"></span>
					</td>
					
        		</tr>
        		<tr>
          			<td width="120" style=" text-align:right;">
						<font color="#e53333">*</font>
          				地<span style="visibility:hidden">一二</span>区：
          			</td>
          			<td>
          			省/直辖市
						<select id="ddlProvince"  onchange="ChangeProv(this)">
							<option value="">==请选择==</option>
						</select>
                       	县/市/区 <select id="ddlCity" class="b15" onchange="CheckCity()">
                        	<option value="">==请选择==</option>
                        </select>
                        <span id="spanProvinceCity"  style="color:#e53333;display:none"></span>
					</td>
          			
        		</tr>
   			    <tr>
				    <td width="120" style=" text-align:right;">
						<font color="#e53333">*</font>详细地址：
          			</td>
          			<td>
						<input type="text" id="txtRAddress" maxlength="200" style="width:440px"  onblur="CheckRAddress()" />
						<span id="spanRAddress"  style="color:#e53333;display:none"></span>
					</td>
        		</tr>
   			    <tr>
				   <td width="120" style=" text-align:right;">
						邮政编码：</td>
          			<td >
          				<input type="text" id="txtRZipcode" maxlength="6"  onblur="CheckRZipcode()" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/>
          				<span style="color:black;">&nbsp;&nbsp;&nbsp;&nbsp;有助于快速确定收货地址</span>
          				<span id="spanRZipcode"  style="color:#e53333;display:none"></span>
          			</td>
          			
        		</tr>
        		<tr>
          			<td width="120" style=" text-align:right;">
						邮箱地址：</td>
          			<td >
          				<input type="text" id="txtREmail" maxlength="40"  onblur="CheckREmail()"/>
          				<span style="color:black;">&nbsp;&nbsp;&nbsp;&nbsp;用来接收订单提醒邮件，便于您及时了解订单状态</span>
          				<span id="spanREmail"  style="color:#e53333;display:none"></span>
          			</td>
          			
        		</tr>  	
				<tr>
          			<td width="120" style=" text-align:right;">
						<font color="#e53333">*</font>手机号码：</td>
          			<td >
          				<input type="text" id="txtRPhone" maxlength="11"  onblur="CheckRPhone()" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/>
          				<span id="spanRPhone"  style="color:#e53333;display:none"></span>
          			</td>
          			
        		</tr>
   			    <tr><td width="120" style=" text-align:right;">&nbsp;&nbsp;固定电话：</td>
   			    <td><input type="text" id="txtTelePhone"  onblur="CheckTelePhone()" onkeyup="this.value=this.value.replace(/[^-0-9]/g,'')" onafterpaste="this.value=this.value.replace(/[^-0-9]/g,'')"/>
			            <span id="spanTelePhone"  style="display:none"></span></td></tr>	 
        				    
        		<tr>
        			<td style="height:15px" colspan="2"></td>
        		</tr>
        		<tr id="tradd">
          			<td></td>
          			
          			<td>
              			 <a onclick="AddMbrcst('new_save')" id="btnSaveMbrcst" href="javascript:void(0);"><img src="http://images.d1.com.cn/images2012/New/user/addaddress.jpg" /></a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="ReSetMbrcst()">清除重写</a>
					</td>
              		
              	</tr>
              	<tr id="trupdate" style="display:none">
          			<td></td>
          			<td>
              			 <a onclick="AddMbrcst('new_save');" id="btnSaveMbrcst" href="javascript:void(0);"><img src="http://images.d1.com.cn/images2012/New/user/saveandupdate.jpg" /></a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="ReSetMbrcst()">清空内容</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a  onclick="Cancel()" href="javascript:void(0)">取消</a>
					</td>
              		
              	</tr>
              	<tr><td colspan="2" height="15"></td></tr>
      		</table>
      		</div>
      		</form>
			<!-- End:新增收货表单 -->
			<script type="text/javascript">BindProvince();</script>
 
	  <!-- 右侧结束 -->
         
     </div>
    <div class="clear"></div>
    <!--中间内容结束-->
    <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
</body>
</html>

