<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>春装折扣-D1优尚网</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style type="text/css">

   .center{ width:980px; margin:0px auto; margin-top:10px;}
   .top{ margin:0px; padding:0px;}
   a{ margin:0px; padding:0px;}
   a img{ border:none;margin:0px; padding:0px;}
   .show{ width:980px; background:#dfe8e3;}
   .show ul { list-style:none; width:980px; padding-top:5px;}
   .show ul li{ float:left; width:220px;margin-left:20px;_margin-left:14px; margin-bottom:10px; text-align:left;}
   .show ul li a{ display:block; width:100%; overflow:hidden; text-align:left; }
   .show ul li a:hover{color:#}a40545;   
   .show ul li .font1{ font-size:12px; color:#787a79;}
   .show ul li .font2{ font-size:14px; color:#f00; font-weight:bold;}
   .show ul li .font3{ font-size:14px; color:#787a79; font-weight:bold;}
   .detail{ height:53px; margin-top:5px; padding-left:10px; line-height:20px; background:#f1f6f2; padding-top:10px;}
</style>
</head>
<body>
   <center>
   <!-- 头部开始 -->
   <%@ include file="/inc/head.jsp" %>
   <!-- 头部结束 -->    
   <div class="center">
        <div class="top">
        <table>
          <tr><td><a href="/product/01720637" target="_blank"><img src="http://images.d1.com.cn/zt2012/Mayczzk/top_01.jpg"/></a></td></tr>
        <tr><td><a href="/product/01720637" target="_blank"><img src="http://images.d1.com.cn/zt2012/Mayczzk/top_02.jpg"/></a></td></tr>
        <tr><td><a href="/product/01720637" target="_blank"><img src="http://images.d1.com.cn/zt2012/Mayczzk/top_03.jpg"/></a></td></tr>
        </table>
                   </div>
        <div class="show">
         <img src="http://images.d1.com.cn/zt2012/Mayczzk/top_041.jpg"/>
         <%
              ArrayList<PromotionProduct> pplist=PromotionProductHelper.getPProductByCode("7722");
              if(pplist!=null&&pplist.size()>0)
              {%>
            	<ul>
            	<%
            	    for(PromotionProduct pp:pplist)
            	    {
            	    	if(pp!=null&&pp.getSpgdsrcm_gdsid()!=null&&pp.getSpgdsrcm_gdsid().length()>0&&Tools.isNumber(pp.getSpgdsrcm_gdsid()))
            	    	{
            	    		Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
            	    		if(p!=null)
            	    		{
            	    		    String imgUrl="";
            	    		    if(p.getGdsmst_img200250()!=null&&p.getGdsmst_img200250().length()>0)
            	    		    {
            	    		    	imgUrl="http://images.d1.com.cn"+p.getGdsmst_img200250();
            	    		    }
            	    		    else
            	    		    {
            	    		    	imgUrl=ProductHelper.getImageTo200(p);
            	    		    }
            	    		%>
            	    			<li>
            	    			    <a href="/product/<%= p.getId() %>" target="_blank" style="background:#fff; text-align:center; padding-top:10px; padding-bottom:10px;"><img src="<%= imgUrl %>" width="200" height="250"/></a>
            	    			    <div class="detail">
            	    			    <a href="/product/<%= p.getId() %>" target="_blank"><font class="font3"><%= Tools.clearHTML(pp.getSpgdsrcm_gdsname()) %></font></a>
                                    <font class="font1">市场价：<strike><%= Tools.getRoundPrice(p.getGdsmst_saleprice().floatValue()) %></strike></font>&nbsp;&nbsp;&nbsp;<font class="font2">品牌特卖：<%= Tools.getRoundPrice(p.getGdsmst_memberprice().floatValue()) %></font> 
                                    </div>         	    			
            	    			</li>
            	    		<%}
            	    	}
            	    }
            	%>
            	</ul>  
              <%}
         %>
         
        
        </div>
        
        <div class="show">
         <img src="http://images.d1.com.cn/zt2012/Mayczzk/top_06.jpg"/>
              <%
              ArrayList<PromotionProduct> pplist1=PromotionProductHelper.getPProductByCode("7723");
              if(pplist!=null&&pplist.size()>0)
              {%>
            	<ul>
            	<%
            	    for(PromotionProduct pp:pplist1)
            	    {
            	    	if(pp!=null&&pp.getSpgdsrcm_gdsid()!=null&&pp.getSpgdsrcm_gdsid().length()>0&&Tools.isNumber(pp.getSpgdsrcm_gdsid()))
            	    	{
            	    		Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
            	    		if(p!=null)
            	    		{
            	    		    String imgUrl="";
            	    		    if(p.getGdsmst_img200250()!=null&&p.getGdsmst_img200250().length()>0)
            	    		    {
            	    		    	imgUrl="http://images.d1.com.cn"+p.getGdsmst_img200250();
            	    		    }
            	    		    else
            	    		    {
            	    		    	imgUrl=ProductHelper.getImageTo200(p);
            	    		    }
            	    		%>
            	    			<li>
            	    			    <a href="/product/<%= p.getId() %>" target="_blank" style="background:#fff; text-align:center; padding-top:10px; padding-bottom:10px;"><img src="<%= imgUrl %>" width="200" height="250"/></a>
            	    			    <div class="detail">
            	    			    <a href="/product/<%= p.getId() %>" target="_blank"><font class="font3"><%= Tools.clearHTML(pp.getSpgdsrcm_gdsname()) %></font></a>
                                    <font class="font1">市场价：<strike><%= Tools.getRoundPrice(p.getGdsmst_saleprice().floatValue()) %></strike></font>&nbsp;&nbsp;&nbsp;<font class="font2">品牌特卖：<%= Tools.getRoundPrice(p.getGdsmst_memberprice().floatValue()) %></font> 
                                    </div>         	    			
            	    			</li>
            	    		<%}
            	    	}
            	    }
            	%>
            	</ul>  
              <%}
         %>
        </div>
        
   </div>
   
   
   
   
   <!-- 尾部开始 -->
   <%@ include file="/inc/foot.jsp" %>
   <!-- 尾部结束 -->
   </center>
</body>
</html>