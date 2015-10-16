<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="public.jsp"%>
<%@include file="/html/public.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【正品行货】毛衣/毛衣_毛衣品牌_价格_图片-D1优尚网</title>
<meta name="Description" content="D1优尚网毛衣,毛衣频道，提供最新款毛衣品牌、毛衣价格、毛衣图片以及毛衣搭配图。想通过网上购物买到名牌毛衣，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网,毛衣" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/channel.css")%>" rel="stylesheet" type="text/css" media="screen" />

</head>

<body>
<div id="wrapper">
		<!--头部-->
		<%@include file="/inc/head.jsp" %>
		<!-- 头部结束-->
		
		<!-- 中间内容 -->		
		<div class="center">
		<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/scrollimg.js")%>"></script>
		<div class="dh">
		   <table width="980" height="42">
		       <tr><td width="140" style="padding-left:15px;font-size:20px; font-family:'微软雅黑';  color:#fff;">
		       毛衣专区
		       </td><td width="700">
		       <ul>
		       <%
		           ArrayList<Promotion> tlist=PromotionHelper.getBrandListByCode("3287",9);
		           if(tlist!=null&&tlist.size()>0)
		           {
		        	   for(Promotion p:tlist)
		        	   {
		        		   if(p!=null)
		        		   {%>
		        			   <li><a href="<%= p.getSplmst_url() %>" target="_blank"><%= p.getSplmst_name() %></a></li>
		        		   <%}
		        	   }
		           }
		       %>
		          
		       </ul>
		       </td><td><a href="http://www.d1.com.cn/result.jsp?productsort=020004,030004" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/nov/allyrf.jpg"/></a></td></tr>
		   </table>
		</div>
		<div class="clear"></div>
		  <div class="scrollimglist">
		 
                <script>ShowCenter(<%= ScrollImg("3293") %>,<%= ScrollText("3293") %>,980,400,3000)</script>     </div>
         
            <!--滚动图结束-->
		 
		 <div class="clear"></div>
		  <div class="gdsmstlist">
		     <div class="gtitle">
		         <h3><a href="http://www.d1.com.cn/result.jsp?productsort=020004" target="_blank">女士毛衣</a></h3>
		     </div>
		     <%=getProductlist1("020004",16) %>		     
		 </div>
		 
		 <div class="gdsmstlist">
		     <div class="gtitle">
		         <h3><a href="http://www.d1.com.cn/result.jsp?productsort=030004" target="_blank">男士毛衣</a></h3>
		     </div>
		     <%=getProductlist1("030004",16) %>		     
		 </div>
		 
		
		 </div>
		 
		<!-- 中间内容结束 -->
		<div class="clear"></div>
		
        <!-- 尾部 -->
		<%@include file="../../inc/foot.jsp" %>
		<!-- 尾部结束 -->
</div>
</body>

</html>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script> 
<script type="text/javascript" language="javascript"> 
 $(document).ready(function() {
        //$(".gdmstlist_sub").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
    });
</script>