<%@ page contentType="text/html; charset=GBK" import="com.yeepay.*" %><%@page 
import="com.d1.*,
com.d1.bean.*,
com.d1.manager.*,
com.d1.helper.*,
com.d1.dbcache.core.*,
com.d1.util.*,
com.d1.service.*,
com.d1.search.*,
org.hibernate.criterion.*,
org.hibernate.*,
java.net.URLEncoder,
java.net.URLDecoder,
net.sf.json.JSONObject,
java.util.*,
java.text.*,
java.io.*"%><%!
//是否显示控制台打印调试信息
private static final boolean isDebug = true;

//打印日志
private static void logInfo(String log){
	if(isDebug) System.err.println(Tools.stockFormatDate(new Date())+"："+log);
}
%><%
String keyValue = Tools.formatString(PubConfig.get("YeepayKey"));   // 商家密钥
String p1_MerId = Tools.formatString(PubConfig.get("YeepayPartner"));   // 商户编号
String r0_Cmd 	= Tools.formatString(request.getParameter("r0_Cmd"));										  // 业务类型
String r1_Code  = Tools.formatString(request.getParameter("r1_Code"));										// 支付结果
String r2_TrxId = Tools.formatString(request.getParameter("r2_TrxId"));										// 易宝支付交易流水号

String r3_Amt   = Tools.formatString(request.getParameter("r3_Amt"));											// 支付金额
String r4_Cur   = Tools.formatString(request.getParameter("r4_Cur"));											// 交易币种
String r5_Pid   = Tools.formatString(request.getParameter("r5_Pid"));											// 商品名称
String r6_Order = Tools.formatString(request.getParameter("r6_Order"));										// 商户订单号

String r7_Uid   = Tools.formatString(request.getParameter("r7_Uid"));											// 易宝支付会员ID
String r8_MP    = Tools.formatString(request.getParameter("r8_MP"));											// 商户扩展信息
String r9_BType = Tools.formatString(request.getParameter("r9_BType"));										// 交易结果返回类型
String hmac     = Tools.formatString(request.getParameter("hmac"));// 签名数据

boolean isOK = false;
logInfo("易宝支付，"+r3_Amt+"--->"+r6_Order+"--"+r8_MP);
// 校验返回数据包
isOK = PaymentForOnlineService.verifyCallback(hmac,p1_MerId,r0_Cmd,r1_Code, 
		r2_TrxId,r3_Amt,r4_Cur,r5_Pid,r6_Order,r7_Uid,r8_MP,r9_BType,keyValue);
if(isOK) {
	if(r1_Code.equals("1")) {
		double r3_amount = Tools.parseDouble(r3_Amt);
		//浏览器定向
		String url = "/index.jsp";
		//获得定单
		OrderBase order = OrderHelper.getById(r6_Order);
		if(order != null && Tools.longValue(order.getOdrmst_orderstatus()) == 0){
			OrderService os = (OrderService)Tools.getService(OrderService.class);
			int reValue = os.updateOrderStatus(order,r3_amount);
	        if(reValue == 0){
	        	logInfo("易宝支付，订单："+r6_Order+"支付成功！");
	        }
		}
		out.println("SUCCESS");
		if(r9_BType.equals("1")) {// 产品通用接口支付成功返回-浏览器重定向
			response.sendRedirect("http://www.d1.com.cn/user/selforder.jsp");
			return;
		} else if(r9_BType.equals("2")) {// 产品通用接口支付成功返回-服务器点对点通讯
			// 如果在发起交易请求时	设置使用应答机制时，必须应答以"success"开头的字符串，大小写不敏感
			out.println("SUCCESS");
		} else if(r9_BType.equals("3")) {// 产品通用接口支付成功返回-电话支付返回	
			
		}else{
			response.sendRedirect("http://www.d1.com.cn/user/selforder.jsp");
			return;
		}
		// 下面页面输出是测试时观察结果使用
		out.println("<br>交易成功!<br>商家订单号:" + r6_Order + "<br>支付金额:" + r3_Amt + "<br>易宝支付交易流水号:" + r2_TrxId);
	}
} else {
	out.println("交易签名被篡改!");
}
%>