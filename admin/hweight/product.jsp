<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>
<%@include file="/html/productpublic1.jsp"%>
<%@include file="/html/getComment.jsp" %>
<%
String id = request.getParameter("id");
if(Tools.isNull(id))id=request.getParameter("gdsid");

//------------------------记录商品来源链接--------------------------------------
String twohttpurl=request.getHeader("Referer");
if(Tools.isNull(twohttpurl))twohttpurl=request.getHeader("referer");
if (!Tools.isNull(twohttpurl)){
	try{
		twohttpurl=HitLogUtil.repbad(twohttpurl);
		twohttpurl =java.net.URLDecoder.decode(twohttpurl,"UTF-8");
   }
   catch(Exception ex){
 	  ex.printStackTrace();
   }
}
String gdsReferer="";
if (session.getAttribute("gdsReferer")!=null){
	gdsReferer=session.getAttribute("gdsReferer").toString();
}
if (Tools.isNull(gdsReferer)||URLDecoder.decode(gdsReferer,"UTF-8").indexOf(id+"\":")==-1){
	try{
	Map<String, Object> mapreferer = null;
	if (!Tools.isNull(gdsReferer)){
		gdsReferer=URLDecoder.decode(gdsReferer,"UTF-8");
	  JSONObject josnmap2 = JSONObject.fromObject(gdsReferer); 
	   mapreferer = (Map)josnmap2;
     }else{
    	 mapreferer= new HashMap<String,Object>();
     }
	   
	mapreferer.put(id,twohttpurl);
	String jsonmap=JSONObject.fromObject(mapreferer).toString();
	session.setAttribute("gdsReferer", URLEncoder.encode(jsonmap));
	//Tools.setCookie(response,"gdsReferer",URLEncoder.encode(jsonmap),(int)(Tools.DAY_MILLIS/1000*1));
	}
	catch(Exception ex){
		//Tools.removeCookie(response, "gdsReferer");
		session.removeAttribute("gdsReferer");
	   }
}

//------------------------------------------------------------------
Product product = ProductHelper.getById(id);
if(product == null){
	//response.setStatus(404);
	//response.setHeader( "Location", "http://www.d1.com.cn/product/"+request.getParameter("id"));
	//response.setHeader( "Connection", "close" );
     response.sendRedirect("/404.jsp");
	out.print("商品不存在！");
	return;
}

//if(product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()!=1){
//	response.sendRedirect("/index.jsp");
//	return;
//}

//if(product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()==2)
//{
	//if(twohttpurl==null)
	//{
       //response.sendRedirect("http://www.d1.com.cn/productv.jsp?id="+id);	
	//}
	//else
	//{
	//	if(!twohttpurl.startsWith("http://admin.d1.com.cn:322"))
	//	{
		  //response.sendRedirect("http://www.d1.com.cn/productv.jsp?id="+id);	
	//	}
	//}
//}

String brandName = product.getGdsmst_brandname();//品牌
String rackCode = product.getGdsmst_rackcode();//类别
String gdsname = Tools.clearHTML(product.getGdsmst_gdsname());//物品名称
float saleprice = Tools.floatValue(product.getGdsmst_saleprice());//市场价
float memberprice = Tools.floatValue(product.getGdsmst_memberprice());//会员价
long discountendDate = Tools.dateValue(product.getGdsmst_discountenddate());//应该是秒杀结束的时间。
float oldmemberprice = Tools.floatValue(product.getGdsmst_oldmemberprice());//旧的会员价
String skuname1 = product.getGdsmst_skuname1();//sku1
long buylimit = Tools.longValue(product.getGdsmst_buylimit());
long ifhavegds = Tools.longValue(product.getGdsmst_ifhavegds());//缺货标识
long validflag = Tools.longValue(product.getGdsmst_validflag());//是否下架，1未下架

long tj_buylimit = 0;//秒杀购买上限
long tj_saletoday = 0;//秒杀今日购买数
String rcmdgds_gdsid = null;
String dxtitle = "";
String endprice = "";

boolean ismiaoshao = false;//是否是秒杀

//市场用的独享
String dxmarket="";
if(request.getParameter("tj")!=null&&request.getParameter("tj").length()>0){
	dxmarket=request.getParameter("tj");
}

String dxid ="";
float dxprice = 0f;
//来源链接
String httpurl=request.getHeader("Referer");
if(Tools.isNull(httpurl))httpurl=request.getHeader("referer");

if(dxmarket!=null&&dxmarket.length()>0){
    String strpingan=Tools.getCookie(request, "PINGAN");
    if(!"pingan".equals(dxmarket.substring(0, 6)) || !"1".equals(strpingan))
    {
    	   if (httpurl!=null && httpurl.indexOf("d1.com.cn")<0)
    	    {
    	    	String strsrcurl=Tools.getCookie(request, "d1.com.cn.srcurl");
    	    	if(Tools.isNull(strsrcurl) || "null".equals(strsrcurl))
    	    	{
    	    	    Tools.setCookie(response,"d1.com.cn.srcurl",httpurl,(int)(Tools.DAY_MILLIS/1000*3));
    	    	}
    	    }
    	    Tools.setCookie(response,"d1.com.cn.peoplercm.subad",dxmarket,(int)(Tools.DAY_MILLIS/1000*3));
    	   
    	    if(!"linktech".equals(dxmarket))
    	    {
    	        Lmclk lk = new Lmclk();
    	        lk.setLmclk_createdate(new Date());
    	        lk.setLmclk_uid("d1_1030");
    	        lk.setLmclk_linkurl("http//www.d1.com.cn/product/"+id);
    	        lk.setLmclk_from(httpurl);
    	        lk.setLmclk_ip(request.getRemoteAddr());
    	        lk.setLmclk_subad(dxmarket);
    	        Tools.getManager(Lmclk.class).create(lk);
    	    }
    }
	ProductExpPrice rcmdusr=(ProductExpPrice)Tools.getManager(ProductExpPrice.class).findByProperty("rcmdusr_uid", dxmarket);
	if(rcmdusr.getRcmdusr_enddate().after(new Date())&&rcmdusr.getRcmdusr_startdate().before(new Date()))
	{
	//设置cookie
	 Tools.setCookie(response,"rcmdusr_uid",dxmarket,(int)(Tools.DAY_MILLIS/1000*3));
	 Tools.setCookie(response,"rcmdusr_rcmid",rcmdusr.getRcmdusr_rcmid().toString(),(int)(Tools.DAY_MILLIS/1000*3));
	 dxid=rcmdusr.getRcmdusr_rcmid().toString();
	 rcmdusr.setRcmdusr_count(rcmdusr.getRcmdusr_count()+1);
	 Tools.getManager(ProductExpPrice.class).update(rcmdusr, false);
	 ProductExpPriceItem expitem = ProductExpPriceHelper.getExpPrice(id,dxid);
	   if(expitem != null){		
			dxprice = Tools.floatValue(expitem.getRcmdgds_memberprice());
			tj_buylimit = Tools.longValue(expitem.getRcmdgds_buylimit());
			tj_saletoday = Tools.longValue(expitem.getRcmdgds_saletoday());
			rcmdgds_gdsid = expitem.getRcmdgds_gdsid();
			if(!Tools.isNull(expitem.getRcmdgds_title())){
				dxtitle = expitem.getRcmdgds_title();
			}
		}else{
			dxprice = memberprice;
		}
	}
	else
	{
		dxprice = memberprice;
	}
}
else{
 	dxid=Tools.getCookie(request,"rcmdusr_rcmid");
	if(!Tools.isNull(dxid)){
		
		ProductExpPriceItem expitem = ProductExpPriceHelper.getExpPrice(id,dxid);
		if(expitem != null){		
			dxprice = Tools.floatValue(expitem.getRcmdgds_memberprice());
			tj_buylimit = Tools.longValue(expitem.getRcmdgds_buylimit());
			tj_saletoday = Tools.longValue(expitem.getRcmdgds_saletoday());
			rcmdgds_gdsid = expitem.getRcmdgds_gdsid();
			if(!Tools.isNull(expitem.getRcmdgds_title())){
				dxtitle = expitem.getRcmdgds_title();
			}
		}else{
			dxprice = memberprice;
		}
	}
}

//获取团购价格
float tuanprice=0f;
List<PromotionProduct> tuanlist=PromotionProductHelper.getPProductByCode("7523");
if(tuanlist!=null&&tuanlist.size()>0)
{
    for(PromotionProduct pp:tuanlist)
    {
    	if(pp!=null)
    	{
    		if(pp.getSpgdsrcm_gdsid()!=null&&pp.getSpgdsrcm_gdsid().toString().equals(id)&&pp.getSpgdsrcm_enddate().after(new Date())&&pp.getSpgdsrcm_begindate().before(new Date()))
    		{
    			tuanprice=pp.getSpgdsrcm_tjprice().floatValue();
    			int r=new Random().nextInt(10);
	        	if(r==0)
	        	{
	        		r=1;
	        	}
	        	
		        pp.setSpgdsrcm_tghit(pp.getSpgdsrcm_tghit().longValue()+r);
		        if(!Tools.getManager(PromotionProduct.class).update(pp,false))
		        {
		        	System.out.print("[团购商品]商品id："+id+"更改点击数目出错!");
		        }
    		}
    	}
    }
}




long currentTime = System.currentTimeMillis();
float hyprice = 0;
if(discountendDate >= currentTime && discountendDate <= currentTime+Tools.MONTH_MILLIS && Tools.floatCompare(oldmemberprice,memberprice)!=0 && Tools.floatCompare(oldmemberprice,0) != 0){
	ismiaoshao = true;
	hyprice = oldmemberprice;
}else{
	hyprice = memberprice;
}
endprice = String.valueOf(hyprice);

String style = null;



if(!Tools.isNull(dxid)&&dxid.length()>0 && Tools.floatCompare(dxprice, memberprice) !=0){
	style = "<span>￥" + Tools.getFormatMoney(hyprice) + "</span>";
}else{
	if(tuanprice>0f)
	{
		if(Tools.floatCompare(oldmemberprice,memberprice)!=0 && Tools.floatCompare(oldmemberprice,0) != 0)
		{
		     style = "<span>￥" + Tools.getFormatMoney(oldmemberprice) + "</span>";
		}
		else{
			style = "<span>￥" + Tools.getFormatMoney(memberprice) + "</span>";
		}
	}
	else
	{
		if(ismiaoshao)
		{
			style = "<span style=\"color:#C00000;\">￥" + Tools.getFormatMoney(oldmemberprice) + "</span>";
		}
		else
		{
	       style = "<span class='mbrprice'>￥" + Tools.getFormatMoney(hyprice) + "</span>";
		}
	}
}




String category = "";//最小的类别，在下面初始化了。

//评论
int contentcount =0;
ArrayList<Comment> commentlists=getCommentList(id);
contentcount=commentlists.size();
//显示星级
int score = 0;
score=getLevelView1019(id);

String gname=Tools.clearHTML(gdsname);

if(gname.indexOf("（")>0){
	gname=gname.substring(0,gname.indexOf("（"));

}

if(gname.indexOf("(")>0){
	gname=gname.substring(0,gname.indexOf("("));
}
String fxcontent="我在@D1优尚官网 发现了一个非常不错的商品："+gname+" 优尚价：￥"+memberprice+"。感觉不错，分享一下 ";

ProductHelper.addHistory(request,response,id);

List<Product> productList = null;//物品集合list，下面用到了。

Product giftProduct = GiftHelper.getGiftProductByProductId(id);//赠品，为null就是没有单品赠品

String show="";
if(request.getParameter("st")!=null&&request.getParameter("st").trim().length()>0){
	show=request.getParameter("st").trim();
}


%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=gdsname %>【图片_价格_报价_怎么样】</title>
<meta name="keywords" content="<%=Tools.clearHTML(product.getGdsmst_gdsname()+(product.getGdsmst_keyword()==null?"":product.getGdsmst_keyword())) %>" />
<meta name="description" content="优尚网热卖产品<%=Tools.clearHTML(product.getGdsmst_gdsname())%>，在这你可以看到<%=Tools.clearHTML(product.getGdsmst_gdsname())%>的图片、评价、价格以及用户对他的使用感受，告诉你<%=Tools.clearHTML(product.getGdsmst_gdsname())%>怎么样，让您买的放心，用的开心。" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/gdsinfo.css?"+System.currentTimeMillis())%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/comment.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/sdshow.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/static.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/gdscoll.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gdsmstlistCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/result.js")%>"></script>

<script type="text/javascript">
function hidehot(){
	$("#divhotimg").hide();
}
function showhot(){
	$("#divhotimg").show();
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
//X元选Y件
function CheckForm(obj){
	var checkgds = $('#tblList input[type=checkbox]:checked');
	var iSelectCnt = checkgds.length;
    if (iSelectCnt == 0){
    	$.alert('请选择商品!');
        return;
    }
    var iMaxCount = -1;
    var strMaxCount = $('#hdnMaxCount').val();
    if (strMaxCount != null && strMaxCount.length > 0){
    	iMaxCount = parseInt(strMaxCount, 10);
    }
    if (iMaxCount != -1){
    	if (iSelectCnt != iMaxCount){
    		$.alert('请选择' + iMaxCount + '件商品!');
            return;
        }
    }
    var arr = new Array();
    checkgds.each(function(i){
    	arr[i] = $(this).val();
    });
    $('#btnAddToCart').attr('attr',arr.toString());
    $.inCart1(obj,{ajaxUrl:'/html/zt2012/20120727polo/xsyListInCart.jsp',width:600,align:'center'},{'code':$(obj).attr("code")});
}

</script>

</head>

<body>
<a name="top1120"></a>
<!--头部-->
<%@include file="/inc/head.jsp" %>
<!-- 头部结束-->
<div class="clear"></div>
<%
if(!Tools.isNull(rackCode)){
%>
<script type="text/javascript">
<%

if(rackCode.startsWith("020010")){ out.print("qunzishow();");}
else if(rackCode.startsWith("020008")||rackCode.startsWith("020009")||rackCode.startsWith("030008")||rackCode.startsWith("030009")){
	   out.print("kzshow();");
	}
else if(rackCode.startsWith("02")&&!rackCode.startsWith("020008")&&!rackCode.startsWith("020009")&&!rackCode.startsWith("021")&&!rackCode.startsWith("022")&&!rackCode.startsWith("023")){
	   out.print("womanshow();");
}
else if(rackCode.startsWith("03")&&!rackCode.startsWith("030008")&&!rackCode.startsWith("030009")&&!rackCode.startsWith("031")&&!rackCode.startsWith("032")&&!rackCode.startsWith("033")){
	   out.print("manshow();");
}
else if(rackCode.startsWith("014")){
	   out.print("zpshow();");
}
else if(rackCode.startsWith("015009")){
	   out.print("spshow();");
}
else if(rackCode.startsWith("023")||rackCode.startsWith("033")){
	   out.print("bagshow();");
}
else if(rackCode.startsWith("021")||rackCode.startsWith("022")||rackCode.startsWith("031")||rackCode.startsWith("032")){
	   out.print("shoesshow();");
	}
else if(rackCode.startsWith("015002")){
	   out.print("watchshow();");
}
else{
	   out.print("indexshow();");
}

%>
</script><%
} %>

<!-- 中间内容-->
<div id="center">
	
		 <!-- banner -->

	
	 <!--链接导航-->
	 <%  if(!rackCode.startsWith("012")){%>
		 <div class="dh">
			<img src="http://images.d1.com.cn/images2012/New/product/green.gif" width="20" height="35" align="top" style="margin-top:-10px;_margin-top:-12px;" />
			<a href="http://www.d1.com.cn/" target="_blank">首页</a><%
			if(!Tools.isNull(rackCode)){
				int size = rackCode.length();
				if(size >= 3){
					for (int i = 3; i <= size; i = i + 3){
						Directory directory = DirectoryHelper.getById(rackCode.substring(0,i));
						if(directory == null) continue;
						category = directory.getRakmst_rackname();
						if(!directory.getId().equals("015")){
							if(i==3){
								%>&nbsp;&gt;&nbsp;<a href="/result.jsp?productsort=<%=directory.getId() %>" target="_blank"><%=category %></a><%
							}else{
								%>&nbsp;&gt;&nbsp;<a href="/result.jsp?productsort=<%=directory.getId() %>" target="_blank"<%if(i==size){ %> class="othera"<%} %>><%=category %></a><%
							}
						}
					}
				}
			}
			%>
			>&nbsp;&nbsp;<%=gdsname  %>
	 	</div>    
		 
	 <%} %>
	 
	 
	    
	 <!--链接导航结束-->

	 
		 <!-- 商品展示-->
	    <div class="goodsshow">
		    
			 
			 <!--商品展示右侧-->
			<div class="gs_right">
			     <!-- 商品展示-->
			    <div class="goods_new">
					<div class="gs_right_title">
					<h1>
					<%=gdsname %>
					<%
					if(product.getGdsmst_rackcode().length()>=9 && product.getGdsmst_rackcode().startsWith("030001001")&&product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()==1){
						%>
					    &nbsp;&nbsp;&nbsp;&nbsp;<b style="color:red;">买衬衫送T恤</b>
					<%}
					
					%>
					</h1>
					<%if(Tools.longValue(product.getGdsmst_specialflag()) == 1&&!"01720068".equals(product.getId())&&!"01720270".equals(product.getId())
					&&!"01720843".equals(product.getId()) &&!"02000396".equals(product.getId())
					&&!"01517302".equals(product.getId())&&!"01517367".equals(product.getId())){ %><img src="http://images.d1.com.cn/images2012/New/product/noyhq.jpg" style="float:left;" /><%} %>
					</div>
					<hr class="newhr"/>
					<!-- 商品展示-->
					<div class="gs_right_spimg" style="position:relative;">
							<img src="<%=ProductHelper.getImageTo400(product) %>" width="400" height="400"  alt="<%= Tools.clearHTML(product.getGdsmst_gdsname()) %>"/>
							<!-- 200-50的图标 -->
							<!--
							<%
							     if(product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().length()>0&&(product.getGdsmst_rackcode().startsWith("02")||product.getGdsmst_rackcode().startsWith("03")||product.getGdsmst_rackcode().startsWith("015009"))&&Tools.longValue(product.getGdsmst_specialflag()) != 1)
							     {%>
							    	<span style="position:absolute; width:117px; height:98px; dislay:block; background:url('http://images.d1.com.cn/images2012/index2012/nov/big50.png'); left:4px; top:10px; z-index:5000;"></span>
           				 
							     <%}
							%>
							  -->
							<div class="fdtp"><img src="http://images.d1.com.cn/images2012/New/fdtp.gif" style="border:none;" align="top" /><a href="http://images.d1.com.cn/<%=product.getGdsmst_bigimg() %>" target="_blank">&nbsp;点击放大图片</a></div>
							<div class="share">
								<img src="http://images.d1.com.cn/images2012/New/share.gif" />
								<a href="javascript:void((function(s,d,e,r,l,p,t,z,c) {var%20f='http://v.t.sina.com.cn/share/share.php?appkey=2833634960',u=z||d.location,p=['&url=',e(u),'& title=',e(t||d.title),'&source=',e(r),'&sourceUrl=',e(l),'& content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a() {if(!window.open([f,p].join(''),'mb', ['toolbar=0,status=0,resizable=1,width=600,height=500,left=',(s.width- 600)/2,',top=',(s.height-600)/2].join('')))u.href=[f,p].join('');}; if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();}) (screen,document,encodeURIComponent,'','','<%=ProductHelper.getImageTo400(product) %>','<%=fxcontent %>','http://www.d1.com.cn/gdsinfo/<%=id %>.asp','utf-8'));" title="分享到新浪微博" rel="nofollow"><img src="http://images.d1.com.cn/images2012/New/sina.gif" alt="分享到新浪微博" /></a>
								<a title="分享到搜狐微博" href="javascript:void((function(s,d,e,r,l,p,t,z,c){var f='http://t.sohu.com/third/post.jsp?',u=z||d.location,p=['&url=',e(u),'&title=',e(t||d.title),'&content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a(){if(!window.open([f,p].join(''),'mb',['toolbar=0,status=0,resizable=1,width=660,height=470,left=',(s.width-660)/2,',top=',(s.height-470)/2].join('')))u.href=[f,p].join('');};if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();})(screen,document,encodeURIComponent,'','','<%=ProductHelper.getImageTo400(product) %>','<%=fxcontent %>','http://www.d1.com.cn/gdsinfo/<%=id %>.asp','utf-8'));" rel="nofollow"><img src="http://images.d1.com.cn/images2012/New/sohuwb.gif" width="18" height="17" alt="分享到搜狐微博" /></a>
								<a href="javascript:void(0)" onclick="postToWb();return false;" title="转播到腾讯微博" rel="nofollow"><img src="http://images.d1.com.cn/images2012/New/wb.gif" alt="转播到腾讯微博" /></a>
								<script type="text/javascript">
								function postToWb(){
			                        var _t = encodeURI(document.title);
			                        _t=encodeURI('<%=fxcontent.replace("@D1优尚官网","@D1优尚网") %>');
			                        var _url = encodeURIComponent('http://www.d1.com.cn/gdsinfo/<%=id %>.asp');
			                        var _appkey = encodeURI("7d55b7e157054243b4a6bd7a826cbc40");//你从腾讯获得的appkey
			                        var _pic = encodeURI('<%=ProductHelper.getImageTo400(product) %>');//（例如：var _pic='图片url1|图片url2|图片url3....）
			                        var _site = 'http://www.d1.com.cn/gdsinfo/<%=id %>.asp';//你的网站地址
			                        var _u = 'http://v.t.qq.com/share/share.php?url='+_url+'&appkey='+_appkey+'&site='+_site+'&pic='+_pic+'&title='+_t;
			                        window.open( _u,'', 'width=700, height=680, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, location=yes, resizable=no, status=no' );
			                    }
								(function(){
			                        var p = {
			                        url:'http://www.d1.com.cn/gdsinfo/<%=id %>.asp',
			                        desc:'<%=fxcontent %>',/*默认分享理由(可选)*/
			                        summary:'<%=fxcontent %>',/*摘要(可选)*/
			                        title:'<%=fxcontent %>',/*分享标题(可选)*/
			                        site: 'http://www.d1.com.cn/gdsinfo/<%=id %>.asp', /*分享来源 如：腾讯网(可选)*/
			                        pics:'<%=ProductHelper.getImageTo400(product) %>' /*分享图片的路径(可选)*/
			                        };
			                        var s = [];
			                        for(var i in p){
			                        s.push(i + '=' + encodeURIComponent(p[i]||''));
			                        }
			                        document.write(['<a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?',s.join('&'),'" target="_blank" title="分享到QQ空间" rel="nofollow"><img src="http://images.d1.com.cn/images2012/New/qq.gif" alt="分享到QQ空间" /></a>'].join(''));
			                        })();
								</script>
							</div>
							 <%
							 if(product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()!=2){
							 if((rackCode.startsWith("020")||rackCode.startsWith("030"))&&!rackCode.startsWith("020011")&&!rackCode.startsWith("020012")&&!rackCode.startsWith("030011")){%>
							
					    	 <a href="/gdscoll/freegdscoll.jsp?id=<%= id%>"  rel="nofollow" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/AUGUST/DIYdp.gif" style="border:none;"/></a><br/>
					    	 <font style="font-family:'微软雅黑'; font-size:14px; ">服饰搭配购买，立享<font style="color:#aa0000">95折</font></font>
					         <%}
							 }
					      %>
					</div>
					<!-- 商品展示结束-->
				 	<!--商品信息说明-->
				     <div class="gs_right_spContent">
                         <table border="0" cellpadding="0" cellspacing="0" width="100%">
						     <tr>
							      <td width="150">会员价：<%=style %></td>
								  <td width="100">市场价：￥<%=Tools.getFormatMoney(saleprice) %></td>
								  <td width="100"><a id="hyyhsmLink" href="javascript:void(0)">会员优惠说明</a>
								      <div class="hyyhsm" id="hyyhsm" style="display:none">
									     <span>会员优惠说明</span>
									      &nbsp;&nbsp;白金会员享受95折优惠<br/>
										  &nbsp;&nbsp;VIP会员享受98折优惠<br/>
									  </div>
									  
								  </td>
							 </tr><%
							
							 //获取活动特价
							 if(!Tools.isNull(dxid)&&dxid.length()>0){
								
								 
							 %><tr><td colspan="3"><%
								 if(!Tools.isNull(dxtitle)){
									 dxtitle = dxtitle.replace("tj_memberprice",String.valueOf(dxprice));
									 %><span style="color:#c00000;font-size:16px; font-weight:bold;"><%=dxtitle %></span><%
									 if(tj_buylimit > 0 && tj_saletoday>=tj_buylimit){
										 %>今日数额已满<%
									 }
								 }else if(!Tools.isNull(rcmdgds_gdsid)){
									 hyprice = dxprice;
									 %><b>独享价：</b><span style="color:#c00000; font-size:20px;font-family:'微软雅黑'">￥<%= dxprice %></span><%
											
								 }
							 %></td></tr><%
							 }
							 else
							 {
							 %>
							<%
						    //获取团购价
							if(tuanprice!= 0f&&Tools.floatCompare(tuanprice , oldmemberprice) != 0){
								 hyprice = tuanprice;
								 %><tr><td colspan="3">团购价：<span style="color:#c00000; font-size:20px;font-family:'微软雅黑'">￥<%=tuanprice %></span><%
									
								 %></td></tr>
								 <%
								 }
							 }
								 %>
						
							 
							 <tr><td colspan="3"><hr/></td></tr><%
							 if(ismiaoshao){//是否是秒杀
								 if(Tools.isNull(rcmdgds_gdsid)){
									 hyprice = memberprice;
								 %>
									 <tr><td colspan="3">
							         <%=GetXSMS(discountendDate,memberprice,oldmemberprice) %>
							         </td></tr>
								 <%}
							 %>
							 <%
							 }if("1".equals(chePingAn)){
							 %>
							 <tr><td colspan="3">
							 	<font color=#F47320>积分兑换需要：<font size=+1><b><%=(int)hyprice*500 %></b></font>分<br />现金购买此商品可获得：<font size=+1><b><%=(int)hyprice*30 %></b></font>分</font>
							 </td></tr><%} %>
							 <tr height="40">
							     <td>商品编码：<%=id %></td>
								 <td colspan="2">
								 
								 <%//if(rackCode != null && rackCode.startsWith("017")) %><!--  <b>30天内无条件退换货</b>--></td>
							 </tr><%
							 if(!Tools.isNull(brandName)){
								 if(brandName!=null)brandName=brandName.trim();
								 String rackcode_temp = product.getGdsmst_rackcode();
								 if(rackcode_temp!=null&&rackcode_temp.length()>=3){
									 rackcode_temp = rackcode_temp.substring(0,3);
									 String url="/result.jsp?productsort="+rackcode_temp+"&productbrand="+java.net.URLEncoder.encode(brandName,"UTF-8")+"&bf=1";
									 ArrayList<Brand> blist=BrandHelper. getBrandInfo(rackcode_temp,product.getGdsmst_brand().trim());
									 if(blist!=null && blist.size()>0){
										 if(!Tools.isNull(blist.get(0).getBrand_url())){
											 url=blist.get(0).getBrand_url();
										 }
									 }
									 
							 %>
							  <tr>
							     <td colspan="3">品　　牌：<font color="#c0000">[<a href="<%=url %>" target=_blank rel="nofollow"><%=brandName %></a>]</font>
							     <%
							     
							     if ("001346".equals(product.getGdsmst_brand())||"001691".equals(product.getGdsmst_brand())
							    		 ||"001564".equals(product.getGdsmst_brand())){
							    	 
							    	 if(product.getGdsmst_gdscoll()!=null&&product.getGdsmst_gdscoll().length()>0){
							    		 String url1="";
							    		 String brand="";
							    		 if ("FEEL MIND".equals(brandName))  brand="feelmind";
							    		 if("诗若漫".equals(brandName)) brand="sheromo";
							    		 if("AleeiShe 小栗舍".equals(brandName)) brand="aleeishe";
							    		 
							    		 Gdsser g=GdsserHelper.getGdsserByName(product.getGdsmst_gdscoll());
							    		 if(g!=null&&brand.length()>0){
							    			 url1="/brand/"+brand+"/series.jsp?serid="+g.getId();
							    			 %>
							    			 &nbsp;&nbsp;&nbsp;&nbsp;  系列：<font color="#c0000">[<a href="<%=url1 %>" target=_blank rel="nofollow"><%=g.getGdsser_title().trim() %></a>]</font>
							       <%
							               }
							    	 }
							     }
							     %>
							     </td>
							 </tr> <%
								 }
							 }
							 
							 %>
						     <tr height="40">
							     <td colspan="3">
							     	<div style="float:left; padding-top:6px;">顾客评分：</div>
							     	<div class="sa<%=score %>" style="float:left;" ></div>
								    <div style="float:left; padding-top:6px;"><a href="#cmt2" onclick="$('#sdLink').hide();$('#commLink').show();$('#ssd').hide();$('#scomment').show();"  rel="nofollow">(已有<%=contentcount %>人评价)</a>
								     &nbsp; &nbsp; &nbsp; &nbsp;
								    <%
								    ArrayList<MyShow> showlist=ShowOrderHelper.getAllShowByGdsid(product.getId());
								    int showlen=showlist==null ? 0:showlist.size();
								    if(showlen>0){
								    	%>
								    	<a href="#sd"  rel="nofollow" onclick="$('#sdLink').show();$('#commLink').hide();$('#ssd').show();$('#scomment').hide();" ><%=showlen %>人晒宝贝</a>
								   <% }
								    %>
								    </div>
								    
								 </td>
						     </tr>
							 <tr>
							     <td colspan="3">
								     <div class="spgg"><%
									    //颜色
									    GoodsGroup group = getGroup(product);
									    if(group != null){
										    List<GoodsGroupDetail> groupList = getGroupDetail(group);
										    if(groupList!= null && !groupList.isEmpty()){
										    	int count=0;
										    	for(GoodsGroupDetail ggd : groupList)
										    	{
										    		String gId = Tools.trim(ggd.getGdsgrpdtl_gdsid());
										    		Product goods = ProductHelper.getById(gId);
										    		if(goods!=null&&goods.getGdsmst_validflag().longValue()==1&&goods.getGdsmst_ifhavegds().longValue()==0)
										    		{
										    			count++;
										    		}
										    	
										    	}							    	
                                                if(count>1)
                                                {										    	
										    	%><div id="skuname2" class="skuname1">
										    	<p>选择<%=Tools.formatString(group.getGdsgrpmst_stdname()) %>：<font id="sizecount2"></font></p>
									    		<ul><%
									    		String selectSku2 = "";
										    	for(GoodsGroupDetail ggd : groupList){
										    		String gId = Tools.trim(ggd.getGdsgrpdtl_gdsid());
										    		Product goods = ProductHelper.getById(gId);
										    		if(goods!=null&&goods.getGdsmst_validflag().longValue()==1)
										    		{
										    		%><li<%if(product.getId().equals(goods.getId())){ selectSku2 = ggd.getGdsgrpdtl_stdvalue(); %> class="select"<%} %>>
										    		<a href="<%=ProductHelper.getProductUrl(goods) %>"  attr="<%=ggd.getId() %>" hidefocus="true"<%if(product.getId().equals(goods.getId())){ %> class="current"<%} %>><img src="<%=ProductHelper.getImageTo80(goods) %>" />
										    		</a>
										    		<br/><br/><br/><%=ggd.getGdsgrpdtl_stdvalue() %></li><%
										    		}
										    	}
										    	%></ul>
										    	</div>
										    	<script type="text/javascript">$('#sizecount2').html('<%=selectSku2 %>');</script><%
										        }
										    }
									    }
									    
									    ///sku
									     List<Sku> skuList=new ArrayList<Sku>();
									    if(!Tools.isNull(skuname1)){
									    	int showsku=1;
									    	if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==0||product.getGdsmst_stocklinkty().longValue()==3)){
									    		showsku=0;
									    	}
									    	//System.out.println(showsku);
										   	 skuList = SkuHelper.getSkuListViaProductIdO(id,showsku);
										    if(skuList != null && !skuList.isEmpty()){
										    	int size = skuList.size();
										    	%><div id="skuname" class="skuname">
										    		<p>选择<%=skuname1 %>：<font id="sizecount"><%=size==1?skuList.get(0).getSkumst_sku1():"未选择" %></font>
										    		<%  ArrayList<GdsAtt> list=GdsAttHelper.getGdsAttByGdsid(id);
										    		
										    		
										    		   if(list!=null&&list.size()>0 || (product.getGdsmst_sizeid()!=null && product.getGdsmst_sizeid()>0))
										    		   {
										    			   String sizeinfo="";
											    		   if(product.getGdsmst_sizeid()!=null && product.getGdsmst_sizeid()>0){
											    			   sizeinfo= getsizeinfo(product);
											    		   }
										    			   if((list.size()>0&& list.get(0).getGdsatt_content().length()>0) || !Tools.isNull(sizeinfo)){
										    		    %>
										    			   <font id="ccdzb" style=" color:#020399; cursor:hand;" onmouseover="ccdzb()" onmouseout="ccdzb1()">(尺寸对照表)</font></p>
										    		      <div id="ccdzb_img" style="position:absolute;display:none; z-index:2222;<%if(!Tools.isNull(sizeinfo)) {%>border:1px solid black;background-color:#ffffff;<%} %>" onmouseover="ccdzb()" onmouseout="ccdzb1()">
										    		    <%
										    		      if(!Tools.isNull(sizeinfo)){
													    		 out.print(sizeinfo);
													    	  }else{%>
										    		    <%= list.get(0).getGdsatt_content() %>
										    		      <%  }%>
										    		    </div>
										    			  <%   }
										    			   
										    		  }
										    		   else
										    		   {%>
										    			   </p>
										    		   <%
										    		   
										    		   }
										    		%>
										    		
										    		<ul>
										    		<%
										    		for(int i=0;i<size;i++){
										    			Sku sku = skuList.get(i);
										    			String skuname = sku.getSkumst_sku1();
										    			if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
										    				if(CartItemHelper.getProductOccupyStock(product.getId(), sku.getId())<ProductHelper.getVirtualStock(product.getId(), sku.getId())){
											    				%><li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a><i>&nbsp;&nbsp;</i></li><%
										    				}
										    				else
										    				{
										    					if(sku.getSkumst_vstock().longValue()==0){ %>
										    						<li><a href="javascript:void(0);" title="售罄"   hidefocus="true"  style="height:21px;line-height:21px;padding:0 9px;border:1px solid #dcdddd;background:#fff;color:#dcdddd;text-decoration:none;"><span><%=skuname %></span></a><i>&nbsp;&nbsp;</i></li>
										    					<%}
										    					else
										    					{%>
										    						<li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a><i>&nbsp;&nbsp;</i></li>
										    					<%}
										    				}
										    			}else{
										    	           if(sku.getSkumst_validflag()!=null&&sku.getSkumst_validflag().longValue()==1)
										    	           {
										    	        	   if(sku.getSkumst_vstock()!=null&&sku.getSkumst_vstock().longValue()<=0&&product.getGdsmst_ifhavedate()!=null&&product.getGdsmst_ifhavedate().after(new Date()))
										    	        	   {
										    			%><li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" flag="1" onclick="choosesku20120717(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a><i>&nbsp;&nbsp;</i></li><%
										    	               }
										    	        	   else
										    	        	   {%>
										    	        		   <li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" flag="0" onclick="choosesku20120717(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a><i>&nbsp;&nbsp;</i></li>
										    	        	   <%}
										    	           }
										    			}
										    		}
										    		%>



										    		
										    		
										    		
										    		</ul>
										    	</div><div class="clear"></div><%
										    }
									    }
									    endprice = (Tools.floatCompare(dxprice,0)==0 ? Tools.getFormatMoney(memberprice) : Tools.getFormatMoney(dxprice));
									    %>
										<div>
											<span>我要购买</span>
											<a href="###" title="减1" class="minus" onclick="addorminus('minus',<%=buylimit %>,'<%=endprice %>')" ><img src="http://images.d1.com.cn/Index/images/j_a.gif"  /></a>
										    <input type="text" id="num_input" objNum="1" value="1" onkeyup="keynum(this,<%=endprice %>);" maxlength='3' class="num" />
										    <a href="###" title="加1" class="add" onclick="addorminus('add',<%=buylimit %>,'<%=endprice %>')"><img src="http://images.d1.com.cn/Index/images/a_j.gif"  /></a><br />
										    <span>小计：</span><b><font color="#a22d48" id="pricecount">￥<%=endprice %></font></b>
										    <%
										    if(product.getGdsmst_stocklinkty()!=null&&product.getGdsmst_stocklinkty().longValue()==0){
										    	Date ifhaveDate = product.getGdsmst_ifhavedate(); 
												if(ifhaveDate != null){//那就是有到货期限。
													if(ifhaveDate.after(new Date()))
													{
													  	if(!Tools.isNull(skuname1)){
													    	String str="";
													    	for(int i=0;i<skuList.size();i++){
												    			Sku sku = skuList.get(i);
												    			String skuname = sku.getSkumst_sku1();
												    			if(sku.getSkumst_validflag()!=null&&sku.getSkumst_validflag().longValue()==1&&sku.getSkumst_vstock()!=null&&sku.getSkumst_vstock().longValue()==0)
												    			{
												    				str+=skuname+"，";
												    			}
													    	}
													    	if(str.length()>0)
													    	{
															   out.print("<br/><font style=\"color:#f66500\">该商品"+skuname1+str+"预计"+(ifhaveDate.getMonth()+1)+"月"+ifhaveDate.getDate()+"日到货，建议您单独下单购买。</font>");
													    	}
													    }
													    else
													    {
													    	if(product.getGdsmst_ifhavegds()!=null&&(product.getGdsmst_ifhavegds().longValue()==0)){
														  	out.print("<br/><font style=\"color:#f66500\">该商品预计"+(ifhaveDate.getMonth()+1)+"月"+ifhaveDate.getDate()+"日到货，建议您单独下单购买。</font>");
													    	}
													    }
												    }
													}
													
												  
													
												
										    	
										    }
										    %>
										</div><%
										if(giftProduct != null&&giftProduct.getGdsmst_validflag()!=null&&giftProduct.getGdsmst_validflag().longValue()==1){
											String giftTitle = Tools.clearHTML(giftProduct.getGdsmst_gdsname());
										%>
										<div class="breakall" style="width:100%;">
											<font color="#892e3f"><b>赠品：</b></font><a href="<%=ProductHelper.getProductUrl(giftProduct) %>" target="_blank" title="<%=giftTitle %>"><%=StringUtils.getCnSubstring(giftTitle,0,44) %></a>
										</div><%
										} %>
									 </div>
								 </td>
							 </tr>
							 <tr height="60"><td colspan="3" valign="middle"><%
							if(ifhavegds == 0){
								if(validflag == 1){
									if(ProductStockHelper.canBuy(product)){
										 if(product.getGdsmst_stocklinkty()!=null&&product.getGdsmst_stocklinkty().longValue()==0)
										 { 
								                Date ifhaveDate1 = product.getGdsmst_ifhavedate(); 
									            if(ifhaveDate1 != null&&ifhaveDate1.after(new Date())) {
									            	if(skuList != null && !skuList.isEmpty()){%>
									            	 <a href="javascript:void(0)" onclick="ShowAJax('<%=id %>')"><img id="gwc0717" src="http://images.d1.com.cn/images2012/New/frgwc.gif" /></a>
							           
									            	<%}
									            	else
									            	{
									            		if(product.getGdsmst_ifhavegds()!=null&&(product.getGdsmst_ifhavegds().longValue()==1||product.getGdsmst_ifhavegds().longValue()==2)){
														  	
									                  %>
								                <a href="javascript:void(0)" onclick="ShowAJax('<%=id %>')"><img id="gwc0717" src="http://images.d1.com.cn/images2012/index2012/ydgsp.jpg" /></a>
						                         <%    }
									            		else{%>
									            			<a href="javascript:void(0)" onclick="ShowAJax('<%=id %>')"><img id="gwc0717" src="http://images.d1.com.cn/images2012/New/frgwc.gif" /></a>
									            		<%}
									            	}
									            }
									            else
									            {%>
									            	 <a href="javascript:void(0)" onclick="ShowAJax('<%=id %>')"><img id="gwc0717" src="http://images.d1.com.cn/images2012/New/frgwc.gif" /></a>
						         
									            <%}
										 }
									    else
									    {%>
							             <a href="javascript:void(0)" onclick="ShowAJax('<%=id %>')"><img id="gwc0717" src="http://images.d1.com.cn/images2012/New/frgwc.gif" /></a>
							            <%} %>
							 <div class="frgwc_div" id="frgwc" style="display:none;">
							    <span style="position:relative;overflow:hidden;">
							    	<font id="countgdsmst1">1</font>件商品加入购物车
							    	<a href="###" class="ui-dialog-titlebar-close ui-corner-all" onclick="$('#frgwc').hide();"><span class="ui-icon ui-icon-closethick">close</span></a>
							    </span>
								<ul>
								<li>
								    <img src="http://images.d1.com.cn<%=product.getGdsmst_smallimg() %>" width="80" height="80" />
									<div style="height:80px;"> <font style="_font-size:12px; "><b>
                                        <%=gdsname %></b></font>
									<br/><br/>
									    加入数量：<font id="countgdsmst2">1</font><br/>
									    总计金额:￥<font id="countgdsmst3"><%=endprice %></font><br/>
									</div>
								
								</li>
								</ul>
								<div class="gwcbtn"><a href="/flow.jsp" target="_blank" onclick="display_hide('frgwc');"><img src="http://images.d1.com.cn/images2012/New/viewcart.gif" alt="查看购物车" /></a><a href="javascript:void(0)" onclick="display_hide('frgwc')"><img src="http://images.d1.com.cn/Index/images/jxgw.jpg" alt="继续购物" /></a>							</div>
							 </div>
							 &nbsp;&nbsp;<a href="###" onclick="addFavorite('<%=id %>');"><img src="http://images.d1.com.cn/images2012/New/jrsc.gif" /></a><%
									}else
										{%>
											<img src="http://images.d1.com.cn/images2012/New/product/yxj.gif" align="absmiddle" />
										<%}
							 
								}else if(validflag != 4){
									%><img src="http://images.d1.com.cn/images2012/New/product/yxj.gif" align="absmiddle" /><%
								}
							 }else if(ifhavegds == 1){//有到货时间
								Date ifhaveDate = product.getGdsmst_ifhavedate(); 
								if(ifhaveDate != null){//那就是有到货期限。
									long spanDay = (ifhaveDate.getTime()-System.currentTimeMillis())/Tools.DAY_MILLIS+1;
									if(spanDay > 0){
										%><span class="dhtx">暂时缺货，预计<%=spanDay %>天到货</span><%
									}else{
										%><span class="dhtx">暂时缺货，近期将到货！</span><a href="###" onclick="emailTZ('<%=id %>');"><img src="http://images.d1.com.cn/images2012/New/dhnotice.gif" align="absmiddle" /></a><%
									}
								}else{
									%><span class="dhtx">暂时缺货，近期将到货！</span><a href="###" onclick="emailTZ('<%=id %>');"><img src="http://images.d1.com.cn/images2012/New/dhnotice.gif" align="absmiddle" /></a><%
								}
							 }else if(ifhavegds == 2){//缺货时间未定
								%><span class="dhtx">暂时缺货，到货时间未定！</span><a href="###" onclick="emailTZ('<%=id %>');"><img src="http://images.d1.com.cn/images2012/New/dhnotice.gif" align="absmiddle" /></a><%
							 }else if(ifhavegds == 3){//非卖品
								%><span class="dhtx">此商品为非卖品，暂时不能订购！</span><%
							 } %></td></tr>
							  <tr><td colspan="3">消费1元积1分 评论/分享得积分。</td></tr>
							 <tr><td colspan="3" height="8"></td></tr>
							 <%
							 List<YhNews> yhNewsList = YhNewsHelper.getYhNewsList(product,4);
							 if(giftProduct != null || (yhNewsList != null && !yhNewsList.isEmpty())){
							 %>
							
							 <tr>
							     <td colspan="3">
								    <div class="zxyh">
									    <font color="#892e3f"><b>最新优惠：</b></font>
									    <ul><%
									    if(yhNewsList != null && !yhNewsList.isEmpty()){
									    for(YhNews info : yhNewsList){
									    	String title = Tools.clearHTML(info.getYhnews_title());
									    %>
										<li><a href="<%=Tools.trim(info.getYhnews_link()) %>" title="<%=title %>" target="_blank" class="anew" rel="nofollow"><%=title %></a></li><%
										}} %>
										</ul>
									</div>
									<div class="clear"></div>
								 </td>
							 </tr><%
							 } %>
						 </table>		 
					 </div>
					  <!--商品信息说明结束-->
				  </div>
				 <!-- 商品展示结束-->
				<div class="clear"></div>
				
				 
				 <!-- 最佳组合-->
				 <a name="gdsgrp"></a>
				 <%  String zhsp="";
				     zhsp=getGdscoll(product);
				 if(product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()!=2)
				 {
				 //String zhsp = getGdspkt(product);
				
				 //if(id.equals("01715898")||id.equals("03000042")||id.equals("02000034")||id.equals("01711848")||id.equals("01711853")||id.equals("03000033")||id.equals("02000023")||id.equals("01711849")||id.equals("01711854")||id.equals("01715900")||id.equals("01717061")||id.equals("03000040")||
						 //id.equals("02000033")||id.equals("01716995")||id.equals("01716996")||id.equals("03000068")||id.equals("02000032")||id.equals("01711846")||id.equals("01711851")||id.equals("03000018")||id.equals("02000021")||id.equals("03000017")||id.equals("02000020")||id.equals("01717060")){
					 //zhsp=getGdscoll0719(product);
				 //}
				// else
				// {
					
				// }
				// String zhsp=getGdscoll(product);
				 %><%=zhsp!=null?zhsp:"" %>
				 <%} %>
				 <!-- 最佳组合结束-->
				
				<!-- 相关商品 -->
				<%if(product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()==2)
				 {%>
				<% 
				request.setAttribute("code", rackCode);
			    request.setAttribute("length", 12);
			%>
				<jsp:include   page= "/html/getProductCList.jsp"   />
				<%} %>
				 <!--商品信息描述-->
				 <div style=" text-align:left;" ><a name="cmt"></a>
				 <hr style=" border:5px solid #fff" />
				  <%
				 boolean isdp=false;
				 if ("001346".equals(product.getGdsmst_brand())||"001691".equals(product.getGdsmst_brand())
			    		 ||"001564".equals(product.getGdsmst_brand()) || product.getGdsmst_rackcode().startsWith("02") || product.getGdsmst_rackcode().startsWith("03")){
				ArrayList<Gdscolldetail> scolllist=GdscollHelper.getGdscolldetailBygdsid(product.getId().trim());
				 if(scolllist!=null && scolllist.size()>0){
					 for(Gdscolldetail d:scolllist){
						 Gdscoll scoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(d.getGdscolldetail_gdscrollid().toString()) ;
							if(scoll!=null && scoll.getGdscoll_flag().longValue()==1){
								isdp=true;
							}
					 }
					 
				 }}
					if(isdp){ %>
					 <div id="divhotimg" style="padding-left:160px;"><img src="http://images.d1.com.cn/images2012/product/hot.gif"/></div>
				  <%}
				 %>
				 <div id="goodsinfotab" class="zh_title"><a href="#cmt" class="newa" onclick="showhot();" attr="info">商品信息</a>
				<%
				    if(isdp){%>
				    	<a href="#cmt" onclick="hidehot();" attr="dp">搭配推荐</a>
				    <%}
				if(showlen>0){%>
					<a href="#cmt" attr="sd">优格晒单</a>
				<%}				
				%>
			
					
					<a href="#cmt" attr="com">顾客评论</a><a href="#cmt" attr="q">商品问答</a><a href="#cmt" attr="s">售后服务</a><a href="#cmt" attr="zf">支付配送</a>
					<%if (product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().length()>=9&&"015002003".equals(product.getGdsmst_rackcode().substring(0, 9))) { %><a href="#cmt" attr="zippo">关于Zippo</a><%} %>
					<%if (product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().length()>=3&&"014".equals(product.getGdsmst_rackcode().substring(0, 3))) { %><a href="#cmt" attr="zpbz">正品保证</a><%} %>
					<a href="#top1120" style="background:none;padding-right:0px; margin-right:0px; margin-top:5px; border:none; float:right;" onclick="ShowAJax('<%=id %>')"><img  src="http://images.d1.com.cn/images2012/index2012/nov/gwc.jpg" width="93" height="23"/></a>				
					
					</div>
					<div class="clear"></div>
					<div id="content_list_info">
					<!-- 商品信息-->
					<span style="display:block">
					 <div class="goods_info">
					    <%
					       if(!Tools.isNull(product.getGdsmst_stdvalue1())||!Tools.isNull(product.getGdsmst_stdvalue2())||!Tools.isNull(product.getGdsmst_stdvalue3())||!Tools.isNull(product.getGdsmst_stdvalue4())||!Tools.isNull(product.getGdsmst_stdvalue5())
					    		   ||!Tools.isNull(product.getGdsmst_stdvalue6())||!Tools.isNull(product.getGdsmst_stdvalue7())||!Tools.isNull(product.getGdsmst_stdvalue8())){
					    //if(!Tools.isNull(getGGInfo(product))){ --%>
					    <div class="gstitle"><img src="http://images.d1.com.cn/images2012/New/Info.jpg" />商品基本信息</div>
						<div class="goods_content_list">
							<%=getGGInfo(product) %>
						</div>
						<%} %>
						<%if (product.getGdsmst_briefintrduce()!=null&&product.getGdsmst_briefintrduce().length()>25) {%>
						<div class="gstitle"><img src="http://images.d1.com.cn/images2012/New/Info.jpg" />商品简介</div>
						<div class="goods_content_list">
							<%String gdsduct=product.getGdsmst_briefintrduce().replace("\r", "<br>");
							gdsduct=product.getGdsmst_briefintrduce().replace("\n", "<br>");
							out.print(gdsduct);  %>
						</div>
						<%} %>
						<div class="gstitle"><img src="http://images.d1.com.cn/images2012/New/spxq.jpg" />商品详情</div>					
						    
						<div class="goods_content goods_info_con">
						<div id="gdsHweight">
						<script >getHweight("<%=id %>");</script>
						</div>
						<% String aaa= product.getGdsmst_detailintruduce();
						       aaa=aaa.replace("‘","'");
						       aaa=aaa.replace("’","'");
						       if(!aaa.contains("<DIV id=2012test></DIV>")){
						       if(brandName.equals("诗若漫")&&aaa.indexOf("http://images.d1.com.cn/zt2012/201205sheromo/brandstory.jpg")>=0)
						        {
						        	aaa=aaa.replace("<IMG src=\"http://images.d1.com.cn/zt2012/201205sheromo/brandstory.jpg\">","");
						        	aaa=aaa.replace("<IMG border=\"0\" src=\"http://images.d1.com.cn/zt2012/201205sheromo/brandstory.jpg\">","");
						        	aaa=aaa.replace("<IMG border=\"0\" src=\"http://images.d1.com.cn/zt2012/201205sheromo/brandstory.jpg\" width=\"750\">", "");
						        	aaa=aaa.replace("<IMG src=\"http://images.d1.com.cn/zt2012/201205sheromo/brandstory.jpg\" width=\"750\">", "");
						       
						        }
						        else if(brandName.equals("AleeiShe 小栗舍")&&aaa.contains("http://images.d1.com.cn/zt2011/aleeisheweb/images/title_15.jpg"))
						        {
						        	aaa=aaa.replace("<IMG src=\"http://images.d1.com.cn/zt2011/aleeisheweb/images/title_15.jpg\">","");
						        	aaa=aaa.replace("<IMG src=\"http://images.d1.com.cn/zt2011/aleeisheweb/images/brandstory1.jpg\">", "");
						        	aaa=aaa.replace("<IMG border=\"0\" src=\"http://images.d1.com.cn/zt2011/aleeisheweb/images/title_15.jpg\">","");
						        	aaa=aaa.replace("<IMG border=\"0\" src=\"http://images.d1.com.cn/zt2011/aleeisheweb/images/brandstory1.jpg\">", "");
						        	aaa=aaa.replace("<IMG border=\"0\" src=\"http://images.d1.com.cn/zt2011/aleeisheweb/images/title_15.jpg\" width=\"750\">", "");
						        	aaa=aaa.replace("<IMG src=\"http://images.d1.com.cn/zt2011/aleeisheweb/images/title_15.jpg\" width=\"750\">", "");
						        	aaa=aaa.replace("<IMG border=\"0\" src=\"http://images.d1.com.cn/zt2011/aleeisheweb/images/brandstory1.jpg\" width=\"750\">", "");
						        	aaa=aaa.replace("<IMG src=\"http://images.d1.com.cn/zt2011/aleeisheweb/images/brandstory1.jpg\" width=\"750\">", "");
						        	
						        }
						        else if(brandName.equals("FEEL MIND")&&aaa.indexOf("http://images.d1.com.cn/zt2011/fm201204/images/15_1.jpg")>=0)
						        {
						        	aaa=aaa.replace("<IMG src=\"http://images.d1.com.cn/zt2011/fm201204/images/15_1.jpg\">","");
						        	aaa=aaa.replace("<IMG border=\"0\" src=\"http://images.d1.com.cn/zt2011/fm201204/images/15_1.jpg\">","");
						        	aaa=aaa.replace("<IMG border=\"0\" src=\"http://images.d1.com.cn/zt2011/fm201204/images/15_1.jpg\" width=\"750\">", "");
						        	aaa=aaa.replace("<IMG src=\"http://images.d1.com.cn/zt2011/fm201204/images/15_1.jpg\" width=\"750\">", "");
						        	
						        }
						       }
						        else{}
						       out.print(aaa);	   
						    %>
						    <p id="20121023test"></p>
						</div>
						<%if (!"01517418".equals(product.getId())){ %>
						<%=getBrandName(product) %>
						<%} %>
						
					 </div>
					 </span>
					<!--商品信息结束-->
						 <%
						 if(isdp)
						 {
					 %>
					<span style="display:none;">
					<div id="divdp"></div>
					<script type="text/javascript">ggdscoll_product('','','',"<%=product.getId()%>")</script>
					</span>
					<!--搭配推荐结束-->
					<%} %>
				<%
				   
				if(showlen>0){%>
					<span style="display:none;"></span>
				<%}				
				%>
					<span style="display:none;"></span>
				  
					<!--商品问答-->
					<span style="display:none;">
					<div class="spwd">
					    <div class="wxts">
					    	<div class="textbox1">温馨提示：因厂家更改商品包装、产地或者更换随机附件等没有任何提前通知，且每位咨询者购买情况、提问时间等不同，为此以下回复仅对提问者3天内有效，其他网友仅供参考！若由此给您带来不便请多多谅解，谢谢！</div>
						</div>
						<div class="spwdlist">
						   <div class="spwdsub">
							 <div class="zxcontent_hf"><%
							List list = GoodsAskHelper.getlistByProductId(id,0,2);
							 if(list != null && !list.isEmpty()){
								 int size = list.size();
							 %>
							 <table width="768"><%
							 for(int i=0;i<size;i++){
								 GoodsAsk ask = (GoodsAsk)list.get(i);
								 String lblmember = "";
								 String lblmberuid ="";
								 if(Tools.longValue(ask.getGdsask_mbrid()) ==0){
									 lblmember = "游客";
									 lblmberuid = "游客";
								 }else{
									 lblmberuid = getUid(ask.getGdsask_uid());
									 User user = UserHelper.getById(String.valueOf(ask.getGdsask_mbrid()));
									 lblmember = UserHelper.getLevelText(user);
								 }
							 %>
							 <tr class="<%=i%2==0?"bc":"bc1" %>">
							     <td>
								     <table>
								     <tr><td height="10"></td></tr>
								     <tr style="width:768px;">
								     	<td style=" text-align:right; width:798px;">
								     		用户：<input type="text" id="lblmbruid" class="<%=i%2==0?"bcother":"bcother1" %>" value="<%=lblmberuid %>" style=" color:#464646; border:none; text-align:center; width:120px;" />
								     		&nbsp; &nbsp;<input type="text" id="lblmember" value="<%=lblmember %>" class="<%=i%2==0?"bcother":"bcother1" %>" style="color:#464646;border:none; text-align:center;  width:60px;" />
								     		&nbsp; &nbsp;<%=Tools.stockFormatDate(ask.getGdsask_createdate()) %>
								     	</td>
								     </tr>
								     <tr>
								     	<td><img src="http://images.d1.com.cn/Index/images/zxnr.jpg" />&nbsp;咨询内容：<%=Tools.clearHTML(ask.getGdsask_content()) %></td>
								     </tr>
								     <tr><td  height="10"></td></tr>
								     <tr>
								     	<td style=" color:#ac4d61;"><img src="http://images.d1.com.cn/Index/images/wthf.jpg" />&nbsp;D1回复：<%=ask.getGdsask_replyContent() %></td>
								     </tr>
								     <tr><td  height="10"></td></tr>
									 </table>
								 </td>
							 </tr><%
							 } %>
							 </table><%
							 } %>
							 </div>
						   </div>
						   <div class="clear"></div>
						   <br/>
						   <hr style="border:solid 10px #fff; width:100%; +width:768px;" /> 
						   <div class="fbzx">发表咨询 </div>
						   <div class="fbzx_sm">
						   	声明：您可在购买前对产品包装、颜色、运输、库存等方面进行咨询，我们有专人进行回复！因厂家随时会更改一些产品的包装、颜色、<br />
				                               产地等参数，所以该回复仅在当时对提问者有效，其他网友仅供参考！咨询回复的工作时间为：周一至周日：9:00至21:00，请耐心等待工作人员的回复。

						   </div>
						   
						   <div class="zxlx">
						   <font style=" color:#000; font-weight:bold; ">咨询类型</font>
						      <input id="Radio6" name="asktype" type="radio" checked="checked"  value="1"/><label for="Radio6">商品咨询</label>
						      <input id="Radio7" name="asktype" type="radio"  value="2"/><label for="Radio7">库存及配送</label>
						      <input id="Radio8" name="asktype" type="radio"  value="3"/><label for="Radio8">支付问题</label>
						      <input id="Radio9" name="asktype" type="radio"  value="4"/><label for="Radio9">发票及保修</label>
						      <input id="Radio10" name="asktype" type="radio"  value="5"/><label for="Radio10">促销及赠品</label>
							  <br/><br/>
						   <font style="color:#000; font-weight:bold;">咨询内容</font><br/>
						   <textarea id="txtcontent" class="zxtext"></textarea>
						   <br/><br/>
						   <a href="javascript:void(0)" onclick="AddAsk()"><img src="http://images.d1.com.cn/Index/images/submit.jpg" /></a>
						   </div>
						</div>
					</div>
					</span>
					
					<!--商品问答结束-->
					
					<!--售后服务-->
					<span style="display:none;">
					<script>getSHFW();</script>
						
					</span>
					<!--售后服务结束-->
					
					<!--支付配送-->
					<span style="display:none;">
					<script>getzfps();</script>
						
					</span>
					<!--支付配送结束-->
					<!-- 关于Zippo开始 -->
					<%if (product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().length()>=9&&"015002003".equals(product.getGdsmst_rackcode().substring(0, 9))) { %>
					<span style="display:none;">
					<script>getZippo();</script>
					</span>
					<%} %>
					<!-- 关于Zippo结束 -->
					
					<!-- 正品保证开始 -->
					<%if (product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().length()>=3&&"014".equals(product.getGdsmst_rackcode().substring(0, 3))) { %>
                    <span style="display:none;">
                     <a name="zpbz"></a>
					<script>getZpbz();</script>
					</span>
			<%} %>
					<!-- 正品保证结束 -->
					
					
					<!-- 商品晒单开始 -->
					<hr style=" border:5px solid #fff" />
					<div style="line-height:1px;height:1px;baclground:#FFF;">
					<a name="sd"></a></div>
					<%
					if(showlen>0){
						%>
					
					<div class="zh_title" id="sdLink"><a href="javascript:void(0)" class="newa">优格晒单</a></div>
					<!--商品晒单-->
					<span id="ssd">
					<%
					
						 int currentPageIndex=1;
						 int pagesize=15;
						 PageBean pBean = new PageBean(showlen,pagesize,currentPageIndex);
						 int end = pBean.getStart()+pagesize;
					 	    if(end > showlen) end = showlen;
					 	 
					 	  List<MyShow> list2 =showlist.subList(pBean.getStart(),end);
					 	 int size=list2.size();
					 	   if(list2!=null && size>0){
					 		%>
					 		<div style="width:750px;padding-top:15px;" name="sdCont" id="SdContent">
					 		<%   
					 		   int row=size/3;//得到行数,及每列个数
					 		   int last=size%3;
					 		   int l1=0; int l2=0; 
					 		   if(last==1){
					 			   l1=1;
					 		   }else if(last==2){
					 			  l1=1;
					 			  l2=1;
					 		   }
					 		   for(int i=0;i<size;i++){
					 			  MyShow show1=list2.get(i); 
				 				  Product p=ProductHelper.getById(show1.getMyshow_gdsid());
				 				
				 				 String uid=show1.getMyshow_mbruid();
				 				 if(uid.trim().length()<6){
				 					 uid="***"+uid+"***";
				 				 }else{
				 					 uid="***"+uid.substring(0, 5)+"***";
				 				 }
				 				String imgurl="http://images1.d1.com.cn";
								if( show1.getMyshow_img400500().indexOf("/uploads/sd/")>=0){
									imgurl="http://d1.com.cn";
								}
					 			   if(i==0){
					 					%>   
					 					<div style="float:left; padding-left:15px;">
					 				  <% }else if(i==row+l1){
					 					 %>   
					 					 </div>
					 					  <div style="float:left; ">
					 				   <% }else if(i==2*row+l1+l2){
						 					 %>   
						 					 </div>
						 					  <div style="float:left;">
						 				   <% }
						 				    if(p!=null){
				 				  %>   
				 				   <div  class="poster_grid poster_wall pins" > 
									<div class="new_poster"> 
									<div class="np_pic hover_pic">   
									<a target="_blank" href="<%=imgurl+show1.getMyshow_img400500() %>" class="pic_load">
									<img width="200" title="" src="<%=imgurl+show1.getMyshow_img240300() %>" onmouseover="sdimg_over('<%= show1.getId()%>')" onmouseout="sdimg_out('<%= show1.getId()%>')" class="goods_pic" /></a> 
					 
									</div> 
									<div class="comm_box"> 
									<p class="l18_f posterContent"><table cellpadding="0" cellspacing="0" border="0" width="100%">
									<tr><td align="left"><b><%=uid %></b></td><td align="right" width="100"><%= new SimpleDateFormat("yyyy-MM-dd").format(show1.getMyshow_createdate())  %></td></tr><tr><td colspan="2" align="left"><%=Tools.clearHTML(show1.getMyshow_content()) %></td></tr></tr>
									</table></p> 
									</div>
									
									  </div>
									  </div>
									  <div style="clear:both;"></div>
									   <div class="floatdp" id="floatdp<%=show1.getId() %>" style="display:none;" >
									  
									   </div>
					 			  <%  }
						 				    if(i==size-1){
						 				    	%>
						 				    	</div>
						 				   <%  }
					 		  }
					 		   
					 		%>
					 		 <div style="clear:both;height:15px;">&nbsp;</div>
					 		 <%    if(pBean.getTotalPages()>1){ %>
							<table cellpadding="0" cellspacing="0" border="0"> <tr>
								<td><div class="GPager">
						           	<span>共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
						           	<%if(pBean.getCurrentPage()>1){ %><a href="#sdCont" onclick="pro_showorder('<%=id %>',1);">首页</a><%}%><%if(pBean.hasPreviousPage()){%><a href="#sdCont" onclick="pro_showorder('<%=id %>',<%=pBean.getPreviousPage() %>);">上一页</a><%}%><%
						           	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
						           		if(i==1){
						           		%><span class="curr"><%=i %></span><%
						           		}else{
						           		%><a href="#sdCont" onclick="pro_showorder('<%=id %>',<%=i %>);"><%=i %></a><%
						           		}
						           	}%>
						           	<%if(pBean.hasNextPage()){%><a href="#sdCont" onclick="pro_showorder('<%=id %>',<%=pBean.getNextPage() %>);">下一页</a><%}%>
						           	<%if(pBean.getCurrentPage()<pBean.getTotalPages()){%><a href="#sdCont" onclick="pro_showorder('<%=id %>',<%=pBean.getTotalPages() %>);">尾页</a><%} %>
						           </div></td>
							</tr></table><%
							} %>
					 		</div>
					 		
						
					<%}}else{
						%>
						<div  id="sdLink">
						</div>
						<span id="ssd">
					<%}
					%>
					</span>
					<!-- 商品晒单结束 -->
					<!-- 商品评论开始 -->
					<hr style=" border:5px solid #fff" />
					<div style="line-height:1px;height:1px;baclground:#FFF;">
					<a name="cmt2"></a></div>
					<div class="zh_title" id="commLink"><a href="javascript:void(0)" class="newa">顾客评论</a></div>
					<!--顾客评论-->
					<span id="scomment">
					    	<div style="padding-top:10px; font-size:14px; font-weight:bold; color:#000;"><a name="cmtCnt"></a>
					    		<img src="http://images.d1.com.cn/Index/images/gkpl_star.gif" style="vertical-align:text-bottom" />顾客评论
					    	</div>
					    	<%
					    	int commentLength = contentcount;
					    	int PAGE_SIZE = 10 ;
					    	PageBean pBean =null; 
					    	String strs="";
					    	List<Comment> commentlist = new ArrayList<Comment>();
					    	pBean=new PageBean(contentcount,PAGE_SIZE,1);
					    	strs=id;
					    	commentlist=getCommentListPage(commentlists,pBean.getStart(),PAGE_SIZE);							    
					    	
					    	if(commentlist != null && !commentlist.isEmpty()){
					    		//int size = commentlist.size();
					    		int avgscore=CommentHelper.getLevelView(id);
					    	%>
					    	<div style="background-color:#F4F4F4;">
								<table cellpadding="0" cellspacing="0" style="margin-left:10px; margin-right:20px; margin-top:10px; margin-bottom:10px; width:95%; line-height:28px;">
									<tr>
					                  <td><div style="float:left">
					                        <div style="float:left;font-size:12px">购买过的顾客评分 |</div>
					                         <div class="sa<%=score %>" style="float:left;" ></div>
					                       </div></td>
					                     <td  align="right"></td>
					                 </tr>
								</table>
							</div>
							<div style="padding-top:10px" id="commentContent">
								<table cellpadding="0" cellspacing="0" style="font-size:12px; width:100%">
										    	
						 <%
						 for(Comment comment:commentlist){
							 User user = UserHelper.getById(String.valueOf(comment.getGdscom_mbrid()));
								//if(user == null) continue;
								String hfusername = getUid(comment.getGdscom_uid());
								String level = UserHelper.getLevelText(user);
								if(comment.getGdscom_mbrid().intValue()==-1){
									level="普通会员";
								}
								else if(comment.getGdscom_mbrid().intValue()==-2){
									level="VIP会员";
								}
								else if(comment.getGdscom_mbrid().intValue()==-3){
									level="白金会员";
								}
							 %>
							 <tr>
								<td>
								<div id="comment" class="m">
					                <div class="mc" >
					                    <div id="divitem" class="item">
					                        <div class="user">
					                            <div class="u-icon">
					                               <img src="<%=UserHelper.getLevelImage(level) %>" width="70" height="70" />                      
					                            </div>
					                            <div class="u-name">
					                             <span><%=hfusername %></span><br>
					                             <span><%=level %></span>
					                            </div>
					                       
					                        </div>
					                        <div class="i-item">
					                        <div class="o-topic">
					                          <div style="float:left"><strong class="topic">
					                            <label style="font-weight:bold">评分：</label>
					                            </strong>
					                            <img src="http://images.d1.com.cn/images2012/New/gds_star<%=comment.getGdscom_level() %>.gif" /></div>
					                            
					                            <div style="float:right"><span class="date-comment">
					                           <%=Tools.stockFormatDate(comment.getGdscom_createdate()) %>
					                            </span></div>
					                            
					                        </div>
					                        <div class="o-topic" style="border:none;" >
					                             <div style="line-height:26px;" class="comment-content">
					                                 <dl>
					                                    <dd><%=comment.getGdscom_content() %></dd>
					                                  </dl>
					                             </div>
					                             <%
					                        if((product.getGdsmst_rackcode().startsWith("020")|| product.getGdsmst_rackcode().startsWith("030")) && !Tools.isNull(product.getGdsmst_skuname1()) && !Tools.isNull(comment.getGdscom_sku1())){
					                        	String h="";
					                        	String w="";
					                        	String c="";
					                        	if(!Tools.isNull(comment.getGdscom_height())){
					                        		h=comment.getGdscom_height()+"cm";
					                        	}
					                        	if(!Tools.isNull(comment.getGdscom_weight())){
					                        		w=comment.getGdscom_weight()+"kg";
					                        	}
					                        	//System.out.println(comment.getGdscom_comp()+"zzzzzzzzzzzzzzzz");
					                        	if("1".equals(comment.getGdscom_comp().trim())){
					                        		c="合适";
					                        	}
					                        	else if("2".equals(comment.getGdscom_comp().trim())){
					                        		c="偏大";
					                        	}
					                        	else if("3".equals(comment.getGdscom_comp().trim())){
					                        		c="偏小";
					                        	}
					                        	%>	
					                        	 <p style="color:black;padding-top:5px;">尺码：<%=comment.getGdscom_sku1() %>&nbsp;&nbsp;&nbsp;&nbsp;身高：<%=h %>&nbsp;&nbsp;&nbsp;&nbsp;体重：<%=w %>&nbsp;&nbsp;&nbsp;&nbsp;顾客认为：<%=c %></p>
					                       <% }
					                        %>
					                              
					                        </div>
					                       
					                        <div class="comment-content">
					                           <dl>
					                           <dd>
					                           <%
					                            if(!Tools.isNull(comment.getGdscom_replyContent())){
					                            	 %>	
					                            	 <p style="color:#892D3D;line-height:26px;" >D1优尚回复：<%=comment.getGdscom_replyContent() %></p>
					                          <%  }
					                           %>
					                            
					                           </dd>
					                           </dl>    
					                        </div>
					                        </div>
					                        <div class="corner tl"></div>
					                     
					                    </div>
					                </div>
					
					        </div>
								</td>
							</tr><%
						}
						 if(pBean.getTotalPages()>1){ %>
							<tr>
								<td><div class="GPager">
						           	<span>共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
						           	<%if(pBean.getCurrentPage()>1){ %><a href="#cmtCnt" onclick="get_comment2('<%=strs %>',1);">首页</a><%}%><%if(pBean.hasPreviousPage()){%><a href="#cmtCnt" onclick="get_comment2('<%=strs %>',<%=pBean.getPreviousPage() %>);">上一页</a><%}%><%
						           	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
						           		if(i==1){
						           		%><span class="curr"><%=i %></span><%
						           		}else{
						           		%><a href="#cmtCnt" onclick="get_comment2('<%=strs %>',<%=i %>);"><%=i %></a><%
						           		}
						           	}%>
						           	<%if(pBean.hasNextPage()){%><a href="#cmtCnt" onclick="get_comment2('<%=strs %>',<%=pBean.getNextPage() %>);">下一页</a><%}%>
						           	<%if(pBean.getCurrentPage()<pBean.getTotalPages()){%><a href="#cmtCnt" onclick="get_comment2('<%=strs %>',<%=pBean.getTotalPages() %>);">尾页</a><%} %>
						           </div></td>
							</tr><%
							} %>
							</table> </div>
						<%
					}else{
					%><div class="commentmore" id="commentmore" > 还没有会员进行评论。</div><%
				} %>
				   </span>
				    <!-- 商品评论结束 -->
					</div>
				
					 <%
            
              Directory dir= DirectoryHelper.getById(product.getGdsmst_rackcode().toString());
              if(dir!=null)
              {
            	  String str=dir.getRakmst_rackname();
            	  if(str.length()>0)
                  {%>
                 	
                 	
     		        <%  //String newtag=getXGSS(id).replace('，', ',');
                 	     ArrayList<Tag> elist=new ArrayList<Tag>();
                 	     ArrayList<Tag> alist=new ArrayList<Tag>();
                 	     ArrayList<Tag> listsss=TagHelper.getTags();
                 	     if(listsss!=null&&listsss.size()>0)
                 	     {
                 	    	 for(Tag t:listsss)
                 	    	 {
                 	    		 if(t!=null&&t.getTag_key()!=null&&t.getTag_key().length()>0&&t.getTag_key().indexOf(str)>=0)
                 	    		 {
                 	    			 alist.add(t);
                 	    		 }
                 	    	 }
                 	     }
                 	     
                 	     if(alist!=null)
                 	     {
                 	    	 for(int i=0;i<alist.size();i++)
                 	    	 {
                 	    		
                 	    		 for(int j=i;j<alist.size()-1;j++)
                 	    		 {
                 	    			 Tag ti=alist.get(i);
                 	    			 Tag tj=alist.get(j+1);
                 	    			 if(ti.getTag_key().equals(tj.getTag_key()))
                 	    			 {
                 	    				 ti=null;
                 	    			 }
                 	    			 elist.add(tj);
                 	    		 }
                 	    	 }
                 	     }
     					
                 	     if(elist!=null&&elist.size()>0)
                 	     {
                 	        
                 	     %>
                 	    	   <div class="xgss" id="xgss">
                 	               <em style="border:none;">相关搜索：  </em>
                 	    	<%  
                 	    	    if(elist.size()<=15)
                 	    	    {
                 	    	    	for(int i=0;i<elist.size();i++)
    		     					{
    		     						Tag cc=elist.get(i);
    		     						if(cc!=null)
    		     						{
    		     						
    		     					%>
    		     		            	<em><a href="http://www.d1.com.cn/channel/<%= cc.getId() %>" target="_blank"><%=cc.getTag_key() %></a></em>
    		     		            <%
    		     						}
    		     					}
                 	    	    }
                 	    	    else
                 	    	    {
                 	    	    	
                 	   			    int num = new Random().nextInt(elist.size()-15);
	                 	   			for(int i=num;i<num+15;i++)
			     					{
			     						Tag cc=elist.get(i);
			     						if(cc!=null)
			     						{
			     						
			     					%>
			     		            	<em><a href="http://www.d1.com.cn/channel/<%= cc.getId() %>" target="_blank"><%=cc.getTag_key() %></a></em>
			     		            <%
			     						}
			     					}
                 	    	    }
                 	    	   %>
                 	             </div>
                 	    <%}
     		            
                 }
                 
                 
                 }%>
                  <div class="clear"></div>
				</div>
				 
				 <!--商品信息描述结束-->
				 <div class="clear"></div>
				
			</div>
		     <!--商品展示右侧结束-->
		     
		     <!--商品展示左侧-->
			  <div class="gs_left">
			  
			  	  <%
			       //获取该商品的前十个商品
			       ArrayList<Product> rlist=new ArrayList<Product>();
			       rlist=getTenProduct(id);
			       if(rlist!=null&&rlist.size()>0)
			       {%>
			    	   <div class="gs_left_por" style="display:none;">
			    	   <div class="gs_left_content">
					   <%  for(Product p:rlist)
						   {
						       if(p!=null)
						       {
						           String title=Tools.clearHTML(p.getGdsmst_gdsname());
						       %>
						    	 <div class="gs_left_content_sub">
							  
							 <div class="gs_left_content_r">
							 	<a href="<%=ProductHelper.getProductUrl(p) %>" title="<%=title %>" target="_blank"><%=title %></a><br/>
							 	<span class="span1">￥<%=p.getGdsmst_memberprice() %></span><span class="span2">￥<%=p.getGdsmst_saleprice() %></span>
							 </div>
				         </div>
						 <hr/>  
						       <%}
						   }
					   %>
					   	 </div>
					   </div>
			       <%}
			   
			  %>
			  
			
			 <!--购买过本商品的用户还购买过-->
			 <% productList = GetAboutProduct(product.getId());
		     //System.out.print(product.getId());
			 if(productList != null && !productList.isEmpty()){					
				 int size = productList.size();				 
				 %>
			 
				 <div class="gs_left_por">
				     <div class="gs_left_ltitle" style=" text-align:left; padding-left:15px;">购买过本商品的用户还购买过</div><%
				
					 %>
					 <div class="gs_left_content"><%
					 for(Product goods : productList){
						 if(!ProductHelper.isNormal(goods)) continue;
						 String title = Tools.clearHTML(goods.getGdsmst_gdsname());
					 %>
			             <div class="gs_left_content_sub">
							 <a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><img src="<%=ProductHelper.getImageTo80(goods) %>" alt="<%=title %>" align="middle" width="60" height="60" /></a>
							 <div class="gs_left_content_r">
							 	<a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><%=title %></a><br/>
							 	<span class="span1">￥<%=goods.getGdsmst_memberprice() %></span><span class="span2">￥<%=goods.getGdsmst_saleprice() %></span>
							 </div>
				         </div>
						 <hr/><%
						} %>
						 <div style=" height:25px;"></div>
					 </div><%
				 	 %>
				 </div>
				 <!-- 浏览过该商品的用户还浏览过商品-->
				 <%}
			      else{
			    	  String linked=product.getGdsmst_linkgds();
					     //List<RackcodeTop> hotList = RcktopHelper.getHotMale(rackCode,5);
						 if(!Tools.isNull(linked)){
							 linked=linked.replace(",", ";").replace("；", ";");
							if(linked.startsWith(";")){
								 linked=linked.substring(1, linked.length()-1);
							 }
							 String[] linklist=null;
							 if(linked.contains(";")){
								 linklist= linked.split(";");
							 }
							// if(linked.contains(",")){
							//	 linklist=linked.split(",");
							// }
						 int size = linklist.length;
						 %>
						 <!--相关商品-->
						 <div class="gs_left_por">
						     <div class="gs_left_ltitle" style=" text-align:left; padding-left:15px;">购买过本商品的用户还购买过</div>
							 <div class="gs_left_content"><%
							 for(int i=0;i<size;i++){
								 Product goods = ProductHelper.getById(linklist[i]);
								 if(goods==null)continue;
								 String title = Tools.clearHTML(goods.getGdsmst_gdsname());

							 %>
							  	<div class="gs_left_content_sub">
									<a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods).trim() %>" target="_blank"><img src="<%=ProductHelper.getImageTo80(goods) %>" align="middle" width="60" height="60" /></a>
									<div class="gs_left_content_r">
										<a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods).trim() %>" target="_blank"><%=title %></a><br/>
										<span class="span1">￥<%=goods.getGdsmst_memberprice() %></span><span class="span2">￥<%=goods.getGdsmst_saleprice() %></span>
									</div>
								</div>
								<hr/><%
								} %>
							 </div>
						 </div>
				 <!--相关商品--><%
				 } else{
					 List<RackcodeTop> hotList = RcktopHelper.getHotMale(rackCode,5);
					 if(hotList!=null && hotList.size()>0){
						 %>
						 <!--本类热卖排行-->
						 <div class="gs_left_por">
				     <div class="gs_left_ltitle" style=" text-align:left; padding-left:15px;">购买过本商品的用户还购买过</div>
					 <div class="gs_left_content"><%
					 for(RackcodeTop codeTop : hotList){
						 Product goods = ProductHelper.getById(codeTop.getRcktop_gdsid());
						 String title = Tools.clearHTML(goods.getGdsmst_gdsname());

					 %>
					  	<div class="gs_left_content_sub">
							<a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods).trim() %>" target="_blank"><img src="<%=ProductHelper.getImageTo80(goods) %>" align="middle" width="60" height="60" /></a>
							<div class="gs_left_content_r">
								<a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods).trim() %>" target="_blank"><%=title %></a><br/>
								<span class="span1">￥<%=goods.getGdsmst_memberprice() %></span><span class="span2">￥<%=goods.getGdsmst_saleprice() %></span>
							</div>
						</div>
						<hr/><%
						} %>
					 </div>
				 </div>
					<% }
				 }
				 }%>
				 
				 
				  <!--最近浏览的商品-->
				 <div class="gs_left_por">
				     <div class="gs_left_ltitle" style=" text-align:left; padding-left:15px;">最近浏览的商品</div><%
					 productList = ProductHelper.getHistoryList(request);
					 if(productList != null && !productList.isEmpty()){
						 int size = productList.size();
					 %>
					 <div class="gs_left_content"><%
					 for(Product goods : productList){
						 if(!ProductHelper.isNormal(goods)) continue;
						 String title = Tools.clearHTML(goods.getGdsmst_gdsname());
					 %>
			             <div class="gs_left_content_sub">
							 <a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><img src="<%=ProductHelper.getImageTo80(goods) %>" alt="<%=title %>" align="middle" width="60" height="60" /></a>
							 <div class="gs_left_content_r">
							 	<a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><%=title %></a><br/>
							 	<span class="span1">￥<%=goods.getGdsmst_memberprice() %></span><span class="span2">￥<%=goods.getGdsmst_saleprice() %></span>
							 </div>
				         </div>
						 <hr/><%
						} %>
						 <div style=" height:25px;"></div>
					 </div><%
				 	} %>
				 </div>
				 <!-- 最近浏览的商品结束-->
			</div>
		     <!--商品展示左侧结束-->
		     
		</div>
	 <!-- 商品展示结束-->
	 
</div>
<div class="clear"></div>
<!--中间内容结束-->
<%@include file="/inc/foot.jsp" %>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gdsmst.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>

<%
if(zhsp != null){
%>
<script type="text/javascript">
var t1 = $("#zhtab > a");
var c1 = $("#content_list > div");
new switch_tags(t1, c1, "newa", 0, "click");
</script><%
}%>
<script type="text/javascript">
	var t2 = $("#goodsinfotab > a");
	var c2 = $("#content_list_info > span");
	var flag=0;		
	var show='<%=show%>';
	t2.each(function(i){
	    if($(this).attr('attr')==show){
	    	flag=i;
	    }
	});
	if(flag!=0){ t2.eq(0).attr('className','');
	c2.eq(0).css('display','none');
	}
	 var obj = t2.eq(flag);
     if(obj.attr('attr')=='com'){
     	$('#sdLink').hide();
 		$('#commLink').hide();
 		$('#ssd').hide();
 		$('#scomment').show();
 		
     }
     else if(obj.attr('attr')=='sd'){
     	$('#sdLink').hide();
 		$('#ssd').show();
 		$('#commLink').hide();
 		$('#scomment').hide();
     }
     else{
     	$('#sdLink').show();
 		$('#commLink').show();
 		$('#ssd').show();
 		$('#scomment').show();
     }
	
	new switch_tags(t2, c2, "newa", flag, "click",2);

</script>
<script type="text/javascript">
$(document).ready(function(){
	var objxg=$("#xgss");
	if(objxg!=null)
		{
		  objxg.css("display","none");
		}
    $('#settings').mouseover(function(){
		$('#opciones').slideToggle();
		$('#settings').hide();
		$(this).toggleClass("cerrar");
    });
	$('#opciones').mouseover(function(){
		$('#opciones').show();
		$('#settings').hide();
	}).mouseout(function(){
		$('#opciones').hide();
		$('#settings').show();
	});
	//$(".goods_info_con").find("img").lazyload({effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
	$('#hyyhsmLink').hover(function(){
		var o = $(this).offset();
		$('#hyyhsm').show().css("left",($(this).offset().left-70)+"px");
	},function(){
		$('#hyyhsm').toggle();
	});
	var gdscolldiv=$('#2012test');
	if(gdscolldiv.length<=0){
	   ggdscoll1('','','','<%= id %>');
	}	
	
	
	//导航栏浮动
	var m=$("#goodsinfotab").offset().top;  
	$(window).bind("scroll",function(){
    var i=$(document).scrollTop(),
    g=$("#goodsinfotab");
	if(i>=m)
	{
		 g.addClass('newbanner1120');
	}
    else{g.removeClass('newbanner1120');}
	});
	
	
	
});
function AddAsk(){
    var asktypevalue = $("input[name='asktype']:checked").val(); //咨询类型
    if(asktypevalue == null || asktypevalue == ""){
    	$.alert("请选择咨询类型！");
    	return;
    }
    var content = $("#txtcontent").val(); //咨询内容
    if(content == null || content == ""){
    	$.alert("请填写咨询内容！");
    	return;
    }
    $.post("/ajax/product/addAsk.jsp",{"gdsask_gdsid":"<%=id %>","gdsask_type":asktypevalue,"gdsask_content":content,"m":new Date().getTime()},function(json){
    	if(json.success){
    		$.alert(json.message);
    		$("#txtcontent").val("");
    	}else{
    		$.alert(json.message);
    	}
    },"json");
}<%
if(ismiaoshao){
%>xsms_gdsmst('mscontent');<%
}
%>

function ccdzb()
{
  var top=$('#skuname').offset().top+$('#skuname p').height()-5;
  var right=$(document).width()-($(".gs_right").offset().left+$(".gs_right").width());
  $("#ccdzb_img").css("top",top);
  $("#ccdzb_img").css("right",right);
  $("#ccdzb_img").css("display","block");

}
function ccdzb1()
{
	$("#ccdzb_img").css("display","none");
}
</script>

</body>
</html>