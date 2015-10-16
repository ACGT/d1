<%@ page contentType="text/html; charset=UTF-8" import="com.d1.alipay.*,java.net.*,org.dom4j.Element,org.dom4j.DocumentException,org.dom4j.io.SAXReader,org.dom4j.Document"%><%@include file="/inc/header.jsp"%>
<%@ page import="com.thoughtworks.xstream.XStream,com.thoughtworks.xstream.io.json.JettisonMappedXmlDriver" %>
<%!
 private static final long serialVersionUID = 1L;
	    /**信用卡*/
	    private static final String CREDITCARD="信用卡";
	    /**储蓄卡*/
	    private static final String DEBITCARD="储蓄卡";
	    /**
	     * 把get请求转给doPost处理
	     */
	    
	    /**
	     * 显示支付前置列表信息
	     * @param payChannleResult 无线收银台针对该笔交易支持的一级资金渠道
	     * @param out 输出流
	     * @param basePath 应用服务器地址
	     */
	    private String showChannels(PayChannleResult payChannleResult,String basePath) {
	       StringBuilder sb=new StringBuilder();
	        sb.append("<div class='ap-b  ap-cb-gray '>");
	        sb.append("<div class='ap-left'>");
	        sb.append("<a href=" + basePath + "&cashierCode=>支付宝账户支付</a><br/>");
	        if (payChannleResult.getLastestPayChannel() != null && payChannleResult.getLastestPayChannel().getCashierCode()!=null) {
	        	sb.append("最近使用:<a href=" +basePath+ "&cashierCode="+payChannleResult.getLastestPayChannel().getCashierCode()+">"
	                +payChannleResult.getLastestPayChannel().getName() + "</a><br/>");
	        }
	        sb.append("</div>");
	        sb.append("</div>");
	        
	        /**得到快捷支付列表(信用卡快捷和储蓄卡快捷)*/
	        List<SupportTopPayChannel> quickPays = payChannleResult.getSupportedPayChannelList();
	        /**快捷支付子节点*/
	        List<SupportSecPayChannel> quickPayChild;
	        if (quickPays != null) {
	        	sb.append("<div class='b-hr'></div>");
	            int index = 0;
	            for (SupportTopPayChannel supportTopPayChannel : quickPays) {
	                index++;
	                sb.append("<div class='ap-b ap-left'>");
	                if (supportTopPayChannel.getCashierCode().equals("CREDITCARD")) {
	                	sb.append("信用卡支付<br/>");
	                }
	                if (supportTopPayChannel.getCashierCode().equals("DEBITCARD")) {
	                	sb.append("储蓄卡支付<br/>");
	                }
	                quickPayChild = supportTopPayChannel.getSupportSecPayChannelList();
	                for (SupportSecPayChannel supportSecPayChannel : quickPayChild) {
	                    if (supportSecPayChannel.getCashierCode().startsWith("CREDITCARD")) {
	                    	sb.append("<a href=" + basePath + "&cashierCode="
	                                    + supportSecPayChannel.getCashierCode() + ">"
	                                    + supportSecPayChannel.getName() + CREDITCARD + "</a><br/>");
	                    }
	                    if (supportSecPayChannel.getCashierCode().startsWith("DEBITCARD")) {
	                    	sb.append("<a href=" + basePath + "&cashierCode="
	                                    + supportSecPayChannel.getCashierCode() + ">"
	                                    + supportSecPayChannel.getName() + DEBITCARD + "</a><br/>");
	                    }
	                }
	                sb.append("</div>");
	                if (index != quickPays.size()) {
	                	sb.append("<div class='b-dot'></div>");
	                }
	            }

	        }
	            return sb.toString();
	    }
	    
	    /**
	     * 输出页面头信息
	     * @param out 输出流
	     * @param basePath 应用服务器地址
	     */
	    private String printHead(String basePath){
	    	StringBuilder sb=new StringBuilder();
	        sb.append("<?xml version='1.0' encoding='UTF-8'?>");
	        sb.append("<!DOCTYPE html PUBLIC '-//WAPFORUM//DTD XHTML Mobile 1.0//EN' 'http://www.wapforum.org/DTD/xhtml-mobile10.dtd'>"); 
	        sb.append("<html xmlns='http://www.w3.org/1999/xhtml'>"); 
	        sb.append("<head>"); 
	        sb.append("<meta http-equiv='Content-Type' content='application/vnd.wap.xhtml+xml;charset=utf-8' />"); 
	        sb.append("<title>手机支付宝</title>"); 
	        sb.append("<link href="+basePath+"css/ap-3g.css rel=stylesheet />");
	        sb.append("<body>");
	        return sb.toString();
	    }
	    
	    /**
	     * 输出页面正文信息
	     * @param out 输出流
	     * @param basePath 应用服务器地址
	     */
	    private String  printBody(){
	    	StringBuilder sb=new StringBuilder();
	    	sb.append("<div class='ap-top'>");
	    	sb.append("<div class='ap-p b-bt'>");
	    	sb.append("商户>支付中心");
	    	sb.append("</div>");
	    	sb.append("<div class='ap-b ap-left ap-noline'>");
	    	sb.append("欢迎您：&nbsp; test &nbsp;<a>退出</a><br />");
	    	sb.append("账号余额：<strong><span class='ap-c-red'>96.49</span></strong>元<br /> ");
	    	sb.append("余额不足还需支付：<strong><span class='ap-c-red'>20</span></strong>元<br />");
	    	sb.append("</div> ");
	    	sb.append("<div class='ap-b b-hr ap-hr'> ");
	    	sb.append(" 选择支付方式");
	    	sb.append("</div>");
	    	return sb.toString();
	    }
	    
	    /**
	     * 输出页面尾信息
	     * @param out 输出流
	     * @param basePath 应用服务器地址
	     */
	    private String printFoot(){
	    	StringBuilder sb=new StringBuilder();
	    	sb.append("<div class='b-hr'> ");
	    	sb.append("<div class='ap-left'>");
	    	sb.append("<a>返回上页</a><br />");
	    	sb.append("<a>账号</a> | <a>充值</a> | <a>首页</a> | <a>帮助</a><br />");
	    	sb.append("<a>意见</a> | <a>书签</a> | <a>合作</a> | <a>友链</a><br />");
	    	sb.append("网络经营许可：京ICP证100422<br />");
	    	sb.append("业务经营许可：京B2-20110012");
	    	sb.append("</div>");
	        
	    	sb.append("</div>");
	    	sb.append("</body>");
	    	sb.append("</html>"); 
	    	return sb.toString();
	    }
	    
	    /**
	     * 得到支付前置列表
	     * @param out_user 外部用户ID
	     * @return 支付前置列表信息
	     * @throws Exception
	     */
	    private String getChannelList(String out_user) throws Exception{
	        
	        Map<String, String> reqParams = new HashMap<String, String>();
	        /**支付前置服务器地址*/
	        String url="https://mapi.alipay.com/gateway.do";
	        /**支付前置服务名称*/
	        reqParams.put("service", "mobile.merchant.paychannel");
	        /**合作商户ID*/
	        reqParams.put("partner", AlipayConfig.partner);
	        /**签名类型*/
	        reqParams.put("sign_type",AlipayConfig.sign_type);
	        /**参数编码字符集*/
	        reqParams.put("_input_charset", AlipayConfig.input_charset);
	        if(!StringUtil.isBlank(out_user)){
	            reqParams.put("out_user", out_user);
	        }
	        
	        /**待签名数据*/
	        String signData = wapParameterUtil.getSignData(reqParams);
	        /**签名*/
	        String sign=wapMD5Signature.sign(signData,AlipayConfig.key);
	        reqParams.put("sign", sign);
	        String params = wapParameterUtil.mapToUrl(reqParams);
	      //  System.out.println("params:"+params);
	        /**http get方式调用接口*/
	        URL serverUrl = new URL(url);
	        HttpURLConnection urlconn = (HttpURLConnection) serverUrl.openConnection();
	        urlconn.setRequestMethod("GET");
	        urlconn.setDoOutput(true);
	        urlconn.connect();
	        urlconn.getOutputStream().write(params.getBytes());
	        
	        InputStream is = urlconn.getInputStream();
	        /**输入流转码成GBK*/
	        BufferedReader in = new BufferedReader(new InputStreamReader(is,"GBK"));
	        StringBuffer buffer = new StringBuffer();
	        String line = "";
	        while ((line = in.readLine()) != null) {
	            buffer.append(line);
	        }
	        
	        /**得到返回数据*/
	        /**返回数据样例：<?xml version="1.0" encoding="GBK"?><alipay><is_success>T</is_success><request><param name="sign">1bfb538f51c5dae91e9b138dbbe7fc6c</param><param name="_input_charset">GBK</param><param name="sign_type">MD5</param><param name="service">mobile.merchant.paychannel</param><param name="partner">2088301265823075</param></request><response><alipay><result>{"payChannleResult":{"supportedPayChannelList":{"supportTopPayChannel":[{"name":"信用卡快捷支付","cashierCode":"CREDITCARD","supportSecPayChannelList":{"supportSecPayChannel":[{"name":"建行","cashierCode":"CREDITCARD_CCB"},{"name":"工行","cashierCode":"CREDITCARD_ICBC"},{"name":"中行","cashierCode":"CREDITCARD_BOC"},{"name":"农行","cashierCode":"CREDITCARD_ABC"},{"name":"平安","cashierCode":"CREDITCARD_SPABANK"},{"name":"更多","cashierCode":"CREDITCARD"}]}},{"name":"借记卡快捷支付","cashierCode":"DEBITCARD","supportSecPayChannelList":{"supportSecPayChannel":[{"name":"工行","cashierCode":"DEBITCARD_ICBC"},{"name":"农行","cashierCode":"DEBITCARD_ABC"}]}}]}}}</result></alipay></response><sign>6142f842c2d96d0d1b58a78cb5edeb20</sign><sign_type>MD5</sign_type></alipay>*/
	        String response = buffer.toString();
	        urlconn.disconnect();
	        return response;
	    }
	    
	    
	    /**
	     * 得到xml字符串节点内容
	     * @param xml xml格式的字符串
	     * @param name xml的节点名称
	     * @return 节点内容
	     */
	    private String getXmlValue(String xml, String name) {
	        if (StringUtil.isBlank(xml) || StringUtil.isBlank(name)) {
	            return "";
	        }
	        int start = xml.indexOf("<" + name + ">");
	        start += (name.length() + 2);// 去掉本字符串和"<"、">"的长度
	        int end = xml.indexOf("</" + name + ">");
	        if (end > start && end <= (xml.length() - name.length() - 2)) {
	            return xml.substring(start, end);
	        } else {
	            return "";
	        }
	    }
%>
<%
response.setContentType( "text/html;charset=utf-8"); 
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

/**得到应用服务器地址*/
String basePath = "http://m.d1.cn/interface/pay/wapalipay/Trade.jsp?OdrID="+strOdrID;

/**获取外部用户id*/
String out_user=lUser.getId();
/**把out_user放入session中 后面用到*/
request.getSession().setAttribute("out_user", out_user);
/**得到支付前置列表*/
String businessResult="";
try {
    businessResult = getChannelList(out_user);
    System.out.println("businessResult:"+businessResult);
    String isSuccess = getXmlValue(businessResult, "is_success");
    /**T为成功*/
    if ("T".equalsIgnoreCase(isSuccess)) {
        
        /**得到支付前置列表信息 是一个json格式的字符串*/
        /**如下格式：{"payChannleResult":{"supportedPayChannelList":{"supportTopPayChannel":[{"name":"信用卡快捷支付","cashierCode":"CREDITCARD","supportSecPayChannelList":{"supportSecPayChannel":[{"name":"建行","cashierCode":"CREDITCARD_CCB"},{"name":"工行","cashierCode":"CREDITCARD_ICBC"},{"name":"中行","cashierCode":"CREDITCARD_BOC"},{"name":"农行","cashierCode":"CREDITCARD_ABC"},{"name":"平安","cashierCode":"CREDITCARD_SPABANK"},{"name":"更多","cashierCode":"CREDITCARD"}]}},{"name":"借记卡快捷支付","cashierCode":"DEBITCARD","supportSecPayChannelList":{"supportSecPayChannel":[{"name":"工行","cashierCode":"DEBITCARD_ICBC"},{"name":"农行","cashierCode":"DEBITCARD_ABC"}]}}]}}}*/
        String result = getXmlValue(businessResult, "result");
        System.out.println("result:"+result);
        String sign=getXmlValue(businessResult, "sign");
        /**这里验签使用GBK字符集*/
        if(!wapMD5Signature.verify("result="+result, sign, AlipayConfig.key,"GBK")){
            out.print("支付前置验签名失败！");
            out.flush();
            out.close();
            return;
        }
        
        /**将json格式数据转化为java对象*/
        XStream xstream = new XStream(new JettisonMappedXmlDriver());
        xstream.alias("payChannleResult", PayChannleResult.class);
        xstream.alias("latestPayChannel", LastestPayChannel.class);
        xstream.alias("supportTopPayChannel", SupportTopPayChannel.class);
        xstream.alias("supportSecPayChannel", SupportSecPayChannel.class);
        PayChannleResult payChannleResult = (PayChannleResult) xstream.fromXML(result);
        
        /**输出头信息*/
         out.print(printHead(basePath));
        /**输出正文*/
         out.print(printBody());
        /**输出支付前置列表信息*/
        out.print(showChannels(payChannleResult,basePath));
        /**输出尾信息*/
         out.print(printFoot());
        
        out.flush();
        out.close();
    }else{
        /** 获取错误码*/
        String error = getXmlValue(businessResult, "error");
        /**解析错误码*/
        if ("ILLEGAL_ARGUMENT".equalsIgnoreCase(error)) {
            out.print("参数格式不正确");
        } else if ("NOT_EXIST_PARTNER_TYPE_CODE".equalsIgnoreCase(error)) {
            out.print("合作伙伴的签约信息不存在");
        } else if ("SYSTEM_ERROR".equalsIgnoreCase(error)) {
            out.print("系统错误");
        } else {
            out.print("系统错误");
        }
        out.flush();
        out.close();
    }
    
} catch (Exception e) {
    out.println("获取支付前置列表信息出错");
    e.printStackTrace();
}
%>