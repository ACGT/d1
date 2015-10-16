<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>庆祝D1优尚网改版 全站2重惊喜满额免费送-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gblistCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">
function CheckForm(obj){
var productid=$(obj).attr("attr");
$.ajax({
    type: "post",
    dataType: "text",
    contentType: "application/x-www-form-urlencoded;charset=UTF-8",
    url: "/ajax/flow/checkCart.jsp",
    cache: false,
    data:{
    	productid: productid
   	 },error: function(XmlHttpRequest, textStatus, errorThrown){
      //  $.alert('修改信息失败！');
    },success: function(msg){
    	//alert(msg);
    	 if(msg==0){
    		$.alert("参数不正确！");
    	 }else  if(msg==1){
    		$.alert("该活动已结束！");
    	 }else  if(msg==2){
    		$.alert("您的购物车中已有该商品！");
    	 }else  if(msg==3){
    		 $.inCart1(obj);
    	 }
    	
    }
    }
)

  //  $.inCart(obj,{ajaxUrl:'/ajax/flow/gbInCart.jsp?productid='+productid,width:400,align:'center'});
}
var lasttime=0;

function view_time2(){

    if(lasttime>0){
        var the_D=Math.floor((lasttime/3600)/24)
        var the_H=Math.floor(lasttime/3600);
        var the_M=Math.floor((lasttime-the_H*3600)/60);
        var the_S=(lasttime-the_H*3600)%60;
        //if(the_D!=0) html += '<span class="daynum">'+the_D+"</span>天";
        if(the_D!=0 || the_H!=0) {$("#h").text(the_H);}
        if(the_D!=0 || the_H!=0 || the_M!=0) {$("#m").text(the_M);}
        $("#s").text(the_S);
       // $getid(objid).innerHTML = html+html2+html1;
        lasttime--;
    }else{
    	//window.location.reload(true);

    }
}
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<%
String	nowtime="";
String tttime="";
ArrayList<PromotionProduct> list=PromotionProductHelper. getPProduct("7633",1);
if(list!=null && list.size()>0){
	PromotionProduct pp=list.get(0);
	  java.text.DateFormat df=new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
      	nowtime= df.format(new Date());
        tttime =df.format(pp.getSpgdsrcm_enddate());
    
}
%>
<table id="__01" width="980"  border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td style="font-size:0px;">
			<img src="http://images.d1.com.cn/images2012/0428/images/qgb-1_01.jpg" width="489" height="118" alt=""/></td>
		<td colspan="2" rowspan="3"  style="font-size:0px;">
			<a href="###" onclick="CheckForm(this);" attr="01720623"><img src="http://images.d1.com.cn/images2012/0428/images/qgb-1_02.jpg" alt="" width="255" height="420" border="0"/></a></td>
		<td rowspan="3"  style="font-size:0px;">
			<a href="###" attr="01720622" onclick="CheckForm(this);"><img src="http://images.d1.com.cn/images2012/0428/images/qgb-1_03.jpg" alt="" width="236" height="420" border="0"/></a></td>
	</tr>
	<tr>
		<td  style="font-size:0px;" valign="top">
			<img src="http://images.d1.com.cn/images2012/0428/images/qgb-1_04.jpg" width="489" height="133" alt="" border="0"/></td>
	</tr>
	<tr>
		<td  style="font-size:0px;" valign="top">
			<img src="http://images.d1.com.cn/images2012/0428/images/qgb-1_05.jpg" width="489" height="169" alt="" border="0"/></td>
	</tr>
	<tr>
		<td  style="font-size:0px;">
			<img src="http://images.d1.com.cn/images2012/0428/images/qgb-1_06.jpg" width="489" height="103" alt=""/></td>
		<td colspan="3"  style="font-size:0px;">
			<a href="http://www.d1.com.cn/zhuanti/20120327qls/index.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/0428/images/qgb-1_07.jpg" alt="" width="491" height="103" border="0"/></a></td>
	</tr>
	<tr>
		<td  style="font-size:0px;">
			<a href="http://www.d1.com.cn/zhuanti/20120327qls/index.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/0428/images/qgb-1_08.jpg" alt="" width="489" height="146" border="0"/></a></td>
		<td colspan="3"  style="font-size:0px;">
			<a href="http://www.d1.com.cn/zhuanti/20120327qls/index.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/0428/images/qgb-1_09.jpg" alt="" width="491" height="146" border="0"/></a></td>
	</tr>
	<tr>
		<td  style="font-size:0px;">
			<a href="http://www.d1.com.cn/zhuanti/20120327qls/index.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/0428/images/qgb-1_10.jpg" alt="" width="489" height="157" border="0"/></a></td>
		<td colspan="3"  style="font-size:0px;">
			<a href="http://www.d1.com.cn/zhuanti/20120327qls/index.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/0428/images/qgb-1_11.jpg" alt="" width="491" height="157" border="0"/></a></td>
	</tr>
	<tr>
		<td  style="font-size:0px;">
			<a href="http://www.d1.com.cn/zhuanti/20120327qls/index.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/0428/images/qgb-1_12.jpg" alt="" width="489" height="138" border="0"/></a></td>
		<td colspan="3"  style="font-size:0px;">
			<a href="http://www.d1.com.cn/zhuanti/20120327qls/index.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/0428/images/qgb-1_13.jpg" alt="" width="491" height="138" border="0"/></a></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/images2012/0428/images/qgb-1_14.jpg" width="619" height="91" alt=""/></td>
			<td colspan="2" style="background-image:url(http://images.d1.com.cn/images2012/0428/images/qgb-1_15.jpg);" valign="middle" align="center">
			<div style="padding-left:140px; padding-top:20px;">
			<div style="float:left; width:55px; color:#FFFFFF"><span style="font-size:30px; font-weight:bold" id="h">12</span></div>
			<div style="float:left; width:60px; color:#FFFFFF"><span style="font-size:30px; font-weight:bold" id="m">12</span></div>
			<div style="float:left; width:60px; color:#FFFFFF"><span style="font-size:30px; font-weight:bold" id="s">12</span></div>
			</div>
			  <script language=javascript>
		var startDate= new Date("<%=nowtime%>");var endDate= new Date("<%=tttime%>");
		 lasttime=(endDate.getTime()-startDate.getTime())/1000;
		//alert(lasttime);
		setInterval(view_time2,1000);</script>
			</td>
	</tr>
	<tr>
		<td colspan="4">
			<% request.setAttribute("code","7633");
		request.setAttribute("length","50");%>
		 <jsp:include   page= "/html/gdspromotion_date.jsp"   />
			</td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/images2012/0428/images/qgb-1_17.jpg" width="980" height="57" alt=""/></td>
	</tr>
	<tr>
		<td colspan="4">
			<% 
			 ArrayList<Promotion> plist=PromotionHelper.getBrandListByCode("3015",100);
			if(plist!=null && plist.size()>0){
				for(Promotion promotion:plist){
					if(!promotion.getSplmst_url().equals("#")){%>
					<a href="<%=PromotionHelper.getPathUrl(0,StringUtils.encodeUrl(promotion.getSplmst_url()))%>" target="_blank">
				<%} %>
				<img src="<%=promotion.getSplmst_picstr() %>"  alt="<%=promotion.getSplmst_name() %>" border="0"/>
				<% if(!promotion.getSplmst_url().equals("#")){%>
					</a>
				<%}%>
				<%}
				
			}
			%>
			</td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/0428/images/分隔符.gif" width="489" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/0428/images/分隔符.gif" width="130" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/0428/images/分隔符.gif" width="125" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/0428/images/分隔符.gif" width="236" height="1" alt=""/></td>
	</tr>
</table>
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>