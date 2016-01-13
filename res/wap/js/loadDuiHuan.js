$chsku = $("#choose_sku");
function dhok(obj) {
	var dhcode = $("#dhcode").val();
	if (dhcode == '') {
		$(".reg_err").html("兑换码不能为空，请输入！");
		return;
	} else {
		$.ajax({
			type : "get",
			dataType : "json",
			url : '/ajax/wap/choosecart.jsp',
			cache : false,
			data : {
				id : dhcode
			},
			error : function(XmlHttpRequest) {
			},
			success : function(json) {
				console.log(json);
				if (json.code == 1) {
					alert(json.message);
				} else if (json.code == 0) {
					$choosesku(dhcode, $chsku)

				} else if (json.code == 2) {
					$(obj).attr('attr', dhcode);
					$.inCart(obj, {
						ajaxUrl : '/ajax/wap/dhInCart.jsp'
					});
				} else if (json.code == 99) {
					window.location.href = "/wap/login.html";
				}
			},
			beforeSend : function() {
			},
			complete : function() {
			}
		});
	}
}

function skuclose() {
	$chsku.hide();
};
$choosesku = function(code, chsku) {
	$.ajax({
		type : "get",
		dataType : "text",
		url : '/ajax/wap/chooseskunew.jsp',
		cache : false,
		data : {
			code : code
		},
		error : function(XmlHttpRequest) {
			alert('错误');
		},
		success : function(data) {
			chsku.html(data);
			chsku.show();
		}
	});
};
var continueBuy=function(){
	$("#cartmsg").slideUp();
};