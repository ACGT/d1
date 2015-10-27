
var is_login = 0;
var user_agent = window.navigator.userAgent.toLowerCase();
if(user_agent.match(/MicroMessenger/i) == 'micromessenger'){
	checkLogin();
}
function checkLogin() {
	
	//alert(window.navigator.userAgent.toLowerCase());
	
	var token = "";
	
	try {
		token = window.localStorage.getItem("token");
	}
	catch(err){
		
	}
	
	//alert(window.location.href+":checkLogin():token:"+window.localStorage.getItem("token"));
	
	var is_token_available = 1; 
	
	if (token==undefined || token == "" || token==null) {	
		is_token_available = 0;
		alert("token is unavailable");
	}else{
		
		$.ajax({
			type:"get",
			url:"api/check_token.jsp?token="+token,
			dataType:'json',
			async:false,
			success:function (ret) {
				//alert("token_available:"+ret.token_available);
				if (ret.status=="0") {
					if (ret.token_available=="1") {
						is_token_available = 1;
					}
					else {
						is_token_available = 1;
						var current_url = document.location.href;
						current_url = encodeURIComponent(current_url);
						window.location.href = "authorize.jsp?callback="+current_url;
					}
				}
			}
		});
	}
	
	if (is_token_available==0) {
		
		is_login = 0;
		var current_url = document.location.href;
		current_url = encodeURIComponent(current_url);
		window.location.href = "authorize.jsp?callback="+current_url;
		
	} 
	else {
		is_login = 1;
	}
		
}


function getwapFoot()
{
	
	if(user_agent.match(/MicroMessenger/i) != 'micromessenger'){
	 var str='<div class="ftxt">';
     str+='    <span class="user"><a href="login.html" class="l">请登陆</a><a href="wxtt.jsp?backurl=/wap/reg.html" class="r">注册</a></span>';
     str+='		<span class="top"><a href="#top" >回到顶部</a></span>';
     str+='</div>';
     str+='	<div class="fcopy">';
     str+='		客服热线:400-680-8666(工作日9:00-18:00)<br>';
     str+='	     Copyright ©2015 京030072';
     str+='	</div>';
     document.write(str);
     return;
	}
	
	
	//alert("foot");
	var current_url = document.location.href;
	//alert(current_url)
	current_url = encodeURIComponent(current_url);
	
	var token = "";
	
	var nick = "";
	
	var head_image = "";
	
	try {
		token = window.localStorage.getItem("token");
	}
	catch(err) {
		
	}
	
	$.ajax({
		type:"get",
		url:"api/get_user_weixin_info.jsp?token="+token,
		dataType:"json",
		async: false, 
		success:function(ret) {
			if (ret.subscribe=="1") {
				var token = window.localStorage.getItem("token");
				nick = ret.nickname;
				head_image = ret.headimgurl;
				var str='<div class="ftxt">';
			    str+='    <span class="user"><img src="' + head_image +'" width="50" height="50" />' + nick + '</span>';
			    str+='		<span class="top"><a href="login.html" >切换账号</a></span>';
			    str+='</div>';
			    str+='	<div class="fcopy">';
			    str+='		客服热线:400-680-8666(工作日9:00-18:00)<br>';
			    str+='	     Copyright ©2015 京030072';
			    str+='	</div>';
			    document.write(str);
				
			}
		}
	});
	
	
}
var loginflag=0;
function loadlogin(){
		
	var url=document.URL;
	  $.ajax({
		type: 'get', 
        url: '/ajax/wap/getlogin.jsp',
		dataType:'json',
		async:false,
		success: function(json){
				/*处理数据*/
				if(json.status=="1"){
					//alert(loginflag);
					loginflag=1;
					//alert("login success");
				//showlogin(json);
				
				}else{
					
					var err="";
					   if(url.lastIndexOf("?")>0)
					   {
					        para=url.substring(url.lastIndexOf("?")+1,url.length);
							var arr=para.split("&");
							para="";
							for(var i=0;i<arr.length;i++)
							{
							   if(arr[i].split("=")[0]=="err"){
								   err=arr[i].split("=")[1];
							   }
							}
					   }
					   if(err==''){
					var ua = window.navigator.userAgent.toLowerCase();
				    if(ua.match(/MicroMessenger/i) == 'micromessenger'){
				    //	window.location.href='/wap/autowxloginto.jsp?backurl='+url;
				    	//return;
				    }}
					
					if(url.lastIndexOf("user/")>0||url.lastIndexOf("dh.html")>0){
						window.location.href='login.html';
						return;
					}
					$(".myuser a").attr("href","login.html");
				}
        }
	});
	}
	function showlogin(json){
		$(".footer .user").html('<a  href="user/index.html" class="l">'+json.username+'</a><a  href="logout.jsp" class="r">退出</a>');

	}
	
	//创建cookie
	function setCookie(name, value, expireday) {
		var exp = new Date();
		exp.setTime(exp.getTime() + expireday*24*60*60*1000); //设置cookie的期限
		document.cookie = name+"="+escape(value)+"; expires"+"="+exp.toGMTString();//创建cookie
	}
	//提取cookie中的值
	function getCookie(name) {
		var cookieStr = document.cookie;
		if(cookieStr.length > 0) {
			var cookieArr = cookieStr.split(";"); //将cookie信息转换成数组
			for (var i=0; i<cookieArr.length; i++) {
				var cookieVal = cookieArr[i].split("="); //将每一组cookie(cookie名和值)也转换成数组
				if(cookieVal[0] == name) {
					return unescape(cookieVal[1]); //返回需要提取的cookie值
				}
			}
		}
	}
	
	function sleep(sleepTime) {
	       for(var start = Date.now(); Date.now() - start <= sleepTime; ) { } 
	}
	
//loadlogin();
	