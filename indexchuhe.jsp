<%@ page contentType="text/html; charset=UTF-8"%><script type="text/javascript" language="javascript" src="/res/js/wapcheck.js?1406565937421"></script>

<script>
if(checkMobile()){
	var ua = window.navigator.userAgent.toLowerCase(); 
	if(ua.match(/MicroMessenger/i) == 'micromessenger'){
	 window.location.href="http://m.d1.cn/ushop_weixin/chuhe.html?id=677";
	}else{
	window.location.href="http://m.d1.cn/wap/shopview.html?id=677";
	}
}else{
	 window.location.href="http://www.d1.com.cn/shop/chuhe";	 
}
</script>
