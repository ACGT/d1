$("#loginbut").click(function(){
	 var url = document.referrer;
	   
user=$("#user").val();
pwd=$("#pwd").val();
var lurl=document.URL;
var gourl="";
 if(lurl.lastIndexOf("?")>0)
 {
      para=lurl.substring(lurl.lastIndexOf("?")+1,lurl.length);
		var arr=para.split("&");
		para="";
		for(var i=0;i<arr.length;i++)
		{
		   if(arr[i].split("=")[0]=="url"){
			   gourl=arr[i].split("=")[1];
		   }
		}
 }

if(user==""||user.length==0){
	$(".login_err").html("用户名不能为空");
	return;
}
if(pwd==""||pwd.length==0){
	$(".login_err").html("密码不能为空");
	return;
}
var token = window.localStorage.getItem("token");
//alert(token);
if (token==null){
	
	
	
	$.ajax({
		type: "get",
		dataType: "json",
		url: '/ajax/wap/checklogin.jsp',
		cache: false,
		data:{user:user,pwd:pwd},
		error: function(XmlHttpRequest){
			$(".login_err").html("内部错误！");
		},success: function(json){
				if(json.success){
					var ua = window.navigator.userAgent.toLowerCase(); 
					if(ua.match(/MicroMessenger/i) == 'micromessenger'){ 
								loginurl(gourl,url);
					}else{
						if(gourl==""){
							if(url=="")    
						     {
						     window.location.href="/wap/user/index.html";
							}else{
							 window.location.href=url;
							}
							}else{
								window.location.href=gourl;
							}
					}
					
				}else{
				$(".login_err").html(json.message);
				}
		     }
		});
	
	return;
	
	
	
	
}
$.ajax({
type: "get",
dataType: "json",
url: 'api/checklogin.jsp',
cache: false,
data:{user:user,pwd:pwd,token:token},
error: function(XmlHttpRequest){
	$(".login_err").html("内部错误！");
},success: function(json){
		if(json.success){
			var ua = window.navigator.userAgent.toLowerCase(); 
			if(ua.match(/MicroMessenger/i) == 'micromessenger'){ 
						loginurl(gourl,url);
			}else{
				if(gourl==""){
					if(url=="")    
				     {
				     window.location.href="/wap/user/index.html";
					}else{
					 window.location.href=url;
					}
					}else{
						window.location.href=gourl;
					}
			}
			
		}else{
		$(".login_err").html(json.message);
		}
     }
});
});

function loginurl(gourl,url){
	if(gourl==""){
		if(url=="")    
	     {
	     window.location.href="/wap/wxtt.jsp?backurl=/wap/user/index.html";
		}else{
		 window.location.href="/wap/wxtt.jsp?backurl="+url;
		}
		}else{
			window.location.href="/wap/wxtt.jsp?backurl="+gourl;
		}
}
