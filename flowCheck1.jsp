<%@ page contentType="text/html; charset=UTF-8"%><%@include file="inc/header.jsp"%><%@include file="inc/islogin.jsp"%><%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.setDateHeader("Expires", 0);
response.setHeader("Pragma","no-cache");
//查看购物车中是否有物品，没有则跳转
//CartHelper.checkCartError(request,response);

CartHelper.updateAllCartItems(request, response);

List<Cart> list = CartHelper.getCartItems(request,response);
if(list == null || list.isEmpty()){
	response.sendRedirect("/flow.jsp");
	return;
}

if(true){
	//限制type=14的赠品金额，必须满足59才允许提交
	boolean hasGift14 = false ;
	int hasGift14gdsid = 0 ;
	boolean isqrj=false;
	if(list!=null){
		for(Cart c_23049:list){
			if(c_23049.getTitle().trim().indexOf("情人节")>0){
				isqrj=true;
				
			}
			if(c_23049.getType().longValue()==14 && !Tools.isNull(c_23049.getTuanCode())){
				hasGift14 = true ;
				hasGift14gdsid = 1 ;
				break;
			}
			if(c_23049.getType().longValue()==14){
				hasGift14 = true ;
				break;
			}
			
			
		}
	}
	if(hasGift14){
		if((CartHelper.getTotalPayMoney(request, response)<59 && hasGift14gdsid!=1 && !isqrj) || (hasGift14gdsid==1 && CartHelper.getTotalPayMoney(request, response)<2 && !isqrj)){
			response.sendRedirect("/flow.jsp");//有type=14的赠品，但是金额没有59元，不让提交
			return;
		}
		if((CartHelper.getTotalPayMoney(request, response)<299 && hasGift14gdsid!=1 && isqrj) || (hasGift14gdsid==1 && CartHelper.getTotalPayMoney(request, response)<2 && isqrj)){
			response.sendRedirect("/flow.jsp");//有type=14的赠品，但是金额没有299元，不让提交   情人节
			return;
		}
	}
}
//收获地址
ArrayList<UserAddress> addressList = UserAddressHelper.getUserAddressList(lUser.getId());
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>D1优尚网-提交订单！</title>
<link type="text/css" href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" />
<link type="text/css" rel="Stylesheet" href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/flowCheck.css")%>" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/PublicFunction.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/flow/flowCheck1.js")%>"></script>
<style>
.mod_cb_addr { width:831px; font-size:12px; border:1px solid #add9fb; background:#ecf7ff; padding:8px 12px 4px; }
.mod_cb_addr p ,.mod_cb_addr dl ,.mod_cb_addr dt ,.mod_cb_addr dd { margin:0; padding:0;}
.mod_cb_addr .hd { clear:both; overflow:hidden; zoom:1; height:18px; line-height:18px;}
.mod_cb_addr .showall { float:right; padding-right:16px; background:url(http://imgcache.qq.com/vipstyle/act/caibei_110831_addr/img/sign.png) no-repeat right center; color:#0083c0; text-decoration:none; margin-left:16px; }
.mod_cb_addr .manage { float:right; color:#0083c0; text-decoration:none; }
.mod_cb_addr dl { clear:both; color:#666; margin-top:-12px; margin-bottom:16px; line-height:24px;}
.mod_cb_addr dt { height:24px; margin-bottom:10px;}
.mod_cb_addr dd { }
</style>
</head>

<body>
<%@include file="/inc/head3.jsp" %>
<table width="887" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
    	<td height="70"><img src="http://images.d1.com.cn/BuyImages/logo.jpg" width="160" height="56" /></td>
    	<td><img src="http://images.d1.com.cn/BuyImages/cart.jpg" width="54" height="53" alt=""/></td>
    	<td>
			<table width="674" border="0" align="center" cellpadding="0" cellspacing="0">
      			<tr>
        			<td height="33" style="background:url(http://images.d1.com.cn/BuyImages/head_process_06.jpg)">&nbsp;</td>
      			</tr>
    		</table>
    	</td>
  	</tr>
</table>
<table border="0" align="center" cellpadding="0" cellspacing="0" class="tb13">
	<tr>
    	<td>
    		<!-- Start:收货人信息头 -->
		    <table width="887" border="0" align="center" cellpadding="0" cellspacing="0">
			    <tr>
				    <td height="40" colspan="2" style="background:url(http://images.d1.com.cn/BuyImages/tjdd.jpg)">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2" style="height:8px"></td>
				</tr>
      			<tr>
        			<td width="120" height="30"><span class="t23">收货人信息</span></td>
        			<td><span id="spanMbrcstMsg" style="display:none" class="t16"></span></td>
      			</tr>
      			<tr>
          			<td height="1px" style="background-color:#b43f5c" colspan="2"></td>
        		</tr>
      			<tr>
        			<td colspan="2" style="height:8px"></td>
      			</tr>
    		</table>
    		<!--End:收货人信息头--><%
			//用户没有收获地址。
			if(addressList == null || addressList.isEmpty()){
			%>
    		<!-- Start:新增收货表单 -->
    		<form id="formAddr" method="post" action="/flowCheck.jsp" onsubmit="return false;">
    		<input type="hidden" id="hdnMbrcstID" value="0" />
    		<input type="hidden" id="MbrcstAction" value="new_save_consignee" />
            <table style="width:800px;border:0px;" align="center" cellpadding="3" cellspacing="0" class="t00" id="tblAddEditMbrct">
        		<tr>
					<td valign="middle" style="width:10px"><span class="t14">*</span></td>
					<td valign="middle" class="t01" style="width:60px;white-space:nowrap;">
						<strong style="white-space:nowrap">姓<span style="visibility:hidden">一二</span>名：</strong>
					</td>
					<td valign="middle" style="width:328px">
						<input type="text" maxlength="20" class="b13" id="txtName" name="txtName" onblur="CheckName()"/>&nbsp;<span id="spanName" class="t17" style="display:none"></span>
					</td>
					<td valign="middle" style="width:111px">
						<input type="radio" id="rdoSex0" value="0" name="rdoSex" checked="checked"/>&nbsp;&nbsp;先生&nbsp;&nbsp;<input type="radio" id="rdoSex1" value="1" name="rdoSex"/>&nbsp;&nbsp;女士
					</td>
          			<td align="left" valign="middle" style="width:191px">&nbsp;</td>
        		</tr>
        		<tr>
          			<td valign="middle"><span class="t14">*</span></td>
          			<td valign="middle" class="t01" style="white-space:nowrap;">
          				<strong>地<span style="visibility:hidden">一二</span>区：</strong>
          			</td>
          			<td valign="middle" colspan="2">
						<select id="ddlProvince" class="b15" onchange="ChangeProv(this)">
							<option value="">==请选择==</option>
						</select>
                        <select id="ddlCity" class="b15" onchange="CheckCity()">
                        	<option value="">==请选择==</option>
                        </select>
                        <span id="spanProvinceCity" class="t17" style="display:none"></span>
					</td>
          			<td align="left" valign="middle"><a href="http://www.zjs.com.cn/WS_Business/WS_Bussiness_CityArea.aspx?id=6" target="_blank">快速查看货到付款地区</a></td>
        		</tr>
   			    <tr>
				    <td valign="middle"><span class="t13"><span class="t14">*</span></span></td>
        		    <td valign="middle" class="t01" style="white-space:nowrap;">
          			    <strong>地<span style="visibility:hidden">一二</span>址：</strong>
          			</td>
          			<td colspan="3" valign="middle">
						<input type="text" id="txtRAddress" maxlength="200" style="width:440px" class="b13" onblur="CheckRAddress()" />
						<span id="spanRAddress" class="t17" style="display:none"></span>
					</td>
        		</tr>
   			    <tr>
				    <td valign="middle"><span class="t14">*</span></td>
        		    <td valign="middle" class="t01" style="white-space:nowrap;"><strong>邮政编码：</strong></td>
          			<td valign="middle">
          				<input type="text" id="txtRZipcode" maxlength="6" class="b13" onblur="CheckRZipcode()" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/>
          				<span id="spanRZipcode" class="t17" style="display:none"></span>
          			</td>
          			<td align="right" valign="middle">&nbsp;</td>
          			<td align="right" valign="middle">&nbsp;</td>
        		</tr>
				<tr>
          			<td valign="middle"><span class="t13"><span class="t14">*</span></span></td>
         	 		<td valign="middle" class="t01" style="white-space:nowrap;"><strong>手机号码：</strong></td>
          			<td valign="middle">
          				<input type="text" id="txtRPhone" maxlength="11" class="b13" onblur="CheckRPhone()" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/>
          				<span id="spanRPhone" class="t17" style="display:none"></span>
          			</td>
          			<td colspan="2" align="left" valign="middle" class="t18"><%--用于接收发货通知短信及送货前确认<br />--%></td>
        		</tr>
   			    <tr>
   				    <td valign="middle">&nbsp;</td>
   				    <td valign="middle" class="t01" style="white-space:nowrap;"><strong>固定电话： </strong></td>
          			<td valign="middle">
          				<input type="text" id="txtTelePhone" maxlength="12" class="b13" onblur="CheckTelePhone()" onkeyup="this.value=this.value.replace(/[^-0-9]/g,'')" onafterpaste="this.value=this.value.replace(/[^-0-9]/g,'')"/>
			            <span id="spanTelePhone" class="t17" style="display:none"></span>
          			</td>
          			<td valign="middle">&nbsp;</td>
          			<td valign="middle">&nbsp;</td>
        		</tr>
        		<tr>
          			<td valign="middle"><span class="t14">*</span></td>
          			<td valign="middle" class="t01" style="white-space:nowrap;"><strong>邮箱地址：</strong></td>
          			<td valign="middle">
          				<input type="text" id="txtREmail" maxlength="40" class="b13" onblur="CheckREmail()"/>
          				<span id="spanREmail" class="t17" style="display:none"></span>
          			</td>
          			<td colspan="2" align="left" valign="middle" class="t18"><%--用来接收订单提醒邮件，便于您及时了解订单状态--%></td>
        		</tr>  			    
        		<tr>
        			<td style="height:1px" colspan="5"></td>
        		</tr>
        		<tr>
          			<td colspan="2">&nbsp;</td>
          			<td colspan="3" align="left" valign="middle">
						<table width="400" border="0" cellspacing="0" cellpadding="0">
            				<tr>
              					<td align="left">
									<input type="button" class="SaveMbrcst" onclick="AddMbrcst('new_save')" id="btnSaveMbrcst"/>
								</td>
              					<td align="left">
									<a href="javascript:void(0)" onclick="ReSetMbrcst()">清除重写</a>
								</td>
              					<td align="left"></td>
            				</tr>
          				</table>
					</td>
        		</tr>
      		</table>
      		</form>
			<!-- End:新增收货表单 -->
			<script type="text/javascript">BindProvince();</script>
			<div id="divHint" style="margin:0 auto;padding-top:4px;padding-bottom:4px;text-align:center">
				<span style="color:#f00;font-size:12px;">您暂无收货人信息，请先添加收货人信息</span>
			</div><%
		}else{//有收货地址了。
		
		
		%><!--Start:收货人列表-->
		<form name="frm_sendpay" method="post" action="ReceiverList1.aspx" id="frm_sendpay">
			<a name="address_top"></a>
    		<table width="861" border="0" align="center" cellpadding="0" cellspacing="0" class="tb43" id="tblMbrcstList">
      			<tr>
        			<td align="center" class="t00" id="tdMbrcst">
        				<div id="divLoadMbrcst" style="text-align:center;margin-top:30px;margin-bottom:30px;">
	                        <span >正在加载收货人信息...<img src="http://images.d1.com.cn/BuyImages/Loading.gif" alt="Loading" /></span>
                        </div>
                        <div id="divMbrcstList"></div>
        			</td>
      			</tr>
    		</table>
    		<table width="861" border="0" align="center" cellpadding="0" cellspacing="0">
    		<tr>
      			<td height="10">&nbsp;</td>
      			</tr>
      			<tr align="left"><td><div id="divcaibeiMbrcstList"></div></td></tr>
    		</table>
    		<!--End:收货人列表--> 
		    <!-- Start：添加、修改收货人信息 -->
    		<table width="800" border="0" align="center" cellpadding="0" cellspacing="0" id="btnAddEditMbrcst">
				<tr><td height="15"></td></tr>
        		<tr>
          			<td valign="top">
						<input type="button" class="AddMbrcst" style="cursor:pointer;" onclick="ToggleAddEditMbrcst()" />
						<img src="http://images.d1.com.cn/images2011/buy/alipay_add_query.png" style="display:none;" />
					</td>
        		</tr>
    		</table>
    		<!-- End：添加、修改收货人信息 -->
		    <!-- Start:新增收货表单 -->
		    <input type="hidden" id="hdnMbrcstID" value="0" />
    		<input type="hidden" id="MbrcstAction" value="new_save_consignee" />
            <table style="display:none;width:800px;border:0px;margin-top:10px;" align="center" cellpadding="3" cellspacing="0" class="t00" id="tblAddEditMbrct">
        		<tr>
					<td valign="middle" style="width:10px"><span class="t14">*</span></td>
					<td valign="middle" class="t01" style="width:60px;white-space:nowrap;">
						<strong style="white-space:nowrap">姓<span style="visibility:hidden">一二</span>名：</strong>
					</td>
					<td valign="middle" style="width:328px">
						<input type="text" maxlength="20" class="b13" id="txtName" name="txtName" onblur="CheckName()"/>&nbsp;<span id="spanName" class="t17" style="display:none"></span>
					</td>
					<td valign="middle" style="width:111px">
						<input type="radio" id="rdoSex0" value="0" name="rdoSex" checked="checked"/>&nbsp;&nbsp;先生&nbsp;&nbsp;<input type="radio" id="rdoSex1" value="1" name="rdoSex"/>&nbsp;&nbsp;女士
					</td>
          			<td align="left" valign="middle" style="width:191px">&nbsp;</td>
        		</tr>
        		<tr>
          			<td valign="middle"><span class="t14">*</span></td>
          			<td valign="middle" class="t01" style="white-space:nowrap;">
          				<strong>地<span style="visibility:hidden">一二</span>区：</strong>
          			</td>
          			<td valign="middle" colspan="2">
						<select id="ddlProvince" class="b15" onchange="ChangeProv(this)">
							<option value="">==请选择==</option>
						</select>
                        <select id="ddlCity" class="b15" onchange="CheckCity()">
                        	<option value="">==请选择==</option>
                        </select>
                        <span id="spanProvinceCity" class="t17" style="display:none"></span>
					</td>
          			<td align="left" valign="middle"><a href="http://www.zjs.com.cn/WS_Business/WS_Bussiness_CityArea.aspx?id=6" target="_blank">快速查看货到付款地区</a></td>
        		</tr>
   			    <tr>
				    <td valign="middle"><span class="t13"><span class="t14">*</span></span></td>
        		    <td valign="middle" class="t01" style="white-space:nowrap;">
          			    <strong>地<span style="visibility:hidden">一二</span>址：</strong>
          			</td>
          			<td colspan="3" valign="middle">
						<input type="text" id="txtRAddress" maxlength="200" style="width:440px" class="b13" onblur="CheckRAddress()" />
						<span id="spanRAddress" class="t17" style="display:none"></span>
					</td>
        		</tr>
   			    <tr>
				    <td valign="middle"><span class="t14">*</span></td>
        		    <td valign="middle" class="t01" style="white-space:nowrap;"><strong>邮政编码：</strong></td>
          			<td valign="middle">
          				<input type="text" id="txtRZipcode" maxlength="6" class="b13" onblur="CheckRZipcode()" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/>
          				<span id="spanRZipcode" class="t17" style="display:none"></span>
          			</td>
          			<td align="right" valign="middle">&nbsp;</td>
          			<td align="right" valign="middle">&nbsp;</td>
        		</tr>
				<tr>
          			<td valign="middle"><span class="t13"><span class="t14">*</span></span></td>
         	 		<td valign="middle" class="t01" style="white-space:nowrap;"><strong>手机号码：</strong></td>
          			<td valign="middle">
          				<input type="text" id="txtRPhone" maxlength="11" class="b13" onblur="CheckRPhone()" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/>
          				<span id="spanRPhone" class="t17" style="display:none"></span>
          			</td>
          			<td colspan="2" align="left" valign="middle" class="t18"><%--用于接收发货通知短信及送货前确认<br />--%></td>
        		</tr>
   			    <tr>
   				    <td valign="middle">&nbsp;</td>
   				    <td valign="middle" class="t01" style="white-space:nowrap;"><strong>固定电话： </strong></td>
          			<td valign="middle">
          				<input type="text" id="txtTelePhone" maxlength="12" class="b13" onblur="CheckTelePhone()" onkeyup="this.value=this.value.replace(/[^-0-9]/g,'')" onafterpaste="this.value=this.value.replace(/[^-0-9]/g,'')"/>
			            <span id="spanTelePhone" class="t17" style="display:none"></span>
          			</td>
          			<td valign="middle">&nbsp;</td>
          			<td valign="middle">&nbsp;</td>
        		</tr>
        		<tr>
          			<td valign="middle"><span class="t14">*</span></td>
          			<td valign="middle" class="t01" style="white-space:nowrap;"><strong>邮箱地址：</strong></td>
          			<td valign="middle">
          				<input type="text" id="txtREmail" maxlength="40" class="b13" onblur="CheckREmail()"/>
          				<span id="spanREmail" class="t17" style="display:none"></span>
          			</td>
          			<td colspan="2" align="left" valign="middle" class="t18"><%--用来接收订单提醒邮件，便于您及时了解订单状态--%></td>
        		</tr>  			    
        		<tr>
        			<td style="height:1px" colspan="5"></td>
        		</tr>
        		<tr>
          			<td colspan="2">&nbsp;</td>
          			<td colspan="3" align="left" valign="middle">
						<table width="400" border="0" cellspacing="0" cellpadding="0">
            				<tr>
              					<td align="left">
									<input type="button" class="SaveMbrcst" onclick="AddMbrcst()" id="btnSaveMbrcst"/>
								</td>
              					<td align="left">
									<a href="javascript:void(0)" onclick="ReSetMbrcst()">清除重写</a>
								</td>
              					<td align="left">
									<a href="javascript:void(0)" onclick="CancelMbrcst()">取消</a>
								</td>
            				</tr>
          				</table>
					</td>
        		</tr>
      		</table>
			<!-- End:新增收货表单 -->
				    
			<!-- Start:支付方式头 -->
			<a name="pay_top"></a>
      		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="tblPayHead">
            	<tr>
        			<td height="2">&nbsp;</td>
      			</tr>
        		<tr>
          			<td width="200" height="30"><span class="t23">支付方式 </span>
          			</td>
          			<td>
          			<%SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
          			Date dStartDate=null;
          			try{
          				   	 dStartDate =fmt.parse("2012-4-21");
          				 }
          			catch(Exception ex){
          				ex.printStackTrace();
          			}
          			if(Tools.dateValue(dStartDate)>System.currentTimeMillis())
          			{
          				%>
          	           <table border="0" cellspacing="0" cellpadding="0">
              				<tr>
                				<td><span style="font-size:12px;"><a href="http://fun.alipay.com/kxq/index.htm" target="_blank">订单满39元选择支付宝付款可获得抽奖机会！</a></span>
                				<span id="spanPayMsg" style="display:none" class="t16"></span></td>
              				</tr>
          				</table>
          				<%
          			}  %>
					</td>
        		</tr>
        		<tr>
          			<td height="1px" style="background-color:#b43f5c" colspan="2"></td>
        		</tr>
        		<tr>
          			<td colspan="2" style="height:6px"></td>
        		</tr>
      		</table>
			<!-- End:支付方式头 -->
				    
			<!--Start:支付方式-->
			<div id="divLoadPay" style="text-align:center;margin-top:30px;margin-bottom:30px;">
            	<span style="font-size:11px;color:#666">正在加载支付方式...<img src="http://images.d1.com.cn/BuyImages/Loading.gif" alt="Loading" /></span>
            </div>
            <div id="divPayList"></div>
            <!--End:支付方式-->
            <!-- Start:送货时间头 -->
            <a name="shipTime_top"></a>
      		<table width="887" border="0" align="center" cellpadding="0" cellspacing="0" id="tblShipTimeHead">
            	<tr>
        			<td height="2">&nbsp;</td>
      			</tr>
        		<tr>
          			<td width="200" height="30"><span class="t23">送货时间 </span></td>
          			<td>
						<table border="0" cellspacing="0" cellpadding="0">
              				<tr>
                				<td><span id="spanShipTimeMsg" style="display:none" class="t16"></span></td>
              				</tr>
          				</table>
					</td>
        		</tr>
        		<tr>
          			<td height="1px" style="background-color:#b43f5c" colspan="2"></td>
        		</tr>
        		<tr>
          			<td colspan="2" style="height:6px"></td>
        		</tr>
      		</table>
			<!-- End:送货时间头 --> 
		    <!-- Start:送货时间头 -->
    		<table width="861" border="0" align="center" cellpadding="2" cellspacing="2" id="tblShipTime">
        		<tr>
          			<td align="right" style="width:100px">
          				<input type="radio" value="送货时间不限（周一至周日均可送货）" name="shipTime"/>
          			</td>
          			<td class="t00">送货时间不限（周一至周日均可送货）</td>
        		</tr>
        		<tr>
          			<td align="right">
          				<input type="radio" value="周六日及节假日送货（工作日不送货）" name="shipTime"/>
          			</td>
          			<td class="t00">周六日及节假日送货（工作日不送货）</td>
        		</tr>
        		<tr>
          			<td align="right">
          				<input type="radio" value="周一至周五工作日送货" name="shipTime"/>
          			</td>
          			<td class="t00">周一至周五工作日送货（写字楼/商用地址客户请选择此项）</td>
        		</tr>
        		<tr>
          			<td align="right">&nbsp;</td>
          			<td class="t00">所有商品将通过快递方式发出。</td>
        		</tr>
    		</table>
    		<!-- End:送货时间头 -->
		    <!--Start:商品清单头-->
    		<table width="887" border="0" align="center" cellpadding="0" cellspacing="0" id="tblGdsListHead">
            	<tr>
       				<td height="2">&nbsp;</td>
      			</tr>
        		<tr>
          			<td height="30"><span class="t23">商品清单</span></td>
        		</tr>
        		<tr>
          			<td height="1px" style="background-color:#b43f5c" colspan="2"></td>
        		</tr>
        		<tr>
          			<td style="height:6px"></td>
        		</tr>
      		</table>
      		<!-- End:商品清单头 -->
		    <!-- Start:返回购物车 -->
      		<table width="734" border="0" align="center" cellpadding="0" cellspacing="0" class="tb33" id="tblBackCart" style="margin-bottom:1px;margin-top:2px;">
        		<tr>
          			<td align="right"><span class="t00"> <a href="/flow.jsp">返回购物车修改</a></span></td>
        		</tr>
      		</table>
      		<!-- End:返回购物车 -->
		    <!--Start:商品清单-->
            <table bgcolor="#f3f3f3" width="734" border="0" align="center" cellpadding="10" cellspacing="0" id="tblGdsList" style="margin-top:1px">
	            <tr class="GdsListHeadRow">
    				<td style="width:60px">商品编号</td>
      				<td style="width:440px">商品名称</td>
      				<td style="width:80px">会员价</td>
      				<td style="width:50px">数量</td>
      				<td style="width:50px">小计</td>
      				<td style="width:50px">积分</td>
  			    </tr><%
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
  			    %>
	            <tr class="GdsListItemRow">
    				<td align="center"><%=cart.getProductId() %></td>
      				<td class="t00"><%if(Tools.longValue(product.getGdsmst_specialflag()) == 1){
	 					out.print("<img src=\"/res/images/flow/noticket.gif\" align=\"absmiddle\" alt=\"该商品不能使用优惠券\" />&nbsp;");
	 				}%><%=goodsName %><%
      				if(type==6){//团购商品
      					%><img src="http://images.d1.com.cn/images2010/tuanbiao.gif" /><%
      				} %><%
      				if(sku != null){
      					out.print("("+sku.getSkumst_sku1()+")");
      				}
      				%></td>
      				<td align="center" class="t00"><%=Tools.getFormatMoney(Tools.floatValue(cart.getOldPrice())) %></td>
      				<td align="center"><%=count %></td>
      				<td align="center" class="t00"><%=Tools.getFormatMoney(money) %></td>
      				<td align="center" class="t00"><%=(int)money %></td>
    			</tr><%
    			}}
  			    if(UserHelper.isPtVip(lUser)){
  			    %>
	            <tr>
		            <td align="center" colspan="6" class="t00" style="padding:4px;background-color:#fff;">
			            <table border="0" cellpadding="0" cellspacing="0" width="700">
				            <tr id="trBj95">
			    	            <td height="25" width="500" align="left">白金VIP会员95折!(特价赠品除外)</td>
			                    <td></td>
			                </tr>
			            </table>
                    </td>
		        </tr><%
		        } %>
        	</table>
		    <!--End:商品清单-->
      			    
      		<!--Start:结算信息头-->
      		<table width="887" border="0" align="center" cellpadding="0" cellspacing="0" id="tblAccountHead">
            	<tr>
        			<td height="2">&nbsp;</td>
     			</tr>
        		<tr>
          			<td height="30"><span class="t23">结算信息</span></td>
        		</tr>
        		<tr>
          			<td height="1px" style="background-color:#b43f5c" colspan="2"></td>
        		</tr>
        		<tr>
          			<td style="height:6px"></td>
        		</tr>
      		</table>
      		<!--End:结算信息头-->
		    <!--Start:优惠券-->
      		<div style="text-align:center;margin-top:30px;margin-bottom:30px;">
            	<table width="861" border="0" align="center" cellpadding="2" cellspacing="2">
            		<tr>
						<td width="50" align="right">&nbsp;</td>
					    <td colspan="6" class="t55" style="text-align:left;"><span style="cursor:pointer;" id="useTKT" onclick="ShowTkt();">+使用D1优尚优惠券</span></td>
					</tr>
            	</table>
            	<div id="divLoadTkt" style="display:none;">
            		<span style="font-size:11px;color:#666">正在加载优惠券...<img src="http://images.d1.com.cn/BuyImages/Loading.gif" alt="Loading" /></span>
            	</div>
            </div>
            <div id="divTktList"></div>
            <!--End:优惠券-->
            <div id="tblPrePay"></div>
   			<!--Start:结算信息-->
        	<table width="800" border="0" align="center" cellpadding="2" cellspacing="2" id="tblAccount">
        		<tr>
          			<td align="right"><!-- <div id="actzhetxt"></div>--></td>
          			<td colspan="5" class="t00">
						<table width="200" border="0" cellpadding="0" cellspacing="0" class="tb13-b">
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
                						<!--  <tr>
                  							<td align="right">- 店庆折扣金额：</td>
                  							<td align="left" class="t13-b"><span id="spanActZhe">--</span>元</td>
                						</tr>-->
                						<tr>
                  							<td align="right">-预存款：</td>
                  							<td align="left" class="t13-b"><span id="spanUsePrepay">--</span>元</td>
                						</tr>
                						<tr>
                  							<td align="right"><span class="t55" style="color:#da0000">应付总额：</span></td>
                  							<td align="left"><span class="t66"><span id="lblTotal">--</span>元</span></td>
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
      		<table width="887" border="0" align="center" cellpadding="0" cellspacing="0" id="tblGestHead">
            	<tr>
        			<td height="2">&nbsp;</td>
      			</tr>
        		<tr>
          			<td height="30" valign="middle"><span class="t23">订单留言</span></td>
        		</tr>
        		<tr>
          			<td height="1px" style="background-color:#b43f5c" colspan="2"></td>
        		</tr>
        		<tr>
          			<td style="height:6px">&nbsp;</td>
        		</tr>
      		</table>
      		<table width="800" border="0" align="center" cellpadding="10" cellspacing="0" id="tblGest">
        		<tr>
          			<td><span class="t00"> 您对送货时间、商品或其他方面有特殊要求，请在这里留言：</span></td>
        		</tr>
        		<tr>
          			<td>
          				<textarea name="txtCustomerMemo" id="txtCustomerMemo" cols="95" rows="5"></textarea>
					</td>
        		</tr>
    		</table>
      		<!--End:订单留言-->
		    <!--Start:提交订单-->
    		<table width="861" border="0" align="center" cellpadding="20" cellspacing="0" id="tblOrder">
        		<tr>
          			<td width="821" align="center">							    
						<div id="divBtnOrder" style="display:block;text-align:center;">
							<input type="button" id="Submit33" name="Submit33" class="SubmitOrder" onclick="javascript:sendupdate()"/>
						</div>
						<div id="divLoadOrder" style="display:none;text-align:center;">
                        	<span style="font-size:12px;color:#FF0000">正在下单，请稍后...</span>
                        </div>
					</td>
        		</tr>
    		</table>
    	</form>
    	<!--End:提交订单--><%
		} %>
		</td>
  	</tr>
</table>
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