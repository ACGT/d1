<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="/res/css/sheromo.css" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<title>畅销商品-诗若漫</title>
<meta name="description" content="D1优尚网是国内唯一在线销售诗若漫商品，提供诗若漫畅销商品产品的最新报价、评论、导购、图片等相关信息" />
<meta name="keywords" content="诗若漫,畅销商品, 诗若漫畅销商品" />
</head>

<body>
<div style="background:#ad1009;background:url('http://images.d1.com.cn/images2012/index2012/newtopbg.jpg'); +margin-top:10px;  " ><a href="http://www.d1.com.cn/zhuanti/20120629qchd/qchd.jsp" style=" width:980px; display:block; margin:0px auto;" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/980X50new3.jpg"/></a></div>
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
				<li class="lifestyle" style="width:90px;"><a href="/brand/sheromo/" style="font-size:16px; ">商品分类</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020010">裙子</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020002">T恤</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020001">衬衫</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020008,020009">裤子</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020006">外套</a></li>
				<li><a href="http://www.d1.com.cn/brand/sheromo/categorydisplay.jsp?productsort=020">全部</a></li>
				<li style="width:70px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li style="width:90px; font-size:16px;color: #9D8F86;">搭配指南&nbsp;<font style="font-size:14px">>></font></li>
								<li style="width:115px;"><a href="http://sheromo.d1.com.cn/srmseries.htm?serid=9&sex=1">知性OL系列</a></li>
				<li style="width:115px;"><a href="http://sheromo.d1.com.cn/srmseries.htm?serid=10">丹宁风尚系列</a></li>
				<li style="width:115px;"><a href="http://sheromo.d1.com.cn/srmseries.htm?serid=11">国际经典系列</a></li>
				<li style="width:75px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li><a href="/brand/sheromo/story.jsp">品牌故事</a></li>
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
			<li style="line-height:26px;"><a  style="font-size:15px;" href="http://sheromo.d1.com.cn/srmseries.htm?serid=<%=g.getId() %>" ><%=g.getGdsser_title().trim() %></a> <img src="http://images.d1.com.cn/images2012/feelmind/images/selected.png"/></li>
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
		     <div class="hotlist">
                     <ul>
                       <%
	    ArrayList<Promotion> list=PromotionHelper.getBrandListByCode("2995",100);
		if(list!=null && list.size()>0){
			for(int i=0;i<list.size();i++){
				Promotion promotion=list.get(i);
				%>
				<li>
				<%
				if(!promotion.getSplmst_url().equals("#")){%>
				<a href="<%=PromotionHelper.getPathUrl(0,StringUtils.encodeUrl(promotion.getSplmst_url()))%>" target="_blank">
			<%} %>
			<img src="<%=promotion.getSplmst_picstr() %>"  alt="<%=promotion.getSplmst_name() %>" border="0" width="243" height="350"/>
			<% if(!promotion.getSplmst_url().equals("#")){%>
				</a>
			<%}%>
			</li>
			<%}
		}else{
	    %>
                       <li><img src="http://images.d1.com.cn/images2012/sheromo/sample.png" width="243" height="350"></li>
                       <li><img src="http://images.d1.com.cn/images2012/sheromo/sample.png" width="243" height="350"></li>
					   <li><img src="http://images.d1.com.cn/images2012/sheromo/sample.png" width="243" height="350"></li>
                       <li><img src="http://images.d1.com.cn/images2012/sheromo/sample.png" width="243" height="350"></li>
					   <li><img src="http://images.d1.com.cn/images2012/sheromo/sample.png" width="243" height="350"></li>
                       <li><img src="http://images.d1.com.cn/images2012/sheromo/sample.png" width="243" height="350"></li>
            <%} %>        
                     </ul>
		     </div>
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
