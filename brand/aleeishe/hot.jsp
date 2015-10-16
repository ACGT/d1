<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="/res/css/aleeishe.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<title>畅销商品-小栗舍</title>
<meta name="description" content="D1优尚网是国内唯一在线销售小栗舍商品，提供小栗舍畅销商品产品的最新报价、评论、导购、图片等相关信息" />
<meta name="keywords" content="小栗舍,畅销商品,小栗舍畅销商品" />
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
				<li style="width:90px;"><a href="/brand/aleeishe/" style="font-size:16px; ">商品分类</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020010">裙子</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020002">T恤</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020001">衬衫</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020008,020009">裤子</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020006">外套</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020">全部</a></li>
				<li style="width:75px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li style="width:90px; font-size:16px;">搭配指南&nbsp;<font style="font-size:14px">>></font></li>
				<li style="width:115px;"><a href="http://www.d1.com.cn/brand/aleeishe/series.jsp?serid=5&sex=1">精致甜美系列</a></li>
				<li style="width:115px;" ><a href="http://www.d1.com.cn/brand/aleeishe/series.jsp?serid=7&sex=1">俏女孩系列</a></li>
				<li style="width:115px;"><a href="http://www.d1.com.cn/brand/aleeishe/series.jsp?serid=6">优雅淑女系列</a></li>
				<li style="width:75px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li><a href="/brand/aleeishe/brand.jsp">品牌故事</a></li>
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
			<li style="line-height:26px;"><a  style="font-size:15px;" href="http://aleeishe.d1.com.cn/asseries.htm?serid=<%=g.getId() %>&sex=1" ><%=g.getGdsser_title().trim() %></a> <img src="http://images.d1.com.cn/images2012/feelmind/images/selected.png"/></li>
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
				
					<div class="hotlist1">
                     <ul>
                    <%
	    ArrayList<Promotion> list=PromotionHelper.getBrandListByCode("2985",100);
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
                       <li><img src="http://images.d1.com.cn/images2012/aleeishe/images/aleeishe-243X350.png" width="243" height="350"/></li>
                       <li><img src="http://images.d1.com.cn/images2012/aleeishe/images/aleeishe-243X350.png" width="243" height="350"/></li>
					   <li><img src="http://images.d1.com.cn/images2012/aleeishe/images/aleeishe-243X350.png" width="243" height="350"/></li>
                       <li><img src="http://images.d1.com.cn/images2012/aleeishe/images/aleeishe-243X350.png" width="243" height="350"/></li>
					   <li><img src="http://images.d1.com.cn/images2012/aleeishe/images/aleeishe-243X350.png" width="243" height="350"/></li>
                       <li><img src="http://images.d1.com.cn/images2012/aleeishe/images/aleeishe-243X350.png" width="243" height="350"/></li>
                 <%} %>   
                    
                     </ul>
                     <div class="clear"></div>
			        </div>
			        
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
