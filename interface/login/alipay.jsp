<%@ page contentType="text/html; charset=UTF-8" import="com.alipay.services.*" %><%@include file="../../inc/header.jsp"%><%
//选填参数//

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

//////////////////////////////////////////////////////////////////////////////////

//把请求参数打包成数组
Map<String, String> sParaTemp = new HashMap<String, String>();
sParaTemp.put("anti_phishing_key", anti_phishing_key);
sParaTemp.put("exter_invoke_ip", exter_invoke_ip);

//构造函数，生成请求URL
String sHtmlText = AlipayService.alipay_auth_authorize(sParaTemp);
out.println(sHtmlText);
%>