alert("com5");

var is_login = 0;

checkLogin();



function checkLogin() {
	
	var token = "";
	
	try {
		token = window.localStorage.getItem("token");
	}
	catch(err){
		
	}
	
	alert(window.location.href+":checkLogin():token:"+window.localStorage.getItem("token"));
	
	var is_token_available = 1; 
	
	if (token==undefined || token == "" ) {	
		is_token_available = 0;
	}else{
		
		$.ajax({
			type:"get",
			url:"api/check_token.jsp?token="+token,
			dataType:'json',
			async:false,
			success:function (ret) {
				
				alert("token="token+";token_available:");
			/*
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
				*/
			}
		});
	}
	
	alert(is_token_available);
	
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

