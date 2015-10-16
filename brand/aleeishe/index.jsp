<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/brand/public.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【小栗舍】_小栗舍官网_D1优尚网旗下品牌_让人着迷的可爱女人之魅力城堡</title>
<meta name="description" content="D1优尚网是国内唯一在线销售小栗舍商品，提供小栗舍产品的最新报价、小栗舍评论、小栗舍导购、小栗舍图片等相关信息" />
<meta name="keywords" content="小栗舍, 小栗舍网购" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="/res/css/aleeishe.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript">
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

<div class="albody">
	<div class="autobody">
	     <!--品牌头部分开始-->
         <div class="altop">
		     <div style="height:92px;"></div>
			 <div class="menur">
			 <ul>      
				<li class="lifestyle" style="width:90px;"><a href="http://aleeishe.d1.com.cn/asindex.htm" style="font-size:16px; ">商品分类</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020010">裙子</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020002">T恤</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020001">衬衫</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020008,020009">裤子</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020006">外套</a></li>
				<li><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020">全部</a></li>
				<li style="width:50px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li style="width:90px; font-size:16px;">搭配指南&nbsp;<font style="font-size:14px">>></font></li>
				<li style="width:115px;"><a href="http://aleeishe.d1.com.cn/asseries.htm?serid=5&sex=1">精致甜美系列</a></li>
				<li style="width:115px;" ><a href="http://aleeishe.d1.com.cn/asseries.htm?serid=7&sex=1">俏女孩系列</a></li>
				<li style="width:115px;"><a href="http://aleeishe.d1.com.cn/asseries.htm?serid=6">优雅淑女系列</a></li>
				<li style="width:55px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li ><a href="http://aleeishe.d1.com.cn/asbrand.htm">品牌故事</a></li>
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
		   <!--左侧结束-->
					<div class="right">
					<div >
					  <%
	     String str1=PromotionHelper.getImgPromotion("3416",1);
	    if(Tools.isNull(str1)) {
	    	%>
	    		<img src="http://images.d1.com.cn/images2012/aleeishe/images/001.jpg" width="765" height="400"/>	
	    	<% }else{
	    		out.print(str1);
	    	}
	     %>
				</div>
				 <!--  	<div class="hotlist1">
                     <ul>
                 <%
	   // ArrayList<Promotion> list=PromotionHelper.getBrandListByCode("2976",30);
		//if(list!=null && list.size()>0){
		//	for(int i=0;i<list.size();i++){
			//	Promotion promotion=list.get(i);
				%>
				<li>
				<%
				//if(!promotion.getSplmst_url().equals("#")){%>
				<a href="<%//=PromotionHelper.getPathUrl(0,StringUtils.encodeUrl(promotion.getSplmst_url()))%>" target="_blank">
			<%//} %>
			<img src="<%//=promotion.getSplmst_picstr() %>"  border="0" />
			<% //if(!promotion.getSplmst_url().equals("#")){%>
				</a>
			<%//}%>
			</li>
			<%//}
		//}
	    %> 
                    
                     </ul>
                     <div class="clear"></div>
			        </div>--> 

				
				
				<!-- 商品推荐 调整为：热门推荐8504、裙装7861、毛衫7859、T恤8051、衬衫8505、外套7858、裤子7860-->
				<div class="plist">
	                <a href="#" target="_blank" style="color:#712549;"><h3>热门推荐</h3></a>
	                <div class="newlist">
	                <%= getProduct("8504",6) %>
	                </div>
	              </div>
	             <div class="plist">
	                <a href="http://www.d1.com.cn/brand/aleeishe/categorydisplay.jsp?productsort=020010" target="_blank" style="color:#712549;"><h3>裙装</h3></a>
	                <div class="newlist">
	                <%= getProduct("7861",6) %>
	                </div>
	              </div>
	            
	          <div class="plist">
	                <a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020002" target="_blank" style="color:#712549;"><h3>T恤</h3></a>
	                <div class="newlist">
	                <%= getProduct("8051",6) %>
	                </div>
	              </div>
	              <div class="plist">
	                <a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020001" target="_blank" style="color:#712549;"><h3>衬衫</h3></a>
	                <div class="newlist">
	                <%= getProduct("8505",6) %>
	                </div>
	              </div>
	                 <div class="plist">
	                <a href="http://www.d1.com.cn/brand/aleeishe/categorydisplay.jsp?productsort=020008,020009" target="_blank" style="color:#712549;"><h3>裤子</h3></a>
	                <div class="newlist">
	                <%= getProduct("7860",6) %>
	                </div>
	              </div>
	              <div class="plist">
	                <a href="http://www.d1.com.cn/brand/aleeishe/categorydisplay.jsp?productsort=020004" target="_blank" style="color:#712549;"><h3>毛衫</h3></a>
	                <div class="newlist">
	                <%= getProduct("7859",6) %>
	                </div>
	              </div>
				<div class="plist">
	                <a href="http://www.d1.com.cn/brand/aleeishe/categorydisplay.jsp?productsort=020006,020002006" target="_blank" style="color:#712549;"><h3>外套</h3></a>
	                <div class="newlist">
	                <%= getProduct("7858",6) %>
	                </div>
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
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>

