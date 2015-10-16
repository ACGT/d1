var valitele=false;
var hasb=false;
//检查手机号码
function CheckPhone(strRPhone,v){
	hasb=true;
    if (typeof(strRPhone) == 'undefined'){
        strRPhone = $.trim($('#txtRPhone').val());
    }
    var spanRPhone = $('#spanRPhone');
    if (strRPhone == null || strRPhone.length == 0){
    	 spanRPhone.html('*请输入手机号码');
        spanRPhone.show();
        $('#imgphone').hide();
        valitele=false;
       
    }
    if (!isMobile(strRPhone)){
        spanRPhone.html('*无效手机号码,请重新输入');
        spanRPhone.show();
        $('#imgphone').hide();
        valitele=false;
       
    }else{
    	if(v==1){
    		ajaxCall('/newlogin/check_validate.jsp?act=is_tel&tel='+strRPhone+'&r='+new Date().getTime(),tel_callback2);
    		
    	}else{
    		ajaxCall('/newlogin/check_validate.jsp?act=is_tel&tel='+strRPhone+'&r='+new Date().getTime(),tel_callback);
    	}
    	
    	
    }

}	
function CheckPhone3(strRPhone){
    if (typeof(strRPhone) == 'undefined'){
        strRPhone = $.trim($('#txtRPhone').val());
    }
    var spanRPhone = $('#spanRPhone');
    if (strRPhone == null || strRPhone.length == 0){
    	 spanRPhone.html('*请输入手机号码');
        spanRPhone.show();
        $('#imgphone').hide();
        return false;
       
    }
    if (!isMobile(strRPhone)){
        spanRPhone.html('*无效手机号码,请重新输入');
        spanRPhone.show();
        $('#imgphone').hide();
        return false;
       
    }else{
    	$.ajax({
            type: "post",
            dataType: "text",
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            url: "/newlogin/check_validate.jsp",
            cache: false,
            data:{
            	email: strREmail,
		        r: new Date().getTime(),
		        act:'is_email'
		       
		    },error: function(XmlHttpRequest, textStatus, errorThrown){
               
            },success: function(result){
            	if(result == 1){
            		 spanREmail.html('');
            		    spanREmail.hide();
            		    $('#imgemail').show();
            		    return true;
       		}else if(result == 2){
       			 spanREmail.html('该邮箱已验证过！');
       		        $('#imgemail').hide();
       		        spanREmail.show();
       		     return false;
       		}else{
       			 spanREmail.html('*邮箱格式错误，请重新输入！');
       		        $('#imgemail').hide();
       		        spanREmail.show();
       		     return false;
       		}

            }
            });
    	
    }

}	
function CheckPhone2(strRPhone){
	hasb=true;
    if (typeof(strRPhone) == 'undefined'){
        strRPhone = $.trim($('#txtRPhone').val());
    }
    var spanRPhone = $('#spanRPhone');
    if ( strRPhone.length == 11){
    	if (!isMobile(strRPhone)){
            spanRPhone.html('*无效手机号码,请重新输入');
            spanRPhone.show();
            $('#imgphone').hide();
            valitele=false;
           
        }else{
        	ajaxCall('/newlogin/check_validate.jsp?act=is_tel&tel='+strRPhone+'&r='+new Date().getTime(),tel_callback);
        }
    }
    

}
function tel_callback(result){
	var spanRPhone = $('#spanRPhone');
	if(result == 1){
		 spanRPhone.html('');
		    spanRPhone.hide();
		    $('#imgphone').show();
		    valitele=true;
		  
	}else if(result == 2){
		spanRPhone.html('该手机号已验证过');
	    spanRPhone.show();
	    $('#imgphone').hide();
	    valitele=false;
	   
	}else{
		 spanRPhone.html('手机号码格式不正确，请重新输入！');
		    spanRPhone.show();
		    $('#imgphone').hide();
		    valitele=false;
		  
	}
	
}
function tel_callback2(result){
	var spanRPhone = $('#spanRPhone');
	var strRPhone = $.trim($('#txtRPhone').val());
	if(result == 1){
		 spanRPhone.html('');
		    spanRPhone.hide();		   
		    valitele=true;
		    $.ajax({
				type: "get",
				dataType: "json",
				url: 'validatetel.jsp',
				cache: false,
				data: {tel:strRPhone,rec_act:"getcode"},
				error: function(XmlHttpRequest){
					alert("获取验证码错误！");
				},success: function(json){
					if(json.success){
						$("#smsg").html("验证码已发送至您的手机上");
						var i=1; 
						var timer=setInterval(function(){i++;
						if(i>=60){
							$(obj).attr("disabled",false);
							i=1;
							$(obj).attr("value","获取验证码");
							clearInterval(timer)
							}else{
								$(obj).attr("disabled",true); 
								var msg=60-i+"秒后重新获取";
								$(obj).attr("value",msg);
							}},1000) 
					}else{
						$("#smsg").html("");
						alert(json.message);
					}
				},beforeSend: function(){
				},complete: function(){
				}
			});
	}else if(result == 2){
		spanRPhone.html('该手机号已验证过');
	    spanRPhone.show();
	    $('#imgphone').hide();
	    valitele=false;
	   
	}else{
		 spanRPhone.html('手机号码格式不正确，请重新输入！');
		    spanRPhone.show();
		    $('#imgphone').hide();
		    valitele=false;
		  
	}
	
}
$('#txtcode').blur(function(){
	valis_code();
	});
	function valis_code(){
		var v=$.trim($("#txtcode").val());
		if(v==""){
			$('#errCode').html("请输入验证码").show();
	    	return false;
		}else if(v.length!=6 || !/^[0-9]{6}/.test(v)){
			$('#errCode').html("验证码输入错误！").show();
			return false;
		}
		return true;
	}
function checktime(obj){ 
	var strRPhone = $.trim($('#txtRPhone').val());
	var yzcode = $.trim($('#yzcode').val());
	
	if(!hasb){
		CheckPhone(strRPhone,1);
	}else if(yzcode == null || yzcode.length == 0){
		alert("请输入验证码！");
		return;
	}else{
		if(valitele){
			$(obj).attr("disabled",true); 
			  $.ajax({
					type: "get",
					dataType: "json",
					url: '/newlogin/validatetel.jsp',
					cache: false,
					data: {tel:strRPhone,rec_act:"getcode",yzcode:yzcode},
					error: function(XmlHttpRequest){
						alert("获取验证码错误！");
					},success: function(json){
						if(json.success){
							$("#smsg").html("验证码已发送至您的手机上");
							var i=1; 
							var timer=setInterval(function(){i++;
							if(i>=60){
								$(obj).attr("disabled",false);
								i=1;
								$(obj).attr("value","获取验证码");
								clearInterval(timer)
								}else{
									$(obj).attr("disabled",true); 
									var msg=60-i+"秒后重新获取";
									$(obj).attr("value",msg);
								}},1000) 
						}else{
							$("#smsg").html("");
							alert(json.message);
						}
					},beforeSend: function(){
					},complete: function(){
					}
				});
		}
	}
	
	
	//alert(111);
	
	} 
	
	function valitel(){
		var strRPhone = $.trim($('#txtRPhone').val());
		var v=$.trim($("#txtcode").val());
		var yzcode=$.trim($("#yzcode").val());
		if(valitele && valis_code()){
			  $.ajax({
					type: "get",
					dataType: "json",
					url: '/newlogin/validatetel.jsp',
					cache: false,
					data: {tel:strRPhone,code:v,rec_act:"valicode",yzcode:yzcode},
					error: function(XmlHttpRequest){
						alert("获取验证码错误！");
					},success: function(json){
						if(json.success){
							location.href="/newlogin/valitelsucess.jsp";
						}else{
							alert(json.message);
						}
					},beforeSend: function(){
					},complete: function(){
					}
				});
		}
	}
	var valiemail=false;
	var hasblur=false;var hasblur2=false;
	//检查邮箱地址
	function CheckEmail(strREmail){
		hasblur=true;
	    if (typeof (strREmail) == 'undefined'){
	        strREmail = $.trim($('#txtREmail').val());
	    }
	    var spanREmail = $('#spanREmail');
	    if (strREmail == null || strREmail.length == 0){
	    	 spanREmail.html('*请输入您的邮箱地址！');
	        spanREmail.show();
	        $('#imgemail').hide();
	        valiemail=false;
	    }
	    if (!isEmail(strREmail)){
	        spanREmail.html('*邮箱格式错误，请重新输入！');
	        $('#imgemail').hide();
	        spanREmail.show();
	        valiemail=false;
	    }else{
	    	ajaxCall('/newlogin/check_validate.jsp?act=is_email&email='+strREmail+'&r='+new Date().getTime(),email_callback);
	    }

	}	
	function email_callback(result){
		 var spanREmail = $('#spanREmail');
		if(result == 1){
			 spanREmail.html('');
			    spanREmail.hide();
			    $('#imgemail').show();
			 valiemail=true;
		}else if(result == 2){
			 spanREmail.html('该邮箱已验证过！');
		        $('#imgemail').hide();
		        spanREmail.show();
		        valiemail=false;
		}else{
			 spanREmail.html('*邮箱格式错误，请重新输入！');
		        $('#imgemail').hide();
		        spanREmail.show();
		        valiemail=false;
		}
		
	}

	function CheckEmail2(strREmail){
		hasblur=true;
	    if (typeof (strREmail) == 'undefined'){
	        strREmail = $.trim($('#txtREmail').val());
	    }
	    var spanREmail = $('#spanREmail');
	    if (strREmail == null || strREmail.length == 0){
	    	 spanREmail.html('*请输入您的邮箱地址！');
	        spanREmail.show();
	        $('#imgemail').hide();
	        valiemail=false;
	    }
	    if (!isEmail(strREmail)){
	        spanREmail.html('*邮箱格式错误，请重新输入！');
	        $('#imgemail').hide();
	        spanREmail.show();
	        valiemail=false;
	    }else{
	    	ajaxCall('/newlogin/check_validate.jsp?act=is_email&email='+strREmail+'&r='+new Date().getTime(),email_callback2);
	    }

	}	
	function email_callback2(result){
		 var spanREmail = $('#spanREmail');
		if(result == 1){
			 valiemail=true;
			 ajaxCall('/newlogin/validatemail.jsp?mail='+strREmail+'&type=get&r='+new Date().getTime(),valemail_callback);
		}else if(result == 2){
			 spanREmail.html('该邮箱已验证过！');
		        $('#imgemail').hide();
		        spanREmail.show();
		        valiemail=false;
		}else{
			 spanREmail.html('*邮箱格式错误，请重新输入！');
		        $('#imgemail').hide();
		        spanREmail.show();
		        valiemail=false;
		}
		
	}	
	function CheckEmail3(strREmail){
		
	    if (typeof (strREmail) == 'undefined'){
	        strREmail = $.trim($('#txtREmail').val());
	    }
	    var spanREmail = $('#spanREmail');
	    if (strREmail == null || strREmail.length == 0){
	    	 spanREmail.html('*请输入您的邮箱地址！');
	        spanREmail.show();
	        $('#imgemail').hide();
	         return false;
	    }
	    if (!isEmail(strREmail)){
	        spanREmail.html('*邮箱格式错误，请重新输入！');
	        $('#imgemail').hide();
	        spanREmail.show();
	        return false;
	    }else{
	    	$.ajax({
	            type: "post",
	            dataType: "text",
	            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
	            url: "/newlogin/check_validate.jsp",
	            cache: false,
	            data:{
	            	email: strREmail,
			        r: new Date().getTime(),
			        act:'is_email'
			       
			    },error: function(XmlHttpRequest, textStatus, errorThrown){
	               
	            },success: function(result){
	            	if(result == 1){
	            		 spanREmail.html('');
	            		    spanREmail.hide();
	            		    $('#imgemail').show();
	            		    ajaxCall('/newlogin/validatemail.jsp?mail='+strREmail+'&type=get&r='+new Date().getTime(),valemail_callback);
	       		}else if(result == 2){
	       			 spanREmail.html('该邮箱已验证过！');
	       		        $('#imgemail').hide();
	       		        spanREmail.show();
	       		     return false;
	       		}else{
	       			 spanREmail.html('*邮箱格式错误，请重新输入！');
	       		        $('#imgemail').hide();
	       		        spanREmail.show();
	       		     return false;
	       		}

	            }
	            });
	    }

	}	
	
	function validemail(){
		var strREmail = $.trim($('#txtREmail').val());
	CheckEmail3(strREmail);
	}
	function valemail_callback(result){
		if(result == 1){
			$.alert('参数错误！');
		}else if(result == 2){
			$.alert('邮箱格式错误');
		}else if(result == 3){
			$.alert('该邮箱已验证过！');
		}else{
			//$.close(); var s="";if((typeof c)!="undefined"){s="?c="+encodeURIComponent(c);}else{s=""+document.location;s=s.replace("http://","");s=s.substring(s.indexOf("/"));s="?c="+encodeURIComponent(s);}$.load("提示",420,"/newlogin/maildialog.jsp"+s);
		location.href="/newlogin/sendemailsuc.jsp";
		}
	}
	//执行某个函数
	function ajaxCall(urlstr , fn){$.get(urlstr,{},function(data){if(fn instanceof Function){fn(data);}});}