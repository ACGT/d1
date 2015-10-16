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
				alert("���ݴ���");
			},success: function(json){
		 
    if(json.SUCCESS){
		   WeixinJSBridge.invoke(
		       'getBrandWCPayRequest', {
		           "appId" : ""+json.appid+"",     //���ں����ƣ����̻�����     
		           "timeStamp":""+json.timeStamp+"",         //ʱ�������1970������������     
		           "nonceStr" : ""+json.nonceStr+"", //�����     
		           "package" : "prepay_id="+json.prepay_id+"",     
		           "signType" : "MD5",         //΢��ǩ����ʽ:     
		           "paySign" : ""+json.sign+"" //΢��ǩ�� 
		       },
		       function(res){    
		           if(res.err_msg == "get_brand_wcpay_request:ok" ) {
		        	   location.href='/wap/user/orderdetail.jsp?orderid='+OdrID;
		        	   
		           }     // ʹ�����Ϸ�ʽ�ж�ǰ�˷���,΢���Ŷ�֣����ʾ��res.err_msg�����û�֧���ɹ��󷵻�    ok����������֤�����Կɿ��� 
		       }
		   ); 
 
    }
			 },beforeSend: function(){
			    }
		});
  }