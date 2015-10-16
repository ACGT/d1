<%@ page contentType="text/html; charset=UTF-8" import="com.yeepay.*" %><%@include file="../../../inc/header.jsp"%><%@include file="../../../inc/islogin.jsp"%><%@include file="../PayConfig.jsp"%><%
//易宝支付接口
String strOdrID = request.getParameter("OdrID");

OrderBase order = OrderHelper.getById(strOdrID);

if(order == null){
	out.print("查询订单出错！");
	return;
}
if(!lUser.getId().equals(String.valueOf(order.getOdrmst_mbrid()))){
	out.print("查询订单出错。");
	return;
}
if(Tools.longValue(order.getOdrmst_orderstatus()) != 0){
	out.print("您的订单不在未支付状态！");
	return;
}
//防止刷页面
Long lastPostTime = (Long)Const.LIMIT_HASH_MAP.get(new Long(lUser.getId()));
if(lastPostTime!=null){
	if(System.currentTimeMillis()-lastPostTime.longValue()<Const.LIMIT_MILLSECONDS){
		out.println("请不要刷页面！");
		return;
	}
}
Const.LIMIT_HASH_MAP.put(new Long(lUser.getId()),new Long(System.currentTimeMillis()));

int iPayID = (int)Tools.longValue(order.getOdrmst_payid());//支付方式
String strBankType = "";
if(iPayID == 31){//平安银行支付
	strBankType = "PINGANBANK-NET";
}else if(iPayID == 27){//农行
	strBankType = "ABC-NET-B2C";
}

String shopName = "D1优尚网" + strOdrID + "订单";//商品名称
if(shopName.length()>20) shopName = shopName.substring(0,20);

String keyValue = Tools.formatString(PubConfig.get("YeepayKey"));// 商家密钥
String nodeAuthorizationURL = Tools.formatString(PubConfig.get("YeepayGateWay"));  	// 交易请求地址
//商家设置用户购买商品的支付信息
String p0_Cmd = "Buy";// 在线支付请求，固定值 ”Buy”
String p1_MerId = Tools.formatString(PubConfig.get("YeepayPartner"));// 商户编号
String p2_Order = order.getId();// 商户订单号
String p3_Amt = Tools.getFormatMoney(Tools.doubleValue(order.getOdrmst_acturepaymoney()));// 支付金额
String p4_Cur = "CNY";// 交易币种
String p5_Pid = shopName;// 商品名称
String p6_Pcat = "订单支付";// 商品种类
String p7_Pdesc = "订单支付";// 商品描述
String p8_Url = Tools.formatString(PubConfig.get("YeepayReturnUrl"));// 商户接收支付成功数据的地址
//p8_Url = "http://219.238.238.15/main/YBReceive.jsp";
String p9_SAF = "0";// 需要填写送货信息 0：不需要  1:需要
String pa_MP = "d1";// 商户扩展信息
String pd_FrpId = strBankType;//银行编码
pd_FrpId = pd_FrpId.toUpperCase();//银行编号必须大写
String pr_NeedResponse = "1";// 是否需要应答机制
String hmac = "";// 交易签名串
// 获得MD5-HMAC签名
hmac = PaymentForOnlineService.getReqMd5HmacForOnlinePayment(p0_Cmd,
		p1_MerId,p2_Order,p3_Amt,p4_Cur,p5_Pid,p6_Pcat,p7_Pdesc,
		p8_Url,p9_SAF,pa_MP,pd_FrpId,pr_NeedResponse,keyValue);
response.setHeader("Content-Type","text/html; charset=GBK");
%><html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title><%="支付中转中，请稍候！" %></title>
</head>
<body>
	<form name="yeepay" action='<%=nodeAuthorizationURL%>' method='POST'>
		<input type='hidden' name='p0_Cmd' value='<%=p0_Cmd %>'>
		<input type='hidden' name='p1_MerId' value='<%=p1_MerId %>'>
		<input type='hidden' name='p2_Order' value='<%=p2_Order %>'>
		<input type='hidden' name='p3_Amt' value='<%=p3_Amt %>'>
		<input type='hidden' name='p4_Cur' value='<%=p4_Cur %>'>
		<input type='hidden' name='p5_Pid' value='<%=p5_Pid %>'>
		<input type='hidden' name='p6_Pcat' value='<%=p6_Pcat %>'>
		<input type='hidden' name='p7_Pdesc' value='<%=p7_Pdesc %>'>
		<input type='hidden' name='p8_Url' value='<%=p8_Url %>'>
		<input type='hidden' name='p9_SAF' value='<%=p9_SAF %>'>
		<input type='hidden' name='pa_MP' value='<%=pa_MP %>'>
		<input type='hidden' name='pd_FrpId' value='<%=pd_FrpId %>'>
		<input type="hidden" name="pr_NeedResponse" value="<%=pr_NeedResponse %>">
		<input type='hidden' name='hmac' value='<%=hmac %>'>
	</form>
	<script type="text/javascript">document.yeepay.submit();</script>
</body>
</html>