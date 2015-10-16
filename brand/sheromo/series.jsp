<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%
   String scontent="";
   String serid="";
   if(!Tools.isNull(request.getParameter("serid"))&&Tools.isNumber(request.getParameter("serid"))){
       serid=request.getParameter("serid");
       if(serid.equals("9"))
       {
    	   scontent="知性OL系列";
       }
       else if(serid.equals("10"))
       {
    	   scontent="丹宁风尚系列";
       }
       else if(serid.equals("11"))
       {
    	   scontent="国际经典系列";
       }
       else
       {
    	   scontent="知性OL系列";
       }
   }
   else {return;}
%>
<html>
<head>
<link href="/res/css/sheromo.css" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<title>诗若漫<%=scontent %>【图片_价格_评价_怎么样】</title>
<meta name="description" content="D1优尚网是国内唯一在线销售诗若漫<%= scontent %>商品，提供诗若漫<%= scontent %>的最新报价、促销、评论、导购、图片等相关信息" />
<meta name="keywords" content="诗若漫<%= scontent %>报价、促销、新闻、评论、导购、图片" />
</head>
<style>
   .fmlist{ width:980px; background:url('http://images.d1.com.cn/images2012/fmdpbg4_1.jpg') repeat-y; margin-top:10px;}
   .fmlist ul{ list-style:bnone; margin:0px;padding:0px;}
   .fmlist ul li {  margin-left:-60px; +margin-left:-64px;height:400px; float:left;}
    .fmlist ul li p{ margin-top:11px; margin-left:35px; width:175px;}
   .fmlist ul li p a { color:#9F486A;}
   .fmlist ul li p span{ display:block; width:80px; text-align:left; float:left;} 
   .fmlist ul li p span font{ font-size:12px; color:#9F486A;;}
    .newbanner1120 {position: fixed;height:35px; background:#fff; line-height:35px; z-index: 20000;top: 0px;text-align: left; width:980px;}
    .stop .newbanner1120 li {width: 45px;float: left;position: relative;margin-top: 0px;background-repeat: no-repeat;background-position: right center;color: white;font-size: 14px;text-align: center;font-family: "微软雅黑";}
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
			 g.removeClass('menu');
			 g.addClass('newbanner1120');
		}
	    else{
	    	 g.removeClass('newbanner1120');
	    	 g.addClass('menu');
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
<div class="sbody">
  <div class="autobody">
    <div class="stop">
	     <div style="height:80px;"></div>
			 <div id="top" class="menu">
			 <ul>      
				<li class="lifestyle" style="width:90px;"><a href="http://sheromo.d1.com.cn/srmindex.htm" style="font-size:16px; ">商品分类</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020010">裙子</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020002">T恤</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020001">衬衫</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020008,020009">裤子</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020006">外套</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020">全部</a></li>
				<li style="width:60px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li style="width:90px; font-size:16px;color: #9D8F86;">搭配指南&nbsp;<font style="font-size:14px">>></font></li>
								<li style="width:115px;" <% if(serid.equals("9")) out.print("class=\"lifestyle\"");%>><a href="http://sheromo.d1.com.cn/srmseries.htm?serid=9&sex=1">知性OL系列</a></li>
				<li style="width:115px;" <% if(serid.equals("10")) out.print("class=\"lifestyle\"");%>><a href="http://sheromo.d1.com.cn/srmseries.htm?serid=10">丹宁风尚系列</a></li>
				<li style="width:115px;" <% if(serid.equals("11")) out.print("class=\"lifestyle\"");%>><a href="http://sheromo.d1.com.cn/srmseries.htm?serid=11">国际经典系列</a></li>
					<li style="width:50px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li ><a href="http://sheromo.d1.com.cn/srmstory.htm">品牌故事</a></li>
				</ul>
				
			 </div>
			 <div class="clear"></div>
	</div>
	<%
         if(serid.equals("9"))
         {%>
        	<img src="http://images.d1.com.cn/images2012/index2012/SEP/srmzx.jpg" style="margin-top:10px;"/> 
         <%}
         else if(serid.equals("10"))
         {%>
        	 <img src="http://images.d1.com.cn/images2012/index2012/SEP/srmdn.jpg" style="margin-top:10px;"/> 
         <%}
         else if(serid.equals("11"))
         {%>
        	 <img src="http://images.d1.com.cn/images2012/index2012/SEP/srmgj.jpg" style="margin-top:10px;"/> 
         <%}
         else
         {%>
        	  <img src="http://images.d1.com.cn/images2012/index2012/SEP/srmzx.jpg" style="margin-top:10px;"/> 
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
									<%}
										}
									}
									%>
									</ul>
									<%
									}
			if(!isscoll){
				%>
                       <li><img src="http://images.d1.com.cn/images2012/sheromo/sample.png" width="243" height="350"></li>
                       <li><img src="http://images.d1.com.cn/images2012/sheromo/sample.png" width="243" height="350"></li>
					   <li><img src="http://images.d1.com.cn/images2012/sheromo/sample.png" width="243" height="350"></li>
                       <li><img src="http://images.d1.com.cn/images2012/sheromo/sample.png" width="243" height="350"></li>
					   <li><img src="http://images.d1.com.cn/images2012/sheromo/sample.png" width="243" height="350"></li>
                       <li><img src="http://images.d1.com.cn/images2012/sheromo/sample.png" width="243" height="350"></li>
              <%} }%>      
                    
                     </ul>
                     </td></tr></table>
			     </div>
				
		
		   <div class="clear"></div>
	</div>

</div>
  <% }
     %>
<%@include file="/inc/foot.jsp" %>
</body>
</html>
