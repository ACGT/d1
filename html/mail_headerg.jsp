<%@page import="com.d1.util.Tools"%>
<%@page import="java.net.URLDecoder"%><%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=GBK"%>


<%
String title=request.getParameter("title");
if(!Tools.isNull(title)){
	title=URLDecoder.decode(title,"utf-8");
}
String strad2="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+request.getParameter("subad")+"1&url=";
String strad="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+request.getParameter("subad")+"&url=";
String str="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+request.getParameter("subad")+"&url="+request.getParameter("url");

%>
<style>
a{ TEXT-DECORATION: none;}
 A:link    {TEXT-DECORATION: none;}
A:hover   { TEXT-DECORATION: none;}
</style>

</head>

<body>
<center>
<table width="750"  border="0" cellpadding="0" cellspacing="0" style="font-size:12px;" align="center">
  <tr>
    <td width="158" height="70"  rowspan="2"><a href="<%=strad %>http://www.d1.com.cn/" target="_blank"><img src="http://images.d1.com.cn/images2013/mail/mailh_01.jpg" width="158" height="55" border="0"/></a></td>
    <td width="271" height="32">&nbsp;</td>
    <td width="84"><img src="<%=strad2 %>http://images.d1.com.cn/images2013/mail/mailh_02.jpg" />&nbsp;&nbsp;<a href="<%=strad %>http://www.d1.com.cn/user/" target="_blank"><span style="color:#000;font-size:9pt;">我的帐户</span></a></td>
    <td width="79"><img src="http://images.d1.com.cn/images2013/mail/mailh_02.jpg"  />&nbsp;&nbsp;<a href="<%=strad %>http://www.d1.com.cn/jifen/index.jsp" target="_blank"><span style="color:#000;font-size:9pt;">积分换购</span></a></td>
    <td width="73"><img src="http://images.d1.com.cn/images2013/mail/mailh_02.jpg" />&nbsp;&nbsp;<a href="<%=strad %>http://help.d1.com.cn/" target="_blank"><span style="color:#000;font-size:9pt;">帮助中心</span></a></td>
    <td width="85"><img src="http://images.d1.com.cn/images2013/index/online.png"  />&nbsp;&nbsp;<a href="http://b.qq.com/webc.htm?new=0&sid=4006808666&eid=218808P8z8p8y8y8q8x8z&o=www.d1.com.cn&q=7&ref=" target="_blank"><span style="color:#000;font-size:9pt;">在线客服</span></a></td>
  </tr>
  <tr>
    <td height="33" colspan="5" align="right"><a href="<%=str%>"><font style="font-size:9pt;color:#000 ">此邮件如果无法浏览，请点击此处》</font></a></td>
  </tr>
  <tr>
    <td height="37" colspan="6" background="http://images.d1.com.cn/images2013/mail/mailh_03.jpg"><table width="750" height="37" border="0" cellpadding="0" cellspacing="0" style="font-family: '微软雅黑';	font-size: 13px;font-weight: 800;color: #FFFFFF;">
      <tr>
        <td width="64" height="37" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;" ><a href="<%=strad %>http://www.d1.com.cn/" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><b>首页</b></span></a></td>
        <td width="74" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;"><a href="<%=strad %>http://www.d1.com.cn/html/women/" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><b>女装</b></span></a> </td>
        <td width="74" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;"><a href="<%=strad %>http://www.d1.com.cn/html/men/" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><b>男装</b></span></a> </td>
        <td width="78" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;"><a href="<%=strad %>http://cosmetic.d1.com.cn/" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><b>化妆品</b></span></a> </td>
        <td width="73" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;"><a href="<%=strad %>http://www.d1.com.cn/result.jsp?productsort=020012,020011,030011,030015" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><b>内衣</b></span></a> </td>
        <td width="61" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;"><a href="<%=strad %>http://www.d1.com.cn/result.jsp?productsort=021,031" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><b>鞋</b></span></a></td>
        <td width="74" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;"> <a href="<%=strad %>http://www.d1.com.cn/result.jsp?productsort=040,015002,015009" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><b>配饰</b></span></a> </td>
        <td width="74" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;"><a href="<%=strad %>http://www.d1.com.cn/result.jsp?productsort=050" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><b>箱包</b></span></a> </td>
        <td width="62" >&nbsp;</td>
        <td width="103" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;"><a href="<%=strad %>http://www.d1.com.cn/zhuanti/201309/dp0928/" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><b>服饰搭配</b></span></a></td>
        <td width="13">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>