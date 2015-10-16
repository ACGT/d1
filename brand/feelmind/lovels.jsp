<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<link href="/res/css/feelmind.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<title> Feel Mind/FM情侣装【官网_价格_图片_怎么样】</title>
<meta name="description" content="D1优尚网是国内唯一在线销售Feel Mind/FM情侣装商品,提供Feel Mind/FM情侣装产品的最新报价、评论、导购、图片等相关信息" />
<meta name="keywords" content="Feel Mind/FM, Feel Mind/FM情侣装报价、促销、新闻、评论、导购、图片" />
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
	       <a href="http://feelmind.d1.com.cn/fmbrand.htm" target="_blank"  >品牌故事</a>
	       </td></tr>
	      
	   </table>
	    <div class="fmenul">
	     <ul>      
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmman.htm" style="font-size:16px; ">FM首页</a></li>
				<li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030" style="font-size:16px; ">男装</a></li>
				<li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020" style="font-size:16px; ">女装</a></li>
                <li class="lifestyle"><a href="http://feelmind.d1.com.cn/fmlovels.htm" style="font-size:16px; ">情侣装</a></li>
              <li style="width:60px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li style="width:90px; font-size:16px;">搭配指南&nbsp;<font style="font-size:14px">>></font></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=1&sex=1">加州男装</a></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=1&sex=2">加州女装</a></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=3&sex=1">西部男装</a></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=3&sex=2">西部女装</a></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=4&sex=1">学院男装</a></li>
				</ul>
      
		</div>
		 <div class="clear"></div>
     </div>
     </div>
     <div class="clear"></div>
     <div class="floverbody">
	     <div class="flovertop">
	       <%
	     String str1=PromotionHelper.getImgPromotion("2967",1);
	    if(Tools.isNull(str1)) {
	    	%>
	    	<img src="http://images.d1.com.cn/images2012/feelmind/images/005-1.jpg" width="980" height="515"/>		

	    	<% }else{
	    		out.print(str1);
	    	}
	     %>
	     
 </div>
		 <div class="fserlist">
		 <%
		 ArrayList<Gdscoll> list=GdscollHelper. getGdscollForLover();
		 if(list!=null && list.size()>0){
			 for(int i=0;i<list.size();i++){
				 Gdscoll scoll=list.get(i);
				 if((i+1)%4==1){
				%>	 
				 <div class="flistr2">
           <ul>
				<% }
			
					%>	
					<li>
				
				<a href="/gdscoll/index.jsp?id=<%=scoll.getId() %>" target="_blank"><img src="http://images1.d1.com.cn<%=scoll.getGdscoll_brandimg() %>" border="0"  /></a>
				</li>
				
			<% 
			if((i+1)%4==0){
				%>
				 </ul>
		   </div>
			<%}
			 }
		 }
		 
		 %>
		 </div>
	 
  </div>
  <div class="clear"></div>

<%@include file="foot.jsp" %>
</body>
</html>
