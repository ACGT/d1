<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp"%><%@include file="../inc/islogin.jsp"%>
<%@page import="
com.pingan.cert.Verify.*,
com.pingan.cert.Interface.*,
com.d1.bean.OrderBase,
com.d1.bean.PingAnUser,
com.d1.helper.OrderHelper,
com.d1.helper.UserHelper,
java.net.URLEncoder,
java.text.SimpleDateFormat,
java.util.Date
"%>
<%
String strOdrID=request.getParameter("OdrID");
OrderBase order=OrderHelper.getById(strOdrID);
if(order==null) {out.print("订单号不存在！");return;}
Double fPaymoney=order.getOdrmst_acturepaymoney();
Double fShipFee=order.getOdrmst_shipfee();
SimpleDateFormat sdf =  new SimpleDateFormat("MM/dd/yyyy HH:mm:ss"); 
String strOrderDate=sdf.format(order.getOdrmst_orderdate());
String strMbrID=order.getOdrmst_mbrid().toString();
PingAnUser pauser=UserHelper.getPinganLoginUser(strMbrID);
if(pauser==null) {out.print("平安会员号不存在！");return;}
//平安接口参数
String strPostUrl=InterfacePost.strPayPostUrl;//跳至万里通url
//String strGUrl=InterfacePost.strPayGUrl;//跳前url
String strGUrl="http://www.d1.com.cn/pingan/Notify.jsp?";
String strBackUrl=InterfacePost.strPayBackUrl;//万里通回调url
String strMethod="CheckRedeem";//操作类型，固定为:CheckRedeem.
String strPartner =InterfacePost.strPayPartner;//万里通分配的合作伙伴代码
String strMemberID=pauser.getMbrmstpingan_memberid();
String strAmount =Tools.getFloat(fPaymoney.floatValue(), 2)+""; //交易金额=商品金额+配送金
String strAttchAmount =Tools.getFloat(fShipFee.floatValue(), 2)+"";//配送金额
String strSysDate = sdf.format(new Date());
String strTTTime = strOrderDate;//交易时间,即客户的付费时
String strTTNumber = strOdrID;//订单号
String strOrderId = strOdrID;//订单号
String strParam =InterfacePost.strPayParam;//产品编号，固定值,待万里通分配
String strTerminalID = "";//终端编号，没有为空
String strChannel = "1";//线上线下标识:固定1
String strPointType = "Base Point";	//点数类型,固定Base Point
String strExt1 ="";//扩展1
String strExt2 ="";//扩展2	
String strExt3 ="";//扩展3
String strMediumSource ="";//媒体参数
String strPaSignature = null;//签名信息

StringBuilder stbQueryStr = new StringBuilder();
stbQueryStr.append("gURL="+URLEncoder.encode(strGUrl,"UTF-8"));
stbQueryStr.append("&BackURL="+URLEncoder.encode(strBackUrl,"UTF-8"));
stbQueryStr.append("&Method="+URLEncoder.encode(strMethod,"UTF-8"));
stbQueryStr.append("&Partner="+URLEncoder.encode(strPartner,"UTF-8"));
stbQueryStr.append("&MemberID="+URLEncoder.encode(strMemberID,"UTF-8"));
stbQueryStr.append("&Amount="+URLEncoder.encode(strAmount,"UTF-8"));
stbQueryStr.append("&AttchAmount="+URLEncoder.encode(strAttchAmount,"UTF-8"));
stbQueryStr.append("&sysDate="+URLEncoder.encode(strSysDate,"UTF-8"));
stbQueryStr.append("&TTTime="+URLEncoder.encode(strTTTime,"UTF-8"));
stbQueryStr.append("&TTNumber="+URLEncoder.encode(strTTNumber,"UTF-8"));
stbQueryStr.append("&OrderId="+URLEncoder.encode(strOrderId,"UTF-8"));
stbQueryStr.append("&param="+URLEncoder.encode(strParam,"UTF-8"));
stbQueryStr.append("&TerminalID="+URLEncoder.encode(strTerminalID,"UTF-8"));
stbQueryStr.append("&Channel="+URLEncoder.encode(strChannel,"UTF-8"));
stbQueryStr.append("&PointType="+URLEncoder.encode(strPointType,"UTF-8"));
stbQueryStr.append("&Ext1="+strExt1);
stbQueryStr.append("&Ext2="+strExt2);
stbQueryStr.append("&Ext3="+strExt3);
stbQueryStr.append("&MediumSource="+URLEncoder.encode(strMediumSource,"UTF-8"));
//SignatureService sign=new SignatureService(Const.PROJECT_PATH+"pingan/zhengshu/D1.pfx","D1&WLT@)!@",Const.PROJECT_PATH+"pingan/zhengshu/");
SignatureService sign=new SignatureService(Const.PROJECT_PATH+"pingan/zhengshu/wanlitong11.pfx","wanlitong",Const.PROJECT_PATH+"pingan/zhengshu/");
//System.out.println("d1gjlpingan:"+stbQueryStr.toString()+"-----"+);
strPaSignature=sign.sign(stbQueryStr.toString());
response.sendRedirect(strPostUrl+"?"+stbQueryStr.toString()+"&paSignature="+strPaSignature);
%>