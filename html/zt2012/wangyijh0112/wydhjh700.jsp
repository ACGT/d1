<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<html>
<head>
<title>网易兑换换券</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style type="text/css">
<!--
body{ font-size:12px; background-color:#FFFFFF; line-height:21px;}

td{ text-align:left;font-size:12px;line-height:21px;}
.lin {
	border-bottom-width: 1px;
	border-bottom-style: dashed;
	border-bottom-color: #BCBCBC;
}
.STYLE1 {color: #FF0000}
-->
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<!-- 头部开始 -->
<%@include file="/html/mail_header.jsp"%>
<!-- 头部结束 -->
<center>
<table width="700" border="0"  cellpadding="0" cellspacing="0">
  <tr>
    <td width="28" bgcolor="#F2F2F2">&nbsp;</td>
    <td width="648" bgcolor="#F2F2F2"><br><p>尊敬的网易积分兑换会员</p>
      <p> <span class="STYLE1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;告诉您一个好消息：网易的产品兑换码可已更换为优尚网150元优惠券啦！</span><br></p>
      <p> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;感谢您参与了网易邮箱用户俱乐部积分换购活动，您还没有来D1优尚网兑换心仪的商品，不能让网易积分白白浪费噢！<br>
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 由于商品兑换周期非常短，应广大网易用户的强烈要求， 我们给还未兑换商品的客户提供 一次“将商品兑换码更换为D1优尚网优惠券的机会”。<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;现在您仍然可以使用兑换码换购商品，如果您不想换购相应商品， 可以选择将兑换码更换为D1优尚网150元优惠券。</p></td>
    <td width="24" bgcolor="#F2F2F2">&nbsp;</td>
  </tr>
  <tr>
    <td class="lin" bgcolor="#F2F2F2">&nbsp;</td>
    <td height="80" align="right"  bgcolor="#F2F2F2" class="lin"><div align="center"><a href="http://www.d1.com.cn/market/1109/wangyi/163cpm1109.asp" target="_blank"><img src="http://images.d1.com.cn/images2012/wydhjh/wydhjh01.jpg" width="119" height="26" border="0"></a>&nbsp;&nbsp;&nbsp;<a href="http://www.d1.com.cn/market/1109/wangyi/163getticket.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/wydhjh/wydhjh02.jpg" width="121" height="27" border="0"></a></div></td>
    <td class="lin" bgcolor="#F2F2F2">&nbsp;</td>
  </tr>
  <tr>
    <td bgcolor="#F2F2F2">&nbsp;</td>
    <td bgcolor="#F2F2F2"><br>Q&amp;A：<br>
      Q：如何兑换？<br>
      A：1、请您在收件箱中查看发件人为：网易邮件中心<span class="STYLE1">mail@service.netease.com</span>，标题为：<br><span class="STYLE1">恭喜成功领取D1优尚网…..</span>.的邮件。请将邮件中以<span class="STYLE1">mqwyjf开头的兑换码</span>完整复制下来。<br>
2、登录已有D1优尚账户或注册新账户，并保持登录状态。<br>
3、只要该兑换码未使用过，点击“<span class="STYLE1"><a href="http://www.d1.com.cn/market/1109/wangyi/163getticket.jsp" target="_blank">更换成优惠券</a></span>”按钮，正确输入兑换码即可成功更换为优惠券。<br>
如您点击“<span class="STYLE1"><a href="http://www.d1.com.cn/market/1109/wangyi/163cpm1109.asp" target="_blank">立即兑换商品</a></span>”，正确输入兑换码即可商品兑换成功。<br>
<br><br></td>
    <td bgcolor="#F2F2F2">&nbsp;</td>
  </tr>
  <tr>
    <td height="10"></td>
    <td height="10"></td>
    <td height="10"></td>
  </tr>
  <tr>
    <td colspan="3"><img src="http://images.d1.com.cn/images2012/wydhjh/wydhjh03.jpg" width="700" height="88"></td>
    </tr>
  <tr>
    <td colspan="3"><% request.setAttribute("code","7521");
		request.setAttribute("subad","swydhjh1203");%>
	  <jsp:include   page= "/html/mail_gdsrcm0305.jsp"   /></td>
    </tr>
</table>
</center>


<%@include file="/html/mail_tail.jsp"%>

</body>
</html>