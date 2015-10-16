<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!
    private static int getAllCount(String gdsid)
    {
	     ArrayList<BuyLimitDtl> bldlist=new ArrayList<BuyLimitDtl>();
	     List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	     clist.add(Restrictions.eq("gdsbuyonedtl_gdsid", gdsid));
	     SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	     SimpleDateFormat df3=new SimpleDateFormat("yyyy-MM-dd");
	     String stime=df3.format(new Date())+" 00:00:00";
	     String etime =df3.format(new Date())+" 23:59:59";
	     try {
	    	 Date starttime=df2.parse(stime); 
		     Date endtime=df2.parse(etime);
		     clist.add(Restrictions.ge("gdsbuyonedtl_createtime", starttime));
		     clist.add(Restrictions.le("gdsbuyonedtl_createtime", endtime));

	     } catch (ParseException e) {
	    	   e.printStackTrace();
	     }
	     List<BaseEntity> blist=Tools.getManager(BuyLimitDtl.class).getList(clist, null, 0, 100);
	     if(blist!=null&&blist.size()>0)
	     {
	    	 return blist.size();
	     }
	     return 0;
    }
%>
<%
    Tools.setCookie(response, "rcmdusr_rcmid", "172", (int)(Tools.DAY_MILLIS/1000*1));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>7月桑拿天 促销更火热 1元起抢购-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" >
   function addcart(obj)
   {
	   var productid=$(obj).attr("attr");
		if(productid==null)
			{
			   $.alert('加入购物车的商品不存在！');
			   return;
			}
	   // var counts=1;	
	   // var sku2="";
	   $.inCart(obj,{ajaxUrl:'/ajax/flow/sevenInCart.jsp',width:400,align:'center'});
		//$.ajax({
			//type: "get",
			//dataType: "json",
			//url: '/ajax/flow/seventlInCart.jsp',
			//cache: false,
			//data: {gdsid:productid,count:counts,skuId:sku2},
			//error: function(XmlHttpRequest){
				//alert("加入购物车出错，请稍后重试或者联系客服处理！");
			//},success: function(json){
				//if(json.success){
					//$.alert("抢购成功!<a href=\"/flow.jsp\">马上去结算</a>");
				//}else{
					//$.alert(json.message);
				//}
			//},beforeSend: function(){
			//},complete: function(){
			//}
		//});
   }
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table id="__01" width="980" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="14">
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_01.jpg" width="980" height="162" alt=""></td>
	</tr>
	<tr>
		<td colspan="14">
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_02.jpg" width="980" height="185" alt=""></td>
	</tr>
	<tr>
		<td colspan="14">
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_03.jpg" width="980" height="95" alt=""></td>
	</tr>
	<tr>
		<td colspan="5" rowspan="2">
		    <%  if(getAllCount("01414291")>=20){ %>
			<a href="javascript:void(0)" ><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq-1_04.jpg" alt="" width="329" height="515" border="0"></a>
	        <%}else{%>
	        	<a href="javascript:void(0)" attr="01414291" onclick="addcart(this)"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_04.jpg" alt="" width="329" height="515" border="0"></a>
	        
	        <%} %>
	    </td>
		<td colspan="5">
		 <%  if(getAllCount("01721234")>=20){ %>
			<a href="javascript:void(0)" attr="01721234"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq-1_05.jpg" alt="" width="322" height="261" border="0"></a></td>
		<%}else
			{%>
			<a href="javascript:void(0)" attr="01721234" onclick="addcart(this)"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_05.jpg" alt="" width="322" height="261" border="0"></a></td>
		
			<%}%>
		<td colspan="4">
		<%  if(getAllCount("01414871")>=20){ %>
			<a href="javascript:void(0)" attr="01414871"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq-1_06.jpg" alt="" width="329" height="261" border="0"></a></td>
	    <%} else
	    {%>
	    	<a href="javascript:void(0)" attr="01414871" onclick="addcart(this)"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_06.jpg" alt="" width="329" height="261" border="0"></a></td>
	
	    <%}%>
	</tr>
	<tr>
		<td colspan="5">
		<%  if(getAllCount("01416664")>=20){ %>
			<a href="javascript:void(0)" attr="01416664"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq-1_07.jpg" alt="" width="322" height="254" border="0"></a></td>
		<%}else{%>
			<a href="javascript:void(0)" attr="01416664" onclick="addcart(this)"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_07.jpg" alt="" width="322" height="254" border="0"></a></td>
	
		<%} %>
		<td colspan="3">
		<%  if(getAllCount("01410254")>=20){ %>
			<a href="javascript:void(0)" attr="01410254"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq-1_08.jpg" alt="" width="328" height="254" border="0"></a></td>
		<%}else{%>
			<a href="javascript:void(0)" attr="01410254" onclick="addcart(this)"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_08.jpg" alt="" width="328" height="254" border="0"></a></td>
		
		<%} %>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_09.jpg" width="1" height="254" alt=""></td>
	</tr>
	<tr>
		<td colspan="14">
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_10.jpg" width="980" height="86" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_11.jpg" width="122" height="45" alt=""></td>
		<td colspan="3">
			<a href="#1"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_12.jpg" alt="" width="166" height="45" border="0"></a></td>
		<td colspan="2">
			<a href="#2"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_13.jpg" alt="" width="164" height="45" border="0"></a></td>
		<td colspan="3">
			<a href="#3"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_14.jpg" alt="" width="192" height="45" border="0"></a></td>
		<td colspan="3">
			<a href="#4"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_15.jpg" alt="" width="217" height="45" border="0"></a></td>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_16.jpg" width="119" height="45" alt=""></td>
	</tr>
	<tr>
		<td colspan="14">
			<a name="1"></a><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_17.jpg" width="980" height="65" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="/product/01720159" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_18.jpg" alt="" width="252" height="342" border="0"></a></td>
		<td colspan="4">
			<a href="/product/01720843" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_19.jpg" alt="" width="238" height="342" border="0"></a></td>
		<td colspan="4">
			<a href="/product/03000046" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_20.jpg" alt="" width="240" height="342" border="0"></a></td>
		<td colspan="3">
			<a href="/product/01715911" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_21.jpg" alt="" width="250" height="342" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="14">
			<a name="2"></a><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_22.jpg" width="980" height="82" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="/product/02000027" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_23.jpg" alt="" width="250" height="342" border="0"></a></td>
		<td colspan="6">
			<a href="/product/01720655" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_24.jpg" alt="" width="242" height="342" border="0"></a></td>
		<td colspan="3">
			<a href="/product/02000193" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_25.jpg" alt="" width="238" height="342" border="0"></a></td>
		<td colspan="3">
			<a href="/product/02000205" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_26.jpg" alt="" width="250" height="342" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="14">
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_27.jpg" width="980" height="23" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="/product/02000270" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_28.jpg" alt="" width="250" height="342" border="0"></a></td>
		<td colspan="5">
			<a href="/product/01720663" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_29.jpg" alt="" width="240" height="342" border="0"></a></td>
		<td colspan="4">
			<a href="/product/01720738" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_30.jpg" alt="" width="240" height="342" border="0"></a></td>
		<td colspan="3">
			<a href="/product/01720733" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_31.jpg" alt="" width="250" height="342" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="14">
			<a name="3"></a><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_32.jpg" width="980" height="88" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="/product/01516969" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_33.jpg" alt="" width="252" height="342" border="0"></a></td>
		<td colspan="4">
			<a href="/product/01516741" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_34.jpg" alt="" width="238" height="342" border="0"></a></td>
		<td colspan="4">
			<a href="/product/01517167" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_35.jpg" alt="" width="240" height="342" border="0"></a></td>
		<td colspan="3">
			<a href="/product/01517024" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_36.jpg" alt="" width="250" height="342" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="14">
			<a name="4"></a><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_37.jpg" width="980" height="89" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="/product/01412279" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_38.jpg" alt="" width="250" height="342" border="0"></a></td>
		<td colspan="5">
			<a href="/product/01417049" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_39.jpg" alt="" width="240" height="342" border="0"></a></td>
		<td colspan="4">
			<a href="/product/01413048" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_40.jpg" alt="" width="240" height="342" border="0"></a></td>
		<td colspan="3">
			<a href="/product/01417074" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_41.jpg" alt="" width="250" height="342" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="14">
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/1yq_42.jpg" width="980" height="76" alt=""></td>
	</tr>
	<tr>
		<td colspan="14"><% request.setAttribute("code","7870");
		request.setAttribute("length","50");%>
        <jsp:include   page= "/html/zt2011/20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/分隔符.gif" width="122" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/分隔符.gif" width="128" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/分隔符.gif" width="2" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/分隔符.gif" width="36" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/分隔符.gif" width="41" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/分隔符.gif" width="123" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/分隔符.gif" width="38" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/分隔符.gif" width="2" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/分隔符.gif" width="152" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/分隔符.gif" width="7" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/分隔符.gif" width="79" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/分隔符.gif" width="131" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/分隔符.gif" width="118" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20120629yyq/分隔符.gif" width="1" height="1" alt=""></td>
	</tr>
</table>
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>