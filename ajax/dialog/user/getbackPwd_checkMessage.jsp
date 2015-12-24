<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
String message = request.getParameter("message");//用request得到 
String uid=request.getParameter("userid");
String message_show= message.substring(0, 3) +"****"+ message.substring(message.length()-5, message.length()-1);
%> 
<style>
.notice{
	height: 40px;
}
#confirmChange{
padding: 5px 10px 5px 10px;
margin-bottom:30px;
margin-left: 20px; 
}
#getPhoneCode{
margin-left:10px;
padding: 5px;
}
</style>
<div>
<div style="margin-top:10px;margin-bottom:10px;font-size: 14px;font-weight: bold;"><span>D1优尚已向您的手机:<%=message_show%>发送了验证码短信，请您查看!</span></div>
<div class="notice"><span><input id="codeStr" type="text" maxlength="4" placeholder="短信验证码" onblur="check_codeStr();" onfocus="onFouces_all('code_notice');"/></span><span><input type="button" id="getPhoneCode" onclick="fnGetPhoneCode();" disabled value="获取验证码" /></span><div id="code_notice" ></div></div>

<div class="notice"><span><input type="password" id="pwd" placeholder="新密码" onblur="check_pwd();" onfocus="onFouces_all('pwd_notice');" /></span><div id="pwd_notice"></div></div>

<div class="notice"><span><input type="password" id="pwd2" placeholder="确认新密码" onblur="check_pwd2();" onfocus="onFouces_all('pwd2_notice');"/></span><div id="pwd2_notice"></div></div>

<div><span><input type="button" id="confirmChange" onclick="findPwd_confirm();" value="确认修改" /></span></div>
</div>
<script type="text/javascript">
var wait=120; 
function time() {  
        if (wait == 0) {  
            $("#getPhoneCode").attr("disabled",false);            
            $("#getPhoneCode").val("获取验证码");  
            wait = 120;  
        } else {  
        	console.log("");
        	$("#getPhoneCode").attr("disabled", true);  
        	$("#getPhoneCode").val("("+wait+")秒后重新获取");  
            wait--;  
            setTimeout(function() {  
                time();
            },  
            1000)  
        }  
    } 

$(document).ready(function(){
	console.log("in ready");
	time();
	//获取手机验证码
	
});
function fnGetPhoneCode(){
	//120秒内不准再发送验证码
	time();
	$.ajax({
        type: "post",
        dataType: "json",
        url: "user/getPhoneCodeForFindPwd.do",
        cache: false,
        data:{phone: <%=message%>,param:'phone'},
        error: function(json){
        	alert(json.message);
           return;
        },
        success: function(json){
        	$("#code_notice").html(json.message);
        	
        }
    });
}

function findPwd_confirm(){
	var flag=check_all();
	console.log("dd:"+flag);
	if(flag){
		$.ajax({
	        type: "post",
	        dataType: "json",
	        url: "user/findPwdConfirm.do",
	        cache: false,
	        data:{phone: <%=message%>,codeStr:$("#codeStr").val(),pwd:$("#pwd").val(),uid:'<%=uid%>'},
	        error: function(json){
	        	alert(json.message);
	           return;
	        },
	        success: function(json){
	        	console.log("json:"+json);
	        	if(json.success){
	        	$.load(json.message,580,'ajax/dialog/user/findPwdSuccess.html');
	        	}else{
	        		alert(json.message);
	        	}
	        	
	        }
	    });
	}
	
}

function check_codeStr(){
	if($("#codeStr").val()==''){
		$("#code_notice").html("<span style='color:red'>短信验证码不能为空！</span>");
		return false;
	}
	return true;
}
function check_pwd(){
	console.log($("#pwd").val().length);
	if($("#pwd").val()==''){
		$("#pwd_notice").html("<span style='color:red'>密码不能为空！</span>");
		return false;
	}else if($("#pwd").val().length < 6 || $("#pwd").val().length>14){
		$("#pwd_notice").html("<span style='color:red'>密码长度必须为6-14位</span>");
		return false;
    }else if(/ /.test($("#pwd").val()) == true){
    	$("#pwd_notice").html("<span style='color:red'>密码中不能包含空格</span>");
    	return false;
    }
	return true;
}
function check_pwd2(){
	var pwdStr=$("#pwd").val();
	var pwdStr2=$("#pwd2").val();
	
	console.log(pwdStr==pwdStr2);
	if(pwdStr!=pwdStr2){
		$("#pwd2_notice").html("<span style='color:red'>两次密码不一致！</span>");
		return false;
	}
	return true;
}
function check_all(){
	var codeCheck=check_codeStr();
	var pwdCheck=check_pwd();
	var pwd2Check=check_pwd2();
	if(!codeCheck){
		return false;
	}
	if(!pwdCheck){
		return false;
	}
	if(!pwd2Check){
		return false;
	}
	return true;
}
function onFouces_all(obj){
	$("#"+obj).html("");
}
</script>