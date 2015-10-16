<%response.sendRedirect("man.jsp"); %>
<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="/res/css/feelmind.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<title>【Feel Mind】_FM品牌官网_D1优尚网旗下品牌</title>
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
	<div ><a href="http://www.d1.com.cn/zhuanti/20120718qchd/qchd.jsp" style=" width:980px; display:block; margin:0px auto;" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/980X60shouyechangtiao.jpg" border="0"/></a></div>
	
<div class="fbody">
  <div class="autobody">
     <!--品牌头部分开始-->
     <div class="ftop">
	 <div class="fmenu">
	    <div class="fmenul">
	      <ul>
	        <li class="lifestyle"><a href="index.jsp">首  页</a></li>
			<li><a href="man.jsp">男  装</a></li>
			<li><a href="woman.jsp">女  装</a></li>
			<li ><a href="lovels.jsp">情 侣 装</a></li>
			<li class="bgnone"><a href="brand.jsp">品牌介绍</a></li>
          </ul>
        </div><div class="fmenur">
		    <ul>
	      
			
          </ul>
		 </div>
		</div>
     </div>
     <!--品牌头部分结束-->
	 <div class="fcontent1">
	     <div class="fl">
	     <%
	     String str1=PromotionHelper.getImgPromotion("2963",1);
	    if(Tools.isNull(str1)) {
	    	%>
	    	<img src="http://images.d1.com.cn/images2012/feelmind/images/fm001.gif" width="330" height="515"/>	
	     
	    	<% }else{
	    		out.print(str1);
	    	}
	     %>
	      </div>
		 <div class="fr">
		   <%
	     String str2=PromotionHelper.getImgPromotion("2964",1);
	    if(Tools.isNull(str2)) {
	    	%>
	    	<img src="http://images.d1.com.cn/images2012/feelmind/images/001.jpg" width="650" height="515"/>			
	     
	    	<% }else{
	    		out.print(str2);
	    	}
	     %>
		  </div>
	 </div>
	 <div class="clear"></div>
	 <!--搭配列表开始-->
	  <div class="fdp">
	    <ul>
	    
	    <%
	    ArrayList<Promotion> list=PromotionHelper.getBrandListByCode("2974",3);
		if(list!=null && list.size()>0){
			for(int i=0;i<list.size();i++){
				Promotion promotion=list.get(i);
				if(i==0){
					%>
					<li>
				 <%}else{
					 %> 
					 <li class="mgl14">
				 <% }
				if(!promotion.getSplmst_url().equals("#")){%>
				<a href="<%=PromotionHelper.getPathUrl(0,StringUtils.encodeUrl(promotion.getSplmst_url()))%>" target="_blank">
			<%} %>
			<img src="<%=promotion.getSplmst_picstr() %>"  alt="<%=promotion.getSplmst_name() %>" border="0" width="317" height="440"/>
			<% if(!promotion.getSplmst_url().equals("#")){%>
				</a>
			<%}%>
			</li>
			<%}
		}else{
	    %>
	    
	      <li><img src="http://images.d1.com.cn/images2012/feelmind/images/002.jpg" width="317" height="440"/></li>
		  <li class="mgl14"><img src="http://images.d1.com.cn/images2012/feelmind/images/002.jpg" width="317" height="440"/></li>
		  <li class="mgl14"><img src="http://images.d1.com.cn/images2012/feelmind/images/002.jpg" width="317" height="440"/></li>
       <%} %>
        </ul>
	  </div>
	   <div class="clear"></div>
	 <!--搭配列表结束-->
	 
  </div>
</div>
<%@include file="foot.jsp" %>
</body>
</html>
