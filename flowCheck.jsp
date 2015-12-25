<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*"%><%@include file="inc/header.jsp"%><%@include file="inc/islogin.jsp"%><%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.setDateHeader("Expires", 0);
response.setHeader("Pragma","no-cache");
//查看购物车中是否有物品，没有则跳转
//CartHelper.checkCartError(request,response);

CartHelper.updateAllCartItems(request, response);
//String cartshopcode="00000000";
//if(session.getAttribute("Cart_ShopCode")!=null){
//cartshopcode= session.getAttribute("Cart_ShopCode").toString();
//}
//List<Cart> list = CartShopCodeHelper.getCartItems(request,response,cartshopcode);
List<Cart> list = CartHelper.getCartItems(request,response);

float getshopactmoney=  CartHelper.getShopActCutMoney(request, response);
if(list == null || list.isEmpty()){
	response.sendRedirect("/flow.jsp");
	return;
}
boolean iszfqr=false;//绽放秋日
String gdsidlist="01417340";
String xlpid="01517437";
int countRcode=0;
int countXl=0;
boolean iszippo=false;boolean iszippozp=false;int zippo=0;int zippozp=0;
//String plist="02000791,02000792,02000793,02000795,02000794,02000796,02000797";//打底裤
int ddknum=0;
boolean isddk=false;
boolean istl=false;
if(list!=null){
	for(Cart c_23049:list){	
		//if(c_23049.getType().longValue()==14 && (gdsidlist.indexOf(c_23049.getProductId())>=0)&& c_23049.getPrice()==0){
		//	iszfqr=true;
		//}
		//if(c_23049.getType().longValue()==13 && (plist.indexOf(c_23049.getProductId())>=0)){
		//	isddk=true;
		//}
		//if(c_23049.getType().longValue()==14 && (plist.indexOf(c_23049.getProductId())>=0)){
		//	ddknum++;
		//}
		if(c_23049.getType().longValue()==13 && ("01511126".equals(c_23049.getProductId()))){
			iszippo=true;zippo++;
		}
		if(c_23049.getType().longValue()==14 && ("01511167".equals(c_23049.getProductId()))){
			iszippozp=true; zippozp++;
		}
		if(c_23049.getType().longValue()==14 && (c_23049.getProductId().equals("01721234") || c_23049.getProductId().equals("01415776")) ){
			istl=true;
		}
		/**
		Product p=ProductHelper.getById(c_23049.getProductId());
		if(p!=null && "020004".equals(p.getGdsmst_rackcode().trim())){
			long discountendDate = Tools.dateValue(p.getGdsmst_discountenddate());//应该是秒杀结束的时间。
			long currentTime = System.currentTimeMillis();
			float hyprice = 0;
			if(!(discountendDate >= currentTime && discountendDate <= currentTime+Tools.MONTH_MILLIS) && Tools.floatValue(p.getGdsmst_memberprice())>=99){
				countRcode++;//毛衣的件数
			}
		}
		
		if((c_23049.getType().longValue()==14 || c_23049.getType().longValue()==0) && xlpid.equals(c_23049.getProductId())){
			countXl++;//毛衣链个数
		}
		**/
	}
}
if(iszfqr && CartHelper.getTotalPayMoney(request, response)<239){
	response.sendRedirect("/flow.jsp");//有type=14的赠品，但是金额没有299元，不让提交
	return;
}
if(istl && CartHelper.getTotalPayMoney(request, response)<2){
	response.sendRedirect("/flow.jsp");
	return;
}
if(!isddk && ddknum>0){
	response.sendRedirect("/flow.jsp");
	return;
}
if(ddknum>5){
	response.sendRedirect("/flow.jsp");
	return;
}
if(!iszippo && iszippozp){//没zippo 但有zippo赠品
	response.sendRedirect("/flow.jsp");
	return;
}
if(zippozp>zippo){//赠品数大于zippo数
	response.sendRedirect("/flow.jsp");
	return;
}
//if(true){
	//限制type=14的赠品金额，必须满足59才允许提交
	//boolean hasGift14 = false ;
	//int hasGift14gdsid = 0 ;
	//boolean isqrj=false;
	//boolean ishwy=false;
	//if(list!=null){
		//for(Cart c_23049:list){
			//if(c_23049.getTitle().trim().indexOf("情人节")>0){
				///isqrj=true;
				
			//}
			//if(c_23049.getTitle().trim().indexOf("红五月")>=0){
				//ishwy=true;
			//}
			//if(c_23049.getType().longValue()==14 && !Tools.isNull(c_23049.getTuanCode())){
				//hasGift14 = true ;
				//hasGift14gdsid = 1 ;
				//break;
			//}
			//if(c_23049.getType().longValue()==14){
				//hasGift14 = true ;
				//break;
			//}
			
			
		//}
	//}
	//if(hasGift14){
		//if(((CartHelper.getTotalPayMoney(request, response)<59 && hasGift14gdsid!=1 && !isqrj) || (hasGift14gdsid==1 && CartHelper.getTotalPayMoney(request, response)<2 && !isqrj) ) && !ishwy){
			//response.sendRedirect("/flow.jsp");//有type=14的赠品，但是金额没有59元，不让提交
			//return;
		//}
		//if((CartHelper.getTotalPayMoney(request, response)<299 && hasGift14gdsid!=1 && isqrj) || (hasGift14gdsid==1 && CartHelper.getTotalPayMoney(request, response)<2 && isqrj)){
			//response.sendRedirect("/flow.jsp");//有type=14的赠品，但是金额没有299元，不让提交   情人节
			//return;
		//}
		//if(CartHelper.getTotalRackcodePayMoney(request, response,"014")<299  && ishwy){
			//out.print("{\"error\":-5,\"content\":\"\"}");//参加红五月活动，化妆品金额不满299
			//return;
		//}
	//}
//}
//收获地址
ArrayList<UserAddress> addressList = UserAddressHelper.getUserAddressList(lUser.getId());
String ph="";
if(lUser.getMbrmst_phoneflag()!=null&&lUser.getMbrmst_phoneflag().longValue()==1)ph=lUser.getMbrmst_usephone();

%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>D1优尚网-提交订单！</title>
<link type="text/css" href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head2012.css")%>" rel="stylesheet" type="text/css" />
<link type="text/css" rel="Stylesheet" href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/flowCheck.css")%>" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/PublicFunction.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/flow/flowCheck.js")%>"></script>
<style>
.mod_cb_addr { width:831px; font-size:12px; border:1px solid #add9fb; background:#ecf7ff; padding:8px 12px 4px; }
.mod_cb_addr p ,.mod_cb_addr dl ,.mod_cb_addr dt ,.mod_cb_addr dd { margin:0; padding:0;}
.mod_cb_addr .hd { clear:both; overflow:hidden; zoom:1; height:18px; line-height:18px;}
.mod_cb_addr .showall { float:right; padding-right:16px; background:url(http://imgcache.qq.com/vipstyle/act/caibei_110831_addr/img/sign.png) no-repeat right center; color:#0083c0; text-decoration:none; margin-left:16px; }
.mod_cb_addr .manage { float:right; color:#0083c0; text-decoration:none; }
.mod_cb_addr dl { clear:both; color:#666; margin-top:-12px; margin-bottom:16px; line-height:24px;}
.mod_cb_addr dt { height:24px; margin-bottom:10px;}
.mod_cb_addr dd { }
.yfgz{overflow:hidden;_zoom:1;}


.d1actt{width:480px;float:left;}
.d1actp{ width:240px; float:right;}
.d1actttile{background: #7abd54;float:left; margin:0px 15px;height:22px;padding:0px 15px 0px 15px; line-height:21px;color:#fff;display: block;}
.d1actmore{background: #f0424e;float:left; margin:0px 15px;height:22px;padding:0px 15px 0px 15px; line-height:21px;color:#fff;display: block;}
.d1actmore a{color:#fff}
.deactspan{float:left; height:22px;padding:0px 15px 0px 15px; line-height:21px;display: block; }

</style>
</head>

<body>
<%@include file="/inc/head3.jsp" %>
<table width="887" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
    	<td height="70"><a href="/" target="_blank"><img src="http://images.d1.com.cn/BuyImages/logo.jpg" width="160" height="56" /></a></td>
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
				    <td valign="middle"></td>
        		    <td valign="middle" class="t01" style="white-space:nowrap;"><strong>邮政编码：</strong></td>
          			<td valign="middle">
          				<input type="text" id="txtRZipcode" maxlength="6" class="b13" onblur="CheckRZipcode()" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/>
          				<span style="color:black;">&nbsp;&nbsp;&nbsp;&nbsp;有助于快速确定收货地址</span>
          				<span id="spanRZipcode" class="t17" style="display:none"></span>
          			</td>
          			<td align="right" valign="middle">&nbsp;</td>
          			<td align="right" valign="middle">&nbsp;</td>
        		</tr>
				<tr>
          			<td valign="middle"><span class="t13"><span class="t14">*</span></span></td>
         	 		<td valign="middle" class="t01" style="white-space:nowrap;"><strong>手机号码：</strong></td>
          			<td valign="middle">
          				<input type="text" id="txtRPhone" maxlength="11" class="b13" value="<%=ph %>" onblur="CheckRPhone()" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/>
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
          			<td valign="middle"></td>
          			<td valign="middle" class="t01" style="white-space:nowrap;"><strong>邮箱地址：</strong></td>
          			<td valign="middle" colspan="3">
          				<input type="text" id="txtREmail" maxlength="40" class="b13" onblur="CheckREmail()"/>
          				<span style="color:black;">&nbsp;&nbsp;&nbsp;&nbsp;用来接收订单提醒邮件，便于您及时了解订单状态</span>
          				
          				<span id="spanREmail" class="t17" style="display:none"></span>
          			</td>
          			
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
					
					<b style="font-size:14px;color:#0257CC;">[</b>	<a style="color:#0257CC;text-decoration:underline;font-size:14px; font-weight:bold;" href="javascript:ToggleAddEditMbrcst();">+新增收货人</a>&nbsp;<b style="font-size:14px;color:#0257CC;">]</b>
						
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
				    <td valign="middle"></td>
        		    <td valign="middle" class="t01" style="white-space:nowrap;"><strong>邮政编码：</strong></td>
          			<td valign="middle">
          				<input type="text" id="txtRZipcode" maxlength="6" class="b13" onblur="CheckRZipcode()" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/>
          					<span style="color:black;">&nbsp;&nbsp;&nbsp;&nbsp;有助于快速确定收货地址</span>
          				<span id="spanRZipcode" class="t17" style="display:none"></span>
          			</td>
          			<td align="right" valign="middle">&nbsp;</td>
          			<td align="right" valign="middle">&nbsp;</td>
        		</tr>
				<tr>
          			<td valign="middle"><span class="t13"><span class="t14">*</span></span></td>
         	 		<td valign="middle" class="t01" style="white-space:nowrap;"><strong>手机号码：</strong></td>
          			<td valign="middle">
          				<input type="text" id="txtRPhone" value="<%=ph %>" maxlength="11" class="b13" onblur="CheckRPhone()" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/>
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
          			<td valign="middle"></td>
          			<td valign="middle" class="t01" style="white-space:nowrap;"><strong>邮箱地址：</strong></td>
          			<td valign="middle" colspan="3" >
          				<input type="text" id="txtREmail" maxlength="40" class="b13" onblur="CheckREmail()"/>
          				<span style="color:black;">&nbsp;&nbsp;&nbsp;&nbsp;用来接收订单提醒邮件，便于您及时了解订单状态</span>
          				<span id="spanREmail" class="t17" style="display:none"></span>
          			</td>
          			
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
          				   	 dStartDate =fmt.parse("2012-04-07");
          				 }
          			catch(Exception ex){
          				ex.printStackTrace();
          			}
          			if(Tools.dateValue(dStartDate)>System.currentTimeMillis())
          			{
          				%>
          	           <table border="0" cellspacing="0" cellpadding="0">
              				<tr>
                				<td><span style="font-size:12px;"><a href="http://union.tenpay.com/act2012/huiyuan/?ADTAG=TENPAY.INDEX.HUIYUAN.SJGG " target="_blank">财付通支付 订单满50元可参加抽奖！</a></span>
                				<span id="spanPayMsg" style="display:none" class="t16"></span></td>
              				</tr>
          				</table>
          				<%
          			}  %>
          			<!-- &nbsp;&nbsp;<font style="color:#f00;"><b>重要提示：春节期间银行电汇和邮局汇款款项顺延到节后工作日确认，建议您选择网上支付方式，可立即到账。</b></font> -->
          			
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
  			  long allactmoney=0;
  			    String strsessionid="";
  			    if(list != null && !list.isEmpty()){
  			    	int size = list.size();
  			  	Collections.sort(list,new ActComparator());
  			  int actid=0;
  			int oldactid=0;
  			long shopactmoney=0;
  			    	for(Cart cart : list){
  			    		Product product = ProductHelper.getById(cart.getProductId());
  			    		if(product == null && cart.getType().longValue()!=-5 ) continue;
  			    		long type = Tools.longValue(cart.getType());
  			    		String goodsName = cart.getTitle();
  			    		Sku sku = SkuHelper.getById(cart.getSkuId());
  			    		long count = Tools.longValue(cart.getAmount());
  			    		float money = Tools.floatValue(cart.getMoney());
  			    	  String shopcode=cart.getShopcode();
  			    	strsessionid=cart.getCookie();
  			    		 if(cart.getActid()!=null){
  			    			 actid=cart.getActid().intValue();
  			    		 }else{
  			    			 oldactid=0;
  			    		 }
  			    		if(oldactid!=actid){
  			    			 D1ActTb d1act=CartHelper.getShopAct(list, shopcode, actid+"");
  			    			 float d1actpmoney=CartHelper.getCartShopActPayMoney(request,response,d1act);
  			    			 long actmoney=0;
  			    			 if(d1act!=null){
  			    				String showactt="活动商品购满"+d1act.getD1acttb_snum1()+"元，即可享受满减";
  			    				String showactt2="";
  			    				
  			    				 if(cart.getActmoney()!=null&&cart.getActmoney().longValue()>0){
  			    					 if(d1act.getD1acttb_snum3().floatValue()>0f&&d1actpmoney>=d1act.getD1acttb_snum3().floatValue()){
  			    						 actmoney=d1act.getD1acttb_enum3();
  			    						 showactt="活动商品已购满"+d1act.getD1acttb_snum3()+"元，已减"+actmoney+"元";
  			    						
  			    					    }else if(d1act.getD1acttb_snum2().floatValue()>0f&&d1actpmoney>=d1act.getD1acttb_snum2().floatValue()){
  			    					    	actmoney=d1act.getD1acttb_enum2();
  			    					    	showactt="活动商品已购满"+d1act.getD1acttb_snum2()+"元，已减"+actmoney+"元";
  			    						}else if(d1act.getD1acttb_snum1().floatValue()>0f&&d1actpmoney>=d1act.getD1acttb_snum1().floatValue()){
  			    							actmoney=d1act.getD1acttb_enum1();
  			    							showactt="活动商品已购满"+d1act.getD1acttb_snum1()+"元，已减"+actmoney+"元";
  			    						}
  			    					 showactt2	="减免：¥"+actmoney;
  			    					 shopactmoney+=actmoney;
  			    				 }
  			    			String fxtxt="";
  			    			if(actmoney >0)fxtxt="<span class=\"d1actttile\">减免："+actmoney+"元</span>";
  			    			String acttxt="";
  			    			String goshopurl="";
  			    			if(d1act.getD1acttb_acttype().longValue()==0){
  			    				acttxt="满减";
  			    				ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(d1act.getD1acttb_shopcode());
  	  			    			if(shpmst!=null&&shpmst.getShpmst_index().longValue()==1&&
  	  			    					!Tools.isNull(shpmst.getShpmst_shopsname())){
  	  			    			goshopurl="http://www.d1.com.cn/shop/"+shpmst.getShpmst_shopsname();
  	  			    			}
  			    			}
  			    			
  			    			if(d1act.getD1acttb_acttype().longValue()==1){
  			    				acttxt="专区满减";
  			    				goshopurl="http://www.d1.com.cn/html/result_rec.jsp?aid="+d1act.getD1acttb_ppcode();
  			    			}else if(d1act.getD1acttb_acttype().longValue()==2){
  			    				acttxt="品牌满减";
  			    				goshopurl="http://www.d1.com.cn/shopbrand.jsp?sc="+d1act.getD1acttb_shopcode()+"&brand="+d1act.getD1acttb_brandcode();

  			    			}else if(d1act.getD1acttb_acttype().longValue()==3){
  			    				String ppcode=d1act.getD1acttb_ppcode();
  			    				acttxt="";
  			    				if("020".equals(ppcode))acttxt="女装满减";
  			    				if("030".equals(ppcode))acttxt="男装满减";
  			    				if("050".equals(ppcode))acttxt="箱包满减";
  			    				if("012".equals(ppcode))acttxt="居家满减";
  			    				if("015".equals(ppcode))acttxt="名品饰品满减";
  			    				goshopurl="http://www.d1.com.cn/result.jsp?shopd1=1&productsort="+ppcode;

  			    			}
  			    	
  			    			

  			    	 out.print("<tr><td   bgcolor=\"#dbeefd\" colspan=\"6\"><div class=\"d1actt\"><span class=\"d1actttile\">满减</span><span class=\"deactspan\">&nbsp;"+showactt+"</span><span class=\"d1actmore\"><a href=\""+goshopurl+"\" target=\"_blank\">查看活动</a></span></div><div class=\"d1actp\"><span class=\"deactspan\">"+d1actpmoney+"</span>"+fxtxt+"</div> </td></tr>");
  			    	 }
  			    	 } 
  			    %>
	            <tr class="GdsListItemRow">
    				<td align="center"><%=cart.getProductId() %></td>
      				<td class="t00"><%if(Tools.longValue(product.getGdsmst_specialflag()) == 1){
	 					out.print("<img src=\"http://images.d1.com.cn/images2012/New/flow/noticket.gif\" align=\"absmiddle\" alt=\"该商品不能使用优惠券\" />&nbsp;");
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
    			if(cart.getActid()!=null){
					 oldactid=cart.getActid().intValue();
				 }else{
					 oldactid=0;
				 }	
    			}
  			      allactmoney+=shopactmoney; 
  			    }
  			    System.out.println(allactmoney+"---------------------"+getshopactmoney);
  		       if((long)getshopactmoney!=allactmoney){
  				response.sendRedirect("/flow.jsp");
  				return;
  			}
  			    
  			    //if(UserHelper.isPtVip(lUser)){
  			    %>
  			    <!--  
	            <tr>
		            <td align="center" colspan="6" class="t00" style="padding:4px;background-color:#fff;">
			            <table border="0" cellpadding="0" cellspacing="0" width="700">
				            <tr id="trBj95">
			    	            <td height="25" width="500" align="left">白金会员享受服饰88折优惠，化妆品及手表95折优惠。</td>
			                    <td></td>
			                </tr>
			            </table>
                    </td>
		        </tr>
		        -->
		        <%
		        //} 
  			    //else if(UserHelper.isVip(lUser)){
  			    %>
  			    <!--  
	            <tr>
		            <td align="center" colspan="6" class="t00" style="padding:4px;background-color:#fff;">
			            <table border="0" cellpadding="0" cellspacing="0" width="700">
				            <tr id="trBj95">
			    	            <td height="25" width="500" align="left">vip会员享受服饰95折优惠</td>
			                    <td></td>
			                </tr>
			            </table>
                    </td>
		        </tr>
		        --><%
		        //} %>
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
      		<% //if(cartshopcode.equals("00000000")){%>
		    <!--Start:优惠券-->
      		<div style="text-align:center;margin-top:30px;margin-bottom:30px;">
            	<table width="861" border="0" align="center" cellpadding="2" cellspacing="2">
            		<tr>
						<td width="50" align="right">&nbsp;</td>
					    <td colspan="6" class="t55" style="text-align:left;"><span style="cursor:pointer;" id="useTKT" onclick="ShowTkt();">+使用D1优尚优惠券</span></td>
					</tr>
            	</table>
            	<%
            	
            	float m_fltBrdTktPrice = CartHelper.getBrandCutMoney(request,response);//品牌减免总金额。
            			//参加活动的价格
                  //float m_bjhdmoney=CartHelper.getbjhdProductMoney(request,response);//半价活动金额。
                  float  m_bjhdmoney=0f;
                  %>
            	<%if (m_fltBrdTktPrice>0||m_bjhdmoney>=200f) {%>
            	<script  type="text/javascript">ShowTkt();</script>
            	<%} %>
            	<div id="divLoadTkt"  style="display:none;">
            		<span style="font-size:11px;color:#666">正在加载优惠券...<img src="http://images.d1.com.cn/BuyImages/Loading.gif" alt="Loading" /></span>
            	</div>
            	
            </div>
            <div id="divTktList"></div>
            <!--End:优惠券-->
            <%//} %>
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
                  							<td align="right">- 优惠券：</td>
                  							<td align="left" class="t13-b"><span id="spanTktValue">--</span>元</td>
                						</tr>
                						<tr>
                  							<td align="right">- 满减金额：</td>
                  							<td align="left" class="t13-b"><span id="spand1ActValue">--</span>元</td>
                						</tr>
                						<!--  <tr>
                  							<td align="right">- 店庆折扣金额：</td>
                  							<td align="left" class="t13-b"><span id="spanActZhe">--</span>元</td>
                						</tr>-->
                							<tr>
                  							<td align="right">+ 运费： </td>
                  							<td align="left" class="t13-b yfgz"><span id="spanShipFee">--</span>元&nbsp;&nbsp;&nbsp;<font id="ccdzb" style=" color:#020399;font-size:12px; cursor:hand;" onmouseover="ccdzb()" onmouseout="ccdzb1()">运费标准</font>
<div id="ccdzb_img" style="position:absolute;display:none;border:1px solid #ccc;background:#fff;height:60px;padding:10px;" onmouseover="ccdzb()" onmouseout="ccdzb1()">
在线支付：   全国运费10元，满59元免运费<br>
货到付款：   全国运费10元，满99元免运费
</div></td>
                						</tr>
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
      		<tr><td style="color:#f00;font-size:14px;">网购温馨提示，电话诈骗猖獗，接到任何购物网站通知中奖或低价促销电话，均为诈骗信息，D1优尚也从不通过电话进行促销，请提高警惕</td></tr>
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
function ccdzb()
{
  var top=$('.yfgz').offset().top-80;
  var right=$(document).width()-($("#ccdzb").offset().left+$("#ccdzb").width());
  //alert($('.yfgz').offset().top);
  $("#ccdzb_img").css("top",top);
  $("#ccdzb_img").css("right",210);
  $("#ccdzb_img").css("display","block");

}
function ccdzb1()
{
	$("#ccdzb_img").css("display","none");
}
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "//hm.baidu.com/hm.js?47fc789d5e1f82a06ff14b894d90fc19";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script>
</html>