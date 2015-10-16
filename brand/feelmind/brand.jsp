<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="/res/css/feelmind.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<title>品牌故事- Feel Mind/FM </title>
<meta name="description" content=" Feel Mind/FM是纯正北美原创风格服装品牌，将流行经典融入产品设计中，以创造风格，展现个人作为品牌代名词，强调个性表达和通过服装传达激情。" />
<meta name="keywords" content=" Feel Mind/FM,品牌介绍, Feel Mind/FM品牌介绍" />
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


<div class="fbody">
  <div class="autobody">
     <!--品牌头部分开始-->
     <div class="ftop">
	 <div class="fmenu">
	   	   <table height="90" width="980" class="newtable">
	       <tr><td colspan="2" height="40"></td></tr>
	       <tr><td width="800"></td><td><a href="http://www.d1.com.cn/zhuanti/20120620tyd/tyd.jsp" target="_blank" >实体体验店</a>
	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	       <a href="http://feelmind.d1.com.cn/fmbrand.htm" target="_blank"  style="color: #D5D3C8;text-decoration: none;">品牌故事</a>
	       </td></tr>
	      
	   </table>
	    <div class="fmenul">
	     <ul>      
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmman.htm" style="font-size:16px; ">FM首页</font></a></li>
				<li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030" style="font-size:16px; ">男装</a></li>
				<li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020" style="font-size:16px; ">女装</a></li>
				<li><a href="http://feelmind.d1.com.cn/fmlovels.jsp" style="font-size:16px; ">情侣装</a></li>
                <li style="width:60px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li style="width:90px; font-size:16px;">搭配指南&nbsp;<font style="font-size:14px">>></font></li>
				<li style="width:150px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=1&sex=1">北美风南加州系列</a></li>
				<li style="width:150px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=3&sex=1">西部/户外经典系列</a></li>
				<li style="width:150px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=4&sex=1">新英格兰/学院系列</a></li>
				<li style="width:100px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=0&sex=2">FM女装系列</a></li>
				
				</ul>
        </div>
		</div>
		 <div class="clear"></div>
     </div>
     
     <div class="floverbody">
	   <table id="Table_01" width="980"  border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/feelmind/images/fm_brandstory_01.gif" width="980" height="215" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/feelmind/images/fm_brandstory_02.jpg" width="980" height="321" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/feelmind/images/fm_brandstory_03.gif" width="980" height="418" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/feelmind/images/fm_brandstory_04.gif" width="980" height="237" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/feelmind/images/fm_brandstory_05.jpg" width="980" height="353" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/feelmind/images/fm_brandstory_06.jpg" width="980" height="294" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/feelmind/images/fm_brandstory_07.jpg" width="980" height="282" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/feelmind/images/fm_brandstory_08.gif" width="980" height="78" alt=""></td>
	</tr>
</table>
	 </div>
	 
  </div>
</div>
<%@include file="foot.jsp" %>
</body>
</html>
