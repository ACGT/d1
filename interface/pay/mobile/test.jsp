<%@ page contentType="text/html; charset=UTF-8" import="com.hisun.iposm.HiiposmUtil"%><%@include file="../../../inc/header.jsp"%><%@include file="../../../inc/islogin.jsp"%><%@include file="../PayConfig.jsp"%><%
//手机支付接口
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


///////////////////////////

//编码格式
String characterSet = "02"; //00--GBK;01--GB2312;02--UTF-8
//页面通知地址
String callbackUrl = PubConfig.get("MobilePayCallBackUrl");
//后台通知地址
String notifyUrl = PubConfig.get("MobilePayNotifyUrl");
//获取用户的IP地址，作为防钓鱼的一种方法
String clientIp = request.getHeader("x-forwarded-for");
if ((clientIp == null) || (clientIp.length() == 0)
		|| ("unknown".equalsIgnoreCase(clientIp))) {
	clientIp = request.getHeader("Proxy-Client-IP");
}
if ((clientIp == null) || (clientIp.length() == 0)
		|| ("unknown".equalsIgnoreCase(clientIp))) {
	clientIp = request.getHeader("WL-Proxy-Client-IP");
}
if ((clientIp == null) || (clientIp.length() == 0)
		|| ("unknown".equalsIgnoreCase(clientIp))) {
	clientIp = request.getRemoteAddr();
}
String ipAddress = clientIp;
//商户请求编号
String requestId = String.valueOf(System.currentTimeMillis());
String signType = "MD5";
String version = "2.0.0";
//商户编号
String merchantId = PubConfig.get("MobileMerchanetId");
//商户密钥
String signKey = PubConfig.get("MobileKey");
String req_url = "https://ipos.10086.cn/ips/cmpayService";
//String req_url = PubConfig.get("MobilePayTokenRedirectUrl");
//////////////////////////

List<OrderItemBase> ilist=null;
switch(order.getType()){
	case 1:
		ilist=OrderItemHelper.getOdrdtlCacheByOrderId(strOdrID);
		break;
	case 2:
		ilist=OrderItemHelper.getOdrdtlListByOrderId(strOdrID);
		break;
   case 3:
	   	ilist=OrderItemHelper.getOdrdtRecentlByOrderId(strOdrID);
	   	break;
   case 4:
	   	ilist=OrderItemHelper.getOdrdtHistorylByOrderId(strOdrID);
       	break;
   default:
	  	ilist=OrderItemHelper.getOdrdtlCacheByOrderId(strOdrID);
	  	break;
}

String merAcDate = Tools.getDBDate().substring(0,8);
String type = "DirectPayConfirm";
String sessionId = "";

Product product = ProductHelper.getById("");

//编码设置
request.setCharacterEncoding(PubConfig.get("MobileCharset"));

double fltActurePayMoney = Tools.doubleValue(order.getOdrmst_acturepaymoney());//支付金额
long fltTotalFee = (long)Math.ceil(fltActurePayMoney*100);//总金额, 分为单位

String amount = String.valueOf(fltTotalFee);
String bankAbbr = "";

switch (order.getOdrmst_payid().intValue()){
case 35://中国光大银行
	bankAbbr="CEBB";
	break;
case 39://浦发银行
	bankAbbr="SPDB";
	break;
}
String currency = "00";
String orderDate = merAcDate;
String orderId = strOdrID;
String period = PubConfig.get("MobilePayPeriod");//5天有效期。
String periodUnit = "02";
String merchantAbbr ="D1优尚" ;
String productDesc = "D1优尚网" + strOdrID + "订单";//商品描述
String productId = strOdrID;
String productName = "D1优尚网" + strOdrID + "订单";//商品名称
String productNum = ""+(ilist!=null?ilist.size():0);
String reserved1 = "";
String reserved2 = "";
String userToken = "";
String showUrl = "http://www.d1.com.cn/user/orderdetail.jsp?orderid="+strOdrID;
String couponsFlag = "";

if(!Tools.isNull(bankAbbr)){
	type = "GWDirectPay";
	productName=URLEncoder.encode(productName,"utf-8") ;
	productDesc=URLEncoder.encode(productDesc,"utf-8") ;
	merchantAbbr=URLEncoder.encode(merchantAbbr,"utf-8") ;
}

//数据签名报文
String signData = characterSet + callbackUrl + notifyUrl
		+ ipAddress + merchantId + requestId + signType + type
		+ version + amount + bankAbbr + currency + orderDate
		+ orderId + merAcDate + period + periodUnit + merchantAbbr
		+ productDesc + productId + productName + productNum
		+ reserved1 + reserved2 + userToken + showUrl + couponsFlag;

HiiposmUtil util = new HiiposmUtil();
//数据签名，hmac为签名后的消息摘要
String hmac = util.MD5Sign(signData, signKey);

//-- 请求报文
String buf = "characterSet=" + characterSet + "&callbackUrl="
		+ callbackUrl + "&notifyUrl=" + notifyUrl
		+ "&ipAddress=" + ipAddress + "&merchantId="
		+ merchantId + "&requestId=" + requestId + "&signType="
		+ signType + "&type=" + type + "&version=" + version
		+ "&amount=" + amount + "&bankAbbr=" + bankAbbr
		+ "&currency=" + currency + "&orderDate=" + orderDate
		+ "&orderId=" + orderId + "&merAcDate=" + merAcDate
		+ "&period=" + period + "&periodUnit=" + periodUnit
		+ "&merchantAbbr=" + merchantAbbr + "&productDesc="
		+ productDesc + "&productId=" + productId
		+ "&productName=" + productName + "&productNum="
		+ productNum + "" + "&reserved1=" + reserved1
		+ "&reserved2=" + reserved2 + "&userToken=" + userToken
		+ "&showUrl=" + showUrl + "&couponsFlag=" + couponsFlag;

if(Tools.isNull(bankAbbr)){
	//-- 带上消息摘要
	buf = "hmac=" + hmac + "&" + buf;

	//发起http请求，并获取响应报文
	String res = util.sendAndRecv(req_url, buf, characterSet);
	//获得手机支付平台的消息摘要，用于验签,
	String hmac1 = util.getValue(res, "hmac");
	String vfsign = util.getValue(res, "merchantId")
			+ util.getValue(res, "requestId")
			+ util.getValue(res, "signType")
			+ util.getValue(res, "type")
			+ util.getValue(res, "version")
			+ util.getValue(res, "returnCode")
			+ URLDecoder.decode(util.getValue(res, "message"),
					"UTF-8") + util.getValue(res, "payUrl");

	//响应码
	String code = util.getValue(res, "returnCode");
	//下单交易成功
	if (!code.equals("000000")) {
		out.println("下单错误:" + code + URLDecoder.decode(util.getValue(res,"message"),"UTF-8"));
		return;
	}

	//-- 验证签名
	boolean flag = false;
	flag = util.MD5Verify(vfsign, hmac1, signKey);

	if (!flag) {
		//request.getSession().setAttribute("message", "验证签名失败！");
		out.println("验签失败");
		return;
	}

	String payUrl = util.getValue(res, "payUrl");
	String submit_url = HiiposmUtil.getRedirectUrl(payUrl);

	response.sendRedirect(submit_url);
}else{

%>
<form id="mobileform" name="mobileform" method="post" action="<%=req_url%>">
			<input type="hidden" name="characterSet" value="<%=characterSet%>" />
			<input type="hidden" name="callbackUrl" value="<%=callbackUrl%>" />
			<input type="hidden" name="notifyUrl" value="<%=notifyUrl%>" />
			<input type="hidden" name="ipAddress" value="<%=ipAddress%>" />
			<input type="hidden" name="merchantId" value="<%=merchantId%>" />
			<input type="hidden" name="requestId" value="<%=requestId%>" />
			<input type="hidden" name="signType" value="<%=signType%>" />
			<input type="hidden" name="type" value="<%=type%>" />
			<input type="hidden" name="version" value="<%=version%>" />
			<input type="hidden" name="hmac" value="<%=hmac%>" />
			<input type="hidden" name="amount" value="<%=amount%>" />
			<input type="hidden" name="bankAbbr" value="<%=bankAbbr%>" />
			<input type="hidden" name="currency" value="<%=currency%>" />
			<input type="hidden" name="orderDate" value="<%=orderDate%>" />
			<input type="hidden" name="orderId" value="<%=orderId%>" />
			<input type="hidden" name="merAcDate" value="<%=merAcDate%>" />
			<input type="hidden" name="period" value="<%=period%>" />
			<input type="hidden" name="periodUnit" value="<%=periodUnit%>" />
			<input type="hidden" name="merchantAbbr" value="<%=merchantAbbr%>" />
			<input type="hidden" name="productDesc" value="<%=productDesc%>" />
			<input type="hidden" name="productId" value="<%=productId%>" />
			<input type="hidden" name="productName" value="<%=productName%>" />
			<input type="hidden" name="productNum" value="<%=productNum%>" />
			<input type="hidden" name="reserved1" value="<%=reserved1%>" />
			<input type="hidden" name="reserved2" value="<%=reserved2%>" />
			<input type="hidden" name="userToken" value="<%=userToken%>" />
			<input type="hidden" name="showUrl" value="<%=showUrl%>" />
			<input type="hidden" name="couponsFlag" value="<%=couponsFlag%>" />
			<input type="submit" value="确认" style="display:none;"/>
		</form>
		<%
		out.print("<script>document.forms['mobileform'].submit();</script>");
}
		%>