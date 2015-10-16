<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商户登录</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
  .text{ height:28px; border:solid 1px #d4d4d4; width:187px; line-height:28px; }
  .text:hover{ border:solid 1px #72bdff;}
</style>
</head>
<body >
<div style="width:100%; background:url('/admin/SHManage/images/shopheader.jpg') center no-repeat; height:82px;"></div>
<div style=" background:#1d4672; height:5px;padding:0px; margin:0px;"></div>
   <div style="width:100%; background:url('/admin/SHManage/images/login_bg.JPG') no-repeat; height:500px;">
<table style="width:980px; margin:0px auto;" border="0" cellpadding="0" cellspacing="0">
  <tr><td style="text-align:left;" valign="top">
   <div style=" width:327px; height:418px; background:url('images/shLogin/bg.png'); float:right; padding:0px;margin:0px; margin-top:30px; overflow:hidden;">

   <table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
      <tr><td height="127" colspan="2"></td></tr>
      <tr>
      <td width="50"></td>
      <td height="30" style="text-align:left;">
      <input type="text" class="text" id="shname" name="shname" style="background:url('images/shLogin/l1.jpg') no-repeat;background-position: 0px 1px; padding-left:37px;"/>
      </td></tr>
      <tr><td height="38" colspan="2"></td></tr>
      <tr><td></td>
      <td style="text-align:left;"><input type="password" class="text" id="pwd" name="pwd" style="background:url('images/shLogin/l2.jpg') no-repeat;background-position: 0px 1px;padding-left:37px;"/></td></tr>
      <tr><td height="34" colspan="2"></td></tr>
      <tr><td height="30"></td>
      <td><input type="text" id="yzm" name="yzm" style="width:95px;" onkeyup="key_up(this);"/>
      <img id="vPic" style="vertical-align:bottom;cursor:pointer;" width="60" height="30" onclick="this.src='/ImageCode?r='+Math.random();" alt="点击刷新验证码" />&nbsp;&nbsp;&nbsp;
						&nbsp;<a href="###" onclick="$('#vPic').attr('src','/ImageCode?r='+Math.random());" title="点击刷新验证码">换一张</a>
      </td></tr>
      <tr><td style="height:165px;+height:155px; text-align:center;" colspan="2" valign="middle" style="text-align:center;">
   <input type="image" name="imageField2" src="/admin/SHManage/images/shLogin/Login.png" onclick="AjaxLogin();" />
    <input type="hidden" id="hvalivode"/></td></tr>
   </table>
   </div>
   </td>
   </tr>
</table>
</div>
</body>
<script type="text/javascript">
$(function(){
	setTimeout(function(){$('#shname').focus();},500);
	$('#vPic').attr('src','/ImageCode?r='+Math.random());
});
//执行某个函数
function ajaxCall(urlstr , fn){$.get(urlstr,{},function(data){if(fn instanceof Function){fn(data);}});}

	//验证码回车登录
	$("#yzm").keydown(function(e){
		if(e.keyCode == '13'){
			AjaxLogin();
		}
	});	
	function is_code(){
		var v=$.trim($("#yzm").val());
		if(v==""){
			alert('请输入验证码')
	    	return false;
		}else if(v.length!=4 || !/^[0-9]{4}/.test(v)){
			alert('验证码输入错误');
			return false;
		}else{
			ajaxCall('/ajax/user/reg_ajax.jsp?act=is_code&code='+escape(v)+'&r='+new Date().getTime(),code_callback);
		}
	}
	function code_callback(result){
		if(result == "true"){
			$("#hvalivode").val("1");
	    	return true;
		}else{			
			$("#hvalivode").val("");
			alert('验证码输入错误！');
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
		var account 	= $("#shname").val();
		var password 	= $("#pwd").val();
		if($.trim(account) == ""){
			alert("用户名不能为空");
			$("#shname").focus();
			return false;
		}
		if($.trim(password) == "" ){
			alert("密码不能为空");
			$("#pwd").focus();
			return false;
		}
		//is_code();
		var hvalivode=$.trim($("#hvalivode").val());
		if(hvalivode.length>0){			
			var login_url = "/admin/ajax/loginCheck.jsp";			
			$.post(login_url,{"txt_shopname":account,"txt_password":password,"url":'http://www.d1.com.cn'},function(json){
				if(json.success){
					window.location.href = json.redirect;
				}else{
					alert(json.message);
				}
			},"json");
		}
		
	}
</script>
