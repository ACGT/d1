<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/jquery-1.3.2.min.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<title>优尚大促节 --D1优尚</title>
<style>
body{background:#f5ce1b}
.banner328{
	background-image: url(http://images.d1.com.cn/zt2014/07/ysdqj_01.jpg);
	background-repeat: no-repeat;
	background-position: center;
	height:452px;
}


.sg_list {
	width: 980px; overflow:hidden;
}
.sg_list ul li{
	width: 318px;
	height:485px;
	border: 1px solid #ebebeb;
	background:#fff;
	margin-top:8px;
}
.sg_list ul li.l {
	float:left; margin-right:10px; 
}
.sg_list ul li.r {
	 float:right;
}
.sg_list ul li.l_soldout {
	float:left; margin-right:10px;
	filter: alpha(opacity=50);
	-moz-opacity: 0.5;
	opacity: 0.5;
	 
}
.sg_list ul li.r_soldout {
	 float:right;
	 filter: alpha(opacity=50);
	 -moz-opacity: 0.5;
	 opacity: 0.5;
}
.sg_list ul li .sgl_item .i_img {
	text-align: center; position:relative;
}
.sg_list ul li .sgl_item .i_img .ii_f{
	position:absolute;
	bottom:10px;
	right:15px;
	font-size:36px;
	background-image: url(http://images.d1.com.cn/images2014/index/index_iconnew.png);
	background-position: 0px 0px;
	width:47px;height:54px; color:#fff;
	text-align:left;
	padding-top:3px;padding-left:10px;
	
}
.li_nogds{
	position:absolute;
	bottom:70px;
	right:80px;
	background-image: url(http://images.d1.com.cn/zt2014/0220qc/end_sale.png);
	filter: alpha(opacity=100);
	-moz-opacity: 10;
	opacity: 10;
	background-position: 0px 0px;
	width:150px;height:135px; color:#fff;
	text-align:left;
	padding-top:3px;padding-left:10px;
	
}
.sg_list ul li .sgl_item .i_img .ii_f .z{ position:absolute; bottom:13px; right:6px; font-size:18px; width:21px; height:21px;}
.sg_list ul li .sgl_item .i_title {
	height: 67px; color:#333333; line-height:21px;padding:12px 14px 0px  14px;font-family:微软雅黑;
	text-align: left;
}
.sg_list ul li .sgl_item .i_title  .tt{font-size:16px;}
.sg_list ul li .sgl_item .i_title .gkey{ /*color:#f3a96e;*/ color:#f0424e; font-size:12px;width: 292px;display:block;overflow:hidden;white-space:nowrap;word-break:keep-all;}

.sg_list ul li .sgl_item .i_price {
	background-image: url(http://images.d1.com.cn/images2014/index/indexsg_bg.jpg);
	background-repeat: no-repeat;
	height:96px;
}
.sg_list ul li .sgl_item .i_price .num {
	float: left;
	width: 130px;
	padding-left:10px;
	padding-top: 30px;
	font-size: 20px;
	line-height: 28px;
	color: #fff;
	font-family:微软雅黑;
}
.sg_list ul li .sgl_item .i_price .pp{ float:right; width:125px; padding-right:5px;padding-top:18px;font-family:微软雅黑;}
.sg_list ul li .sgl_item .i_price .pp .s{ color:#f0424e; font-size:48px; line-height:46px; font-weight:800}
.sg_list ul li .sgl_item .i_price .pp .m{ color:#fff; font-size:14px; line-height:16px;}


.i_price_new {
background-image: url(http://images.d1.com.cn/zt2014/06/red.png);
background-repeat: repeat;
height: 70px;

}
.i_price_newbg {
background-image: url(http://images.d1.com.cn/zt2014/06/green.png);
background-repeat: repeat;
height: 70px;
}

.lijiqiang {
position: absolute;
width: 140px;
height: 65px;
right:0px;
bottom: 50px;
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
.mj_list {
	width: 980px; overflow:hidden;
}
.mj_list ul li{
	width: 237px;
	height:385px;
	border: 1px solid #ebebeb;
	background:#fff;
	margin-top:8px;
}
.mj_list ul li {
	float:left; margin-right:8px; 
}
.mj_list ul li.r {
	 float:right;margin-right:0;
}
</style>
</head>
<body style="background:#0066cb;">
<!--头部-->
<%@include file="/inc/head.jsp" %>
<!-- 头部结束-->
<div class="banner328">
</div>
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="5"><img src="http://images.d1.com.cn/zt2014/07/ysdqj_03.jpg" width="980" height="138" /></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/zt2014/07/ysdqj_05.jpg" width="195" height="127" /></td>
    <td><img src="http://images.d1.com.cn/zt2014/07/ysdqj_06.jpg" width="196" height="127" /></td>
    <td><img src="http://images.d1.com.cn/zt2014/07/ysdqj_07.jpg" width="197" height="127" /></td>
    <td><img src="http://images.d1.com.cn/zt2014/07/ysdqj_08.jpg" width="196" height="127" /></td>
    <td><img src="http://images.d1.com.cn/zt2014/07/ysdqj_09.jpg" width="196" height="127" /></td>
  </tr>
  <tr>
    <td colspan="5"><img src="http://images.d1.com.cn/zt2014/07/ysdqj_10.jpg" width="980" height="73" /></td>
  </tr>
  <tr>
    <td colspan="5">
  <table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><a href="http://www.d1.com.cn/result.jsp?productsort=030002" target="_blank"><img src="http://images.d1.com.cn/zt2014/07/nztx.jpg"></a></td>
    <td><a href="http://www.d1.com.cn/result.jsp?productsort=030001" target="_blank"><img src="http://images.d1.com.cn/zt2014/07/nzcs.jpg"></a></td>
    <td><a href="http://www.d1.com.cn/result.jsp?productsort=030008004" target="_blank"><img src="http://images.d1.com.cn/zt2014/07/nzk.jpg"></a></td>
    <td><a href="http://www.d1.com.cn/result.jsp?productsort=031002" target="_blank"><img src="http://images.d1.com.cn/zt2014/07/xrnx.jpg"></a></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><a href="http://www.d1.com.cn/result.jsp?productsort=020010004" target="_blank"><img src="http://images.d1.com.cn/zt2014/07/dress.jpg"></a></td>
    <td><a href="http://www.d1.com.cn/result.jsp?productsort=020002" target="_blank"><img src="http://images.d1.com.cn/zt2014/07/nzt.jpg"></a></td>
    <td><a href="http://www.d1.com.cn/search.jsp?key_wds=6Zuq57q66KGr&rackcode=020" target="_blank"><img src="http://images.d1.com.cn/zt2014/07/xf.jpg"></a></td>
    <td><a href="http://www.d1.com.cn/result.jsp?productsort=020009" target="_blank"><img src="http://images.d1.com.cn/zt2014/07/xrdk.jpg"></a></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><a href="http://www.d1.com.cn/result.jsp?productsort=014001021" target="_blank"><img src="http://images.d1.com.cn/zt2014/07/bb.jpg"></a></td>
    <td><a href="http://www.d1.com.cn/result.jsp?productsort=014001003" target="_blank"><img src="http://images.d1.com.cn/zt2014/07/bshfs.jpg"></a></td>
    <td><a href="http://www.d1.com.cn/result.jsp?productsort=014001004" target="_blank"><img src="http://images.d1.com.cn/zt2014/07/mm.jpg"></a></td>
    <td><a href="http://www.d1.com.cn/result.jsp?&productother6=%E9%98%B2%E6%99%92&productsort=014001013" target="_blank"><img src="http://images.d1.com.cn/zt2014/07/fs.jpg"></a></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><a href="http://www.d1.com.cn/result.jsp?productsort=015002004" target="_blank"><img src="http://images.d1.com.cn/zt2014/07/mpsb.jpg"></a></td>
    <td><a href="http://www.d1.com.cn/result.jsp?productsort=015009" target="_blank"><img src="http://images.d1.com.cn/zt2014/07/jzsp.jpg"></a></td>
    <td><a href="http://www.d1.com.cn/result.jsp?productsort=012007" target="_blank"><img src="http://images.d1.com.cn/zt2014/07/jfby.jpg"></a></td>
    <td><a href="http://www.d1.com.cn/result.jsp?productsort=050001" target="_blank"><img src="http://images.d1.com.cn/zt2014/07/jpnb.jpg"></a></td>
  </tr>
</table>

    </td>
  </tr>
  <tr>
    <td colspan="5"><img src="http://images.d1.com.cn/zt2014/07/ysdqj_14.jpg" width="980" height="66" /></td>
  </tr>
  <tr>
    <td colspan="5">
    <div class="mj_list">
    	<ul>
    	<%
    	List<Promotion> plist= PromotionHelper.getBrandListByCode("3712",100);
    	if(plist!=null&&plist.size()>0){
    		String cli="";
    		int i=0;
    		for(Promotion pm:plist){
    			cli="";
    			 i++;
    			if(i%4==0){
    				cli="class=\"r\"";
    			}
    			
    			
    			%>
    			<li <%=cli %> >
    			<a href="<%=pm.getSplmst_url()%>" target="_blank">
    			<img src="<%=pm.getSplmst_picstr() %>" border="0" />
    			</a>
                </li>
    	
    	<%}
    	}%>
        	
        </ul>
    </div>
    </td>
  </tr>
</table>
<%@include file="/inc/foot.jsp"%>
</body>
</html>
