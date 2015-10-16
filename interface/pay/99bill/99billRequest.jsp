<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../../inc/header.jsp"%><%@include file="../../../inc/islogin.jsp"%><%@include file="../PayConfig.jsp"%><%@include file="99bill.jsp"%><%!
//功能函数。将变量值不为空的参数组成字符串
public String appendParam(String returnStr,String paramId,String paramValue){
	if(!returnStr.equals("")){
		if(!paramValue.equals("")){
			returnStr=returnStr+"&"+paramId+"="+paramValue;
		}
	}else{
		if(!paramValue.equals("")){
			returnStr=paramId+"="+paramValue;
		}
	}	
	return returnStr;
}
//功能函数。将变量值不为空的参数组成字符串。结束
%><%
//块钱支付接口
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

//#交易请求地址
String postUrl=Tools.formatString(PubConfig.get("99billGateWay"));
//人民币网关账户号10016060491
///请登录快钱系统获取用户编号，用户编号后加01即为人民币网关账户号。
String merchantAcctId=Tools.formatString(PubConfig.get("99billPartner"));
//字符集.固定选择值。可为空。
///只能选择1、2、3.
///1代表UTF-8; 2代表GBK; 3代表gb2312
///默认值为1
String inputCharset="1";
//服务器接受支付结果的后台地址.与[pageUrl]不能同时为空。必须是绝对地址。
///快钱通过服务器连接的方式将交易结果发送到[bgUrl]对应的页面地址，在商户处理完成后输出的<result>如果为1，页面会转向到<redirecturl>对应的地址。
///如果快钱未接收到<redirecturl>对应的地址，快钱将把支付结果GET到[pageUrl]对应的页面。
String bgUrl=Tools.formatString(PubConfig.get("99billReturnUrl"));
//
String pageUrl = "";
//网关版本.固定值
///快钱会根据版本号来调用对应的接口处理程序。
///本代码版本号固定为v2.0
String version="v2.0";
//语言种类.固定选择值。
///只能选择1、2、3
///1代表中文；2代表英文
///默认值为1
String language="1";

//签名类型.固定值
///1代表MD5签名
///当前版本固定为1
String signType="4";
//支付人姓名
///可为中文或英文字符
String payerName=order.getOdrmst_rname();
//支付人联系方式类型.固定选择值
///只能选择1
///1代表Email
String payerContactType="1";
//支付人联系方式
///只能选择Email或手机号
String payerContact=lUser.getMbrmst_email();
//商户订单号
///由字母、数字、或[-][_]组成
String orderId=order.getId();
//订单金额
///以分为单位，必须是整型数字
///比方2，代表0.02元
double fltActurePayMoney = Tools.doubleValue(order.getOdrmst_acturepaymoney());//支付金额
long fltTotalFee = (long)Math.ceil(fltActurePayMoney*100);//总金额, 分为单位
String orderAmount=String.valueOf(fltTotalFee);
//订单提交时间
///14位数字。年[4位]月[2位]日[2位]时[2位]分[2位]秒[2位]
///如；20080101010101
String orderTime=Tools.getDBDate();
//商品名称
///可为中文或英文字符
String productName="订单支付";

//商品数量
///可为空，非空时必须为数字
String productNum="";
//商品代码
///可为字符或者数字
String productId="";

//商品描述
String productDesc="订单支付";

//扩展字段1
///在支付结束后原样返回给商户
String ext1="";

//扩展字段2
///在支付结束后原样返回给商户
String ext2="";
	
//支付方式.固定选择值
///只能选择00、10、11、12、13、14
///00：组合支付（网关支付页面显示快钱支持的各种支付方式，推荐使用）10：银行卡支付（网关支付页面只显示银行卡支付）.11：电话银行支付（网关支付页面只显示电话支付）.12：快钱账户支付（网关支付页面只显示快钱账户支付）.13：线下支付（网关支付页面只显示线下支付方式）
String payType="00";

//同一订单禁止重复提交标志
///固定选择值： 1、0
///1代表同一订单号只允许提交1次；0表示同一订单号在没有支付成功的前提下可重复提交多次。默认为0建议实物购物车结算类商户采用0；虚拟产品类商户采用1
String redoFlag="0";

//快钱的合作伙伴的账户号
///如未和快钱签订代理合作协议，不需要填写本参数
String pid="";

//生成加密签名串
///请务必按照如下顺序和规则组成加密串！
String signMsgVal="";
signMsgVal=appendParam(signMsgVal,"inputCharset",inputCharset);
	signMsgVal=appendParam(signMsgVal,"bgUrl",bgUrl);
	signMsgVal=appendParam(signMsgVal,"pageUrl",pageUrl);
	signMsgVal=appendParam(signMsgVal,"version",version);
	signMsgVal=appendParam(signMsgVal,"language",language);
	signMsgVal=appendParam(signMsgVal,"signType",signType);
	signMsgVal=appendParam(signMsgVal,"merchantAcctId",merchantAcctId);
	signMsgVal=appendParam(signMsgVal,"payerName",payerName);
	signMsgVal=appendParam(signMsgVal,"payerContactType",payerContactType);
	signMsgVal=appendParam(signMsgVal,"payerContact",payerContact);
	signMsgVal=appendParam(signMsgVal,"orderId",orderId);
	signMsgVal=appendParam(signMsgVal,"orderAmount",orderAmount);
	signMsgVal=appendParam(signMsgVal,"orderTime",orderTime);
	signMsgVal=appendParam(signMsgVal,"productName",productName);
	signMsgVal=appendParam(signMsgVal,"productNum",productNum);
	signMsgVal=appendParam(signMsgVal,"productId",productId);
	signMsgVal=appendParam(signMsgVal,"productDesc",productDesc);
	signMsgVal=appendParam(signMsgVal,"ext1",ext1);
	signMsgVal=appendParam(signMsgVal,"ext2",ext2);
	signMsgVal=appendParam(signMsgVal,"payType",payType);
	signMsgVal=appendParam(signMsgVal,"redoFlag",redoFlag);
	signMsgVal=appendParam(signMsgVal,"pid",pid);
	
String signMsg=Pkipair.signMsg(signMsgVal);
%><html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><%="支付中转中，请稍候！" %></title>
</head>
<body>
	<form name="kqPay" action='<%=postUrl %>' method='POST'>
		<input type='hidden' name='inputCharset' value='<%=inputCharset %>'>
		<input type='hidden' name='bgUrl' value='<%=bgUrl %>'>
		<input type='hidden' name='pageUrl' value='<%=pageUrl %>'>
		<input type='hidden' name='version' value='<%=version %>'>
		<input type='hidden' name='language' value='<%=language %>'>
		<input type='hidden' name='signType' value='<%=signType %>'>
		<input type='hidden' name='merchantAcctId' value='<%=merchantAcctId %>'>
		<input type='hidden' name='payerName' value='<%=payerName %>'>
		<input type='hidden' name='payerContactType' value='<%=payerContactType %>'>
		<input type='hidden' name='payerContact' value='<%=payerContact %>'>
		<input type='hidden' name='orderId' value='<%=orderId %>'>
		<input type='hidden' name='orderAmount' value='<%=orderAmount %>'>
		<input type="hidden" name="orderTime" value="<%=orderTime %>">
		<input type='hidden' name='productName' value='<%=productName %>'>
		<input type='hidden' name='productNum' value='<%=productNum %>'>
		<input type='hidden' name='productId' value='<%=productId %>'>
		<input type='hidden' name='productDesc' value='<%=productDesc %>'>
		<input type='hidden' name='ext1' value='<%=ext1 %>'>
		<input type='hidden' name='ext2' value='<%=ext2 %>'>
		<input type='hidden' name='payType' value='<%=payType %>'>
		<input type='hidden' name='redoFlag' value='<%=redoFlag %>'>
		<input type='hidden' name='pid' value='<%=pid %>'>
		<input type='hidden' name='signMsg' value='<%=signMsg %>'>
	</form>
	<script type="text/javascript">document.kqPay.submit();</script>
</body>
</html>