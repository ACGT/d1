<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>D1优尚网-最新搭配</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
.dplist{ width:980px; overflow:hidden;margin:0px auto;}
.dplist ul{list-style:none;}
.dplist ul li{ float:left;margin-top:10px; width:317px; height:362px; overflow:hidden; margin-right:14px;}
</style>

</head>
<body>

<%@include file="/inc/head.jsp" %>
<div style="width:980px; margin:0px auto;">
   <%
        ArrayList<Promotion> promotionlist=PromotionHelper.getBrandListByCode("3342", 100);
        if(promotionlist!=null&&promotionlist.size()>0)
        {
        	for(int i=0;i<promotionlist.size();i++)
        	{
        		Promotion promotion=promotionlist.get(i);
        		if(i==0)
        		{%>
        			<div>
        			    <img src="<%= promotion.getSplmst_picstr() %>"/>
        			</div>
        		<%}
        		else if(i==1)
        		{%>
        			<div class="dplist">
        			   <ul>
        			   <li>
        			      <a href="<%=promotion.getSplmst_url() %>" target="_blank"><img src="<%= promotion.getSplmst_picstr() %>"/></a>
        			   </li>
        			  
        		<%}
        		else if(i==promotionlist.size()-1)
        		{%>
        		<li <%if(i%3==0)out.print("style=\"margin-right:0px;\""); %>>
        			      <a href="<%=promotion.getSplmst_url() %>" target="_blank"><img src="<%= promotion.getSplmst_picstr() %>"/></a>
        			   </li>
        			 </ul>
        			</div>
        		<%}
        		else
        		{%>
        			 <li <%if(i%3==0)out.print("style=\"margin-right:0px;\""); %>>
        			      <a href="<%=promotion.getSplmst_url() %>" target="_blank"><img src="<%= promotion.getSplmst_picstr() %>"/></a>
        			   </li>
        		<%}
        	}
        }
   %>
</div>  
  
  
<div class="clear"></div>


   <!-- 底部 -->
   <%@ include file="/inc/foot.jsp" %>
   <!-- 底部结束 -->
   
</body>
</html>


