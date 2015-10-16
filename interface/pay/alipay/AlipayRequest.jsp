<%
/* *
 *功能：纯网关接口接入页
 *版本：3.2
 *日期：2011-03-17
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。

 *************************注意*****************
 *如果您在接口集成过程中遇到问题，可以按照下面的途径来解决
 *1、商户服务中心（https://b.alipay.com/support/helperApply.htm?action=consultationApply），提交申请集成协助，我们会有专业的技术工程师主动联系您协助解决
 *2、商户帮助中心（http://help.alipay.com/support/232511-16307/0-16307.htm?sh=Y&info_type=9）
 *3、支付宝论坛（http://club.alipay.com/read-htm-tid-8681712.html）
 *如果不想使用扩展功能请把扩展功能参数赋空值。
 **********************************************
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@include file="/inc/header.jsp" %><%!
String getBank(int payid){
	String bankname="ICBCB2C";
	switch(payid){
	case 4://招商银行
		bankname="CMB";
		break;
	case 6://中国工商银行
		bankname="ICBCB2C";
		break;
	case 26://中国建设银行
		bankname="CCB";
		break;
	case 27://中国农业银行
		bankname="ABC";
		break;
	case 31://交通银行
		bankname="SPABANK";
		break;
	case 34://交通银行
		bankname="COMM";
		break;
	case 35://中国光大银行
		bankname="CEBBANK";
		break;
	case 36://兴业银行
		bankname="CIB";
		break;
	case 37://广东发展银行
		bankname="GDB";
		break;
	case 38://中信银行
		bankname="CITIC";
		break;
	case 39://上海浦东发展银行
		bankname="SPDB";
		break;
	case 40://中国银行
		bankname="BOCB2C";
		break;
	case 41://深圳发展银行
		bankname="SDB";
		break;
	case 42://北京银行
		bankname="BJBANK";
		break;
	case 43://中国民生银行
		bankname="CMBC";
		break;
	case 45://杭州银行
		bankname="HZCBB2C";
		break;
	case 46://上海银行
		bankname="SHBANK";
		break;
	case 47://宁波银行
		bankname="NBBANK";
		break;
	case 48://北京农村商业银行
		bankname="BJRCB";
		break;
	case 49://富滇银行
		bankname="FDB";
		break;
	case 50://中国邮政储蓄银行
		bankname="POSTGC";
		break;
	default:
		bankname="";
		break;
	}

	return bankname;
}
%>
<%@ page import="com.d1.alipay.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>支付宝纯网关接口</title>
	</head>
	<%    
		////////////////////////////////////请求参数//////////////////////////////////////
		String strOdrID = request.getParameter("OdrID");
if(Tools.isNull(strOdrID)){
	out.print("订单号出错！");
	return;
}
OrderBase order = OrderHelper.getById(strOdrID);
if(lUser==null){
	response.sendRedirect("/login.jsp");
}
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
boolean isTuan = true;
List<OrderItemBase> list = OrderHelper.getOrderItemList(order);
if(list != null && !list.isEmpty()){
	for(OrderItemBase ot : list){
		if(!ot.getOdrdtl_gdsname().startsWith("【团购商品】")){
			isTuan = false;
			break;
		}
	}
}

isTuan = false ;//暂时取消担保交易，如果要恢复，去掉这一行就行，KK修改，2012-01-30

if(isTuan){//全部是团购物品
	response.sendRedirect("AlipaySRequest.jsp?OdrID="+strOdrID);
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
		//必填参数//

		//请与贵网站订单系统中的唯一订单号匹配
		String out_trade_no =strOdrID;
		//订单名称，显示在支付宝收银台里的“商品名称”里，显示在支付宝的交易管理的“商品名称”的列表里。
		String subject = "订单支付";
		//订单描述、订单详细、订单备注，显示在支付宝收银台里的“商品描述”里
		String body = shopName;
		//订单总金额，显示在支付宝收银台里的“应付总额”里
		String total_fee = Tools.getFormatMoney(Tools.doubleValue(order.getOdrmst_acturepaymoney()));//订单总价
		
		
		//扩展功能参数——默认支付方式//
		
		//默认支付方式，取值见“纯网关接口”技术文档中的请求参数列表
		String paymethod = "";
		//默认网银代号，代号列表见“纯网关接口”技术文档“附录”→“银行列表”
		String defaultbank = getBank(order.getOdrmst_payid().intValue());
		if(!Tools.isNull(defaultbank)){
			paymethod = "bankPay";	
		}
		
		//扩展功能参数——防钓鱼//

		//防钓鱼时间戳
		String anti_phishing_key  = "";
		//获取客户端的IP地址，建议：编写获取客户端IP地址的程序
		String exter_invoke_ip= "";
		//注意：
		//1.请慎重选择是否开启防钓鱼功能
		//2.exter_invoke_ip、anti_phishing_key一旦被设置过，那么它们就会成为必填参数
		//3.开启防钓鱼功能后，服务器、本机电脑必须支持远程XML解析，请配置好该环境。
		//4.建议使用POST方式请求数据
		//示例：
		//anti_phishing_key = AlipayService.query_timestamp();	//获取防钓鱼时间戳函数
		//exter_invoke_ip = "202.1.1.1";
		
		//扩展功能参数——其他///
		
		//自定义参数，可存放任何内容（除=、&等特殊字符外），不会显示在页面上
		String extra_common_param = "";
		//默认买家支付宝账号
		String buyer_email = "";
		//商品展示地址，要用http:// 格式的完整路径，不允许加?id=123这类自定义参数
		String show_url = "http://www.d1.com.cn";
		
		//扩展功能参数——分润(若要使用，请按照注释要求的格式赋值)//
		
		//提成类型，该值为固定值：10，不需要修改
		String royalty_type = "10";
		//提成信息集
		String royalty_parameters ="";
		//注意：
		//与需要结合商户网站自身情况动态获取每笔交易的各分润收款账号、各分润金额、各分润说明。最多只能设置10条
		//各分润金额的总和须小于等于total_fee
		//提成信息集格式为：收款方Email_1^金额1^备注1|收款方Email_2^金额2^备注2
		//示例：
		//royalty_type = "10"
		//royalty_parameters	= "111@126.com^0.01^分润备注一|222@126.com^0.01^分润备注二"
		
		//////////////////////////////////////////////////////////////////////////////////
		
		//把请求参数打包成数组
		Map<String, String> sParaTemp = new HashMap<String, String>();
        sParaTemp.put("payment_type", "1");
        sParaTemp.put("out_trade_no", out_trade_no);
        sParaTemp.put("subject", subject);
        sParaTemp.put("body", body);
        sParaTemp.put("total_fee", total_fee);
        sParaTemp.put("show_url", show_url);
        sParaTemp.put("paymethod", paymethod);
        sParaTemp.put("defaultbank", defaultbank);
       // sParaTemp.put("anti_phishing_key", anti_phishing_key);
       // sParaTemp.put("exter_invoke_ip", exter_invoke_ip);
       // sParaTemp.put("extra_common_param", extra_common_param);
       // sParaTemp.put("buyer_email", buyer_email);
       // sParaTemp.put("royalty_type", royalty_type);
      //  sParaTemp.put("royalty_parameters", royalty_parameters);
		
		//构造函数，生成请求URL
		String sHtmlText = AlipayService.create_direct_pay_by_user(sParaTemp);
		out.println(sHtmlText);
	%>
	<body>
	</body>
</html>
