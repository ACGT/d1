<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%
/*String pingan = Tools.getCookie(request,"pingan");
if(Tools.isNull(pingan)){
	response.sendRedirect("pingan");
}*/
String url1 = request.getHeader("referer");
if(url1!=null&&url1.indexOf("zhuanti/201303/szn0307/")>0){
	session.setAttribute("zntkturl", url1);
}
String backurl = request.getParameter("c");
if(Tools.isNull(backurl)) backurl = "/";
String username = Tools.getCookie(request,"LastLoginName");
if(username != null) username = URLDecoder.decode(username,"UTF-8");
%>
<style>
.spanmsg{ border:solid 1px #6bc7f0; background-color:#e8f5fd; color:#74797d; font-weight:normal; display:block; padding:0px; line-height:18px; font-size:12px; margin-top:1px;}
.spanmsg2{  color:#74797d; font-weight:normal; font-size:12px;padding:0px;}
.spanmsg2 a{  color:#0149ab; font-weight:normal; font-size:12px;text-decoration:underline; padding:0px;}
.login_input{ border:1px solid #A6A6A6; width:200px; margin:0px; padding:4px 0px 4px 6px; float:left}
.apwd{ color:#B10300; text-decoration:underline; }
</style>
<div class="dialogdiv">
  <div class="lll layer_w333 login_t mar10">
    <div class="error_div login_t3" id="loginTip" style="display:none;"> <span class="img01"></span> <span class="lll error_t1" id="loginMsg"></span> </div>
  </div><input type="hidden" id="hvalivode"/>
  <table cellpadding="0" cellspacing="0" style="font-size:12px;">
  <tr>
  <td colspan="2"><img src="http://images.d1.com.cn/images2012/login/lotop1.jpg" border="0" usemap="#Mapreg"/>
<map name="Mapreg" id="Mapreg"><area shape="rect" coords="76,1,147,23" href="/register.jsp" target="_blank" /></map></td>
  </tr>
  <tr>
  <td colspan="2" height="10">
  </td>
  </tr>
  
					 <tr>
						 <td style=" text-align:right" width="80">用户名：</td><td style="text-align:left;"><input type="text" id="loginName" tabIndex="1" class="login_input" maxlength="255" tabindex="100" value="<%=username!=null?username:"" %>" /></td>
					 </tr>
					 <tr><td></td><td><span id="errUsername" class="spanmsg" style="display:none;width:160px;" >用户名/Email不能为空！</span></td></tr>
					 <tr><td colspan="2" height="8"></td></tr>
					 <tr>
						 <td style=" text-align:right" width="80">密码：</td><td style="text-align:left;"><input type="password" tabIndex="2" id="loginPwd" class="login_input" tabindex="101"  maxlength="14" />&nbsp;&nbsp;&nbsp;&nbsp;
						 <a href="###" class="apwd" onclick="$.load('找回密码',580,'/ajax/dialog/user/getbackPwd.jsp')">忘记密码？</a></td>
					 </tr>
					 <tr><td></td><td><span id="errPassword" class="spanmsg"  style="display:none;">密码不能为空！</span></td></tr>
					  <tr><td colspan="2" height="10"></td></tr>
					  <tr>
						 <td style=" text-align:right" width="80" >验证码：</td><td style="text-align:left;"> <span class="spanmsg2"><input type="text" tabIndex="3" name="code" class="login_input" id="code"  maxlength="4" style="width:80px;" onkeyup="key_up(this);"/>&nbsp;&nbsp;
						 <img id="vPic" style="vertical-align:bottom;cursor:pointer;" width="60" height="24" onclick="this.src='/ImageCode?r='+Math.random();" alt="点击刷新验证码" />&nbsp;&nbsp;&nbsp;
						看不清，&nbsp;<a href="###" onclick="$('#vPic').attr('src','/ImageCode?r='+Math.random());" title="点击刷新验证码">换一张</a></span></td>
					 </tr>
					 <tr><td></td><td><span id="errCode" class="spanmsg" style="display:none;width:100px;">请输入验证码</span></td></tr>
					
					 <tr><td colspan="2" height="20"></td></tr>
					
					
					 <tr><td  colspan="2" style=" text-align:center; "> <input class="layer_button login_t2 lll" type="button" onclick="javascript:AjaxLogin();" tabIndex="4"   onkeydown="if(event.keyCode==13){AjaxLogin();}"  onmousemove="this.className='layer_button_over login_t2 lll'" onmouseout="this.className='layer_button login_t2 lll'" value="登 录" />
						<div style="text-align:left; float:left;padding-top:8px;padding-left:10px;"> <input type="checkbox" id="rember"<%if(!Tools.isNull(username)){ %> checked="checked"<%} %> class="input_chk"  /><font color="#000000">记住用户名</font>&nbsp;<span class="lll red" style="line-height:30px; margin-left:10px; display:inline"><span id="spStatus"></span></span>
					 </div>
					 </td></tr>
					</table>
  
  
  
   <div class="clear"></div>
   <div class="lhdiv" style="padding-top:15px;background:#F2F2F2;">
						合作商户账户登录：
						<table cellpadding="0" cellspacing="0" border="0" style="font-size:12px;">
<tr style="height:35px;"><td  valign="middle"><a href="/login.do" id="qqlogin"><img src="http://images.d1.com.cn/images2012/login/qq.jpg" border="0"/></a></td><td  class="newa" >&nbsp;<a href="/login.do" class="newa">QQ</a></td>
<td>&nbsp;&nbsp;|&nbsp;</td>
<td valign="middle"><a href="/interface/login/sina.jsp" ><img src="http://images.d1.com.cn/images2012/login/xl.jpg" border="0"/></a></td>
<td valign="middle"><a href="/interface/login/sina.jsp" class="newa">&nbsp;新浪微博</a></td>
<td>&nbsp;&nbsp;|&nbsp;</td>
<td valign="middle"><a href="/interface/login/sohu.jsp" class="newa"><img src="http://images.d1.com.cn/images2012/login/sh.jpg" border="0"/></a></td><td  valign="middle"><a href="/interface/login/sohu.jsp" class="newa">&nbsp;搜狐微博</a></td>
<td>&nbsp;&nbsp;|&nbsp;</td>
<td><a href="/interface/login/alipay.jsp" class="newa"><img src="http://images.d1.com.cn/images2012/login/zfb.jpg" border="0"/></a></td>
<td>&nbsp;&nbsp;|&nbsp;</td>
<td valign="middle"><a href="/interface/login/tenpay.jsp" ><img src="http://images.d1.com.cn/images2012/login/cft.jpg" border="0"/></a></td>
<td>&nbsp;&nbsp;|&nbsp;</td>
<td valign="middle"><a href="/interface/login/139mail.jsp" class="newa"><img src="http://images.d1.com.cn/images2012/login/139.jpg" border="0"/></a></td><td  valign="middle"><a href="/interface/login/139mail.jsp" class="newa">&nbsp;139邮箱</a></td>
</tr>
 </table>

					</div>
    </div>
 
<script type="text/javascript">
setTimeout(function(){$("#<%=Tools.isNull(username)?"loginName":"loginPwd" %>").focus();},500);
var $status = $("#spStatus");
var pwdErrorCount = 0; 
var $islogining = 0;
$(function(){
	setTimeout(function(){$('#reg_email').focus();},500);
	$('#vPic').attr('src','/ImageCode?r='+Math.random());
});
//执行某个函数
function ajaxCall(urlstr , fn){$.get(urlstr,{},function(data){if(fn instanceof Function){fn(data);}});}
//存在验证码时 验证码框回车登录
$("#loginName").focus(function(){
		$('#errUsername').html("请输入用户名/Email/手机号").show();
});
$('#loginName').blur(function(){
$('#errUsername').html("").hide();
	
});
$("#loginName").keydown(function(e){
	if(e.keyCode == '13'){
		$("#loginPwd").focus();
		$(this).blur();
		if($("#loginPwd").val() != ''){
			$("#loginPwd").select();
		}
	}
});
$('#loginPwd').focus(function(){
	$('#errPassword').html("请填写长度为6-14字符的密码，字母区分大小写").show();
});
$('#loginPwd').blur(function(){
	$('#errPassword').html("").hide();
});
//密码框回车
$("#loginPwd").keydown(function(e){
	if(e.keyCode == '13'){
		$(this).blur();
		$("#code").focus();
		if($("#code").val() != ''){
			$("#code").select();
		}
	}
	
});
//验证码回车登录
$("#code").keydown(function(e){
	if(e.keyCode == '13'){
		AjaxLogin();
		$(this).blur();
	}
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
function change_keydown_event($obj){
	$obj.keydown(function(e){
		if(e.keyCode == '13'){
			AjaxLogin();
		}
	})
}
function isEmail(v){
  var reg = /^([a-zA-Z0-9]+[_|\_|\.]?[-]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
  return reg.test(v);
}
//登录验证
function AjaxLogin(){
	if($islogining == 1) return;
	var account 	= $("#loginName").val();
	var password 	= $("#loginPwd").val();
	if($.trim(account) == ""){
		$('#errUsername').html("请输入用户名/Email/手机号").show();
		$("#loginName").focus();
		return false;
	}
	if($.trim(password) == "" ){
		$('#errPassword').html("请填写长度为6-14字符的密码，字母区分大小写").show();
		$("#loginPwd").focus();
		return false;
	}
	var hvalivode=$.trim($("#hvalivode").val());
	if(hvalivode.length==0){
		$status.html("验证码错误!");
		return false;
	}
	var retURL 	= "<%=backurl.replace("#","") %>";
	var login_url = "/ajax/user/loginCheck.jsp";
	$status.html("会员登录验证中...");
	
	$islogining = 1;

	$.post(login_url,{"txt_account":account,"txt_password":password,"type":"ajax","url":retURL,"rember":"<%=Tools.isNull(username)?"0":"1" %>"},
		function(json){
			if(json.success){
				$status.html("登录成功!");	
				if(json.redirect.indexOf("html/zt2012/1203zndq/znzhufu.jsp")>=0){
					$.close();
				}
				else if(json.redirect.indexOf("/market/")>=0){
					$.close();
				}
				else if(json.redirect.indexOf("/market/1206/wydh/")>=0){
					$.close();
				}
				else if(json.redirect.indexOf("/html/zt2012/20120727ay/")>=0){
					$.close();
				}
				else if(json.redirect.indexOf("html/zt2012/201203zndq/index.jsp")>=0||json.redirect.indexOf("html/zt2012/201203zndq/")>=0||json.redirect.indexOf("html/zt2012/201203zndq")>=0)
				{
					$.close();
				}else if(json.redirect.indexOf("/zhuanti/20120912zj/zj1.jspa1")>=0){
					$status.html("正在打开页面，请稍等...");
					window.location.href = "http://www.d1.com.cn/zhuanti/20120912zj/zj1.jsp";
				}
				
				else{
				$status.html("正在打开页面，请稍等...");
				   if (json.redirect.indexOf("/newlogin/valitel.jsp")){
				  window.location.href = json.redirect;

				 }else{
					 window.location.href = json.redirect;
				 }
				}
			}else{
				$status.html("登录失败!");
				LoginError(json.message);
			}
			$islogining = 0;
		},"json");
}
function key_up(obj){
	obj.value=obj.value.replace(/[^0-9]/g,'');
	//if(obj.value.length==4){
		is_code(obj.value);
	//}
}
function LoginError(msg){
	$("#loginMsg").html(msg);
	if(msg == '账户或密码错误！')	{
		pwdErrorCount++;
		$("#loginPwd").select();
		if(pwdErrorCount == 3){
			pwdErrorCount = 0;
			$("#loginName").select();
		}
	}
	$("#loginTip").show();
}
</script>