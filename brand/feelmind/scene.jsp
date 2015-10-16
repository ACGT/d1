<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<link href="/res/css/feelmind.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<title>FEEL MIND场景展示</title>
</head>

<body>
<div style="background:url('http://images.d1.com.cn/images2012/index2012/index98050bg2.jpg')  "><a href="http://www.d1.com.cn/zhuanti/20120629qchd/qchd.jsp" style=" width:980px; display:block; margin:0px auto;" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/980X50new1.jpg"/></a></div>

<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<div class="clear"></div>
	<!-- 头部结束-->
<div class="fbody">
  <div class="autobody">
     <!--品牌头部分开始-->
     <div class="ftop">
	 <div class="fmenu">
	    <div class="fmenul">
	      <ul>
	       
			<li><a href="man.jsp">男  装</a></li>
			<li><a href="woman.jsp">女  装</a></li>
			<li class="bgnone"><a href="lovels.jsp">情 侣 装</a></li>
          </ul>
        </div><div class="fmenur">
		    <ul>
	        <li  class="lifestyle"><a href="scene.jsp">场景展示</a></li>
			<li class="bgnone"><a href="brand.jsp">品牌介绍</a></li>
          </ul>
		 </div>
		</div>
		 <div class="clear"></div>
     </div>
     
     <div class="floverbody">
     <%
    
     boolean bl=false;
 	 ArrayList<Promotion> list=PromotionHelper.getBrandListByCode("3007",10);
		if(list!=null && list.size()>0){
			bl=true;
			for(Promotion promotion:list){
				%>
				 <div class="flovertop">
				 <%
				 if(!promotion.getSplmst_url().equals("#")){%>
				<a href="<%=PromotionHelper.getPathUrl(0,StringUtils.encodeUrl(promotion.getSplmst_url()))%>" target="_blank">
			<%} %>
			<img src="<%=promotion.getSplmst_picstr() %>"  alt="<%=promotion.getSplmst_name() %>" border="0" width="317" height="440"/>
			<% if(!promotion.getSplmst_url().equals("#")){%>
				</a>
			<%}%>
				 </div>
			<%}
		}
 	if(!bl){
 		 %>
 		   <div class="flovertop"><img src="http://images.d1.com.cn/images2012/feelmind/images/005.jpg" width="980" height="515"/>		 </div>
  	     <div class="flovertop"><img src="http://images.d1.com.cn/images2012/feelmind/images/005.jpg" width="980" height="515"/>		 </div>
		 <div class="flovertop"><img src="http://images.d1.com.cn/images2012/feelmind/images/005.jpg" width="980" height="515"/>		 </div>
  <%	}
     %>
	   
	 </div>
	 
  </div>
</div>
<%@include file="foot.jsp" %>
</body>
</html>
