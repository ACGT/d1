<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>商品兑换-D1优尚网</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" language="javascript" src="/res/js/wapcheck.js?1406565937421"></script>

<script>
 
if(checkMobile()){
	window.location.href="http://m.d1.cn/wap/shopview.html?id=603";
}else{
	window.location.href="http://www.d1.com.cn/shop/601/1";
}
 
</script>