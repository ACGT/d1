//javascript version 1.0
function email_focus(){
	$("#err_email").html("请填写您常用的Email地址。便于您接收订单邮件，取回密码等。").removeClass('red');
}
function pass_focus(){
	$("#err_pass1").html("密码长度6-14位，支持数字、符号、字母，字母区分大小写").removeClass('red');
}
function pass2_focus(){
	$("#err_pass2").html("请再次输入您设置的密码").removeClass('red');
}
function code_focus(){
	$("#err_code").html("请输入验证码").removeClass('red');
}

var validate = {"email":false,"passWord":false,"rePassWord":false,"code":false};

//判断是否全部通过验证
var funValidateSuccess = function(){
	for(var v in validate){
		if(!validate[v]){
			$('#regist_submit').attr('disabled',true);//禁止提交
			return false;
		}
	}
	$('#regist_submit').attr('disabled',false);//允许提交
	return true;
};

//regist
function user_regist(form,obj){
	is_email($('#email').val());
	is_pass($('#password').val());
	is_pass2($('#password2').val());
	is_code($('#code').val());
	if(funValidateSuccess()){
		form.submit();
	}
}

function is_email(v){
	if (v == ''){
    	$("#email_Notice").html("邮箱地址不能为空，请输入").addClass('red');
    	validate["email"] = false;
	}else if (!isEmail(v)){
		$("#email_Notice").html("邮箱地址格式有误，请修改").addClass('red');
		validate["email"] = false;
	}else{
		ajaxCall('/ajax/user/reg_ajax.jsp?act=is_email&email='+escape(v)+'&r='+new Date().getTime(),email_callback);
	}
	funValidateSuccess();
}

function email_callback(result){
	if(result == 'true'){
		$("#email_Notice").html("<img src='http://images.d1.com.cn/images2012/New/reg/suc.jpg' />").removeClass('red');
    	validate["email"] = true;
	}else{
		$("#email_Notice").html("该邮箱已被注册，请重新输入").addClass('red');
    	validate["email"] = false;
	}
	funValidateSuccess();
}

function is_pass(v){
	if(v.length < 6 || v.length>14){
		$("#pass_Notice").html("密码长度必须为6-14位").addClass('red');
		validate["passWord"] = false;
    }else if(/ /.test(v) == true){
    	$("#pass_Notice").html("密码中不能包含空格").addClass('red');
		validate["passWord"] = false;
    }else{
        $("#pass_Notice").html("<img src='http://images.d1.com.cn/images2012/New/reg/suc.jpg' />").removeClass('red');
        validate["passWord"] = true;
    }
    funValidateSuccess();
}

function is_pass2(v){
	if(v.length < 6 || v.length>14){
		$("#pass2_Notice").html("密码长度必须为6-14位").addClass('red');
		validate["rePassWord"] = false;
    }else if(v!=$("#form_Regist :password[name='password']").val()){
    	$("#pass2_Notice").html("两次输入密码不一致").addClass('red');
    	validate["rePassWord"] = false;
    }else{
        $("#pass2_Notice").html("<img src='http://images.d1.com.cn/images2012/New/reg/suc.jpg' />").removeClass('red');
        validate["rePassWord"] = true;
    }
    funValidateSuccess();
}

function is_code(v){
	if(v==""){
		$("#code_Notice").html("验证码不能为空！").addClass('red');
    	validate["code"] = false;
	}else if(v.length!=4 || !/^[0-9]{4}/.test(v)){
		$("#code_Notice").html("验证码输入错误！").addClass('red');
    	validate["code"] = false;
	}else{
		ajaxCall('/ajax/user/reg_ajax.jsp?act=is_code&code='+escape(v)+'&r='+new Date().getTime(),code_callback);
	}
	funValidateSuccess();
}

function code_callback(result){
	if(result == 'true'){
		$("#code_Notice").html("<img src='http://images.d1.com.cn/images2012/New/reg/suc.jpg' />").removeClass('red');
    	validate["code"] = true;
	}else{
		$("#code_Notice").html("验证码输入错误！").addClass('red');
    	validate["code"] = false;
	}
	funValidateSuccess();
}

function key_up(obj){
	obj.value=obj.value.replace(/[^0-9]/g,'');
	if(obj.value.length==4){
		is_code(obj.value);
	}
}
function key_down(e){
	if(e.keyCode == '13'){
		funValidateSuccess();
		if($('#regist_submit').attr('disabled')==false){
			document.form_Regist.submit();
		}
	}
}

//执行某个函数
function ajaxCall(urlstr , fn){$.get(urlstr,{},function(data){if(fn instanceof Function){fn(data);}});}