<%@ page contentType="text/html; charset=UTF-8" import="org.alipay.services.AlipayService"%><%@include file="../../../inc/header.jsp"%><%@include file="../../../inc/islogin.jsp"%><%@include file="../PayConfig.jsp"%><%
//支付宝支付接口
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

////////////////////////////////////请求参数//////////////////////////////////////

//必填参数//
//请与贵网站订单系统中的唯一订单号匹配
String out_trade_no = strOdrID;
//订单名称，显示在支付宝收银台里的“商品名称”里，显示在支付宝的交易管理的“商品名称”的列表里。
String subject = shopName;
//订单描述、订单详细、订单备注，显示在支付宝收银台里的“商品描述”里
String body = shopName;
//订单总金额，显示在支付宝收银台里的“应付总额”里
String price = Tools.getFormatMoney(Tools.doubleValue(order.getOdrmst_acturepaymoney()));//订单总价

//物流费用，即运费。
String logistics_fee = "0.00";
//物流类型，三个值可选：EXPRESS（快递）、POST（平邮）、EMS（EMS）
String logistics_type = "EXPRESS";
//物流支付方式，两个值可选：SELLER_PAY（卖家承担运费）、BUYER_PAY（买家承担运费）
String logistics_payment = "SELLER_PAY";

//商品数量，建议默认为1，不改变值，把一次交易看成是一次下订单而非购买一件商品。
String quantity = "1";

//扩展参数//

//买家收货信息（推荐作为必填）
//该功能作用在于买家已经在商户网站的下单流程中填过一次收货信息，而不需要买家在支付宝的付款流程中再次填写收货信息。
//若要使用该功能，请至少保证receive_name、receive_address有值
String receive_name	= "";			//收货人姓名，如：张三
String receive_address = "";		//收货人地址，如：XX省XXX市XXX区XXX路XXX小区XXX栋XXX单元XXX号
String receive_zip = "";				//收货人邮编，如：123456
String receive_phone = "";		//收货人电话号码，如：0571-81234567
String receive_mobile = "";		//收货人手机号码，如：13312341234

// 网站商品的展示地址，不允许加?id=123这类自定义参数
String show_url = "http://www.d1.com.cn";

//////////////////////////////////////////////////////////////////////////////////

//把请求参数打包成数组
Map<String, String> sParaTemp = new HashMap<String, String>();
sParaTemp.put("payment_type","1");
sParaTemp.put("show_url", show_url);
sParaTemp.put("out_trade_no", out_trade_no);
sParaTemp.put("subject", subject);
sParaTemp.put("body", body);
sParaTemp.put("price", price);
sParaTemp.put("logistics_fee", logistics_fee);
sParaTemp.put("logistics_type", logistics_type);
sParaTemp.put("logistics_payment", logistics_payment);
sParaTemp.put("quantity", quantity);
sParaTemp.put("receive_name", receive_name);
sParaTemp.put("receive_address", receive_address);
sParaTemp.put("receive_zip", receive_zip);
sParaTemp.put("receive_phone", receive_phone);
sParaTemp.put("receive_mobile", receive_mobile);

//构造函数，生成请求URL
String sHtmlText = AlipayService.trade_create_by_buyer(sParaTemp);
out.println(sHtmlText);
%>