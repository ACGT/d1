<%@page import="com.d1.util.Tools"%>
<%@page import="java.net.URLDecoder"%><%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=GBK"%>


<%
String title=request.getParameter("title");
if(!Tools.isNull(title)){
	title=URLDecoder.decode(title,"utf-8");
}
String subad_p = "";
if(act_list != null && act_list.getActindex_subad() != null){
	subad_p = act_list.getActindex_subad();
}
String uu = "";
if(act_list != null && act_list.getActindex_gourl() != null){
	uu = act_list.getActindex_gourl().replace("&", "@");
}else if(request.getParameter("subad")!=null){
	uu = "http://www.d1.com.cn/html/miaosha";
}
String strad2="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+(request.getParameter("subad")==null?subad_p:request.getParameter("subad"))+"1&url=";
String strad="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+(request.getParameter("subad")==null?subad_p:request.getParameter("subad"))+"&url=";
String str="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+(request.getParameter("subad")==null?subad_p:request.getParameter("subad"))+"&url="+(request.getParameter("url")==null ? uu : request.getParameter("url"));
%>
<style>
a{ TEXT-DECORATION: none;}
 A:link    {TEXT-DECORATION: none;}
A:hover   { TEXT-DECORATION: none;}
</style>

</head>

<body>
<center>
<table width="750" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="750"  border="0" cellpadding="0" cellspacing="0" style="font-size:12px;" align="center">
        <tr>
          <td width="158" height="70"  rowspan="2"><a href="<%=strad %>http://www.d1.com.cn/" target="_blank"><img src="http://images.d1.com.cn/zt2012/mail/mailh_01.jpg" width="158" height="55" border="0"/></a></td>
          <td width="271" height="32">&nbsp;</td>
          <td width="84"><img src="<%=strad2 %>http://images.d1.com.cn/images2013/mail/mailh_02.jpg" />&nbsp;<a href="<%=strad %>http://www.d1.com.cn/user/" target="_blank"><span style="color:#000;font-size:9pt;">我的帐户</span></a></td>
          <td width="79"><img src="http://images.d1.com.cn/zt2012/mail/mailh_02.jpg"  />&nbsp;<a href="<%=strad %>http://www.d1.com.cn/jifen/index.jsp" target="_blank"><span style="color:#000;font-size:9pt;">积分换购</span></a></td>
          <td width="73"><img src="http://images.d1.com.cn/zt2012/mail/mailh_02.jpg" />&nbsp;<a href="<%=strad %>http://help.d1.com.cn/" target="_blank"><span style="color:#000;font-size:9pt;">帮助中心</span></a></td>
          <td width="85"><img src="http://images.d1.com.cn/zt2012/mail/online.png"  />&nbsp;<a href="http://b.qq.com/webc.htm?new=0&sid=4006808666&eid=218808P8z8p8y8y8q8x8z&o=www.d1.com.cn&q=7&ref=" target="_blank"><span style="color:#000;font-size:9pt;">在线客服</span></a></td>
        </tr>
        <tr>
          <td height="33" colspan="5" align="right"><a href="<%=strad %>http://help.d1.com.cn/hphelpnew.htm?code=0505">如何正常接收促销邮件？</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=str %>"><font style="font-size:9pt;color:#000 ">此邮件如果无法浏览，请点击此处》</font></a></td>
        </tr>
      </table>
   </td>
  </tr>
  <tr>
    <td><table width="0" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><a href="<%=strad %>http://www.d1.com.cn/" target="_blank"><img src="http://images.d1.com.cn/images2015/mail/hmail2015_01.jpg" border="0"></a></td>
        <td><a href="<%=strad %>http://www.d1.com.cn/result.jsp?productsort=014" target="_blank"><img src="http://images.d1.com.cn/images2015/mail/hmail2015_02.jpg" border="0"></a></td>
        <td><a href="<%=strad %>http://www.d1.com.cn/result.jsp?productsort=030" target="_blank"><img src="http://images.d1.com.cn/images2015/mail/hmail2015_03.jpg" border="0"></a></td>
        <td><a href="<%=strad %>http://www.d1.com.cn/result.jsp?productsort=020" target="_blank"><img src="http://images.d1.com.cn/images2015/mail/hmail2015_04.jpg" border="0"></a></td>
        <td><img src="http://images.d1.com.cn/images2015/mail/hmail2015_05.jpg" border="0"></td>
     </tr>
    </table></td>
  </tr>
</table>