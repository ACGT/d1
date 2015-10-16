<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp"%>
<%
String strLtinfo = Tools.getCookie(request,"LTINFO");//buy/ltfront.asp
String strLianmeng = Tools.getCookie(request,"d1.com.cn.peoplercm");//buy/liangmeng.asp
String strSubad = Tools.getCookie(request,"d1.com.cn.peoplercm.subad");//buy/liangmeng.asp
String strPlinfo = Tools.getCookie(request,"PLINFO");//pluslink 的 cookies buy/pluslink_d1_front.asp
String strChanet = Tools.getCookie(request,"CHANET");//chanet 的 cookies buy/chanet.asp
String strEqifa = Tools.getCookie(request,"EQIFA");//eqifa 的 cookies buy/eqifa.asp
String strEQIFAsrc = Tools.getCookie(request,"EQIFAsrc"); //eqifa 的 cookies buy/eqifa.asp,用于区分是sem还是cps
String strYiqifa = Tools.getCookie(request,"YIQIFA");//yiqifa 的 cookies buy/yiqifa.asp
String strYiqifa_Cid = Tools.getCookie(request,"YIQIFA_Cid");//yiqifa 的 cookies buy/yiqifa.asp
String strLele = Tools.getCookie(request,"lele");//乐乐 的 cookies buy/eqifa.asp
String strLele_S = Tools.getCookie(request,"lele_s");//'乐乐 的 cookies buy/eqifa.asp
String strYeedou = Tools.getCookie(request,"yeedou");//一兜 的 cookies buy/yeedou.asp
String strWEIYI = Tools.getCookie(request,"WEIYI");//唯一 的 cookies buy/Redirect.asp
String strAigoVip = Tools.getCookie(request,"AigoVip");//贵宾网 的 cookies /include/header2007.asp
String strPingan = Tools.getCookie(request,"PINGAN");//贵宾网 的 cookies /include/header2007.asp
String strYOYI = Tools.getCookie(request,"YOYI");//YOYI 的 cookies buy/YOYI.asp
String strIPVGOU = Tools.getCookie(request,"IPVGOU");//联通 的 cookies intf/IPVGOU.asp
String strSOHUVIP = Tools.getCookie(request,"SOHUVIP");//SOHUVIP 的 cookies intf/SOHUVIP.asp
String strFANLI = Tools.getCookie(request,"51FANLI");//返利网 的 cookies intf/51FANLI.asp
String strHZLY = Tools.getCookie(request,"HZLY");//惠众联银 的 cookies buy/hzly.asp
String strLhdlTemp = Tools.getCookie(request,"lhdltemp");//'联合登陆 的 cookies
String strYiGao = Tools.getCookie(request,"YIGAO");//'亿起发cpc的亿告接口 的 cookies intf/yigao.asp
String strD1_Kefu = String.valueOf(session.getAttribute("d1kf_userid"));//客服下单
String strWangYi = Tools.getCookie(request,"wangyi");//网易
String rcmdusr_rcmid = Tools.getCookie(request,"rcmdusr_rcmid");//index99独享价
String srcurl = Tools.getCookie(request,"d1.com.cn.srcurl");//index99独享价
out.println("Ltinfo:"+strLtinfo);
out.println("lm:"+strLianmeng);
out.println("Subad:"+strSubad);
out.println("Plinfo:"+strPlinfo);
out.println("CHANET:"+strChanet);
out.println("EQIFA:"+strEqifa);
out.println("EQIFAsrc:"+strEQIFAsrc);
out.println("YIQIFA:"+strYiqifa);
out.println("YIQIFA_Cid:"+strYiqifa_Cid);
out.println("lele:"+strLele);
out.println("lele_s:"+strLele_S);
out.println("yeedou:"+strYeedou);
out.println("WEIYI:"+strWEIYI);
out.println("AigoVip:"+strAigoVip);
out.println("pingan:"+strPingan);
out.println("YOYI:"+strYOYI);
out.println("IPVGOU:"+strIPVGOU);
out.println("SOHUVIP:"+strSOHUVIP);
out.println("51FANLI:"+strFANLI);
out.println("HZLY:"+strHZLY);
out.println("lhdltemp:"+strLhdlTemp);
out.println("yigao:"+strYiGao);
out.println("d1kf_userid:"+strD1_Kefu);
out.println("wangyi:"+strWangYi);
out.println("rcmdusr_rcmid:"+rcmdusr_rcmid);
out.println("d1.com.cn.srcurl:"+srcurl);
%>