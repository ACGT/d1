<%@ page contentType="text/html; charset=UTF-8" import="com.tenpay.util.TenpayUtil,com.tenpay.RequestHandler"%><%@include file="../../../inc/header.jsp"%><%@include file="../../../inc/islogin.jsp"%><%@include file="../PayConfig.jsp"%><%
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

double fltActurePayMoney = Tools.doubleValue(order.getOdrmst_acturepaymoney());//支付金额
int iPayID = (int)Tools.longValue(order.getOdrmst_payid());//支付方式

String strBankType = null;
switch (iPayID){
    case 6:
        strBankType = "ICBC";//中国工商银行
        break;
    case 4:
        strBankType = "CMB";//招商银行
        break;
    case 26:
        strBankType = "CCB";//中国建设银行
        break;
    case 27:
        strBankType = "ABC";//中国农业银行
        break;
    case 31:
        strBankType = "PAB";//平安银行
        break;
    case 34:
        strBankType = "COMM";//交通银行
        break;
    case 35:
        strBankType = "CEB";//光大银行
        break;
    case 36:
        strBankType = "CIB";//兴业银行
        break;
    case 37:
        strBankType = "GDB";//广东发展银行
        break;
    case 38:
        strBankType = "CITIC";//中兴银行
        break;
    case 39:
        strBankType = "SPDB";//上海浦发银行
        break;
    case 40:
        strBankType = "BOC";//中国银行
        break;
    case 41:
        strBankType = "SDB";//深圳发展银行
        break;
    case 42:
        strBankType = "BOB";//北京银行
        break;
    case 43:
        strBankType = "CMBC";//民生银行
        break;
    case 51:
        strBankType = "ABC_FP";//农业银行快捷支付
        break;
    case 52:
        strBankType = "BOC_FP";//中国银行快捷支付
        break;
    case 53:
        strBankType = "ICBC_FP";//工商银行快捷支付
        break;
    case 54:
        strBankType = "CCB_FP";//建行银行快捷支付
        break;
    case 55:
        strBankType = "CMB_FP";//招商银行快捷支付
        break;
    case 56:
        strBankType = "PAB_FP";//平安银行快捷支付
        break;
    case 57:
        strBankType = "CEB_FP";//光大银行快捷支付
        break;
    case 58:
        strBankType = "SDB_FP";//深圳发展银行快捷支付
        break;
    default:
        strBankType = "DEFAULT";
        break;
}
//快捷支付银行
/*
51	农业银行快捷支付		ABC_FP
52	中国银行快捷支付		BOC_FP
53	工商银行快捷支付		ICBC_FP
54	建行银行快捷支付		CCB_FP
55	招商银行快捷支付		CMB_FP
56	平安银行快捷支付		PAB_FP
57	光大银行快捷支付		CEB_FP
58	深圳发展银行快捷支付	 SDB_FP
*/
//fltActurePayMoney = 0.06f;

String strDesc = "D1优尚网" + strOdrID + "订单";//商品名称
long fltTotalFee = (long)Math.ceil(fltActurePayMoney*100);//总金额, 分为单位

boolean isTest = ("0".equals(PubConfig.get("TenPayRunMode"))?true:false);//是否是测试的。

//商户号
String bargainor_id = PubConfig.get("TenPayPartner"+(isTest?"_T":""));
//密钥
String key = PubConfig.get("TenPaySPKey"+(isTest?"_T":""));
//回调通知URL
String return_url = PubConfig.get("TenPayReturnUrl"+(isTest?"_T":""));
//通知URL
String notify_url = PubConfig.get("TenPayNotifyUrl"+(isTest?"_T":""));
//创建PayRequestHandler实例
RequestHandler reqHandler = new RequestHandler(request, response);
//设置密钥
reqHandler.setGateUrl(PubConfig.get("TenPayGateUrl"+(isTest?"_T":"")));
reqHandler.setKey(key);
//初始化
reqHandler.init();
//-----------------------------
//设置支付参数
//-----------------------------
reqHandler.setParameter("sign_type","MD5");
reqHandler.setParameter("service_version","1.0");
reqHandler.setParameter("input_charset","UTF-8");
reqHandler.setParameter("sign_key_index","1");
reqHandler.setParameter("bank_type",strBankType);
reqHandler.setParameter("body",strDesc);
reqHandler.setParameter("attach","");
reqHandler.setParameter("return_url",return_url);
reqHandler.setParameter("notify_url",notify_url);
reqHandler.setParameter("partner",bargainor_id);
reqHandler.setParameter("out_trade_no",strOdrID);
reqHandler.setParameter("total_fee",String.valueOf(fltTotalFee));
reqHandler.setParameter("fee_type","1");
reqHandler.setParameter("spbill_create_ip",request.getRemoteAddr());


/* reqHandler.setParameter("bargainor_id", bargainor_id);			//商户号
reqHandler.setParameter("sp_billno", sp_billno);				//商家订单号
reqHandler.setParameter("transaction_id", transaction_id);		//财付通交易单号
reqHandler.setParameter("return_url", return_url);				//支付通知url
reqHandler.setParameter("notify_url", notify_url);				//支付通知url
reqHandler.setParameter("desc", strDesc);	//商品名称
reqHandler.setParameter("total_fee", String.valueOf(fltTotalFee));		//商品金额,以分为单位
reqHandler.setParameter("cs","UTF-8");
reqHandler.setParameter("bank_type",strBankType);//银行 */

//用户ip,测试环境时不要加这个ip参数，正式环境再加此参数
//if(!isTest) reqHandler.setParameter("spbill_create_ip",request.getRemoteAddr());

//获取请求带参数的url
String requestUrl = reqHandler.getRequestURL();
//Tools.writeFile(Const.PROJECT_PATH+"log/tenpay.txt",requestUrl);
response.sendRedirect(requestUrl);
%>