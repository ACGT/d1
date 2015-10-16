<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="/res/css/sheromo.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<title>品牌故事-诗若漫</title>
<meta name="description" content="诗若漫为成熟女性带来职业休闲装的新概念让他们上班和休闲场合都能感觉到自信和美丽" />
<meta name="keywords" content="诗若漫,品牌故事, 诗若漫品牌故事" />
 <script language=javascript>
 function view_time2(){
		var startDate= new Date();
		var endDate= new Date("2012/07/20 15:00:00");
		var lasttime=(endDate.getTime()-startDate.getTime())/1000;
	    if(lasttime>0){
	    	var the_D=Math.floor((lasttime/3600)/24)
	        var the_H=Math.floor((lasttime-the_D*24*3600)/3600);
	        var the_M=Math.floor((lasttime-the_D*24*3600-the_H*3600)/60);
	        var the_S=Math.floor((lasttime-the_H*3600)%60);
	       if(the_D!=0){$("#topd").text(the_D);}
	        if(the_D!=0 || the_H!=0) {$("#toph").text(the_H);}
	        if(the_D!=0 || the_H!=0 || the_M!=0) {$("#topm").text(the_M);}
	        $("#tops").text(the_S);
	       // $getid(objid).innerHTML = html+html2+html1;
	        lasttime--;
	    }
	}	
	$(document).ready(function() {
		var startDate= new Date();
		var endDate= new Date("2012/07/20 15:00:00");
		var lasttime=(endDate.getTime()-startDate.getTime())/1000;
	    if(lasttime>0){
	  setInterval(view_time2,1000);
	    }
	});
		</script>
</head>

<body>
<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<div class="clear"></div>
	<!-- 头部结束-->

<div class="sbody">
  <div class="autobody">
     <div class="stop">
	     <div style="height:80px;"></div>
			 <div class="menu">
			<ul>      
				<li class="lifestyle" style="width:90px;"><a href="http://sheromo.d1.com.cn/srmindex.htm" style="font-size:16px; ">商品分类</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020010">裙子</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020002">T恤</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020001">衬衫</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020008,020009">裤子</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020006">外套</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020">全部</a></li>
				<li style="width:60px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li style="width:90px; font-size:16px;color: #9D8F86;">搭配指南&nbsp;<font style="font-size:14px">>></font></li>
								<li style="width:115px;"><a href="http://sheromo.d1.com.cn/srmseries.htm?serid=9&sex=1">知性OL系列</a></li>
				<li style="width:115px;"><a href="http://sheromo.d1.com.cn/srmseries.htm?serid=10">丹宁风尚系列</a></li>
				<li style="width:115px;"><a href="http://sheromo.d1.com.cn/srmseries.htm?serid=11">国际经典系列</a></li>
				<li style="width:50px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li class="lifestyle"><a href="http://sheromo.d1.com.cn/srmstory.htm">品牌故事</a></li>
				</ul>
			 </div>
			 <div class="clear"></div>
	</div>
	<!--列表开始-->
	<div class="scontent">
    <table id="__01" width="980"   border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/sheromo/story_01.jpg" width="980" height="221" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/sheromo/story_02.jpg" width="980" height="167" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/sheromo/story_03.jpg" width="980" height="207" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/sheromo/story_04.jpg" width="980" height="182" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/sheromo/story_05.jpg" width="980" height="136" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/sheromo/story_06.jpg" width="980" height="203" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/sheromo/story_07.jpg" width="980" height="78" alt=""></td>
	</tr>
</table>
  </div>
  </div>
</div>
<%@include file="/inc/foot.jsp" %>
</body>
</html>
