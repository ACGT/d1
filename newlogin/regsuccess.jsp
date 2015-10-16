<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/inc/islogin.jsp"%><%

%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>注册成功</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/PublicFunction.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/newlogin/validate.js")%>"></script>
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
.ulvalidate li{ float:left;padding-left:20px;}
.reg_bottom{margin:0px auto;  width:756px;}
</style>
<script type="text/javascript">

</script>
</head>

<body>
<%@include file="/inc/head2.jsp" %>
<div class="center">
<!-- 注册成功-->
<%
String lkturl="";
String strLtinfo="";
//LTINFO
/*String ckeLtinfo = Tools.getCookie(request,"LTINFO");

if (!Tools.isNull(ckeLtinfo))
{
    strLtinfo = URLDecoder.decode(ckeLtinfo.trim(),"UTF-8");
    strLtinfo = strLtinfo.replace("'","\"");

if (!Tools.isNull(strLtinfo)){
	 lkturl="http://service.linktech.cn/purchase_cpa.php";
		StringBuffer str=new StringBuffer();
		str.append("a_id=");
		str.append(strLtinfo);
		str.append("&m_id=d1bianli");
		str.append("&mbr_id=").append(lUser.getMbrmst_uid());
		str.append("&&o_cd=").append(lUser.getMbrmst_uid());
		str.append("&p_cd=d1_member");
		//IntfUtil.GetPostData(url, str.toString());
		lkturl+="?"+str.toString();
		
} */%>
<%//if (!Tools.isNull(lkturl)) {%>
		<!-- <img src="<%//= lkturl%>" width=1 height=1 style=display:none> -->
<%//}} %>
   <div class="reg_suc">
   	   <div class="regsuc_top">
			  <span>恭喜您成为D1优尚注册会员！</span>
		</div>
		</div>
		<div style="clear:both;"></div>
		 <div class="regsuc_main"> <div class="regsuc_maindetail">
		 <table cellpadding="0" cellspacing="0" border="0" width="550px">
			<tr><td align="center">
				<table cellpadding="0" cellspacing="0" border="0" >
				<tr><td><img src="http://images.d1.com.cn/images2012/login/zc_31.jpg"/></td>
				<td><span class="regsuc_mainspan">&nbsp;恭喜您已注册成功&nbsp;&nbsp;&nbsp;&nbsp;</span></td><td><a href="/index.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/login/zc_13.jpg" border="0"/></a></td>
				</tr>
				</table>
			</td></tr>
			<tr><td align="center"><span style="font-size:14px;">您的登录用户名为：<b><%=lUser.getMbrmst_uid() %></b>，请绑定手机，以后也可凭手机号码登录</span></td></tr>
			<tr><td align="center">
			 <table cellpadding="0" cellspacing="0" border="0" width="550px">
			<tr><td align="center">
				<table cellpadding="0" cellspacing="0" border="0" >
				<tr><td><span style="font-size:14px;">手机号码：</span></td>
				<td><input type="text" id="txtRPhone" maxlength="11" onblur="CheckPhone(this.value,0)" onkeyup="this.value=this.value.replace(/[^\d]/g,'');CheckPhone2(this.value);" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "  />&nbsp;&nbsp;<span id="spanRPhone" style="color:red;display:none;">*请输入手机号码 </span><img  id="imgphone" src="http://images.d1.com.cn/images2012/New/user/infosucc.jpg" style=" vertical-align:middle;display:none;" /></td>
				<td>&nbsp;&nbsp;<input type="button" value="获取验证码" style="border:1px #727272 solid;height:24px;" onclick="checktime(this)"/></td>
				</tr>
				<tr><td></td>
				<td valign="top" ><span style="font-size:12px;color:#727272;" id="smsg"></span></td>
				<td></td>
				</tr>
				<tr><td><span style="font-size:14px;">验证码：</span></td>
				<td align="left"><input type="text" id="txtcode"  maxlength="6" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "  />&nbsp;&nbsp;<span id="errCode" style="color:red;display:none;">*请输入验证码 </span><img  id="imgphone" src="http://images.d1.com.cn/images2012/New/user/infosucc.jpg" style=" vertical-align:middle;display:none;" /></td>
				<td></td>
				</tr>
				<tr><td colspan="3" height="30px">&nbsp;</td></tr>
				<tr><td colspan="3" align="center"><a href="javascript:valitel();"><img src="http://images.d1.com.cn/images2012/login/zc_17.jpg" border="0"/></a></td></tr>
				<tr><td colspan="3" height="40px">&nbsp;</td></tr>
				</table>
			</td></tr></table>
			</td></tr>
		</table>
		
		 </div>  
		  
		 <div style=" background:#f6f6f6; float:left;width:745px; height:140px;margin-top:20px;margin-left:3px;">
	 <div style="padding-top:15px;padding-left:30px;">为了您的账户安全，请验证手机和邮箱。验证通过后可接收账户金额及订单状态的变动提醒，使用快速找回密码、发表评论等功能。</div>
	<div style="padding-top:35px;padding-left:30px;">
	<ul class="ulvalidate">
	<li><a href="/newlogin/valiemail.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/login/zc_21.jpg" border="0"/></a></li>
	<li><a href="/newlogin/valitel.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/login/zc_23.jpg" border="0"/></a></li>
	<li><a href="/newlogin/profile.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/login/zc_25.jpg" border="0"/></a><br/>
	<span style="color:red;font-size:12px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;生日期间可收到生日礼物哦</span>
	</li>
	</ul>
	</div>
	</div>
	<div class="clear"></div>
	
	<div style="height:15px;">&nbsp;</div>
		</div>
    <div style="clear:both;"></div>
    <div class="reg_bottom"><img src="http://images.d1.com.cn/images2012/login/zc_08.jpg"/></div>
</div>
<%@include file="/inc/foot.jsp" %>
</body>
</html>