function checkweixinpay(OdrID){
	if (typeof WeixinJSBridge == "undefined"){
		   if( document.addEventListener ){
		       document.addEventListener('WeixinJSBridgeReady',  weixinpay(OdrID), false);
		   }else if (document.attachEvent){
		       document.attachEvent('WeixinJSBridgeReady',  weixinpay(OdrID)); 
		       document.attachEvent('onWeixinJSBridgeReady',  weixinpay(OdrID));
		   }
		}else{
			weixinpay(OdrID);
		}
}
function weixinpay(OdrID){
	   $.ajax({
			type: "get",
			data:{OdrID:OdrID},
			dataType: "json",
			url: '/interface/pay/weixinpay/payRequest.jsp',
			cache: false,
			error: function(XmlHttpRequest){
				alert("内容错误！");
			},success: function(json){
		 
    if(json.SUCCESS){
		   WeixinJSBridge.invoke(
		       'getBrandWCPayRequest', {
		           "appId" : ""+json.appid+"",     //公众号名称，由商户传入     
		           "timeStamp":""+json.timeStamp+"",         //时间戳，自1970年以来的秒数     
		           "nonceStr" : ""+json.nonceStr+"", //随机串     
		           "package" : "prepay_id="+json.prepay_id+"",     
		           "signType" : "MD5",         //微信签名方式:     
		           "paySign" : ""+json.sign+"" //微信签名 
		       },
		       function(res){    
		           if(res.err_msg == "get_brand_wcpay_request:ok" ) {
		        	   location.href='/wap/user/orderdetail.jsp?orderid='+OdrID;
		        	   
		           }     // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。 
		       }
		   ); 
 
    }
			 },beforeSend: function(){
			    }
		});
  }