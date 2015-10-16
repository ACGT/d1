<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/inc/islogin.jsp"%><%

%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>手机验证成功</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/PublicFunction.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head2012.css")%>" rel="stylesheet" type="text/css" media="screen" />
<style type="text/css" >
body{ margin:0px; padding:0px; border:none; background:#fff; font-size:12px; color:#000;}
a img{ border:none;}
img{ border:none;}
.center{margin:0px auto; }
.reg_suc{ margin:0px auto; margin-top:40px; width:756px; height:76px; background:url(http://images.d1.com.cn/images2012/login/zc_10.jpg) no-repeat; }
.reg_suc table{ text-align:center;}
.reg_suc table td span{ font-size:16px; color:#d1436b; font-weight:bold; padding-bottom:30px;}
.reg_suc table td .newspan{ color:#000; font-size:14px; line-height:22px;}
.regsuc_top{width:739px;  height:70px; text-align:left; padding-top:6px;padding-left:20px;margin:0px ;}
.regsuc_top span{color:#ffffff;font-weight:bold;font-size:36px;}
.regsuc_main{margin:0px auto; width:756px;  background:url(http://images.d1.com.cn/images2012/login/zc_06.jpg) ;padding-top:20px; }
.regsuc_mainspan{ font-size:16px; color:#d1436b; font-weight:bold;}
.regsuc_maindetail{padding-left:100px;}
.regsuc_maindetail table td{font-size:14px; line-height:36px;}
.ulvalidate{ list-style-type: none;}
.ulvalidate li{ float:left;padding-left:60px;}
.reg_bottom{margin:0px auto;  width:756px;}
</style>

</head>

<body>
<%@include file="/inc/head2.jsp" %>
<div class="center">
<!-- 注册成功-->

<div class="reg_suc">
   	   <div class="regsuc_top">
			  <span>恭喜您成功绑定手机！</span>
		</div>
		</div>
		<div style="clear:both;"></div>
		 <div class="regsuc_main"> <div class="regsuc_maindetail">
		 <table cellpadding="0" cellspacing="0" border="0" width="550px">
			<tr><td align="center">
				<table cellpadding="0" cellspacing="0" border="0" >
				<tr><td><img src="http://images.d1.com.cn/images2012/login/zc_31.jpg"/></td>
				<td><span class="regsuc_mainspan">&nbsp;恭喜您成功绑定手机，以后也可以使用手机号码直接登录</span></td>
				</tr>
				</table>
			</td></tr>
			
		</table>
		 
		 </div> 
		 <div class="clear"></div>
		 
		 <%
		 if(session.getAttribute("zntkturl")!=null){
		 String url=session.getAttribute("zntkturl").toString();
		 session.setAttribute("zntkturl","");
		 response.sendRedirect(url);
		 }

	//判断是否进行邮箱、手机验证
	boolean isemailflag=false;boolean isphoneflag=false;boolean isdetail=false;
	if(lUser.getMbrmst_mailflag()!=null && lUser.getMbrmst_mailflag().longValue()==1){
		isemailflag=true;
	}if(lUser.getMbrmst_phoneflag()!=null && lUser.getMbrmst_phoneflag().longValue()==1){
		isphoneflag=true;
	}
	if(!Tools.isNull(lUser.getMbrmst_name()) && lUser.getMbrmst_birthday()!=null){
		isdetail=true;
	}
	if(!isdetail || !isemailflag || !isphoneflag){
		%>	
		 <div style=" background:#f6f6f6; float:left;width:745px; height:140px;margin-top:20px;margin-left:3px;">
	 <div style="padding-top:15px;padding-left:30px;">为了您的账户安全，请验证手机和邮箱。验证通过后可接收账户金额及订单状态的变动提醒。</div>
	<div style="padding-top:35px;padding-left:30px;">
	<ul class="ulvalidate">
	<%if(!isemailflag){ %><li><a href="/newlogin/valiemail.jsp" ><img src="http://images.d1.com.cn/images2012/login/zc_21.jpg" border="0"/></a></li><%} %>
	<%if(!isphoneflag){ %><li><a href="/newlogin/valitel.jsp" ><img src="http://images.d1.com.cn/images2012/login/zc_23.jpg" border="0"/></a></li><%} %>
	<%if(!isdetail){ %><li><a href="/user/profile.jsp" ><img src="http://images.d1.com.cn/images2012/login/zc_25.jpg" border="0"/></a><br/>
	<span style="color:red;font-size:12px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;生日期间可收到生日礼物哦</span></li><%} %>
	</ul>
	</div>
	</div>
	<div class="clear"></div>
	<div style="height:15px;">&nbsp;</div>
	<div class="clear"></div>
	<%}
	%>
	
		 </div>
   <div style="clear:both;"></div>
    <div class="reg_bottom"><img src="http://images.d1.com.cn/images2012/login/zc_08.jpg"/></div>
</div>
<%@include file="/inc/foot.jsp" %>
</body>
</html>