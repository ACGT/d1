<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="/res/css/aleeishe.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<title>品牌故事-小栗舍</title>
<meta name="description" content="小栗舍品牌含义是让人着迷的可爱女人之魅力城堡, 小栗舍品牌故事包括：消费群体、风格、构成" />
<meta name="keywords" content="小栗舍,品牌故事,小栗舍品牌故事" />

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

 
<div class="albody">
	<div class="autobody">
	     <!--品牌头部分开始-->
         <div class="altop">
		     <div style="height:92px;"></div>
			 <div class="menur">
			 <ul>      
				<li style="width:90px;"><a href="http://aleeishe.d1.com.cn/asindex.htm" style="font-size:16px; ">商品分类</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020010">裙子</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020002">T恤</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020001">衬衫</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020008,020009">裤子</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020006">外套</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020">全部</a></li>
				<li style="width:55px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li style="width:90px; font-size:16px;">搭配指南&nbsp;<font style="font-size:14px">>></font></li>
				<li style="width:115px;"><a href="http://aleeishe.d1.com.cn/asseries.htm?serid=5&sex=1">精致甜美系列</a></li>
				<li style="width:115px;" ><a href="http://aleeishe.d1.com.cn/asseries.htm?serid=7&sex=1">俏女孩系列</a></li>
				<li style="width:115px;"><a href="http://aleeishe.d1.com.cn/asseries.htm?serid=6">优雅淑女系列</a></li>
				<li style="width:50px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li class="lifestyle"><a href="http://aleeishe.d1.com.cn/asbrand.jsp">品牌故事</a></li>
				</ul>
			 </div>
	         <div class="menu">
			 </div>
		 </div>
			 <div class="alcontent">
	<table id="__01" width="980" height="1427" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/aleeishe/images/story2_01.jpg" width="980" height="60" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/aleeishe/images/story2_02.jpg" width="980" height="119" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/aleeishe/images/story2_03.jpg" width="980" height="144" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/aleeishe/images/story2_04.jpg" width="980" height="106" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/aleeishe/images/story2_05.jpg" width="980" height="106" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/aleeishe/images/story2_06.jpg" width="980" height="87" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/aleeishe/images/story2_07.jpg" width="980" height="122" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/aleeishe/images/story2_08.jpg" width="980" height="99" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/aleeishe/images/story2_09.jpg" width="980" height="99" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/aleeishe/images/story2_10.jpg" width="980" height="157" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/aleeishe/images/story2_11.jpg" width="980" height="110" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/aleeishe/images/story2_12.jpg" width="980" height="112" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/aleeishe/images/story2_13.jpg" width="980" height="106" alt=""></td>
	</tr>
</table>
			 </div>
					
		 </div>
	</div>
<div class="clear"></div>
	
	<!-- 尾部开始 -->
	<%@include file="/inc/foot.jsp" %>
	<!-- 尾部结束 -->
</body>
</html>
