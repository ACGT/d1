<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="/res/css/sheromo.css" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<title>诗若漫场景搭配</title>
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
				<li><a href="index.jsp">商品分类</a></li>
				<li class="lifestyle"><a href="scene.jsp">场景搭配</a></li>
				<li><a href="hots.jsp">畅销商品</a></li>
				<li class="bgnone"><a href="story.jsp">品牌故事</a></li>
				</ul>
			 </div>
			 <div class="clear"></div>
	</div>
	<!--列表开始-->
	<div class="scontent">
	    <div class="left">
		<!--left-->
			   <div class="fclsmenu">
				 <ul class="one">
				    <%
		     ArrayList<Gdsser> Gdsserlist= GdsserHelper.getGdsserByBrandid("1969");
	if(Gdsserlist!=null && Gdsserlist.size()>0){
		for(Gdsser g:Gdsserlist){
			%>
			<li style="line-height:26px;"><a  style="font-size:15px;" href="series.jsp?serid=<%=g.getId() %>&sex=1" target="_blank"><%=g.getGdsser_title().trim() %></a> <img src="http://images.d1.com.cn/images2012/feelmind/images/selected.png"/></li>
		<%}
	}else{%>
				   <li><a  style="font-size:15px;" href="#">北美风南加州系列</a></li>
				   <li><a  style="font-size:15px;" href="#">北美风南加州系列</a></li>
				   <li><a  style="font-size:15px;" href="#">北美风南加州系列</a></li>
				<%} %>
				  <li>&nbsp;</li>  
				 </ul>
				 <%
			request.setAttribute("brandname", "诗若漫");
			request.setAttribute("rackcode", "02");
			%>
	        <jsp:include   page= "category.jsp"   />
			   </div>
		   </div>
		   <!--left  end-->
		   <!--right-->
		   <div class="right">
		   <div>
		     <%
	     String str1=PromotionHelper.getImgPromotion("2996",1);
	    if(Tools.isNull(str1)) {
	    	%>
	    		<img src="http://images.d1.com.cn/images2012/sheromo/001.jpg" width="760" height="400">
	    	<% }else{
	    		out.print(str1);
	    	}
	     %>
		 </div>  
		     <%
					  ArrayList<Promotion> list2=PromotionHelper.getBrandListByCode("2997",100);
						if(list2!=null && list2.size()>0){
							for(Promotion promotion:list2){
								
	    %>
	    		 <div class="pd10"><a href="<%=PromotionHelper.getPathUrl(0,StringUtils.encodeUrl(promotion.getSplmst_url()))%>" target="_blank">
	    		<img src="<%=promotion.getSplmst_picstr() %>"  alt="<%=promotion.getSplmst_name() %>" border="0" />
	    		</a></div>
	    	<% }}else{
	    %>
				
				<div class="pd10"><img src="http://images.d1.com.cn/images2012/sheromo/002.jpg" width="760" height="197"></div>
				 <div class="pd10"><img src="http://images.d1.com.cn/images2012/sheromo/002.jpg" width="760" height="197"></div>
				 <div class="pd10"><img src="http://images.d1.com.cn/images2012/sheromo/002.jpg" width="760" height="197"></div>
		<%} %>
		   </div>
		   <!--right-->
		   <div class="clear"></div>
	</div>
	<!--列表结束-->
  </div>
</div>
<%@include file="/inc/foot.jsp" %>
</body>
</html>
