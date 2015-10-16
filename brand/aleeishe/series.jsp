<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
   String scontent="";
   String serid="";
   if(!Tools.isNull(request.getParameter("serid"))&&Tools.isNumber(request.getParameter("serid"))){
	   serid=request.getParameter("serid");
       if(serid.equals("5"))
       {
    	   scontent="精致甜美系列";
       }
       else if(serid.equals("6"))
       {
    	   scontent="优雅淑女系列";
       }
       else if(serid.equals("7"))
       {
    	   scontent="俏女孩系列";
       }
       else
       {
    	   scontent="精致甜美系列";
       }
   }
   else { return;}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="/res/css/aleeishe.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<title>小栗舍<%=scontent %>【图片_价格_评价_怎么样】</title>
<meta name="keywords" content="小栗舍<%= scontent %>系列报价、促销、新闻、评论、导购、图片" />
<meta name="description" content="D1优尚网是国内唯一在线销售小栗舍<%= scontent %>系列商品，提供小栗舍<%= scontent %>系列的最新报价、促销、评论、导购、图片等相关信息" />

<style>
   .fmlist{ width:980px; background:url('http://images.d1.com.cn/images2012/fmdpbg3_1.jpg') repeat-y; margin-top:10px;}
   .fmlist ul{ list-style:bnone; margin:0px;padding:0px;}
   .fmlist ul li { margin-left:-60px; +margin-left:-64px; height:400px; float:left;}
    .fmlist ul li p{ margin-top:11px; margin-left:35px; width:175px;}
   .fmlist ul li p a { color:#9F486A;}
   .fmlist ul li p span{ display:block; width:80px; text-align:left; float:left;} 
   .fmlist ul li p span font{ font-size:12px; color:#9F486A;;}
   .newbanner1120 {position: fixed; width:980px;z-index: 20000;top: 0px;text-align: left;background:#fff;height:35px; line-height:35px;
filter:alpha(opacity=70); /*IE*/
-moz-opacity:0.7; /*MOZ , FF*/
opacity:0.7; /*CSS3, FF1.5*/	
	background-color: #000000;}
	.newbanner1120 li {width: 45px;float: left;position: relative;margin-top: 0px;color: white;font-size: 14px;text-align: center;font-family: "微软雅黑";}
	.newbanner1120 li a {color: white;font-size: 14px;text-decoration: none;text-transform: uppercase;padding: 1px 9px;white-space: nowrap;font-family: "微软雅黑";}
   </style>
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
    	    //导航栏浮动
    		var m=$("#top").offset().top;  
    		$(window).bind("scroll",function(){
    	    var i=$(document).scrollTop(),
    	    g=$("#top");
    		if(i>=m)
    		{
    			g.removeClass('menur');
    			 g.addClass('newbanner1120');
    		}
    	    else{
    	    	 g.removeClass('newbanner1120');
    	    	 g.addClass('menur');
    	    	 }
    		});
    	});
		</script>
</head>

<body>
<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<div class="clear"></div>
	<!-- 头部结束-->


     <%
    
     if(!Tools.isNull(request.getParameter("serid"))){
    	 %> 
<div class="albody">
	<div class="autobody" style=" background:#fbd2e4;">
	     <!--品牌头部分开始-->
        <div class="altop">
		     <div style="height:92px;"></div>
			 <div class="menur" id="top">
			 <ul>      
				<li style="width:90px;"><a href="http://aleeishe.d1.com.cn/asindex.htm" style="font-size:16px; ">商品分类</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020010">裙子</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020002">T恤</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020001">衬衫</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020008,020009">裤子</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020006">外套</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020">全部</a></li>
				<li style="width:55px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li style="width:90px; font-size:16px;">搭配指南&nbsp;<font style="font-size:14px">>></font></li>
				<li style="width:115px;" <% if(serid.equals("5")) out.print("class=\"lifestyle\"");%>><a href="http://aleeishe.d1.com.cn/asseries.htm?serid=5&sex=1">精致甜美系列</a></li>
				<li style="width:115px;" <% if(serid.equals("7")) out.print("class=\"lifestyle\"");%>><a href="http://aleeishe.d1.com.cn/asseries.htm?serid=7&sex=1">俏女孩系列</a></li>
				<li style="width:115px;" <% if(serid.equals("6")) out.print("class=\"lifestyle\"");%>><a href="http://aleeishe.d1.com.cn/asseries.htm?serid=6">优雅淑女系列</a></li>
				<li style="width:50px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li><a href="http://aleeishe.d1.com.cn/asbrand.htm">品牌故事</a></li>
				</ul>
			 </div>
	         <div class="menu">
			 </div>
		 </div>
	
		 <%
         if(serid.equals("5"))
         {%>
        	<img src="http://images.d1.com.cn/images2012/aleeishe/images/ALEEISHE-01.jpg" style="margin-top:10px;"/> 
         <%}
         else if(serid.equals("7"))
         {%>
        	 <img src="http://images.d1.com.cn/images2012/index2012/AUGUST/bgxls.jpg" style="margin-top:10px;"/> 
         <%}
         else if(serid.equals("6"))
         {%>
        	 <img src="http://images.d1.com.cn/images2012/aleeishe/images/ALEEISHE-02.jpg" style="margin-top:10px;"/> 
         <%}
         else
         {%>
        	  <img src="http://images.d1.com.cn/images2012/aleeishe/images/ALEEISHE-01.jpg" style="margin-top:10px;"/> 
         <%}
        
     %>
		
		
			
	  <div class="fmlist">
	  <table><tr><td>
		     <%
		    ArrayList<Gdsser> Gdsserlist= GdsserHelper.getGdsserByBrandid("1690");
		    Gdsser g=GdsserHelper.getById(request.getParameter("serid"));	
		    if(g!=null){
			boolean isscoll=false;
			ArrayList<Gdscoll> scolllist=GdscollHelper.getGdscollBysceneid(g.getId());
			if(scolllist!=null && scolllist.size()>0){
				%>
				<ul>
				<%
				isscoll=true;
				int count=0;
				for(int i=0;i<scolllist.size();i++){
					Gdscoll scoll=scolllist.get(i);
					if(scoll!=null&&scoll.getGdscoll_flag()!=null&&scoll.getGdscoll_flag().longValue()==1){
						//查看搭配详细
						int counts=0;
   					    ArrayList<Gdscolldetail> gdetaillist=GdscollHelper.getGdscollBycollid1(scoll.getId());
						if(gdetaillist!=null)
						{
							for(Gdscolldetail gd:gdetaillist)
							{
								Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
								if(p!=null&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
									counts++;
									
								}
							}
						}
						
						if(counts>1){
						
						count++;
						if(count%5==1)
						{%>
							<li style="margin-left:0px;">
						<%}
						else
						{%>
							<li>
						<%}
				%>
				<a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%=scoll.getId() %>" target="_blank"><img src="http://images1.d1.com.cn<%=scoll.getGdscoll_brandimg() %>" border="0" /></a>
				<%  
				   ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid(scoll.getId());
				   if(gdlist!=null&&gdlist.size()>0)
				   {
					   int newsum=0;
					   out.print("<p>");
					   for(Gdscolldetail gd:gdlist)
					   {
						   if(gd!=null&&gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1&&gd.getGdscolldetail_gdsid()!=null&&gd.getGdscolldetail_gdsid().length()>0)
						   {
							   newsum++;
							   Product product=ProductHelper.getById(gd.getGdscolldetail_gdsid());
							   if(product!=null&&product.getGdsmst_ifhavegds().longValue()==0&&product.getGdsmst_validflag().longValue()==1)
							   {%>
								   <span><a href="http://www.d1.com.cn/product/<%= product.getId()%>" target="_blank"><%= gd.getGdscolldetail_title()%></a>&nbsp;<font><%= Tools.getFormatMoney(product.getGdsmst_memberprice().floatValue())%></font></span>
							  <% }
						   }
						   
					   }
					   out.print("</p>");	
				   }  
				   %>
				</li>
				<%
				}					
					}
				}
				%>
				</ul>
				<%
				}
			if(!isscoll){
				%>
				<li><img src="http://images.d1.com.cn/images2012/aleeishe/images/aleeishe-243X350.png" width="243" height="350"/></li>
                       <li><img src="http://images.d1.com.cn/images2012/aleeishe/images/aleeishe-243X350.png" width="243" height="350"/></li>
					   <li><img src="http://images.d1.com.cn/images2012/aleeishe/images/aleeishe-243X350.png" width="243" height="350"/></li>
                       <li><img src="http://images.d1.com.cn/images2012/aleeishe/images/aleeishe-243X350.png" width="243" height="350"/></li>
					   <li><img src="http://images.d1.com.cn/images2012/aleeishe/images/aleeishe-243X350.png" width="243" height="350"/></li>
                       <li><img src="http://images.d1.com.cn/images2012/aleeishe/images/aleeishe-243X350.png" width="243" height="350"/></li>
			<%}
		}
		%>
		</ul>
		</td></tr></table>
	
		 </div>
	 	<div class="clear"></div>
    <% }
     %>


	</div>
</div>
<div class="clear"></div>
	
	<!-- 尾部开始 -->
	<%@include file="/inc/foot.jsp" %>
	<!-- 尾部结束 -->
</body>
</html>
