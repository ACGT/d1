<%@ page contentType="text/html; charset=UTF-8" import="com.d1.bean.id.SequenceIdGenerator"%><%@include file="/inc/header.jsp"%><%

%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>注册页面</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head2012.css")%>" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/newlogin/regist.js")%>"></script>
<style type="text/css" >
body{ margin:0px; padding:0px; border:none; background:#fff; font-size:12px; color:#000;}
a img{ border:none;}
img{ border:none;}
.center{margin:0px auto; }
.reg{margin:0px auto;  width:756px; height:76px; background:url(http://images.d1.com.cn/images2012/login/zc_03-2.jpg) no-repeat; margin-top:40px;}
.btnlogin{padding-left:500px;_padding-left:500px;  height:62px; text-align:right; padding-top:14px;}
.btnlogin a { }
.reg1{margin:0px auto;  width:756px;  background:url(http://images.d1.com.cn/images2012/login/zc_06.jpg) ; padding-top:20px;}
.reg_main{ padding-left:10px; }
.reg_main table{ color:#333; font-size:14px;}
.reg_main table td{ line-height:22px;}
.reg_info{ font-size:16px; color:#d1436b; font-weight:bold; padding-bottom:30px;}
.inputstyle{width:220px; border:solid 1px #ababab; background-color:#f4f4f4; height:22px;}
.reg_main .input_chk{  height:15px; width:20px; background:#fff; border:none; vertical-align:middle;}
.reg_main .td1{ text-align:right;}
.reg_main span{ color:#999999; font-size:12px;}
.reg_main span.red{color:#F00;}
.reg_main span a{ color:#0014a8; text-decoration:underline;}
.reg_main td img{ vertical-align:middle;}
.v2reg_tips02{display:none;  color:#a10000; border:1px #ffd5d5 solid; padding:3px 5px; display:inline-block;}
.reg_bottom{margin:0px auto;  width:756px;}
#getPhoneCode{
	    font-size: 13px;
    height: 30px;
    line-height: 30px;
    padding: 0 10px;
}
</style>
</head>

<body>
<%
String backurl = request.getHeader("referer");
//System.out.print(backurl+"qqqqqqqqqqqqqqq");
if(backurl!=null&&backurl.indexOf("/market/1206/wydh/")>0){
	session.setAttribute("url", backurl);
}
if(backurl!=null&&backurl.indexOf("/market/1207/wangyidh/")>0){
	session.setAttribute("url", backurl);
}
if(backurl!=null&&backurl.indexOf("zhuanti/201303/szn0307/")>0){
	session.setAttribute("url", backurl);
}

if(backurl!=null&&backurl.indexOf("/html/zt2013/etkt0708")>0){
	session.setAttribute("url", backurl);
}

%>
<%@include file="/inc/head2.jsp" %>
<div class="center">
<table cellpadding="0" cellspacing="0" border="0">

</table>


     <div class="reg">
			<div class="btnlogin">
			<table width="100%">
			<tr><td width="100px" align="center"><a href="/login.jsp">
			   <span style="color:#fff;font-size:16px;  font-family:微软雅黑">已有账户</span></a></td>
			   <td align="left">  <a href="/login.jsp">
			   <img src="http://images.d1.com.cn/images2012/login/reglogin.png" alt="立即登录"/></a></td>
			   </tr>
			</table>
			
			 
			</div>
       </div>
       <div style="clear:both;"></div>
       <div class="reg1">
		   <div class="reg_main">
		   <form name="form_Regist" id="form_Regist" action="register.do" method="post" onsubmit="return false;">
		   <table width="740">
			  <tr><td class="reg_info" colspan="3" >填写注册信息</td></tr>
			  <tr><td class="td1"  width="150px">*手机号码：</td><td ><input type="text" name="mobilephone" id="mobilephone"  onfocus="phone_focus();" onblur="is_mobilephone(this.value);" maxlength="11" class="inputstyle"/>&nbsp;&nbsp;<span id="mobilephone_Notice2"></span></td></tr>
			 <tr><td  class="td1">&nbsp;</td><td ><span id="mobilephone_Notice"></span><span>&nbsp;</span>
			  </td></tr>
			   <tr><td class="td1" >*您的性别：</td><td align="left"><input type="checkbox" name="sex" id="sex1" value="0" style="width:20px;" onclick="checksex1(this)"/>男&nbsp;&nbsp;<input type="checkbox" name="sex" id="sex2"  value="1" style="width:20px;" onclick="checksex2(this)"/>女&nbsp;&nbsp;<span id="sex_Notice2"></span></td></tr>
			 <tr><td  class="td1">&nbsp;</td><td ><span id="sex_Notice">选择性别，方便我们推荐适合您的商品。</span><span>&nbsp;</span></td></tr>
			  <tr><td colspan="3" height="10"></td></tr>
			  <tr><td class="td1">*设置密码：</td><td><input type="password" name="password" id="password" onfocus="pass_focus();" onblur="is_pass(this.value);" maxlength="14" class="inputstyle"/>&nbsp;&nbsp;<span id="pass_Notice2"></span>
			  </td></tr>
			 <tr><td  class="td1">&nbsp;</td><td ><span id="pass_Notice"></span><span>&nbsp;</span>
			  </td></tr>
			  <tr><td colspan="3" height="10"></td></tr>
			  <tr><td class="td1">*确认密码：</td><td><input type="password" name="password2" id="password2" onfocus="pass2_focus();" onblur="is_pass2(this.value);" maxlength="14" class="inputstyle"/>&nbsp;&nbsp;<span id="pass2_Notice2"></span>
			   </td></tr>
			 <tr><td  class="td1">&nbsp;</td><td ><span id="pass2_Notice"></span><span>&nbsp;</span>
			  </td></tr>
			  
			  <tr><td colspan="3" height="10"></td></tr>
			  <tr><td class="td1">*手机验证码：</td><td><input type="text" name="code" id="code" onfocus="code_focus();" onblur="is_code(this.value);" maxlength="4" onkeyup="key_up(this);" onkeydown="key_down(event);" class="inputstyle" style="width:118px;" />&nbsp;&nbsp;<button id="getPhoneCode" onclick="fnGetPhoneCode();" disabled>获取验证码</button></td></tr>
			   <tr><td  class="td1">&nbsp;</td><td ><span id="code_Notice"></span><span>&nbsp;</span>
			  </td></tr>
			  <tr><td colspan="3" height="50"></td></tr>
			  <tr><td colspan="3" style="text-align:center;"><input id="regist_submit" onclick="user_regist(form_Regist,this);" type="image" style="width:auto;height:auto;border:none;background:none;" src="http://images.d1.com.cn/images2012/New/reg/reg_new.jpg" /></td></tr>
 <tr><td colspan="3" height="20"></td></tr>
		   </table></form>
		   </div>
    </div>
    <div style="clear:both;"></div>
    <div class="reg_bottom"><img src="http://images.d1.com.cn/images2012/login/zc_08.jpg"/></div>
    
</div>
<script type="text/javascript">
$(function(){
	setTimeout(function(){$('#reg_email').focus();},500);
	$('#vPic').attr('src','/ImageCode?r='+Math.random());
});
</script>
<%@include file="/inc/foot.jsp" %>
</body>
</html>