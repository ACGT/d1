<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>网易兑换-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="http://mimg.127.net/xm/all/point_club/110622/css/style.css"		rel="stylesheet" type="text/css"/>
<link href="http://mimg.127.net/xm/all/point_club/progress/medaltalent/css/style.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src = "http://mimg.127.net/xm/all/point_club/js/jifen_110817.js"></script>	
<script type="text/javascript" src="http://mimg.127.net/mailapi/webmailapi-2.2.min.utf8.js"></script>
<script type="text/javascript" src = "http://mimg.127.net/p/tools/jquery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src = "http://club.mail.163.com/jifen/js/action120926.js"></script>
<script type="text/javascript" src = "http://club.mail.163.com/jifen/js/page110829.js"></script>
<script type="text/javascript" src = "http://club.mail.163.com/jifen/js/address120206.js"></script>	
<script type="text/javascript" src = "http://club.mail.163.com/jifen/js/prompt120203.js"></script>	
<script type="text/javascript" src = "http://mimg.127.net/xm/all/point_club/js/share121025.js"></script>
<script type="text/javascript" src = "http://club.mail.163.com/jifen/js/countdown111008.js"></script>
<script type="text/javascript" src = "http://club.mail.163.com/jifen/js/share2mail.js"></script>	
<script type="text/javascript" src = "http://club.mail.163.com/jifen/js/util121120.js"></script>
<script type="text/javascript" src = "http://club.mail.163.com/jifen/js/slide111221.js"></script>
<script type="text/javascript" src = "http://club.mail.163.com/jifen/js/recommend120229.js"></script>

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<center>
<div class="header">	
<div class="inner page">
<div style="float:left;padding-top:10px;"> <a href="http://club.mail.163.com/jifen/index.do" title="进入网易邮箱" target="_blank" >	<img src="http://mimg.127.net/xm/all/point_club/img/logo.png" alt="网易邮箱用户俱乐部——享受积分礼品回馈·获取最新产品咨询·体验邮箱等级特权的平台" />		</a>	</div>	
<div style="float:left; padding-left:20px;"> 
<a href="http://d1.com.cn" title="进入D1优尚" target="_blank" >	<img src="http://images.d1.com.cn/images2012/index2012/daohang_13.jpg"  />		</a>	
</div>
<div class="header-links">		
	<a href="http://mail.163.com/" target="_blank" title="163邮箱" onClick="return onHrefClick(this);">163</a>			| <a href="http://mail.126.com/" target="_blank" title="126邮箱" onClick="return onHrefClick(this);">126</a>			| <a href="http://mail.yeah.net/" target="_blank" title="yeah邮箱" onClick="return onHrefClick(this);">yeah</a>			| <a href="http://zhidao.mail.163.com/zhidao/newsugg.jsp#用户俱乐部"				target="_blank" title="" onClick="return onHrefClick(this);">用户反馈</a> | <a		href="http://club.mail.163.com/jifen/privilege/jifen.do" title="" onClick="return onHrefClick(this);">积分规则</a> | <a				href="http://help.163.com/special/007525G0/163mail_index.html"				target="_blank" title="" onClick="return onHrefClick(this);">帮助中心</a>		</div>	</div></div>	
	<div class="navigation-warper">		
	<div class="navigation">		
		<a class="subscribe " href="http://subscribe.mail.163.com/subscribe/outer.jsp?sub=true&product=jifen&notify_type=mail" target="_blank" title="免费订阅俱乐部信息">免费订阅俱乐部信息</a>
		<ul class="navigation-list ch5On"><!-- 哪个频道被激活，则左侧调用 chxOn -->
			<li class="ch1"><a href="http://club.mail.163.com/jifen/index.do" target="_blank" >首页</a></li>
			<li class="ch2"><a href="http://club.mail.163.com/jifen/privilege/grade.do" target="_blank" >特权等级</a></li>
			<li class="ch3"><a href="http://club.mail.163.com/jifen/activity/list.do" target="_blank" >活动区</a></li>
				<li class="ch4"><a href="http://www.d1.com.cn/html/zt2012/20121212wycj/cjindex.jsp" target="_blank" >抽奖区</a></li>
<li class="ch5"><a href="http://www.d1.com.cn/html/zt2012/20121212wycj/dhindex.jsp" target="_blank" >兑换区</a></li>
	<li class="ch6"><a href="http://club.mail.163.com/jifen/wininfo/query.do" target="_blank" >中奖信息</a></li>
		<li class="ch7"><a href="http://club.mail.163.com/jifen/ucenter/uinfo.do" target="_blank" >个人中心</a></li>
		</ul>				</div>	</div>
	<div class="page">		
  <div class="g-contBox g-shadow g-contBox-noBdr">		
  <div class="g-contBox-title">&nbsp;</div>
  			<div class="g-contBox-content">			
  				<div class="g-contBox-contBgBot">	
  		  <jsp:include   page= "tj.jsp"   />		
  </div></div></div></div>	
</center>
</body>
</html>	