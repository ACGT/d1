<%@ page contentType="text/html; charset=UTF-8" import="com.d1.alipay.*,java.net.*,org.dom4j.Element,org.dom4j.DocumentException,org.dom4j.io.SAXReader,org.dom4j.Document"%><%@include file="/inc/header.jsp"%>
<%!
/**
 * 准备alipay.wap.auth.authAndExecute服务的参数
 * 
 * @param request
 * @param requestToken
 * @return 返回授权接口参数map
 */
private Map<String, String> prepareAuthParamsMap(
		HttpServletRequest request, String requestToken) {
	Map<String, String> requestParams = new HashMap<String, String>();
	StringBuilder reqData = new StringBuilder();
	reqData.append("<auth_and_execute_req><request_token>"+requestToken+"</request_token>")
			.append("</auth_and_execute_req>");
	requestParams.put("req_data", reqData.toString());
	requestParams.putAll(prepareCommonParams(request));
	requestParams.put("service", "alipay.wap.auth.authAndExecute");
	return requestParams;
}

/**
 * 准备通用参数
 * 
 * @param request
 * @return 通用参数map
 */
private Map<String, String> prepareCommonParams(HttpServletRequest request) {
	Map<String, String> commonParams = new HashMap<String, String>();
	commonParams.put("service", "alipay.wap.trade.create.direct");
	commonParams.put("sec_id",AlipayConfig.sign_type);
	commonParams.put("partner", AlipayConfig.partner);
	commonParams.put("format", "xml");
	commonParams.put("v", "2.0");
	return commonParams;
}

/**
 * 对参数进行签名
 * @param reqParams 待签名参数
 * @param signAlgo 签名类型
 * @param key MD5校验码
 * @return 返回签名结果
 */
private String sign(Map<String, String> reqParams, String signAlgo,
		String key) {

	String signData = wapParameterUtil.getSignData(reqParams);

	String sign = "";
	try {
		sign = wapMD5Signature.sign(signData, key);
	} catch (Exception e1) {
		e1.printStackTrace();
	}
	return sign;
}

/**
 * 调用alipay.wap.auth.authAndExecute服务的时候需要跳转到支付宝的页面，组装跳转url
 * @param reqParams
 * @param reqUrl 请求url
 * @return 返回组装好的url字符串
 * @throws Exception
 */
private String getRedirectUrl(Map<String, String> reqParams, String reqUrl)
		throws Exception {
	String redirectUrl = reqUrl + "?";
	redirectUrl = redirectUrl + wapParameterUtil.mapToUrl(reqParams);
	return redirectUrl;
}

/**
 * 获取请求数据
 * @param reqParams 请求参数map
 * @param reqUrl 请求url
 * @return 返回请求结果数据
 * @throws Exception
 */
private wapResponseResult send(Map<String, String> reqParams, String reqUrl) throws Exception {
	String response = "";
	String invokeUrl = reqUrl;
	URL serverUrl = new URL(invokeUrl);
	HttpURLConnection conn = (HttpURLConnection) serverUrl.openConnection();

	conn.setRequestMethod("POST");
	conn.setDoOutput(true);
	conn.connect();
	String params = wapParameterUtil.mapToUrl(reqParams);
	conn.getOutputStream().write(params.getBytes());

	InputStream is = conn.getInputStream();

	BufferedReader in = new BufferedReader(new InputStreamReader(is));
	StringBuffer buffer = new StringBuffer();
	String line = "";
	while ((line = in.readLine()) != null) {
		buffer.append(line);
	}
	response = URLDecoder.decode(buffer.toString(), "utf-8");
	conn.disconnect();
	return praseResult(response);
}

/**
 * 解析支付宝返回的结果
 * @param response
 * @return
 * @throws Exception
 */
private wapResponseResult praseResult(String response)
		throws Exception {
	HashMap<String, String> resMap = new HashMap<String, String>();
	String v = wapParameterUtil.getParameter(response, "v");
	String service = wapParameterUtil.getParameter(response, "service");
	String partner = wapParameterUtil.getParameter(response, "partner");
	String sign = wapParameterUtil.getParameter(response, "sign");
	String reqId = wapParameterUtil.getParameter(response, "req_id");
	resMap.put("v", v);
	resMap.put("service", service);
	resMap.put("partner", partner);
	resMap.put("sec_id", AlipayConfig.sign_type);
	resMap.put("req_id", reqId);
	String businessResult = "";
	wapResponseResult result = new wapResponseResult();
	if (response.contains("<err>")) {
		result.setSuccess(false);
		businessResult = wapParameterUtil.getParameter(response, "res_error");
		/** 转换错误信息 */
		XMapUtil.register(wapErrorCode.class);
		wapErrorCode errorCode = (wapErrorCode) XMapUtil
				.load(new ByteArrayInputStream(businessResult
						.getBytes("UTF-8")));
		result.setErrorMessage(errorCode);
	

	} else {
		businessResult = wapParameterUtil.getParameter(response, "res_data");
		result.setSuccess(true);
		result.setBusinessResult(businessResult);
		resMap.put("res_data", businessResult);
		/** 获取待签名数据 */
		String verifyData = wapParameterUtil.getSignData(resMap);
		/** 对待签名数据验签名 */
		boolean verified = wapMD5Signature.verify(verifyData, sign,
				AlipayConfig.key);
		if (!verified) {
			throw new Exception("验证签名失败");
		}
	}

	return result;
}


%>
<%
response.setContentType("text/html;charset=UTF-8");
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

String shopName = "D1优尚网" + strOdrID + "订单";//商品名称
if(shopName.length()>20) shopName = shopName.substring(0,20);


Map<String, String> requestParams = new HashMap<String, String>();
String cashierCode=request.getParameter("cashierCode");//银行编码
String out_user="";
if(StringUtil.isBlank(out_user)){
    out_user="";
}
request.setCharacterEncoding("utf-8");
/**商品名称*/
String subject =shopName;
/**商品总价*/
String totalFee = Tools.getFormatMoney(Tools.doubleValue(order.getOdrmst_acturepaymoney()));//订单总价
/**外部交易号 这里取当前时间，商户可根据自己的情况修改此参数，但保证唯一性*/
String outTradeNo =strOdrID;
/**卖家帐号*/
String sellerAccountName =AlipayConfig.seller_email;
String path = request.getContextPath();

/**接收支付宝发送的通知的url*/
String notifyUrl = AlipayConfig.wap_notify_url;
/**支付成功跳转链接*/
String callbackUrl =AlipayConfig.wap_return_url;

/**未完成支付，用户点击链接返回商户url*/
String merchantUrl ="http://m.d1.cn/wap/user/orderdetail.jsp?orderid="+strOdrID;
/**req_data的内容*/
StringBuilder reqData = new StringBuilder();
reqData.append("<direct_trade_create_req>").append("<subject>"+ subject+"</subject>");
reqData.append("<out_trade_no>" + outTradeNo+ "</out_trade_no>");
reqData.append("<total_fee>" + totalFee+ "</total_fee>");
reqData.append("<seller_account_name>" + sellerAccountName+ "</seller_account_name>");
reqData.append("<notify_url>" + notifyUrl.toString()+ "</notify_url>");
reqData.append("<call_back_url>" + callbackUrl.toString()+ "</call_back_url>");
reqData.append("<out_user>" + out_user+ "</out_user>");
reqData.append("<merchant_url>" + merchantUrl+ "</merchant_url>");
/**如果cashierCode不为空就组装此参数*/
if (StringUtil.isNotBlank(cashierCode)) {
	reqData.append("<cashier_code>" + cashierCode+ "</cashier_code>");
}
reqData.append("</direct_trade_create_req>");
requestParams.put("req_data", reqData.toString());
requestParams.put("req_id", System.currentTimeMillis() + "");
requestParams.putAll(prepareCommonParams(request));




Map<String, String> reqParams =requestParams;

String signAlgo = AlipayConfig.sign_type;
String reqUrl = AlipayConfig.wap_req_url;

/** 获取商户MD5 key */
String key = AlipayConfig.key;
String sign = sign(reqParams, signAlgo, key);
reqParams.put("sign", sign);

wapResponseResult resResult = new wapResponseResult();
String businessResult = "";
try {
	resResult = send(reqParams, reqUrl);
} catch (Exception e1) {
	e1.printStackTrace();
}
if (resResult.isSuccess()) {
	businessResult = resResult.getBusinessResult();
	//System.out.print(businessResult);
} else {
	
	out.print("出错信息：" + resResult.getErrorMessage().getDetail());
	out.flush();
	System.out.println("出错信息："
			+ resResult.getErrorMessage().getDetail());
	return;
}

HashMap<String, String> businessResulinfo = null;
InputStream in = null;
try {
	in = new ByteArrayInputStream(businessResult.getBytes("UTF-8"));
	SAXReader reader = new SAXReader();
	Document doc = reader.read(in);
	
	Element root = doc.getRootElement();
	
	List es = root.elements();
	if(es != null && !es.isEmpty()){
		businessResulinfo = new HashMap<String,String>();
		int size = es.size();
		for(int i=0;i<size;i++){
			Element el = (Element)es.get(i);
			businessResulinfo.put(el.getName(),el.getTextTrim());
		}
	}
}catch(UnsupportedEncodingException e){
	e.printStackTrace();
}catch (DocumentException e){
	e.printStackTrace();
} finally{
	try{
		if(in != null) in.close();
	} catch(IOException e){
		System.err.println("chanet close inputstream error!");
	}
}

/** 开放平台返回的内容中取出request_token */
String requestToken = businessResulinfo.get("request_token");
Map<String, String> authParams = prepareAuthParamsMap(request,
		requestToken);
/** 对调用授权请求数据签名 */
String authSign = sign(authParams, signAlgo, key);
authParams.put("sign", authSign);
String redirectURL = "";
try {
	redirectURL = getRedirectUrl(authParams, reqUrl);
	System.out.println("redirectURL:" + redirectURL);
} catch (Exception e) {
	e.printStackTrace();
}
if (StringUtil.isNotBlank(redirectURL)) {
	response.sendRedirect(redirectURL);
	return;
}
%>