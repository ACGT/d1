<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/html/public.jsp"%>
<%@include file="/brand/public.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> 【Feel Mind】_FM品牌官网_D1优尚网旗下品牌</title>
<meta name="description" content="D1优尚网是国内唯一在线销售Feel Mind/FM男装商品,提供Feel Mind/FM男装产品的最新报价、评论、导购、图片等相关信息" />
<meta name="keywords" content="Feel Mind/FM, Feel Mind/FM男装报价、促销、新闻、评论、导购、图片" />

<link href="/res/css/feelmind.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />

<style>
 /*滚动图片样式*/
	.scrollimglist{ width:740px;  height:365px; margin-top:10px; margin-left:12px; _margin-left:5px; }
	.container{ overflow:hidden;  width:740px; height:365px; }
	#CenterImg{overflow:hidden;padding:1px;}
	#CenterImg img{ border:none;}
	#ImgTable{table-layout:auto;}
	#ImgTable tr td a img{margin:1px;margin-top:0px;padding:0px;}
	#idNum{float:right;position:absolute;top:342px;right:18px;}
	#idNum li{float:left;list-style:none;color: #000;text-align: center;line-height: 15px;width: 15px;height: 15px;	font-family:"微软雅黑";font-size: 13px; font-weight:bold; cursor: pointer;margin: 2px;background:#f3f3f5;}
	#idNum li.on{line-height: 15px;width: 17px;height: 16px;color:#fff;background:#8a2b3f;}
</style>

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
			$.post("/html/resulthtml.jsp",{"gdsid":gdsid,"count":count},function(data){
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


<div class="fbody">
  <div class="autobody">
     <!--品牌头部分开始-->
     <div class="ftop">
	 <div class="fmenu">
	   <table height="90" width="980" class="newtable">
	       <tr><td colspan="2" height="40"></td></tr>
	       <tr><td width="800"></td><td><a href="http://www.d1.com.cn/zhuanti/20120620tyd/tyd.jsp" target="_blank" >实体体验店</a>
	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	       <a href="http://feelmind.d1.com.cn/fmbrand.htm" target="_blank" >品牌故事</a>
	       </td></tr>
	      
	   </table>
	    <div class="fmenul">
	     <ul>      
				<li class="lifestyle" style="width:90px;"><a href="http://feelmind.d1.com.cn/fmman.htm" style="font-size:16px; ">FM首页</font></a></li>
				<li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030" style="font-size:16px; ">男装</a></li>
				<li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020" style="font-size:16px; ">女装</a></li>
				<li><a href="http://feelmind.d1.com.cn/fmlovels.htm" style="font-size:16px; ">情侣装</a></li>
                <li style="width:60px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li style="width:90px; font-size:16px;">搭配指南&nbsp;<font style="font-size:14px">>></font></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=1&sex=1">加州男装</a></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=1&sex=2">加州女装</a></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=3&sex=1">西部男装</a></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=3&sex=2">西部女装</a></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=4&sex=1">学院男装</a></li>
				</ul>
        </div>
		</div>
		 <div class="clear"></div>
     </div>
     <div class="fmanc">
	   <!--左侧开始-->
	   <div class="fmancl">
	       <div class="fclsmenu">
		     <ul class="one">
		     <%
		     ArrayList<Gdsser> Gdsserlist= GdsserHelper.getGdsserByBrandid("987");
	if(Gdsserlist!=null && Gdsserlist.size()>20){
		for(Gdsser g:Gdsserlist){
			%>
			<li style="line-height:26px;"><a  style="font-size:15px;" href="series.jsp?serid=<%=g.getId() %>&sex=1" ><%=g.getGdsser_title().trim() %></a> <img src="http://images.d1.com.cn/images2012/feelmind/images/selected.png"/></li>
		<%}
	}%>
	         </ul>
	        
	        <%
			request.setAttribute("brandname", "FEEL MIND");
			request.setAttribute("rackcode", "03");
			%>
	         <jsp:include   page= "category.jsp"   />
		   </div>
	   </div>
	   <!--左侧结束-->
	    <!--右侧开始-->
	   <div class="fmancr">
	      <script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/YSImgScoll.js")%>"></script>
	             
	      <div class="scrollimglist">       
	                <script>ShowCenter(<%= ScrollImg("3126") %>,<%= ScrollText("3126") %>)</script>
	      </div>
		 <div class="bot">
	       <ul>
	       <%
	       ArrayList<Promotion> list=PromotionHelper.getBrandListByCode("3127",100);
	   	if(list!=null && list.size()>0){
	   		for(Promotion promotion:list){
	   			if(!promotion.getSplmst_url().equals("#")){%>
				<li><a href="<%=PromotionHelper.getPathUrl(0,StringUtils.encodeUrl(promotion.getSplmst_url()))%>" target="_blank">
			<%} %>
			<img src="<%=promotion.getSplmst_picstr() %>"  alt="<%=promotion.getSplmst_name() %>" border="0" />
			<% if(!promotion.getSplmst_url().equals("#")){%>
				</a></li>
			<%}
	   		}
	   	}else{%>   
	    	     <li><img src="http://images.d1.com.cn/images2012/feelmind/images/004.jpg" width="730" height="457"/></li>
			  <li><img src="http://images.d1.com.cn/images2012/feelmind/images/004.jpg" width="730" height="457"/></li>
	      <% }
	   	%>
		    
	       </ul>
		 </div>
		 <!-- 商品推荐 -->
				<div class="plist">
	                <a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030002" target="_blank" style="color:#919191;"><h3>T恤</h3></a>
	                <div class="newlist">
	                <%= getProduct("7866",6) %>
	                </div>
	              </div>
	              <div class="plist">
	                <a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030005" target="_blank" style="color:#919191;"><h3>卫衣</h3></a>
	                <div class="newlist">
	                <%= getProduct("7867",6) %>
	                </div>
	              </div>
	              <div class="plist">
	                <a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030001" target="_blank" style="color:#919191;"><h3>衬衫</h3></a>
	                <div class="newlist">
	                <%= getProduct("7868",6) %>
	                </div>
	              </div>
	              <div class="plist">
	                <a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030008,030009&order=3" target="_blank" style="color:#919191;"><h3>裤子</h3></a>
	                <div class="newlist">
	                <%= getProduct("7869",6) %>
	                </div>
	              </div>
	              <div class="plist">
	                <a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030006" target="_blank" style="color:#919191;"><h3>外套</h3></a>
	                <div class="newlist">
	                <%= getProduct("8050",6) %>
	                </div>
	              </div>
	   </div>
	   <!--右侧结束-->
	    <div class="clear"></div>
	 </div>
	 
  </div>
</div>
<%@include file="foot.jsp" %>
</body>
</html>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
