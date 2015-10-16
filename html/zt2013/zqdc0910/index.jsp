<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
private static ArrayList<GdsCutImg> getByGdsid(String gdsid){
	ArrayList<GdsCutImg> list=new ArrayList<GdsCutImg>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsmst_gdsid", gdsid));
	List<BaseEntity> b_list = Tools.getManager(GdsCutImg.class).getList(clist, null, 0,1);
	if(b_list==null || b_list.size()==0) return null;		
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((GdsCutImg)be);
		}
	}	
	
     return list;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>金九狂欢中秋大促-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gblistCart.js")%>"></script>
<style>
*{
	margin:0;
	padding:0;
}
.imglin {
	border: 1px solid #ffffff;
}

#phoneCarousel{
	/*	This is the carousel section, it
		contains the stage and the arrows */
		padding-top:15px;
	height:422px;
	position:relative;
	width:980px;
	background:url('http://images.d1.com.cn/zt2013/zqdc0910/zqdc_08.jpg') no-repeat;
}


#phoneCarousel .arrow{
	/* The two arrows */
	width:44px;
	height:44px;
	background:url('http://images.d1.com.cn/zt2013/zqdc0910/left.png') no-repeat;
	position:absolute;
	top:50%;
	left:0;
	cursor:pointer;
}

#phoneCarousel .next{
	/* Individual styles for the next icon */
	background:url('http://images.d1.com.cn/zt2013/zqdc0910/right.png') no-repeat;
	position:absolute;
	background-position:right top;
	left:auto;
	right:0;
}

/* Hover styles */

#phoneCarousel .arrow:hover{
	background-position:left bottom;
}

#phoneCarousel .next:hover{
	background-position:right bottom;
}



#stage{
	/* The stage contains the animated phone images */
	left:50%;
	margin-left:-450px;
	position:absolute;
	width:900px;
	height:100%;
}

#stage img{
	/* Hiding all the images by default */
	display:none;
}

#stage .default{
	/*	This class is applied only to the iphone img by default
		and it is the only one visible if JS is disabled */
	display:block;
	left:50%;
	margin-left:-135px;
	position:absolute;
}

#stage .animationReady{
	/* This class is assigned to the images on load */
	display:block;
	position:absolute;
	top:0;
	left:0;
}

a, a:visited {
	text-decoration:none;
	outline:none;
}

a:hover{	text-decoration:underline;}
a img{	border:none;}

</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table id="__01" width="981" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="23">
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_01.jpg" width="980" height="350" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="350" alt=""></td>
	</tr>
	<tr>
		<td colspan="23">
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_02-2.jpg" width="980" height="145" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="145" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
		<a href="http://www.d1.com.cn/product/01205303" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_03.jpg" width="196" height="392" alt="" border="0"></a></td>
		<td colspan="5">
			<a href="http://www.d1.com.cn/product/01205201" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_04.jpg" width="198" height="392" alt="" border="0"></a></td>
		<td colspan="5">
			<a href="http://www.d1.com.cn/product/02200265" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_05.jpg" width="186" height="392" alt="" border="0"></a></td>
		<td colspan="6">
			<a href="http://www.d1.com.cn/product/02002019" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_06.jpg" width="178" height="392" alt="" border="0"></a></td>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/01204545" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_07-2.jpg" width="222" height="392" alt="" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="392" alt=""></td>
	</tr>
	<tr>
		<td colspan="23">
		  <div id="phoneCarousel">
    	<div class="previous arrow"></div>
        <div class="next arrow"></div>
        
        <div id="stage">
        <% 
    	StringBuilder sb = new StringBuilder();
        List<PromotionProduct> recommendList =PromotionProductHelper.getPromotionProductByCode("8782" , 9);
    	if(recommendList != null && !recommendList.isEmpty()){
    		

    		for(int i=0;i<recommendList.size();i++){
    			PromotionProduct pp = recommendList.get(i);
       		   
       		 Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
				if(product!=null)
				{

					String imgurl1="";
					 String title =product.getGdsmst_gdsname();
		
						
											
							imgurl1= product.getGdsmst_img240300();
							if(imgurl1!=null&&imgurl1.startsWith("/shopimg/gdsimg")){
								imgurl1 = "http://images1.d1.com.cn"+imgurl1.trim();
								}else{
									imgurl1 = "http://images.d1.com.cn"+imgurl1.trim();
								}
				       		    
       		  sb.append("<a href=\"").append("/product/").append(product.getId()).append("\" title=\"").append(title).append("\" target=\"_blank\">");
       		    sb.append("<img class=\"imglin\" id=\"iphone").append(i).append("\" class=\"default\" src=\"").append(imgurl1).append("\" width=\"240\" height=\"300\" alt=\"title\" />");
       		  sb.append("</a>");
				}
       		
    		}
    		
    	} 
    	out.print(sb.toString());
    	%>
            
  
        </div>
    </div>
			<!--  <script type="text/javascript" src="/res/js/jquery-1.3.2.min.js"></script>-->
<script type="text/javascript" src="/res/js/d1zq.js"></script>

			</td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="422" alt=""></td>
	</tr>
	<tr>
		<td colspan="23">
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_09.jpg" width="980" height="62" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="62" alt=""></td>
	</tr>
	<tr>
		<td colspan="23">
		<% request.setAttribute("code","8783");
		request.setAttribute("length","12");%>
        <jsp:include   page= "/html/gdsrec2013.jsp"   />
			</td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="366" alt=""></td>
	</tr>
	<tr>
		<td colspan="10" rowspan="2">
			<a href="http://www.d1.com.cn/product/02001972" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_11.jpg" alt="" width="414" height="398" border="0"></a></td>
		<td colspan="8">
			<a href="http://www.d1.com.cn/product/02001972" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_12.jpg" alt="" width="286" height="255" border="0"></a></td>
		<td colspan="5" rowspan="2">
			<a href="http://www.d1.com.cn/product/02001997" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_13.jpg" alt="" width="280" height="398" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="255" alt=""></td>
	</tr>
	<tr>
		<td colspan="8">
			<a href="http://www.d1.com.cn/product/02001997" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_14.jpg" alt="" width="286" height="143" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="143" alt=""></td>
	</tr>
	<tr>
		<td rowspan="2">
			<a href="http://www.d1.com.cn/gdscoll/index.jsp?id=2087" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_15.jpg" alt="" width="185" height="535" border="0"></a></td>
		<td colspan="5" rowspan="2">
			<a href="http://www.d1.com.cn/gdscoll/index.jsp?id=2117" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_16.jpg" alt="" width="180" height="535" border="0"></a></td>
		<td colspan="15">
			<a href="http://www.d1.com.cn/result.jsp?productsort=020010" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_17.jpg" alt="" width="421" height="267" border="0"></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/result.jsp?productsort=040007003" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_18.jpg" alt="" width="194" height="267" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="267" alt=""></td>
	</tr>
	<tr>
		<td colspan="9">
			<a href="http://www.d1.com.cn/product/02001967" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_19.jpg" alt="" width="222" height="268" border="0"></a></td>
		<td colspan="8">
			<a href="http://www.d1.com.cn/result.jsp?productsort=020002001" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_20.jpg" alt="" width="393" height="268" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="268" alt=""></td>
	</tr>
	<tr>
		<td colspan="7" rowspan="2">
			<a href="http://www.d1.com.cn/product/02001990" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_21.jpg" alt="" width="370" height="401" border="0"></a></td>
		<td colspan="10">
			<a href="http://www.d1.com.cn/product/02001990" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_22.jpg" alt="" width="257" height="259" border="0"></a></td>
		<td colspan="6" rowspan="2">
			<a href="http://www.d1.com.cn/product/02001975" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_23.jpg" alt="" width="353" height="401" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="259" alt=""></td>
	</tr>
	<tr>
		<td colspan="10">
			<a href="http://www.d1.com.cn/product/02001975" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_24.jpg" alt="" width="257" height="142" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="142" alt=""></td>
	</tr>
	<tr>
		<td colspan="8" rowspan="2">
			<a href="http://www.d1.com.cn/product/02001934" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_25.jpg" alt="" width="391" height="272" border="0"></a></td>
		<td colspan="5" rowspan="3">
			<a href="http://www.d1.com.cn/gdscoll/index.jsp?id=2096" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_26.jpg" alt="" width="183" height="536" border="0"></a></td>
		<td colspan="6" rowspan="3">
			<a href="http://www.d1.com.cn/gdscoll/index.jsp?id=2101" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_27.jpg" alt="" width="178" height="536" border="0"></a></td>
		<td colspan="4">
			<a href="http://www.d1.com.cn/zhuanti/201309/qzxx0904/" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_28.jpg" alt="" width="228" height="262" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="262" alt=""></td>
	</tr>
	<tr>
		<td colspan="4" rowspan="2">
			<a href="http://www.d1.com.cn/result.jsp?productsort=015009016" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_29.jpg" alt="" width="228" height="274" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="10" alt=""></td>
	</tr>
	<tr>
		<td colspan="8">
			<a href="http://www.d1.com.cn/result.jsp?productsort=020015" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_30.jpg" alt="" width="391" height="264" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="264" alt=""></td>
	</tr>
	<tr>
		<td colspan="5" rowspan="2">
			<a href="http://www.d1.com.cn/product/02001983" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_31.jpg" alt="" width="234" height="402" border="0"></a></td>
		<td colspan="7">
			<a href="http://www.d1.com.cn/product/02001983" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_32.jpg" alt="" width="265" height="260" border="0"></a></td>
		<td colspan="11" rowspan="2">
			<a href="http://www.d1.com.cn/product/03000227" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_33.jpg" width="481" height="402" alt="" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="260" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_34.jpg" width="265" height="142" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="142" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/01517521" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_35.jpg" alt="" width="191" height="267" border="0"></a></td>
		<td colspan="13">
			<a href="http://www.d1.com.cn/result.jsp?productsort=020004003&amp;order=4" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_36.jpg" alt="" width="422" height="267" border="0"></a></td>
		<td colspan="6" rowspan="2">
			<a href="http://www.d1.com.cn/gdscoll/index.jsp?id=2129" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_37.jpg" alt="" width="180" height="533" border="0"></a></td>
		<td rowspan="2">
			<a href="http://www.d1.com.cn/gdscoll/index.jsp?id=603" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_38.jpg" alt="" width="187" height="533" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="267" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/result.jsp?productsort=031" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_39.jpg" alt="" width="189" height="266" border="0"></a></td>
		<td colspan="9">
			<a href="http://www.d1.com.cn/product/03000195" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_40.jpg" alt="" width="236" height="266" border="0"></a></td>
		<td colspan="5">
			<a href="http://www.d1.com.cn/result.jsp?productsort=030008004" target="_blank"><img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_41.jpg" alt="" width="188" height="266" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="266" alt=""></td>
	</tr>
	<tr>
		<td colspan="23">
		
		<table id="__01" width="980" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/01417340" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130904qzxx/qzxx_01-1.jpg" alt="" width="980" height="355" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/product/01417340" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130904qzxx/qzxx_02.jpg" alt="" width="980" height="79" border="0" usemap="#hzpMap"></a></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2013/20130904qzxx/qzxx_03.jpg" width="980" height="71" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/html/gdsmstxsylist.jsp?code=8780" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130904qzxx/qzxx_04.jpg" alt="" width="488" height="375" border="0"></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/html/gdsmstxsylist.jsp?code=8781" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130904qzxx/qzxx_05.jpg" alt="" width="492" height="375" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2013/20130904qzxx/qzxx_06.jpg" width="980" height="80" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01417595" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130904qzxx/qzxx_07.jpg" alt="" width="491" height="488" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01417593" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130904qzxx/qzxx_08.jpg" alt="" width="489" height="488" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01417594" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130904qzxx/qzxx_09.jpg" alt="" width="491" height="483" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01417589" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130904qzxx/qzxx_10.jpg" alt="" width="489" height="483" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01417587" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130904qzxx/qzxx_11.jpg" alt="" width="491" height="484" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01417571" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130904qzxx/qzxx_12.jpg" alt="" width="489" height="484" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01417580" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130904qzxx/qzxx_13.jpg" alt="" width="491" height="484" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01417585" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130904qzxx/qzxx_14.jpg" alt="" width="489" height="484" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01417573" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130904qzxx/qzxx_15.jpg" alt="" width="491" height="484" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01417551" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130904qzxx/qzxx_16.jpg" alt="" width="489" height="484" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2013/20130904qzxx/qzxx_17.jpg" width="980" height="16" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130904qzxx/分隔符.gif" width="488" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130904qzxx/分隔符.gif" width="3" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/20130904qzxx/分隔符.gif" width="489" height="1" alt=""></td>
	</tr>
</table>
		
		
		</td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="62" alt=""></td>
	</tr>
	<tr>
		<td colspan="23">
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/zqdc_42.jpg" width="980" height="62" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="62" alt=""></td>
	</tr>
	<tr>
		<td colspan="23">
			<% request.setAttribute("code","8784");
		request.setAttribute("length","50");%>
        <jsp:include   page= "/html/gdsrec2013.jsp"   />
			</td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="1" height="35" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="185" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="4" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="2" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="5" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="38" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="131" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="5" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="21" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="3" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="20" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="11" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="74" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="75" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="6" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="7" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="26" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="14" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="73" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="52" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="6" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="28" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="7" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/zqdc0910/分隔符.gif" width="187" height="1" alt=""></td>
		<td></td>
	</tr>
</table>
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>