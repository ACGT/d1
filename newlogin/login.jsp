<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%
if(lUser != null){
	response.sendRedirect("/user/");
	return;
}

String username = Tools.getCookie(request,"LastLoginName");
if(username != null) username = URLDecoder.decode(username,"UTF-8");

String backurl = request.getParameter("url");
session.setAttribute("backurl", backurl);
if(Tools.isNull(backurl)){
	backurl = request.getHeader("referer");
	if(Tools.isNull(backurl)){
		backurl = "/";
	}
}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-用户登录</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head2012.css")%>" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
body{ margin:0px; padding:0px; border:none; background:#fff; font-size:12px; color:#000;}
a img{ border:none;}
img{ border:none;}
.clear{font-size:0; line-height:0; height:0; visibility:hidden; clear:both;float:none;  }
.center{ margin:0px auto; padding-top:50px; padding-bottom:200px; }
.login{ margin:0px auto; background:#fff; width:980px;z-index:10;overflow:hidden;_zoom:1;}
.login span{ font-size:24px; line-height:25px; color:#d5a2a9; font-weight:bold; display:block; padding-top:25px;}
.floatLogin{ position:absolute; background:url(http://images.d1.com.cn/images2012/New/reg/login_fd.png); width:402px;  overflow:hidden; height:388px; top:0; right:0; padding-top:70px; z-index:100;_filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(enabled=true, sizingMethod=scale, src="http://images.d1.com.cn/images2012/New/reg/login_fd.png");_background:none;}
.floatdiv{ position:absolute;width:402px;  overflow:hidden; height:388px; top:0; right:0; padding-top:70px; z-index:101;}
.floatdiv table{ color:#333;}
.floatdiv input{vertical-align:middle;width:182px; height:20px;line-height:20px; background-color:#f4f4f4; border:solid 1px #acacac;}
.floatdiv .spanmsg{ border:solid 1px #6bc7f0; background-color:#e8f5fd; color:#74797d; font-weight:normal; display:block; padding:0px; line-height:18px; font-size:12px; margin-top:1px;}
.floatdiv .spanmsg2{  color:#74797d; font-weight:normal; font-size:12px;padding:0px;}
.floatdiv .spanmsgred{  color:#0149ab; font-weight:normal; font-size:12px;padding:0px;}
.floatdiv .spanmsg2 a{  color:#0149ab; font-weight:normal; font-size:12px;text-decoration:underline; padding:0px;}
.floatdiv .input_chk{  height:15px; width:20px; background:#fff; border:none; vertical-align:middle;}
.apwd{ color:#333; text-decoration:underline; }
.lhdiv{ background:url(http://images.d1.com.cn/images2012/New/reg/login_lhdiv.jpg); width:332px; height:93px; float:right; _float:left; _width:325px; _padding-left:40px;:40px; margin-right:35px; padding-top:15px; padding-left:5px; margin-left:18px; _margin-right:0px; }
.lhdiv img{ vertical-align:text-bottom; }
.lhdiv .newa{ text-decoration:none; color:#0149ab; margin-right:5px; line-height:25px;}
.lhdiv .newa:hover{text-decoration:underline;}
.msdiv{  width:345px; _width:300px; float:right; _float:left; _padding-left:40px; line-height:18px; margin-right:26px;}

.mod_cb_jr_pop { font-size:12px; width:220px; padding:6px 10px 10px; position:absolute; left:0; top:28px;}
.mod_cb_jr_pop .pop_title { font-size:16px; font-family:"Microsoft Yahei"; line-height:30px; padding-left:28px; background:url(http://imgcache.qq.com/vipstyle/act/caibei_110826_tips/img/bg.png) no-repeat left -34px;}
.mod_cb_jr_pop .pop_tips { line-height:20px; }
.mod_cb_jr_pop .pop_flag { position:absolute; width:15px; height:7px; left:15px; top:-6px;}

.mod_cb_jr_pop1 { background:#fffce6; border:1px solid #f5d682;}
.mod_cb_jr_pop1 .pop_title { color:#0066b8;}
.mod_cb_jr_pop1 .pop_tips{ color:#858585;}
.mod_cb_jr_pop1 .pop_close { color:#0066b8; text-decoration:underline;}
.mod_cb_jr_pop1 .pop_flag { background:url(http://imgcache.qq.com/vipstyle/act/caibei_110826_tips/img/bg.png) left -21px no-repeat; }

.mod_cb_jr_popx { vertical-align:text-bottom; width:500px;}
.mod_cb_jr_popx .pop_title { display:inline-block; *display:inline; zoom:1;}
.mod_cb_jr_popx .pop_tips{ display:inline-block; *display:inline; zoom:1;}
.newa2{color:#325bc4;}

</style>
<script type="text/javascript">
$(document).ready(function(){
					 $("#qqlogin").hover(function() {
					  $("#divmsg").show();
					},function() {
					    $("#divmsg").hide();
					});
});

</script>
</head>

<body>
<%@include file="/inc/head2.jsp" %>
<div class="center">
    <div class="login">
    	<div style="float:left;width:542px;padding-top:0px;">
			<a href="http://www.d1.com.cn/html/help/description.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/New/reg/login_newimg1.jpg"/></a>

		</div>
		<div style="float:right;width:402px;position:relative;height:458px;">
			<div class="floatLogin"></div>
			<div class="floatdiv">
				<table cellpadding="0" cellspacing="0">
					 <tr>
						 <td style=" text-align:right" width="80">用户名：</td><td style="text-align:left;"><input type="text" id="login_Name" maxlength="255" value="<%=username!=null?username:"" %>" /></td>
					 </tr>
					 <tr><td></td><td><span id="errUsername" class="spanmsg" style="display:none;width:160px;" >用户名/Email不能为空！</span></td></tr>
					 <tr><td colspan="2" height="8"></td></tr>
					 <tr>
						 <td style=" text-align:right" width="80">密码：</td><td style="text-align:left;"><input type="password" id="login_Pwd" maxlength="14" />&nbsp;&nbsp;&nbsp;&nbsp;
						 <a href="###" class="apwd" onclick="$.load('找回密码',580,'/ajax/dialog/user/getbackPwd.jsp')">忘记密码？</a></td>
					 </tr>
					 <tr><td></td><td><span id="errPassword" class="spanmsg"  style="display:none;">密码不能为空！</span></td></tr>
					  <tr><td colspan="2" height="10"></td></tr>
					  <tr>
						 <td style=" text-align:right" width="80" >验证码：</td><td style="text-align:left;"> <span class="spanmsg2"><input type="text" name="code" id="code"  maxlength="4" style="width:80px;" onkeyup="key_up(this);"/>&nbsp;&nbsp;
						 <img id="vPic" style="vertical-align:bottom;cursor:pointer;" width="60" height="24" onclick="this.src='/ImageCode?r='+Math.random();" alt="点击刷新验证码" />&nbsp;&nbsp;&nbsp;
						看不清，&nbsp;<a href="###" onclick="$('#vPic').attr('src','/ImageCode?r='+Math.random());" title="点击刷新验证码">换一张</a></span></td>
					 </tr>
					 <tr><td></td><td><span id="errCode" class="spanmsg" style="display:none;width:100px;">请输入验证码</span></td></tr>
					
					 <tr><td colspan="2" height="20"></td></tr>
					
					
					 <tr><td  colspan="2" style=" text-align:center; padding-left:95px;"><img onclick="AjaxLogin();" src="http://images.d1.com.cn/images2012/New/login_new.gif" style="float:left;cursor:pointer;" />
						<div style="text-align:left; float:left;padding-top:8px;padding-left:10px;"> <input type="checkbox" id="rember"<%if(!Tools.isNull(username)){ %> checked="checked"<%} %> class="input_chk"  /><font color="#000000">记住用户名</font>
					 </div>
					 </td></tr>
					</table>
		
					<div class="lhdiv">
						合作商户账户登录：
						<div style="line-height:28px;">
						<table>
<tr>
<td  valign="middle"><div style="padding-top:5px;"><div style=" position:relative; ">
<a href="/login.do" id="qqlogin">
<table cellpadding="0" cellspacing="0" border="0">
<tr><td  valign="bottom"><img src="http://images.d1.com.cn/images2012/login/qq.jpg" border="0"/></td><td  class="newa" >&nbsp;&nbsp;QQ</td></tr>
 </table></a>
			
			<div id="divmsg" style="display:none" class="mod_cb_jr_pop mod_cb_jr_pop1">
				<div class="pop_title">QQ彩贝联盟商户</div>
				<div class="pop_tips">使用QQ无需注册，购物还可额外获得彩贝积分返还。<a class="pop_close" href="#">我知道了</a></div>
				<div class="pop_flag"></div>
			</div>
		</div></div></td>
		<td>	
<table cellpadding="0" cellspacing="0" border="0">
<tr style="height:35px;"><td valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="/interface/login/sina.jsp" ><img src="http://images.d1.com.cn/images2012/login/xl.jpg" border="0"/></a></td>
<td valign="middle"><a href="/interface/login/sina.jsp" class="newa">&nbsp;新浪微博</a></td>
<td valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="/interface/login/sohu.jsp" class="newa"><img src="http://images.d1.com.cn/images2012/login/sh.jpg" border="0"/></a></td><td  valign="middle"><a href="/interface/login/sohu.jsp" class="newa">&nbsp;搜狐微博</a></td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="/interface/login/alipay.jsp" class="newa"><img src="http://images.d1.com.cn/images2012/login/zfb.jpg" border="0"/></a></td>
</tr>

 </table>
		
	</td>
</tr>
<tr><td colspan="2">
<table cellpadding="0" cellspacing="0" border="0">
 <tr style="height:30px;"><td valign="top"><a href="/interface/login/tenpay.jsp" ><img src="http://images.d1.com.cn/images2012/login/cft.jpg" border="0"/></a></td>
<td valign="middle">&nbsp;&nbsp;|&nbsp;<a href="/interface/login/139mail.jsp" class="newa"><img src="http://images.d1.com.cn/images2012/login/139.jpg" border="0"/></a></td><td  valign="top"><a href="/interface/login/139mail.jsp" class="newa">&nbsp;139邮箱</a></td>
</tr>
 </table>
</td></tr>
</table>

						</div>
					</div>
			        <div class="clear"></div>
					<div class="msdiv" style=" line-height:18px; _line-height:14px; _width:330px;">
					   <font color='#c60000'><b>还不是D1优尚会员？</b></font><br/>
					   立即注册成为D1优尚会员，便能享受便宜又放心的购物乐趣！
					</div>
					<table width="200">
					   <tr><td style="height:10px; _height:1px; +height:5px;" ></td></tr>
					</table>
					<div style=" width:395px; text-align:center; "><a href="/register.jsp"><img src="http://images.d1.com.cn/images2012/New/reg_new.gif" /></a></div>
				</div>
		</div>
	</div>
	<input type="hidden" id="hvalivode"/>
</div>
<script type="text/javascript">
$(function(){
	setTimeout(function(){$('#reg_email').focus();},500);
	$('#vPic').attr('src','/ImageCode?r='+Math.random());
});
//执行某个函数
function ajaxCall(urlstr , fn){$.get(urlstr,{},function(data){if(fn instanceof Function){fn(data);}});}

$('#login_Name').focus(function(){
		$('#errUsername').html("请输入用户名/Email/手机号").show();
});
$('#login_Name').blur(function(){
$('#errUsername').html("").hide();
	
});
$('#login_Pwd').focus(function(){
	$('#errPassword').html("请填写长度为6-14字符的密码，字母区分大小写").show();
});
//验证码回车登录
$("#code").keydown(function(e){
	if(e.keyCode == '13'){
		AjaxLogin();
	}
});
$("#login_Pwd").blur(function(){
		$('#errPassword').html("").hide();
});
$('#code').focus(function(){
	$('#errCode').html("请输入验证码").show();
});
$('#code').blur(function(){
$('#errCode').html("").hide();
});
function is_code(){
	var v=$.trim($("#code").val());
	if(v==""){
		$('#errCode').html("请输入验证码").show();
    	return false;
	}else if(v.length!=4 || !/^[0-9]{4}/.test(v)){
		$('#errCode').html("验证码输入错误！").show();
		return false;
	}else{
		ajaxCall('/ajax/user/reg_ajax.jsp?act=is_code&code='+escape(v)+'&r='+new Date().getTime(),code_callback);
	}
}
function code_callback(result){
	if(result == 'true'){
		$('#errCode').html("").hide();
		$("#hvalivode").val("1");
    	return true;
	}else{
		$('#errCode').html("验证码输入错误！").show();
		$("#hvalivode").val("");
		return false;
	}
}
function key_up(obj){
	obj.value=obj.value.replace(/[^0-9]/g,'');
	if(obj.value.length==4){
		is_code(obj.value);
	}
}

//登录验证

function AjaxLogin(){
	
	var account 	= $("#login_Name").val();
	var password 	= $("#login_Pwd").val();
	if($.trim(account) == ""){
		$('#errUsername').html("用户名/Email不能为空").show();
		$("#login_Name").focus();
		return false;
	}
	if($.trim(password) == "" ){
		$('#errPassword').html("密码不能为空").show();
		$("#login_Pwd").focus();
		return false;
	}
	//is_code();
	var hvalivode=$.trim($("#hvalivode").val());
	if(hvalivode.length>0){
		var retURL 	= "<%=backurl.replace("#","") %>";
		var login_url = "loginCheck.jsp";
		
		$.post(login_url,{"txt_account":account,"txt_password":password,"type":"page","url":retURL,"rember":$('#rember').attr("checked")?1:0},function(json){
			if(json.success){
				window.location.href = json.redirect;
			}else{
				$.alert(json.message);
			}
		},"json");
	}
	
}
</script>
<%@include file="/inc/foot.jsp" %>
</body>
</html>