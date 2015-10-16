<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp"%><%
String strKey = PubConfig.get("139mail_key");//md5加密密钥
String strClickSysId = PubConfig.get("139mail_partner");//合作商id
String strRType = "0";//转向Url类型
String strRUrl = "";//转向url
//当前时间戳 - 2000-01-01 00:00:00 的秒数
long lngNowTimetamp = (System.currentTimeMillis()-946656000000l)/1000;
lngNowTimetamp += 5 * 60;

String strMKey1 = strClickSysId + strRType + strRUrl + lngNowTimetamp + strKey;

strMKey1 = MD5.to32MD5(strMKey1).toUpperCase();

String url = "http://sq.mail.10086.cn/TrustLogWeb/webapi/TrustLogin.aspx?clickSysId="+strClickSysId+"&rType="+strRType;
url+="&rUrl="+strRUrl+"&timestamp="+lngNowTimetamp+"&mKey="+strMKey1;

response.sendRedirect(url);

///139返回地址好像本地没法配置。。
%>