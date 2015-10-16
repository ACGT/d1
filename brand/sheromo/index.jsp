<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/brand/public.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="/res/css/sheromo.css" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<title>【诗若漫】_诗若漫官网_D1优尚网旗下品牌</title>
<meta name="description" content="D1优尚网是国内唯一在线销售诗若漫商品，提供诗若漫产品的最新报价、诗若漫评论、诗若漫导购、诗若漫图片等相关信息" />
<meta name="keywords" content="诗若漫, 诗若漫网购" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="/res/css/aleeishe.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
 <script language=javascript>
 function scrollresult(imglistobj,cicleobj,flag)
 {
     var t = n = 0; 
     var count=$(imglistobj+" span").length;
 	$(imglistobj+" span:not(:first-child)").hide();
 	$("#pre2012"+flag).click(function(){
 		var obj=$(imglistobj+" span").filter(":visible").attr("attr");
 		if(obj-1<=0) obj=count+1;
 		obj=obj-1;
 		$(imglistobj+" span").filter(":visible").hide().parent().children().eq(obj-1).fadeIn(500);
 		$("#commensapn"+flag).css("display","block");
 	});
 	$("#next2012"+flag).click(function(){
 		var obj=$(imglistobj+" span").filter(":visible").attr("attr");
 		if(obj>=count) obj=0;
 		obj=obj-1;
 		$(imglistobj+" span").filter(":visible").hide().parent().children().eq(obj+1).fadeIn(500);
 		$("#commensapn"+flag).css("display","block");
 	});
 	}

 function mdmover(gdsid,flag)
 {
 	var obj=$("#floatdp"+gdsid+flag);
 	obj.css("display","block");
 	}


  function mdm_out(gdsid,flag)
 {
 	 $("#floatdp"+gdsid+flag).css("display","none");
 	
 }

 function getFloatdp(gdsid,count)
 {
 	var obj=$("#floatdp"+gdsid+count);
 	if(obj!=null)
 	{
 		    $(obj).addClass("floatdp");//css("background","#fff");
 			$(obj).html("<img src='http://images.d1.com.cn/images2012/New/Loading.gif' style=\"margin-left:120px; margin-top:120px; margin-bottom:120px; \"/>");
 			$.post("/html/brandhtml.jsp",{"gdsid":gdsid,"count":count},function(data){
 				$(obj).html(data);
 				$(obj).removeClass("floatdp");
 				$(obj).addClass("floatdp1");
 				//$(obj).css("background","");
 				//$(obj).addClass("floatdp");
 				//$(obj).css("background-image","url('http://images.d1.com.cn/images2012/index2012/xsj1.png') no-repeat");
 				//$(obj).css("background-position","right 315px;");
 				//$(obj).css("margin-top","0px");
 			});
 	
     }
 }

 function mdm_over(gdsid,flag)
 {
 	var obj=$("#floatdp"+gdsid+flag);
 	if(obj!=null)
 		{
 		   getFloatdp(gdsid,flag);
 		   obj.css("display","block");
 		}
     
 }
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
	});
		</script>
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
			  <ul>      <!-- 裙装  T恤 衬衫 毛衫 裤子 外套 -->
				<li class="lifestyle" style="width:90px;"><a href="http://sheromo.d1.com.cn/srmindex.htm" style="font-size:16px; ">商品分类</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020010">裙子</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020002">T恤</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020001">衬衫</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020008,020009">裤子</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020006">外套</a></li>
				<li><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020">全部</a></li>
				<li style="width:60px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li style="width:90px; font-size:16px;color: #9D8F86;">搭配指南&nbsp;<font style="font-size:14px">>></font></li>
								<li style="width:115px;"><a href="http://sheromo.d1.com.cn/srmseries.htm?serid=9&sex=1">知性OL系列</a></li>
				<li style="width:115px;"><a href="http://sheromo.d1.com.cn/srmseries.htm?serid=10">丹宁风尚系列</a></li>
				<li style="width:115px;"><a href="http://sheromo.d1.com.cn/srmseries.htm?serid=11">国际经典系列</a></li>
				<li style="width:50px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li ><a href="http://sheromo.d1.com.cn/srmstory.htm">品牌故事</a></li>
				</ul>
				
			 </div>
			 <div class="clear"></div>
	</div>
	
	 
	<!--列表开始-->
	<div class="scontent">
	<table><tr><td>
	    <div class="left">
		<!--left-->
			   <div class="fclsmenu">
				 <ul class="one">
				  <%
		     ArrayList<Gdsser> Gdsserlist= GdsserHelper.getGdsserByBrandid("1969");
	if(Gdsserlist!=null && Gdsserlist.size()>20){
		for(Gdsser g:Gdsserlist){
			%>
			<li style="line-height:26px;"><a  style="font-size:15px;" href="series.jsp?serid=<%=g.getId() %>&sex=1" ><%=g.getGdsser_title().trim() %></a> <img src="http://images.d1.com.cn/images2012/feelmind/images/selected.png"/></li>
		<%}
	}%>  
				 </ul>
				  <%
					String flagbrand=session.getAttribute("flaghead")==null?"2":session.getAttribute("flaghead").toString();
			        
				    request.setAttribute("flag",flagbrand);
					request.setAttribute("rackcode", "020");					
			%>
	        <jsp:include   page= "category1.jsp"   />
			   </div>
		   </div>
		   <!--left  end-->
		   <!--right-->
		   <div class="right">
					<div class="pd10">
					  <%
	     String str1=PromotionHelper.getImgPromotion("2992",1);
	    if(!Tools.isNull(str1)) {
		    		out.print(str1);
	    	}
	     %>
					
					</div>
					<!--  <div class="hotlist">
                     <ul>
                      <%
	  //  ArrayList<Promotion> list=PromotionHelper.getBrandListByCode("2993",30);
		//if(list!=null && list.size()>0){
			//for(int i=0;i<list.size();i++){
			//	Promotion promotion=list.get(i);
				%>
				<li>
				<%
				//if(!promotion.getSplmst_url().equals("#")){%>
				<a href="<%//=PromotionHelper.getPathUrl(0,StringUtils.encodeUrl(promotion.getSplmst_url()))%>" target="_blank">
			<%//} %>
			<img src="<%//=promotion.getSplmst_picstr() %>"   border="0" width="243" height="350"/>
			<% //if(!promotion.getSplmst_url().equals("#")){%>
				</a>
			<%//}%>
			</li>
			<%//}
		//}
	    %>
             
                     </ul>
			     </div>-->
	
		
		   <!-- 商品推荐 调整：裙装7865、毛衫7863、外套7862、T恤8049、衬衫8506、裤装7864-->
		        <div class="plist">
		           <a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020010" target="_blank"> <h3>裙装</h3></a>
		           <div class="newlist">
		              <%= getProduct("7865",6) %>
		           </div>
		        </div>
		     
	              <div class="plist">
	                <a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020002" target="_blank" style="color:#58412F;"><h3>T恤</h3></a>
	                <div class="newlist">
	                <%= getProduct("8049",6) %>
	                </div>
	              </div>
	              <div class="plist">
	                <a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020001" target="_blank" style="color:#58412F;"><h3>衬衫</h3></a>
	                <div class="newlist">
	                <%= getProduct("8506",6) %>
	                </div>
	              </div>
	              <div class="plist">
	                <a href="http://www.d1.com.cn/brand/sheromo/categorydisplay.jsp?productsort=020008,020009" target="_blank" style="color:#58412F;"><h3>裤子</h3></a>
	                <div class="newlist">
	                <%= getProduct("7864",6) %>
	                </div>
	              </div>
	                 <div class="plist">
	                <a href="http://www.d1.com.cn/brand/sheromo/categorydisplay.jsp?productsort=020004" target="_blank" style="color:#58412F;"><h3>毛衫</h3></a>
	                <div class="newlist">
	                <%= getProduct("7863",6) %>
	                </div>
	              </div>
		        
				<div class="plist">
	                <a href="http://www.d1.com.cn/brand/sheromo/categorydisplay.jsp?productsort=020006,020002006" target="_blank" style="color:#58412F;"> <h3>外套</h3></a>
	                <div class="newlist">
	                <%= getProduct("7862",6) %>
	                </div>
	              </div>
	              
	              
	   </div>
	      <!--right-->
	         <div class="clear"></div>
		</td></tr></table>
		   </div>
		
		
	</div>
	<!--列表结束-->
  </div>
</div>
<%@include file="/inc/foot.jsp" %>
</body>
</html>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
