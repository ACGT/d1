function getwapFoot()
{

	 var str='<div class="ftxt">';
	     str+='    <span class="user"><a href="login.html" class="l">请登陆</a><a href="wxtt.jsp?backurl=/wap/reg.html" class="r">注册</a></span>';
	     str+='		<span class="top"><a href="#top" >回到顶部</a></span>';
	     str+='</div>';
	     str+='	<div class="fcopy">';
	     str+='		客服热线:400-680-8666(工作日9:00-18:00)<br>';
	     str+='	     Copyright ©2015 京030072';
	     str+='	</div>';
	   document.write(str);


	 
}
var loginflag=0;
function loadlogin(){
		
	var url=document.URL;
	  $.ajax({
		type: 'get', 
        url: '/ajax/wap/getlogin.jsp',
		dataType:'json',
		success: function(json){
				/*处理数据*/
				if(json.status=="1"){
					loginflag=1;
				showlogin(json);
				
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
					
					if(url.lastIndexOf("/wap/user/")>0||url.lastIndexOf("/wap/dh.html")>0){
						window.location.href='/wap/login.html';
						return;
					}
					$(".myuser a").attr("href","/wap/login.html");
				}
        }
	});
	}
	function showlogin(json){
		$(".footer .user").html('<a  href="/wap/user/index.html" class="l">'+json.username+'</a><a  href="/logout.jsp" class="r">退出</a>');

	}
loadlogin();
	