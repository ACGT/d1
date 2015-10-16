<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>品牌故事- YOUSOO </title>
<meta name="description" content=" YOUSOO中文邮萨，意味时尚，璀璨奢华，品味时尚，让每一位女性都拥有时尚的感知，让平凡人众不同，让每一位女性都得到幸福…… " />
<meta name="keywords" content=" YOUSOO,品牌故事, YOUSOO品牌故事" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

<style type="text/css" >

   .middle{ width:980px; margin:0px auto;+margin-top:10px;}
   .middle_top{ background:url('http://images.d1.com.cn/images2012/YOUSOO/images/ystest1.jpg') repeat-x; height:127px; overflow:hidden;}
    .ysdh{ background:url('http://images.d1.com.cn/images2012/YOUSOO/images/YStest_05_1.jpg'); height:46px; width:980px; line-height:48px;
           font-size:16px; margin:0px; padding:0px;}
    .ysdh span{ display:block; text-align:center; float:left;}
    .ysdh a{ color:#aaa8b3;padding:3px 6px; font-family:'微软雅黑';}
    .ysdh a:hover{color:#aaa8b3; text-decoration:underline; }
   
</style>
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

<body style="background:#7f7c87;">
<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<div class="clear"></div>
	<!-- 头部结束-->



    <!-- 中间位置 -->
    <div class="middle">
        <div class="middle_top">
           <div style="width:980px; margin:0px auto;">
              <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_03.jpg"/>
              <div class="ysdh">
                 <span style=" width:120px;"><a href="http://yousoo.d1.com.cn/"  >商品分类</a></span>
                 <span style=" width:125px;"><a href="http://yousoo.d1.com.cn/yscxsp.htm" >畅销商品</a></span>
                 <span style=" width:120px;"><a href="http://yousoo.d1.com.cn/ys/brandstory.htm"  style="background:#6e6a78; color:#fff;">品牌故事</a></span>
                 <div class="clear"></div>
              </div>
           </div>
           </div>
       <table border="0" cellpadding="0" cellspacing="0">
          <tr><td><img src="http://images.d1.com.cn/images2012/YOUSOO/images/YS3_03.jpg"/></td></tr>
          <tr><td><img src="http://images.d1.com.cn/images2012/YOUSOO/images/YS3_05.jpg"/></td></tr>
          <tr><td><img src="http://images.d1.com.cn/images2012/YOUSOO/images/YS3_06.jpg"/></td></tr>
          <tr><td><img src="http://images.d1.com.cn/images2012/YOUSOO/images/YS3_07.jpg"/></td></tr>
          <tr><td><img src="http://images.d1.com.cn/images2012/YOUSOO/images/YS3_08.jpg"/></td></tr>
          <tr><td><img src="http://images.d1.com.cn/images2012/YOUSOO/images/YS3_09.jpg"/></td></tr>
          <tr><td><img src="http://images.d1.com.cn/images2012/YOUSOO/images/YS3_10.jpg"/></td></tr>
       </table>
    </div>
    <!-- 中间位置结束 -->
    <%@include file="/inc/foot.jsp" %>
</body>
</html>

