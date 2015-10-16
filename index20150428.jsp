<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/inc/funindex.jsp"%>
<%
String httpurl=request.getHeader("Referer");
if(Tools.isNull(httpurl))httpurl=request.getHeader("referer");
if(!Tools.isNull(httpurl)&&httpurl.indexOf("http://baidu.com")>=0){
	return;
}
if(session.getAttribute("wapurl_flag")==null&&!Tools.isNull(httpurl)&&httpurl.startsWith("http://m.d1.cn")){
   session.setAttribute("wapurl_flag", "www");
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！">
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买">
<title>D1优尚网-时尚网上购物商城,在线销售化妆品、名表、饰品、女装、男装等个人扮靓物品</title>

<script src="/res/js/jquery-1.3.2.min.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript" src="/res/js/d1.js?1406565937411"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/rollImageKP.js?"+System.currentTimeMillis())%>"></script>
<link href="/res/css/index/index2015.css" rel="stylesheet" type="text/css">
<script src="/res/js/index/SpryTab1.js" type="text/javascript"></script>
<script src="/res/js/index/SpryTab2.js" type="text/javascript"></script>
<script src="/res/js/index/SpryTab3.js" type="text/javascript"></script>
<link href="/res/css/index/layout.css?1.15" rel="stylesheet" type="text/css">
<link href="/res/css/index/SpryTab1.css" rel="stylesheet" type="text/css">
<link href="/res/css/index/SpryTab2.css" rel="stylesheet" type="text/css">
<script type="text/javascript" language="javascript" src="/res/js/wapcheck.js?1406565937421"></script>

<script>
<%if(session.getAttribute("wapurl_flag")==null){%>
if(checkMobile()){
	window.location.href="http://m.d1.cn";
}
<%}%>
</script>
<style type="text/css">

.i_price_new {
background-image: url(http://images.d1.com.cn/zt2014/0304/pricebg-big1.gif);
background-repeat: repeat;
height: 70px;

}
.i_price_newbg {
background-image: url(http://images.d1.com.cn/zt2014/0304/bgbigbar-or.gif);
background-repeat: repeat;
height: 70px;
}

.lijiqiang {
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/lijiqiang-big.png);
background-repeat: no-repeat;
background-position: 0px 0px;
width: 126px;
height: 47px;
right:17px;
bottom: 60px;
}
.jijkqiang {
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/getitsoon.jpg);
background-repeat: no-repeat;
background-position: 0px 0px;
width: 126px;
height: 47px;
right:17px;
bottom: 60px;
}
.shouqing{
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/shouqingbig.png);
background-repeat: no-repeat;
background-position: 0px 0px;
width: 126px;
height: 47px;
right:17px;
bottom: 60px;
}

.s2_1 {
color: #FFFFFF;
font-size: 43px;
line-height: 43px;
padding-left: 16px;
/*vertical-align: bottom;*/
font-family: 'arial';
display: block;
height: 38px;
padding-top: 5px;
}

.s3{
color: #f7949b;
font-size: 10px;
padding-left: 21px;
vertical-align: top;
font-family: '微软雅黑';
}
.s3new{
color: #fcbf9c;
font-size: 10px;
padding-left: 21px;
vertical-align: top;
font-family: '微软雅黑';
}
.zhekou_t {
position: absolute;
background-image: url(http://images.d1.com.cn/zt2014/0304/checknap.png);
background-position: 0px 0px;
width: 39px; height: 18px;
left:12px;
bottom: 165px;
}
.djs_newlist{
font-size: 14pt;
color: #f0424e;
padding:0px 2px;
font-family: 'arial';
}
.productadright{position: fixed;_position: absolute;right: 0px;bottom: 0px;width: 160px;font-size: 12px;_top: expression(documentElement.scrollTop+documentElement.clientHeight-this.offsetHeight);overflow: hidden;z-index: 200000;display: block;}
.page_f{
    left: 0px;bottom: 0px;width: 100px;font-size: 12px;display: block;
	float:left;
	margin-top:10px; 
	margin-left:10px; 
	position:fixed; 
	_position:absolute;
	_bottom:auto; 
	_top:expression(eval(document.documentElement.scrollTop));
	z-index:99999;
}

.topbannerdiv{	position:relative; width:980px; height:450px; margin: 0px auto;}
.topbannerdiv .link1{ position:absolute;  width:980px; height:450px; bottom:0; left:0px; }

.banner328 {
background-image: url(http://images.d1.com.cn/zt2014/0415/0415.jpg);
background-repeat: no-repeat;
background-position: center;
height: 300px;
}

</style>
<script type="text/javascript">
$(document).ready(function() {	
$('.mbm_item li').mouseover(function(){
	$(this).parent().find(".on").removeClass("on");
	$(this).find("a").addClass("on");
	vindex=$('.mbm_item li').index($(this)[0] );
	//alert(vindex);
	$(".mbi_right .mb_list").hide();
	if(vindex==0)$("#brandl1").show();
	if(vindex==1)$("#brandl2").show();
	if(vindex==2)$("#brandl3").show();
   });
   $('.hr_tit a').mouseover(function(){
	$(this).parent().find(".on").removeClass("on");
	$(this).addClass("on");
	vindex=$('.hr_tit a').index($(this)[0] );
	$(".hr_body .hr_list").hide();
	if(vindex==0)$("#hr1").show();
	if(vindex==1)$("#hr2").show();
	if(vindex==2)$("#hr3").show();
   });
    $('.hr_list li').mouseover(function(){
	$(this).parent().find(".on").removeClass("on");
	$(this).addClass("on");
   });
});
</script>
</head>
<body>

<!-- top  start -->
<!-- 头部开始 -->
<%@include file="/inc/head2015.jsp" %>
<!-- 头部结束 -->
<!-- top over  -->
<!--首页轮播-->
<div id="imgrollys">
	    <div id="imgslideys" style=" background-color: transparent;">
		    <div id="imgRollOuterys">
		    <% ArrayList<Promotion> pttlist=new ArrayList<Promotion>();
		       pttlist=PromotionHelper.getBrandListByCode("3882", 10);//轮播3882
		       StringBuilder sbtt1219=new StringBuilder();
		       StringBuilder sbtt1219img=new StringBuilder();
		       if(pttlist!=null&&pttlist.size()>0)
		       {
		    	   for(int i=0;i<pttlist.size();i++)
		    	   {
		    		   Promotion ptt=pttlist.get(i);
		    		   if(ptt!=null)
		    		   {
		    			   out.print("<div  img_index=\""+i+"\" style=\"background:url('"+ptt.getSplmst_picstr()+"') no-repeat center center;\"><a href=\""+ptt.getSplmst_url()+"\" title=\""+Tools.clearHTML(ptt.getSplmst_name())+"\" target=\"_blank\"></a></div>");
		    		       sbtt1219.append("<a href=\""+ptt.getSplmst_url()+"\"  target=\"_blank\" img_index=\""+i+"\" class=\"datai\">"+(i+1)+"</a>");
			    		   if(i==pttlist.size()-1)
			    		   {
			    			   sbtt1219img.append("\""+ptt.getSplmst_picstr()+"\"");
			    		   }
			    		   else
			    		   {
			    			   sbtt1219img.append("\""+ptt.getSplmst_picstr()+"\",");
			    		   }
		    		   }
		    	   }
		       }
		    %>
		    </div>
		    <p style="right:-<%=12*pttlist.size() %>px">
		    <% out.print(sbtt1219.toString()); %>
			</p>
		     <div class="imgrollboxys">
			     <div class="left" ></div>
			     <div class="right" ></div>
		     </div>
	     </div>
</div>
<div class="index_ad2" style="background-image: url(http://images.d1.com.cn/Index/2015/index_01_4.jpg);"></div>

<!--首页轮播结束-->


<!-- 
<div class="content">

 <%
 List<Promotion> recommendList = PromotionHelper.getBrandListByCode("3882" , 1);
	if(recommendList != null && !recommendList.isEmpty()){
		for(Promotion p:recommendList)
		{
			String url=p.getSplmst_url();
			String img=p.getSplmst_picstr();
		    
 %>
<a href="<%=url %>" target="_blank">
<div class="index_ad" style="background-image: url(<%=img%>);"></div>
</a>
<%}} %>
</div>
 -->
<div class="allwrapper">
	<div class="brand_hot">
		<div class="bh_tit">
			<span>大牌促销</span>
			<i></i>
		</div>
		<div class="bh_body">
				<ul>
					<%=getbrandhot("3834",6) %>
				</ul>
		</div>
	</div>
	<div class="main_brand">
    	<div class="mb_menu">
    		<div class="mbm_line">
    			
    		</div>
    		<div class="mbm_item">
    			<ul>
    				<li><a href="###" class="on"><span>精选品牌</span></a></li>
    				<li><a href="###"><span>国际大牌</span></a></li>
    				<li><a href="###"><span>国货精品</span></a></li>
    			</ul>
    		</div>
    	</div>
    	<div class="mb_item">
    		<div class="mbi_left">
    		    <%=getimgstr("3835",1,0) %>	
    		</div>
    		<div class="mbi_right">
    			<div class="mb_list" style="display: block;" id="brandl1">
    				<ul>
    				<%=getbrandimg("3836",8) %>
    				 </ul>
    			</div>
    		<div class="mb_list" id="brandl2" style="display: none;">
    				<ul>
    					<%=getbrandimg("3837",8) %>
    					</ul>
    			</div>
    			<div class="mb_list" id="brandl3" style="display: none;">
    				<ul>
    					<%=getbrandimg("3838",8) %>
    					</ul>
    			</div>
    		</div>
    	</div>
    </div>
	<div class="hotrec">
		<div class="hr_tit">
			<a href="" class="on" ><i class="bg1"></i>当季热卖</a>
			<a href="" ><i class="bg2"></i>新品快递</a>
			<a href="" ><i class="bg3"></i>销量排行</a>
		</div>
		<div class="hr_body">
			<div class="hr_list" id="hr1">
				<%=gethotrec("9653",5) %>
			</div>
			<div class="hr_list" id="hr2" style="display:none">
				<%=gethotrec("9459",5) %>
			</div>
			<div class="hr_list" id="hr3" style="display:none">
				<%=gethotrec("9460",5) %>
			</div>
		</div>
	</div>
    <div align="center"><%=getimgstr("3885",1,0) %></div>
    <div class="main_div1" style="padding-top:20px; *padding-top:5px;">
      <%=getrck2015("3845,3846,3847,3848,3878","013018003",2) %>
    </div>
   <div class="main_div1" style="padding-top:20px; *padding-top:5px;">
      <%=getrck2015("3849,3850,,3852,3879","013018004",3) %>
    </div>
    <div class="main_div1" style="padding-top:20px; *padding-top:5px;">
      <%=getrck2015("3853,3854,3855,3856,3880","013018005",4) %>
    </div>
    <div class="main_div1" style="padding-top:20px; *padding-top:5px;">
      <%=getrck2015("3857,3858,3859,3860,3881","013018006",5) %>
    </div>
     <div class="menrec">
		<%=getmenrec("3862,3863,3864,3865,3866,3876","男人馆") %>
	</div>
    <div class="menrec">
		<%=getmenrec("3871,3872,3873,3874,3875,3877","女人街") %>
	</div>
  </div>
  </div>
  <script type="text/javascript">
<!--
//var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
var TabbedPanels2 = new Spry.Widget.TabbedPanels2("TabbedPanels2");
var TabbedPanels3 = new Spry.Widget.TabbedPanels3("TabbedPanels3");
var TabbedPanels4 = new Spry.Widget.TabbedPanels3("TabbedPanels4");
var TabbedPanels5 = new Spry.Widget.TabbedPanels3("TabbedPanels5");

//-->
</script>
<!-- 底部开始 -->
<%@include file="/inc/foot.jsp" %>
<!-- 底部结束 -->
</body>
</html>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
<script type="text/javascript" >
$(document).ready(function() {
	
	var count_dt=$('#imgRollOuterys').children("div").length;
	if(count_dt>1)
		{
	
			/*大图轮播*/
			 var roll_images=[<%= sbtt1219img.toString()%>];
			 var imgrollbg=['#fff','#fff','#fff','#fff','#fff','#fff','#fff','#fff'];
				 var bg = imgrollbg || null;
				 new RollImage(roll_images, $("#imgRollOuterys"), $("#imgslideys>p>a"), null, $("#imgrollys .left"), $("#imgrollys .right"), bg).run(1);
			 $("#imgrollys").hover(function (){
					$(this).find(".left,.right").fadeIn();
			  },
			  function ()
			  {
				    $(this).find(".left,.right").fadeOut();
			  });       
			  $(".imglist").find("img").lazyload({ effect: "show", placeholder: "http://images.d1.com.cn/Index/images/grey.gif",threshold : 200 });
			  $(".zblist").find("img").lazyload({ effect: "show", placeholder: "http://images.d1.com.cn/Index/images/grey.gif",threshold : 200 });
		}
	else
		{
				$(".datai").css('display','none');
		
		}
		});


</script>
</body>
</html>
