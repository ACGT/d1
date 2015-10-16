function sync_d1_user() {
	//alert("bbb");
	var login_url = "api/sync_d1_user_info.jsp?token="+window.localStorage.getItem("token");
	//alert(login_url);
	$.ajax({
		type:"get",
		url:login_url,
		dataType:"json",
		async:false,
		success:function(ret) {
			//alert("login!");
		}
	});
}
sync_d1_user();