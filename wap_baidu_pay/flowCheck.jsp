<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%><%@include
	file="/wap/inc/islogin.jsp"%>
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.setDateHeader("Expires", 0);
response.setHeader("Pragma","no-cache");
//查看购物车中是否有物品，没有则跳转
//CartHelper.checkCartError(request,response);

CartHelper.updateAllCartItems(request, response);

List<Cart> list = CartHelper.getCartItems(request,response);
if(list == null || list.isEmpty()){
	response.sendRedirect("/wap/flow.jsp");
	return;
}

//收获地址
ArrayList<UserAddress> addressList = UserAddressHelper.getUserAddressList(lUser.getId());
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网-提交订单！</title>
<link type="text/css"
	href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>"
	rel="stylesheet" />
<link
	href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/wap.css")%>"
	rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript"
	src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript"
	src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/PublicFunction.js")%>"></script>
<script type="text/javascript"
	src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/flow/flowCheck_wap.js")%>"></script>
<style>
.t14 {
	color: red;
}

.t17 {
	color: red;
}

.t01 {
	height: 20px;
}

.t23 {
	color: white;
}

.d2 {
	background: #b43f5c;
	height: 22px;
	width: 100%;
}
</style>
</head>

<body>
	<%@ include file="/wap/inc/head.jsp"%>
	<!-- Start:收货人信息头 -->
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td class="d2"><span class="t23">&nbsp;收货人信息</span></td>
			<td><span id="spanMbrcstMsg" style="display: none" class="t16"></span></td>
		</tr>
		<tr>
			<td height="1px" style="background-color: #b43f5c" colspan="2"></td>
		</tr>
		<tr>
			<td colspan="2" style="height: 8px"></td>
		</tr>
	</table>
	<!--End:收货人信息头-->
	<%
			//用户没有收获地址。
			if(addressList == null || addressList.isEmpty()){
			%>
	<!-- Start:新增收货表单 -->
	<form id="formAddr" method="post" action="/wap/flowCheck.jsp"
		onsubmit="return false;">
		<input type="hidden" id="hdnMbrcstID" value="0" /> <input
			type="hidden" id="MbrcstAction" value="new_save_consignee" />
		<table style="border: 0px;" cellpadding="3" cellspacing="0"
			class="t00" id="tblAddEditMbrct">
			<tr>
				<td valign="middle" style="width: 10px"><span class="t14">*</span></td>
				<td valign="middle" class="t01" style="white-space: nowrap;"><strong
					style="white-space: nowrap">姓<span
						style="visibility: hidden">一二</span>名：
				</strong></td>
				<td valign="middle"><input type="text" maxlength="20"
					class="b13" id="txtName" name="txtName" onblur="CheckName()" />&nbsp;<span
					id="spanName" class="t17" style="display: none"></span> <br /></td>
				<td valign="middle"></td>
				<td align="left" valign="middle">&nbsp;</td>
			</tr>
			<tr>
				<td valign="middle" style="width: 10px"><span class="t14">*</span></td>
				<td valign="middle" class="t01" style="white-space: nowrap;"></td>
				<td valign="middle"><input type="radio" id="rdoSex0" value="0"
					name="rdoSex" checked="checked" />&nbsp;&nbsp;先生&nbsp;&nbsp;<input
					type="radio" id="rdoSex1" value="1" name="rdoSex" />&nbsp;&nbsp;女士
				</td>
				<td valign="middle"></td>
				<td align="left" valign="middle">&nbsp;</td>
			</tr>
			<tr>
				<td valign="middle"><span class="t14">*</span></td>
				<td valign="middle" class="t01" style="white-space: nowrap;"><strong>地<span
						style="visibility: hidden">一二</span>区：
				</strong></td>
				<td valign="middle" colspan="2"><select id="ddlProvince"
					class="b15" onchange="ChangeProv(this)">
						<option value="">==请选择==</option>
				</select> <select id="ddlCity" class="b15" onchange="CheckCity()">
						<option value="">==请选择==</option>
				</select> <span id="spanProvinceCity" class="t17" style="display: none"></span>
				</td>
				<td align="left" valign="middle"></td>
			</tr>
			<tr>
				<td valign="middle"><span class="t13"><span class="t14">*</span></span></td>
				<td valign="middle" class="t01" style="white-space: nowrap;"><strong>地<span
						style="visibility: hidden">一二</span>址：
				</strong></td>
				<td colspan="3" valign="middle"><input type="text"
					id="txtRAddress" maxlength="200" class="b13"
					onblur="CheckRAddress()" /> <span id="spanRAddress" class="t17"
					style="display: none"></span></td>
			</tr>
			<tr>
				<td valign="middle"><span class="t14">*</span></td>
				<td valign="middle" class="t01" style="white-space: nowrap;"><strong>邮政编码：</strong></td>
				<td valign="middle"><input type="text" id="txtRZipcode"
					maxlength="6" class="b13" onblur="CheckRZipcode()"
					onkeyup="this.value=this.value.replace(/[^\d]/g,'')"
					onafterpaste="this.value=this.value.replace(/[^\d]/g,'') " /> <span
					id="spanRZipcode" class="t17" style="display: none"></span></td>
				<td align="right" valign="middle">&nbsp;</td>
				<td align="right" valign="middle">&nbsp;</td>
			</tr>
			<tr>
				<td valign="middle"><span class="t13"><span class="t14">*</span></span></td>
				<td valign="middle" class="t01" style="white-space: nowrap;"><strong>手机号码：</strong></td>
				<td valign="middle"><input type="text" id="txtRPhone"
					maxlength="11" class="b13" onblur="CheckRPhone()"
					onkeyup="this.value=this.value.replace(/[^\d]/g,'')"
					onafterpaste="this.value=this.value.replace(/[^\d]/g,'') " /> <span
					id="spanRPhone" class="t17" style="display: none"></span></td>
				<td colspan="2" align="left" valign="middle" class="t18">
					<%--用于接收发货通知短信及送货前确认<br />--%>
				</td>
			</tr>
			<tr>
				<td valign="middle">&nbsp;</td>
				<td valign="middle" class="t01" style="white-space: nowrap;"><strong>固定电话：
				</strong></td>
				<td valign="middle"><input type="text" id="txtTelePhone"
					maxlength="12" class="b13" onblur="CheckTelePhone()"
					onkeyup="this.value=this.value.replace(/[^-0-9]/g,'')"
					onafterpaste="this.value=this.value.replace(/[^-0-9]/g,'')" /> <span
					id="spanTelePhone" class="t17" style="display: none"></span></td>
				<td valign="middle">&nbsp;</td>
				<td valign="middle">&nbsp;</td>
			</tr>
			<tr>
				<td valign="middle"><span class="t14">*</span></td>
				<td valign="middle" class="t01" style="white-space: nowrap;"><strong>邮箱地址：</strong></td>
				<td valign="middle"><input type="text" id="txtREmail"
					maxlength="40" class="b13" onblur="CheckREmail()" /> <span
					id="spanREmail" class="t17" style="display: none"></span></td>
				<td colspan="2" align="left" valign="middle" class="t18">
					<%--用来接收订单提醒邮件，便于您及时了解订单状态--%>
				</td>
			</tr>
			<tr>
				<td style="height: 1px" colspan="5"></td>
			</tr>
			<tr>
				<td colspan="1">&nbsp;</td>
				<td colspan="4" align="left" valign="middle">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td align="left"><input type="button" class="SaveMbrcst"
								onclick="AddMbrcst('new_save')" id="btnSaveMbrcst" value="保存" />
							</td>
							<td align="left"><a href="javascript:void(0)"
								onclick="ReSetMbrcst()">清除重写</a></td>
							<td align="left"></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
	<!-- End:新增收货表单 -->
	<script type="text/javascript">BindProvince();</script>
	<div id="divHint"
		style="margin: 0 auto; padding-top: 4px; padding-bottom: 4px; text-align: center">
		<span style="color: #f00; font-size: 12px;">您暂无收货人信息，请先添加收货人信息</span>
	</div>
	<%
		}else{//有收货地址了。
		
		
		%><!--Start:收货人列表-->
	<form name="frm_sendpay" method="post" action="ReceiverList1.aspx"
		id="frm_sendpay">
		<a name="address_top"></a>
		<table border="0" cellpadding="0" cellspacing="0" class="tb43"
			id="tblMbrcstList">
			<tr>
				<td class="t00" id="tdMbrcst">
					<div id="divLoadMbrcst"
						style="text-align: center; margin-top: 30px; margin-bottom: 30px;">
						<span>正在加载收货人信息...<img
							src="http://images.d1.com.cn/BuyImages/Loading.gif" alt="Loading" /></span>
					</div>
					<div id="divMbrcstList"></div>
				</td>
			</tr>
		</table>

		<!--End:收货人列表-->
		<!-- Start：添加、修改收货人信息 -->
		<table border="0" cellpadding="0" cellspacing="0"
			id="btnAddEditMbrcst">
			<tr>
				<td height="5"></td>
			</tr>
			<tr>
				<td valign="top">&nbsp; <input type="button" class="AddMbrcst"
					style="cursor: pointer;" onclick="ToggleAddEditMbrcst()"
					value="添加收货人" /> <img
					src="http://images.d1.com.cn/images2011/buy/alipay_add_query.png"
					style="display: none;" />
				</td>
			</tr>
		</table>
		<!-- End：添加、修改收货人信息 -->
		<!-- Start:新增收货表单 -->
		<input type="hidden" id="hdnMbrcstID" value="0" /> <input
			type="hidden" id="MbrcstAction" value="new_save_consignee" />
		<table style="display: none; border: 0px; margin-top: 10px;"
			cellpadding="3" cellspacing="0" class="t00" id="tblAddEditMbrct">
			<tr>
				<td valign="middle" style="width: 10px"><span class="t14">*</span></td>
				<td valign="middle" class="t01" style="white-space: nowrap;"><strong
					style="white-space: nowrap">姓<span
						style="visibility: hidden">一二</span>名：
				</strong></td>
				<td valign="middle"><input type="text" maxlength="20"
					class="b13" id="txtName" name="txtName" onblur="CheckName()" />&nbsp;<span
					id="spanName" class="t17" style="display: none"></span></td>
				<td valign="middle"></td>
				<td align="left" valign="middle">&nbsp;</td>
			</tr>

			<tr>
				<td valign="middle" style="width: 10px"><span class="t14"></span></td>
				<td valign="middle" class="t01"
					style="width: 60px; white-space: nowrap;"></td>
				<td valign="middle"><input type="radio" id="rdoSex0" value="0"
					name="rdoSex" checked="checked" />&nbsp;&nbsp;先生&nbsp;&nbsp;<input
					type="radio" id="rdoSex1" value="1" name="rdoSex" />&nbsp;&nbsp;女士
				</td>
				<td valign="middle"></td>
				<td align="left" valign="middle">&nbsp;</td>
			</tr>
			<tr>
				<td valign="middle"><span class="t14">*</span></td>
				<td valign="middle" class="t01" style="white-space: nowrap;"><strong>地<span
						style="visibility: hidden">一二</span>区：
				</strong></td>
				<td valign="middle" colspan="2"><select id="ddlProvince"
					class="b15" onchange="ChangeProv(this)">
						<option value="">==请选择==</option>
				</select> <select id="ddlCity" class="b15" onchange="CheckCity()">
						<option value="">==请选择==</option>
				</select> <span id="spanProvinceCity" class="t17" style="display: none"></span>
				</td>
				<td align="left" valign="middle"></td>
			</tr>
			<tr>
				<td valign="middle"><span class="t13"><span class="t14">*</span></span></td>
				<td valign="middle" class="t01" style="white-space: nowrap;"><strong>地<span
						style="visibility: hidden">一二</span>址：
				</strong></td>
				<td colspan="3" valign="middle"><input type="text"
					id="txtRAddress" maxlength="200" class="b13"
					onblur="CheckRAddress()" /> <span id="spanRAddress" class="t17"
					style="display: none"></span></td>
			</tr>
			<tr>
				<td valign="middle"><span class="t14">*</span></td>
				<td valign="middle" class="t01" style="white-space: nowrap;"><strong>邮政编码：</strong></td>
				<td valign="middle"><input type="text" id="txtRZipcode"
					maxlength="6" class="b13" onblur="CheckRZipcode()"
					onkeyup="this.value=this.value.replace(/[^\d]/g,'')"
					onafterpaste="this.value=this.value.replace(/[^\d]/g,'') " /> <span
					id="spanRZipcode" class="t17" style="display: none"></span></td>
				<td align="right" valign="middle">&nbsp;</td>
				<td align="right" valign="middle">&nbsp;</td>
			</tr>
			<tr>
				<td valign="middle"><span class="t13"><span class="t14">*</span></span></td>
				<td valign="middle" class="t01" style="white-space: nowrap;"><strong>手机号码：</strong></td>
				<td valign="middle"><input type="text" id="txtRPhone"
					maxlength="11" class="b13" onblur="CheckRPhone()"
					onkeyup="this.value=this.value.replace(/[^\d]/g,'')"
					onafterpaste="this.value=this.value.replace(/[^\d]/g,'') " /> <span
					id="spanRPhone" class="t17" style="display: none"></span></td>
				<td colspan="2" align="left" valign="middle" class="t18">
					<%--用于接收发货通知短信及送货前确认<br />--%>
				</td>
			</tr>
			<tr>
				<td valign="middle">&nbsp;</td>
				<td valign="middle" class="t01" style="white-space: nowrap;"><strong>固定电话：
				</strong></td>
				<td valign="middle"><input type="text" id="txtTelePhone"
					maxlength="12" class="b13" onblur="CheckTelePhone()"
					onkeyup="this.value=this.value.replace(/[^-0-9]/g,'')"
					onafterpaste="this.value=this.value.replace(/[^-0-9]/g,'')" /> <span
					id="spanTelePhone" class="t17" style="display: none"></span></td>
				<td valign="middle">&nbsp;</td>
				<td valign="middle">&nbsp;</td>
			</tr>
			<tr>
				<td valign="middle"><span class="t14">*</span></td>
				<td valign="middle" class="t01" style="white-space: nowrap;"><strong>邮箱地址：</strong></td>
				<td valign="middle"><input type="text" id="txtREmail"
					maxlength="40" class="b13" onblur="CheckREmail()" /> <span
					id="spanREmail" class="t17" style="display: none"></span></td>
				<td colspan="2" align="left" valign="middle" class="t18">
					<%--用来接收订单提醒邮件，便于您及时了解订单状态--%>
				</td>
			</tr>
			<tr>
				<td style="height: 1px" colspan="5"></td>
			</tr>
			<tr>
				<td colspan="1">&nbsp;</td>
				<td colspan="4" align="left" valign="middle">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td align="left"><input type="button" class="SaveMbrcst"
								onclick="AddMbrcst()" id="btnSaveMbrcst" value="保存" /></td>
							<td align="left">&nbsp; <a href="javascript:void(0)"
								onclick="ReSetMbrcst()">清除重写</a>
							</td>
							<td align="left">&nbsp; <a href="javascript:void(0)"
								onclick="CancelMbrcst()">取消</a>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

		<!-- End:新增收货表单 -->

		<!-- Start:支付方式 -->
		<a name="pay_top"></a>
		<table border="0" cellpadding="0" cellspacing="0" id="tblPayHead"
			width="100%">

			<tr>
				<td class="d2"><span class="t23">&nbsp;支付方式 </span></td>

			</tr>
			<tr>
				<td height="1px" style="background-color: #b43f5c"></td>
			</tr>
			<tr>
				<td><input type="radio" name="req_payid" value="0"
					checked="checked">货到付款</input></td>
			</tr>
		</table>
		<!-- End:支付方式 -->


		<!-- Start:送货时间头 -->
		<a name="shipTime_top"></a>
		<table border="0" cellpadding="0" cellspacing="0" id="tblShipTimeHead"
			width="100%">

			<tr>
				<td class="d2"><span class="t23">&nbsp;送货时间 </span></td>
				<td>
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><span id="spanShipTimeMsg" style="display: none"
								class="t16"></span></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="1px" style="background-color: #b43f5c" colspan="2"></td>
			</tr>
			<tr>
				<td colspan="2" style="height: 6px"></td>
			</tr>
		</table>
		<!-- End:送货时间头 -->
		<!-- Start:送货时间头 -->
		<table border="0" cellpadding="2" cellspacing="2" id="tblShipTime">
			<tr>
				<td><input type="radio" value="送货时间不限（周一至周日均可送货）"
					name="shipTime" /></td>
				<td class="t00">送货时间不限（周一至周日均可送货）</td>
			</tr>
			<tr>
				<td><input type="radio" value="周六日及节假日送货（工作日不送货）"
					name="shipTime" /></td>
				<td class="t00">周六日及节假日送货（工作日不送货）</td>
			</tr>
			<tr>
				<td><input type="radio" value="周一至周五工作日送货" name="shipTime" />
				</td>
				<td class="t00">周一至周五工作日送货</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td class="t00">（写字楼/商用地址客户请选择此项）<br />所有商品将通过快递方式发出。
				</td>
			</tr>
		</table>
		<!-- End:送货时间头 -->
		<!--Start:商品清单头-->
		<table border="0" cellpadding="0" cellspacing="0" id="tblGdsListHead"
			width="100%">

			<tr>
				<td class="d2"><span class="t23">&nbsp;商品清单</span></td>
			</tr>
			<tr>
				<td height="1px" style="background-color: #b43f5c"></td>
			</tr>
			<tr>
				<td style="height: 6px"></td>
			</tr>
		</table>
		<!-- End:商品清单头 -->
		<!-- Start:返回购物车 -->
		<table border="0" cellpadding="0" cellspacing="0" class="tb33"
			id="tblBackCart" style="margin-bottom: 1px; margin-top: 2px;">
			<tr>
				<td align="right"><span class="t00"> <a
						href="/wap/flow.jsp">&nbsp;返回购物车修改</a></span></td>
			</tr>
		</table>
		<!-- End:返回购物车 -->
		<!--Start:商品清单-->
		<table bgcolor="#f3f3f3" border="0" cellpadding="10" cellspacing="0"
			id="tblGdsList" style="margin-top: 1px">
			<%
	           float jifen=0f;
  			    if(list != null && !list.isEmpty()){
  			    	
  			    	int size = list.size();
  			    	for(Cart cart : list){
  			    		Product product = ProductHelper.getById(cart.getProductId());
  			    		if(product == null && cart.getType().longValue()!=-5 ) continue;
  			    		long type = Tools.longValue(cart.getType());
  			    		String goodsName = cart.getTitle();
  			    		Sku sku = SkuHelper.getById(cart.getSkuId());
  			    		long count = Tools.longValue(cart.getAmount());
  			    		float money = Tools.floatValue(cart.getMoney());
  			    		jifen+=money;
  			    %>
			<tr class="GdsListItemRow">

				<td class="t00">
					<%if(Tools.longValue(product.getGdsmst_specialflag()) == 1){
	 					out.print("<img src=\"http://images.d1.com.cn/images2012/New/flow/noticket.gif\" align=\"absmiddle\" alt=\"该商品不能使用优惠券\" />&nbsp;");
	 				}%>&nbsp;<%=goodsName %>
					<%
      				if(type==6){//团购商品
      					%><img src="http://images.d1.com.cn/images2010/tuanbiao.gif" />
					<%
      				} %>
				</td>
			</tr>
			<tr>
				<td>&nbsp;尺码（规格）:<%
      				if(sku != null){
      					out.print("("+sku.getSkumst_sku1()+")");
      				}
      				%></td>
			</tr>
			<tr>
				<td class="t00">&nbsp;小计：<%=Tools.getFormatMoney(money) %></td>
			</tr>
			<tr>
				<td>&nbsp;数量：<%=count %></td>
			</tr>
			<%
    			}}
  			    if(UserHelper.isPtVip(lUser)){
  			    %>
			<tr>
				<td align="center" colspan="6" class="t00"
					style="padding: 4px; background-color: #fff;">
					<table border="0" cellpadding="0" cellspacing="0" width="700">
						<tr id="trBj95">
							<td height="25" align="left">白金VIP会员95折!(特价赠品除外)</td>
							<td></td>
						</tr>
					</table>
				</td>
			</tr>
			<%
		        } %>
		</table>
		<!--End:商品清单-->

		<!--Start:优惠券-->
		<div style="margin-top: 5px; margin-bottom: 5px;">
			<table border="0" cellpadding="2" cellspacing="2">
				<tr>
					<td colspan="6" class="t55" style="text-align: left;"><span
						style="cursor: pointer;" id="useTKT" onclick="ShowTkt();">+使用D1优尚优惠券</span></td>
				</tr>
			</table>
			<div id="divLoadTkt" style="display: none;">
				<span style="font-size: 11px; color: #666">正在加载优惠券...<img
					src="http://images.d1.com.cn/BuyImages/Loading.gif" alt="Loading" /></span>
			</div>
		</div>
		<div id="divTktList"></div>
		<table id="tTicket" style="display: none;">
			<tr>
				<td>已使用<span id="tvalue"></span>元优惠券
				</td>
			</tr>
			<tr>
				<td><a href="javascript:cancleTicket();">取消使用优惠券</a></td>
			</tr>
		</table>
		<!--End:优惠券-->
		<!--Start:预存款-->

		<!--End:预存款-->

		<!--Start:结算信息头-->
		<table border="0" cellpadding="0" cellspacing="0" id="tblAccountHead"
			width="100%">

			<tr>
				<td class="d2"><span class="t23">&nbsp;结算信息</span></td>
			</tr>
			<tr>
				<td height="1px" style="background-color: #b43f5c"></td>
			</tr>
			<tr>
				<td style="height: 6px"></td>
			</tr>
		</table>
		<!--End:结算信息头-->
		<!--Start:优惠券-->

		<div id="tblPrePay"></div>
		<!--End:优惠券-->
		<!--Start:结算信息-->
		<table border="0" cellpadding="2" cellspacing="2" id="tblAccount">
			<tr>
				<td align="right">&nbsp;</td>
				<td colspan="5" class="t00">
					<table width="200" border="0" cellpadding="0" cellspacing="0"
						class="tb13-b">
						<tr>
							<td height="80" align="center" class="t00">
								<table width="200" border="0" cellpadding="0" cellspacing="5">
									<tr>
										<td align="right">商品金额：</td>
										<td align="left" class="t13-b"><span id="lblGdsFee">--</span>元</td>
									</tr>
									<tr>
										<td align="right">+ 运费：</td>
										<td align="left" class="t13-b"><span id="spanShipFee">--</span>元</td>
									</tr>
									<tr>
										<td align="right">- 优惠券：</td>
										<td align="left" class="t13-b"><span id="spanTktValue">--</span>元</td>
									</tr>
									<tr>
										<td align="right">-预存款：</td>
										<td align="left" class="t13-b"><span id="spanUsePrepay">--</span>元</td>
									</tr>
									<tr>
										<td align="right"><span class="t55"
											style="color: #da0000">应付总额：</span></td>
										<td align="left"><span class="t66"><span
												id="lblTotal">--</span>元</span></td>
									</tr>
									<tr>
										<td colspan="2"><span class="t55" style="color: #da0000">您将获得<span
												style="color: red;"><%=jifen %></span>积分
										</span></td>

									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<!--End:结算信息-->
		<!--Start:订单留言-->
		<table border="0" cellpadding="0" cellspacing="0" id="tblGestHead"
			width="100%">

			<tr>
				<td valign="middle" class="d2"><span class="t23">&nbsp;订单留言</span></td>
			</tr>
			<tr>
				<td height="1px" style="background-color: #b43f5c"></td>
			</tr>

		</table>
		<table border="0" cellpadding="10" cellspacing="0" id="tblGest">
			<tr>
				<td><a href="javascript:showmoemo();">填写订单留言>></a></td>
			</tr>
			<tr>
				<td style="height: 6px"></td>
			</tr>
			<tr id="tr1" style="display: none;">
				<td width="98%">&nbsp;<textarea name="txtCustomerMemo"
						id="txtCustomerMemo" rows="5" style="width: 95%;"></textarea>
				</td>
			</tr>
			<tr id="tr2" style="display: none;">
				<td>&nbsp;&nbsp;<a href="javascript:clearmoemo();">清空</a>&nbsp;&nbsp;<a
					href="javascript:canclememo();">取消</a></td>
			</tr>
		</table>
		<!--End:订单留言-->
		<!--Start:提交订单-->
		<table border="0" cellpadding="5" cellspacing="0" id="tblOrder">
			<tr>
				<td align="center">
					<div id="divBtnOrder" style="display: block; text-align: center;">
						&nbsp;<input type="button" id="Submit33" name="Submit33"
							class="SubmitOrder" onclick="javascript:sendupdate()"
							value="提交订单" />
					</div>
					<div id="divLoadOrder" style="display: none; text-align: center;">
						<span style="font-size: 12px; color: #FF0000">正在下单，请稍后...</span>
					</div>
				</td>
			</tr>
			<tr>
				<td height="10px">&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;<a href="/wap/flow.jsp">返回我的购物车&gt;&gt;</a></td>
			</tr>
			<tr>
				<td height="10px">&nbsp;</td>
			</tr>
		</table>
	</form>
	<!--End:提交订单-->
	<%
		} %>

	<%@ include file="/wap/inc/userfoot.jsp"%>
</body>
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-25292063-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
</html>