<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！">
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买">
<title>D1优尚网-时尚网上购物商城,在线销售化妆品、名表、饰品、女装、男装等个人扮靓物品</title>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js?"+System.currentTimeMillis())%>"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/autotab.js?"+System.currentTimeMillis())%>"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/rollImageKP.js?"+System.currentTimeMillis())%>"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/wapcheck.js?"+System.currentTimeMillis())%>"></script>
<link type="text/css" rel="stylesheet" href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/index2014.css?"+System.currentTimeMillis())%>" />

<script>

if(checkMobile()){
	window.location.href="http://m.d1.cn";
}
</script>
<style type="text/css">
.cji_price_new {
background-image: url(http://images.d1.com.cn/zt2014/06/red.png);
background-repeat: repeat;
height: 70px;

}

.cjlijiqiang {
position: absolute;
width: 140px;
height: 65px;
right:0px;
bottom: 50px;
}

.i_price_new {
background-image: url(http://images.d1.com.cn/zt2014/0304/pricebg-big1.gif);
background-repeat: repeat;
height: 70px;

}
.i_price_newbg {
background-image: url(http://images.d1.com.cn/zt2014/0304/bgbigbar-or.gif);
background-repeat: repeat;
height: 70px;
}

.lijiqiang {
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/lijiqiang-big.png);
background-repeat: no-repeat;
background-position: 0px 0px;
width: 126px;
height: 47px;
right:17px;
bottom: 60px;
}
.jijkqiang {
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/getitsoon.jpg);
background-repeat: no-repeat;
background-position: 0px 0px;
width: 126px;
height: 47px;
right:17px;
bottom: 60px;
}
.shouqing{
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/shouqingbig.png);
background-repeat: no-repeat;
background-position: 0px 0px;
width: 126px;
height: 47px;
right:17px;
bottom: 60px;
}

.s2_1 {
color: #FFFFFF;
font-size: 43px;
line-height: 43px;
padding-left: 16px;
/*vertical-align: bottom;*/
font-family: 'arial';
display: block;
height: 38px;
padding-top: 5px;
}

.s3{
color: #f7949b;
font-size: 10px;
padding-left: 21px;
vertical-align: top;
font-family: '微软雅黑';
}
.s3new{
color: #fcbf9c;
font-size: 10px;
padding-left: 21px;
vertical-align: top;
font-family: '微软雅黑';
}
.zhekou_t {
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/checknap.png);
background-position: 0px 0px;
width: 39px; height: 18px;
left:12px;
bottom: 165px;
}
.djs_newlist{
font-size: 14pt;
color: #f0424e;
padding:0px 2px;
font-family: 'arial';
}
.productadright{position: fixed;_position: absolute;right: 0px;bottom: 0px;width: 160px;font-size: 12px;_top: expression(documentElement.scrollTop+documentElement.clientHeight-this.offsetHeight);overflow: hidden;z-index: 200000;display: block;}
.page_f{
    left: 0px;bottom: 0px;width: 100px;font-size: 12px;display: block;
	float:left;
	margin-top:10px; 
	margin-left:10px; 
	position:fixed; 
	_position:absolute;
	_bottom:auto; 
	_top:expression(eval(document.documentElement.scrollTop));
	z-index:99999;
}

.topbannerdiv{	position:relative; width:980px; height:450px; margin: 0px auto;}
.topbannerdiv .link1{ position:absolute;  width:980px; height:450px; bottom:0; left:0px; }

.banner328 {
background-image: url(http://images.d1.com.cn/images2014/index/newpage_02-2.jpg);
background-repeat: no-repeat;
background-position: center;
height: 604px;
}
.banner0721 {
background-image: url(http://images.d1.com.cn/images2014/index/banner140721.jpg);
background-repeat: no-repeat;
background-position: center;
height: 100px;
margin:10px 0;
}
.brandlist{margin:10px 0;}
.brandlist li{width:280px;}
.brandlist li.l{ float: left;margin-right:26px;}
.brandlist li.r{ float: right;}
</style>

</head>

<body style="background:#fcddc1">
<a name="top1120"></a>
<input type="hidden" name="order" id="order" value="1"/>
<input type="hidden" name="type_his" id="type_his" value="1"/>
<input type="hidden" name="rackcode" id="rackcode"/>

<!-- 头部开始 -->
<%@include file="/inc/head201309.jsp" %>
<!-- 头部结束 -->

<div class="banner328">
 
</div>


 


<div style="background-color: #FFFFFF; width: 1200px;margin: 0 auto;">

<table width="1200" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="3"><img src="http://images.d1.com.cn/images2014/index/newpage_04-4.jpg" usemap="#Mapnewpage" width="1200" height="352" border="0" /></td>
  </tr>
  <tr>
    <td colspan="3"><img src="http://images.d1.com.cn/images2014/index/newpage_06-3.jpg" usemap="#Mapnewpage2" width="1200" height="382" border="0" /></td>
  </tr>
  <tr>
    <td><a href="http://www.d1.com.cn/shop/463/2" target="_blank"><img src="http://images.d1.com.cn/images2014/index/newpage_07.jpg" width="407" height="533" border="0" /></a></td>
    <td><a href="http://www.d1.com.cn/shop/464/2" target="_blank"><img src="http://images.d1.com.cn/images2014/index/newpage_08.jpg" width="393" height="533" border="0" /></a></td>
    <td><a href="http://www.d1.com.cn/shop/465/2" target="_blank"><img src="http://images.d1.com.cn/images2014/index/newpage_09.jpg" width="400" height="533" border="0" /></a></td>
  </tr>
  <tr>
    <td><a href="http://www.d1.com.cn/shop/466/2" target="_blank"><img src="http://images.d1.com.cn/images2014/index/newpage_10.jpg" width="407" height="531" border="0" /></a></td>
    <td><a href="http://www.d1.com.cn/shop/467/2" target="_blank"><img src="http://images.d1.com.cn/images2014/index/newpage_11-2.jpg" width="393" height="531" border="0" /></a></td>
    <td><a href="http://www.d1.com.cn/shop/468/2" target="_blank"><img src="http://images.d1.com.cn/images2014/index/newpage_12.jpg" width="400" height="531" border="0" /></a></td>
  </tr>
</table>
<map name="Mapnewpage">
  <area shape="rect" coords="734,108,1051,353" href="http://www.d1.com.cn/shop/478/1" target="_blank">
</map>
<map name="Mapnewpage2">
  <area shape="rect" coords="735,1,1051,87" href="http://www.d1.com.cn/shop/478/1" target="_blank">
<div class="brandlist">
<ul>

<%
ArrayList<Promotion> pptop=PromotionHelper.getBrandListByCode("3719", 56);//轮播3685

if(pptop!=null&&pptop.size()>0)
{
	int j=1;
for(Promotion ptt:pptop){
		   
		   %>
		   <li class="<%=j%4==0?"r":"l"%>"><a href="<%=ptt.getSplmst_url()!=null?ptt.getSplmst_url():""  %>" target="_blank"><img src="<%= ptt.getSplmst_picstr() %>"  /></a></li>
		   <%
		   j++;
}
}
%></ul>
<div class="clear"></div>
</div>
</div>

<!-- 底部开始 -->
<%@include file="/inc/foot.jsp" %>
<!-- 底部结束 -->
</body>
</html>
