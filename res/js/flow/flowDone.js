//javascript pay
function payOrder(payId,obj){
	//alert(payId);
	obj.disabled = true;
	switch(payId){
		case 1:
			paysend_mobile();
			break;
		case 2:
			paysend_qq();
			break;
		case 3:
			paysend_99bill();
			break;
		case 4:
			paysend_alipay();
			break;
		case 5:
			paysend_yeepay();
			break;
		case 6:
			paysend_pingan();
			break;
		default:
			alert("在线支付方式错误，请联系客服处理！");
			obj.disabled = false;
	}
}
// 手机支付
function paysend_mobile(){
	document.form1.action = "/interface/pay/mobile/mobileRequest.jsp";
    document.form1.submit();
}
//财付通
function paysend_qq(){
    document.form1.action = "/interface/pay/tenpay/TenPayRequest.jsp";
	document.form1.submit();
}
//快钱支付
function paysend_99bill(){
    document.form1.action = "/interface/pay/99bill/99billRequest.jsp";
	document.form1.submit();
}
//支付宝
function paysend_alipay(){
    document.form1.action = "/interface/pay/alipay/AlipayRequest.jsp";
	document.form1.submit();
}
//易宝
function paysend_yeepay(){
    document.form1.action = "/interface/pay/yeepay/YeepayRequest.jsp";
	document.form1.submit();
}
//平安万里通
function paysend_pingan(){
    document.form1.action = "/pingan/pay.jsp";
	document.form1.submit();
}

function payOrder2(payId,ordId , obj){
	//alert(payId);
	obj.disabled = true;
	switch(payId){
		case 1:
			top.location.href="/interface/pay/mobile/mobileRequest.jsp?OdrID="+ordId;
			break;
		case 2:
			top.location.href="/interface/pay/tenpay/TenPayRequest.jsp?OdrID="+ordId;
			break;
		case 3:
			top.location.href="/interface/pay/99bill/99billRequest.jsp?OdrID="+ordId;
			break;
		case 4:
			top.location.href="/interface/pay/alipay/AlipayRequest.jsp?OdrID="+ordId;
			break;
		case 5:
			top.location.href="/interface/pay/yeepay/YeepayRequest.jsp?OdrID="+ordId;
			break;
		case 6:
			top.location.href="/pingan/pay.jsp?OdrID="+ordId;
			break;
		case 61:
			top.location.href="/interface/pay/baidu/PayRequest.jsp?OdrID="+ordId;
			break;
		default:
			alert("在线支付方式错误，请联系客服处理！");
			obj.disabled = false;
	}
}