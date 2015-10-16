<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="/res/css/aleeishe.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<title>小栗舍首页</title>
</head>

<body>
<div style="background:#ad1009;background:url('http://images.d1.com.cn/images2012/index2012/newtopbg.jpg'); +margin-top:10px;  " ><a href="http://www.d1.com.cn/zhuanti/20120629qchd/qchd.jsp" style=" width:980px; display:block; margin:0px auto;" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/980X50new3.jpg"/></a></div>
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
				<li ><a href="/brand/aleeishe/">商品分类</a></li>
				<li  class="lifestyle"><a href="scene.jsp">场景搭配</a></li>
				<li><a href="hot.jsp">畅销商品</a></li>
				<li class="bgnone"><a href="brand.jsp">品牌故事</a></li>
				</ul>
			 </div>
	         <div class="menu">
			 </div>
		 </div>
			 <div class="alcontent">
					   <!--左侧开始-->
		   <div class="fmancl">
			   <div class="fclsmenu">
				 <ul class="one">
				  <%
		     ArrayList<Gdsser> Gdsserlist= GdsserHelper.getGdsserByBrandid("1690");
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
			request.setAttribute("brandname", "AleeiShe 小栗舍");
			request.setAttribute("rackcode", "02");
			%>
	        <jsp:include   page= "category.jsp"   />
			   </div>
		   </div>
		   <!--左侧结束-->
					<div class="right">
					<%
					 ArrayList<Promotion> list2=PromotionHelper.getBrandListByCode("2986",100);
					if(list2!=null && list2.size()>0){
						for(Promotion promotion:list2){
							%>
							<div><a href="<%=PromotionHelper.getPathUrl(0,StringUtils.encodeUrl(promotion.getSplmst_url()))%>" target="_blank">
	    		<img src="<%=promotion.getSplmst_picstr() %>"  alt="<%=promotion.getSplmst_name() %>" border="0" width="765" height="400"/>
	    		</a></div>
						<%}
					}else{
					%>
				<div class="pd10"><img src="http://images.d1.com.cn/images2012/aleeishe/images/001.jpg" width="765" height="400"/></div>
					<div class="pd10"><img src="http://images.d1.com.cn/images2012/aleeishe/images/001.jpg" width="765" height="400"/></div>
				  <%} %>
				   </div>
				</div>
				<div class="clear"></div>
		 </div>
	</div>
<div class="clear"></div>
	
	<!-- 尾部开始 -->
	<%@include file="/inc/foot.jsp" %>
	<!-- 尾部结束 -->
</body>
</html>
