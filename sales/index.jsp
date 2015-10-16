<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚特卖会-周周有特卖，天天有秒杀！</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/sales.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" >
jQuery(function($){
	var indexs = 0;
	$(".showon").toggle(function(){
		indexs = $(".showon").index(this);
		$(".showon").eq(indexs).html("<img src='http://images.d1.com.cn/images2011/sales/tm002.gif' />");
		$(".lin").eq(indexs).removeClass("brandhid");
	},function(){
		$(".showon").eq(indexs).html("<img src='http://images.d1.com.cn/images2011/sales/tm002.gif' />");
		$(".lin").eq(indexs).addClass("brandhid");
	});
});
//限时抢购
var the_s=new Array();

function $getid(id)
{
    return document.getElementById(id);
}

function view_time(the_s_index,objid){

    if(the_s[the_s_index]>=0){
        var the_D=Math.floor((the_s[the_s_index]/3600)/24)
        var the_H=Math.floor((the_s[the_s_index]-the_D*24*3600)/3600);
        var the_M=Math.floor((the_s[the_s_index]-the_D*24*3600-the_H*3600)/60);
        var the_S=(the_s[the_s_index]-the_H*3600)%60;
        html = "倒计时: ";
        if(the_D!=0) html += '<span class="daynum">'+the_D+"</span>天";
        if(the_D!=0 || the_H!=0) html += '<span class="hour">'+(the_H)+"</span>小时";
        if(the_D!=0 || the_H!=0 || the_M!=0) html += '<span class="minute">'+the_M+"</span>分";
        html += '<span class="second">'+the_S+"</span>秒";
        $getid(objid).innerHTML = html;
        the_s[the_s_index]--;
    }else{
        $getid(objid).innerHTML = "已结束";

    }
}
</script>
</head>
<body>
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<!-- 中部开始 -->
<div class="tmhbody">
	<!--特卖会品牌开始-->
	
	<div class="tmhbrand mgt8">
	     <div class="brandlist" align="center">
		 <div class="brandtitle"><img src="http://images.d1.com.cn/images2011/sales/tm001.gif" width="74" height="60" /></div>
		 <div class="lin brandhid">
		   <ul>
		   <% 
		   request.setAttribute("imgTextCode", "2427");
	%>
			<jsp:include page="getImgText.jsp" flush="true" /> 
		   </ul>
		   <div class="clear"></div>
		   </div>
		    <div class="clear"></div>
	  </div>
	  <DIV class=showon><img src="http://images.d1.com.cn/images2011/sales/tm002.gif" /></DIV>
	</div>
	<!--特卖会品牌结束-->
	<!--特卖区域开始-->
	<div class="tmharea">
		<!--特卖列表开始-->
		<div class="tmhlist">
		   <div class="tmviews">
		    <dl>
				<%
				 SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				 String	nowtime= DateFormat.format(new Date());
				ArrayList<ProductSale> productSaleList=ProductSaleHelper.getTodayProductSaleList();
				if(productSaleList!=null){
					 int i=1;
					 for(ProductSale productSale:productSaleList){
						
						 String	endtime= DateFormat.format(productSale.getSalesmst_endtime());

					%>
		      <dt class="mgt8">
		      <span class="tmhvtl"><%=productSale.getSalesmst_title() %></span>
		      <span class="tmhvtr" id=tjjs_<%=i%>></span>
		      <SCRIPT language=javascript>
var startDate= new Date("<%=nowtime%>");var endDate= new Date("<%=endtime%>");the_s[<%=i%>]=(endDate.getTime()-startDate.getTime())/1000;
setInterval("view_time(<%=i%>,'tjjs_<%=i%>')",1000);</SCRIPT>
			   </dt>
			  <dd><a href="salesviews.jsp?id=<%=productSale.getId()%>" target="_blank">
			  <img src="<%=productSale.getSalesmst_indeximg() %>" border="0" /></a></dd>
			  <%
			  i++;
					 }
				}
			  %>
		     </dl>
		   </div>
		</div>
		<!--特卖列表结束-->
		<!--特卖限制开始-->
		<div class="tmhtj">
		  <dl>
		     <dt><span class="xstj">限时特价</span><span class="sale">&nbsp;&nbsp;sale</span></dt>
			 <dd>
			  <% 
		   request.setAttribute("imgCode", "2428");
	%>
			<jsp:include   page= "function.jsp"   />   
			 </dd>
		  </dl>
		</div>
		<!--特卖限制结束-->
	</div>
	<!--特卖区域结束-->
</div>
<div style="clear:both;"></div>
<!-- 中部结束 -->
<%@include file="/inc/foot.jsp"%>
</body>
</html>