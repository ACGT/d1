<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%!

//获得每个栏目的关键字推荐
private static String getKeyWord(String code){
	if(!Tools.isMath(code)) return "";
	StringBuilder sb = new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , -1);
	if(recommendList != null && !recommendList.isEmpty()){
		int size = recommendList.size();
		sb.append("<h2>");
		for(int i=0;i<size;i++){
			Promotion recommend = recommendList.get(i);
     		String title = recommend.getSplmst_name();
     		sb.append("<a href=\"").append(StringUtils.encodeUrl(recommend.getSplmst_url())).append("\" title=\"").append(title).append("\" target=\"_blank\">").append(title).append("</a>");
     		if(i<size-1) sb.append("|");
		}
		sb.append("</h2>");
	}
	return sb.toString();
}
//热门分类
private static String getHotAssort(String code){
	if(!Tools.isMath(code)) return "";
	StringBuilder sb = new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , -1);
	if(recommendList != null && !recommendList.isEmpty()){
		sb.append("<ul>");
		for(Promotion recommend : recommendList){
			String title = recommend.getSplmst_name();
			sb.append("<li><a href=\"").append(StringUtils.encodeUrl(recommend.getSplmst_url())).append("\" target=\"_blank\" title=\"").append(title).append("\">").append(title).append("</a>|</li>");
		}
		sb.append("</ul>");
	}
	return sb.toString();
}
//显示物品的列表，count是显示物品的数量,width图片宽度,height图片高度
//type 1，取女装，2男装，0默认，女装160x200，男装200x200，默认120x120
private static String getGoodsList(String code , int length , int width , int height , int type){
	if(!Tools.isMath(code) || length<=0) return "";
	List<PromotionProduct> recommendProList = PromotionProductHelper.getPromotionProductByCode(code , 100);
	StringBuilder sb = new StringBuilder();
	if(recommendProList != null && !recommendProList.isEmpty()){
    	int size = recommendProList.size();
    	int count = 0;
    	sb.append("<ul class=\"").append(type==2?"goods_listnew":"goods_list").append("\">");
    	for(int i=0;i<size&&count<length;i++){
    		PromotionProduct recommend = recommendProList.get(i);
    		Product product = ProductHelper.getById(recommend.getSpgdsrcm_gdsid());
    		if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
    		String title = Tools.clearHTML(recommend.getSpgdsrcm_gdsname());
    		
    		String imgURL = null;
    		if(type == 1){
    			imgURL = "http://images.d1.com.cn/"+product.getGdsmst_fzimg();
    		}else if(type == 2){
    			imgURL = recommend.getSpgdsrcm_otherimg();
    			if(Tools.isNull(imgURL)) imgURL = "http://images.d1.com.cn/"+product.getGdsmst_imgurl();
    		}else{
    			imgURL = "http://images.d1.com.cn/"+product.getGdsmst_otherimg3();
    		}
    		
    		sb.append("<li><dl><dt><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" title=\"").append(title).append("\" target=\"_blank\"><img src=\"").append(imgURL).append("\" alt=\"").append(title).append("\" width=\"").append(width).append("\" height=\"").append(height).append("\"/></a></dt>");
    		sb.append("<dd class=\"name\"><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" title=\"").append(title).append("\" target=\"_blank\">").append(title).append("</a></dd>");
    		sb.append("<dd><strong>￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</strong><del>￥").append(Tools.getFormatMoney(product.getGdsmst_saleprice())).append("</del></dd><dd class=\"clear\"></dd></dl></li>");
    		count++;
    	}
    	sb.append("</ul>");
	}
	
	return sb.toString();
}




//男装商品列表
private static String getGoodsList(String code,int length){
	if(!Tools.isMath(code) || length<=0) return "";
	List<PromotionProduct> recommendProList = PromotionProductHelper.getPromotionProductByCode(code , 100);
	StringBuilder sb = new StringBuilder();
	if(recommendProList != null && !recommendProList.isEmpty())
	{
	  	int size = recommendProList.size();
	  	int count = 0;
	  	sb.append("<ul class=\"").append("goods_list").append("\">");
  	for(int i=0;i<size&&count<length;i++)
  	{
  		PromotionProduct recommend = recommendProList.get(i);
  		Product product = ProductHelper.getById(recommend.getSpgdsrcm_gdsid());
  		if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
  		String title = Tools.clearHTML(recommend.getSpgdsrcm_gdsname());
  		
  		
  	    String imgURL = "http://images.d1.com.cn/"+product.getGdsmst_fzimg();
  	    count++;
  	    if(count%4==0)
  	    {
  		
  		sb.append("<li style=\"padding-right:0px;\"><dl><dt><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" title=\"").append(title).append("\" target=\"_blank\"><img src=\"").append(imgURL).append("\" alt=\"").append(title).append("\" width=160\" height=200\"/></a></dt>");
  		sb.append("<dd class=\"name\"><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" title=\"").append(title).append("\" target=\"_blank\">").append(title).append("</a></dd>");
  		sb.append("<dd><strong>￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</strong><del>￥").append(Tools.getFormatMoney(product.getGdsmst_saleprice())).append("</del></dd><dd class=\"clear\"></dd></dl></li>");
  	    }
  	    else
  	    {
  	    	sb.append("<li><dl><dt><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" title=\"").append(title).append("\" target=\"_blank\"><img src=\"").append(imgURL).append("\" alt=\"").append(title).append("\" width=160\" height=200\"/></a></dt>");
  	  		sb.append("<dd class=\"name\"><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" title=\"").append(title).append("\" target=\"_blank\">").append(title).append("</a></dd>");
  	  		sb.append("<dd><strong>￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</strong><del>￥").append(Tools.getFormatMoney(product.getGdsmst_saleprice())).append("</del></dd><dd class=\"clear\"></dd></dl></li>");
  	  	    
  	    }
  	}
  	sb.append("</ul>");
	}
	
	return sb.toString();
}

//获取优品尚志
private static String getUpsz(String code,int length){
	if(!Tools.isMath(code) || length<=0) return "";
	ArrayList<Promotion> recList = PromotionHelper.getBrandListByCode(code,length);
	if(recList!=null&&recList.size()>0)
	{
		StringBuilder sb = new StringBuilder();
		for(int i=0;i<recList.size();i++)
		{
			if(i==0)
			{
				sb.append(" <div id=\"ypsz_"+(i+1)+"\" class=\"magabody\">");
				sb.append(" <a href=\""+StringUtils.encodeUrl(recList.get(i).getSplmst_url())+"\" target=\"_blank\">");
				sb.append("<img src=\""+recList.get(i).getSplmst_picstr()+"\" width=\"245\" height=\"305\"></img></a>");
				sb.append("<span style=\"display:block; padding-top:4px; padding-bottom:2px; _padding-bottom:0px;\">");
				sb.append("<a href=\""+StringUtils.encodeUrl(recList.get(i).getSplmst_url())+"\" target=\"_blank\" >");
				sb.append("<img src=\"http://images.d1.com.cn/Index/DJYD.gif\" style=\" margin-left:1px; _margin-top:3px; _margin-bottom:3px; +margin-top:2px; +margin-bottom:2px;\" ></img></a></span></div>");
				
				}
			else
			{
				sb.append(" <div id=\"ypsz_"+(i+1)+"\" class=\"magabody\" style=\"display:none;\">");
				sb.append(" <a href=\""+StringUtils.encodeUrl(recList.get(i).getSplmst_url())+"\" target=\"_blank\">");
				sb.append("<img src=\""+recList.get(i).getSplmst_picstr()+"\" width=\"245\" height=\"305\"></img></a>");
				sb.append("<span style=\"display:block; padding-top:4px; padding-bottom:2px; _padding-bottom:0px;\">");
				sb.append("<a href=\""+StringUtils.encodeUrl(recList.get(i).getSplmst_url())+"\" target=\"_blank\" >");
				sb.append("<img src=\"http://images.d1.com.cn/Index/DJYD.gif\" style=\" margin-left:1px; _margin-top:3px; _margin-bottom:3px; +margin-top:2px; +margin-bottom:2px;\" ></img></a></span></div>");
				
			}
		}
		return sb.toString();
	}
	return "";
}

//获取优尚推新
private String getUSTX(String code,int length)
{
	StringBuilder sb = new StringBuilder();
	if(!Tools.isMath(code) || length<=0) return "";
	ArrayList<Promotion> list=new ArrayList<Promotion>();
	list=PromotionHelper.getBrandListByCode(code,length);
	if(list!=null&&list.size()>0)
	{
		//sb.append("<UL id=\"sec_list\">");
		int i=0;
		for(Promotion p:list)
		{
			
			if(p!=null)
			{
				StringBuilder map=new StringBuilder();
				i++;
				ArrayList<PromotionImagePos> piplist=new ArrayList<PromotionImagePos>();
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("promotionId", p.getId()));
				List<BaseEntity> b_list = Tools.getManager(PromotionImagePos.class).getList(clist, null, 0, 100);
				if(b_list!=null){
					for(BaseEntity be:b_list){
						piplist.add((PromotionImagePos)be);
					}
				}
				sb.append("<li><img alt=\"\" src=\""+p.getSplmst_picstr()+"\" width=\"980\" height=\"500\"  usemap=\"#pimg_"+i+"\"/>");
				map.append("<map name=\"pimg_").append(i).append("\" id=\"").append("pimg_").append(i).append("\">");
				for(PromotionImagePos pip:piplist)
				{
					
					if(pip!=null)
					{
						int left=0;
						int top=0;
						//left=(((i-1)*980)+pip.getPos_x()-24+(Tools.parseInt(pip.getExt1())-pip.getPos_x())/2);
						left=pip.getPos_x()+10;
						if(left>400)
						{
							left=pip.getPos_x()-25;
						}
						top=pip.getPos_y()-35;
						int divtop=0;
						if(top+40>350)
						{
							divtop=350;
						}
						else
							divtop=top+40;
						
							
						//sb.append("<a href=\"javascript:void(0)\" onmouseover=\"mdm_over('"+pip.getId()+"')\" onmouseout=\"mdm_out('"+pip.getId()+"')\"><img src=\"http://images.d1.com.cn/Index/MaoDian.gif\" style=\" position:absolute; left:"+ left+"px; top:"+top+"px; z-index:1400;\" width=\"55\" height=\"79\" /></a>");
						sb.append("<div id=\"div_"+pip.getId()+"\" style=\"left:"+(left+100)+"px; top:"+divtop+"px; \" onmouseover=\"mdm_over('"+ pip.getId()+"')\" onmouseout=\"mdm_out('"+pip.getId()+"')\" >");
						map.append("<area shape=\"rect\" coords=\"").append(pip.getPos_x()+",").append(pip.getPos_y()+",").append(pip.getExt1()+",").append(pip.getExt2()).append("\"").append(" onmouseover=\"mdm_over('"+ pip.getId()+"')\" onmouseout=\"mdm_out('"+pip.getId()+"')\""); 
						Product product=ProductHelper.getById(pip.getProductId());
						if(product!=null)
						{
							sb.append("<a href=\"http://www.d1.com.cn/product/"+pip.getProductId()+"\" target=\"_blank\">"+Tools.clearHTML(product.getGdsmst_gdsname())+"</a><br/>");
							
							sb.append("<b>￥"+product.getGdsmst_memberprice().longValue()+"</b><br/><strike>￥"+product.getGdsmst_saleprice().longValue()+"</strike><br/><hr style=\" border:solid 1px #fff;\" />");
						    map.append("href=\"").append("http://www.d1.com.cn/product/"+product.getId()).append("\" target=\"_blank\"");
						}
						map.append(">");
						sb.append("</div>");
							
					}
				}
				map.append("</map>");
				sb.append("</li>");
				sb.append(map.toString());
			}
		}
		
		
		//sb.append("</UL>");
		return sb.toString();
	}
	
	return "";
			
}


//获取优尚推新的个数
private int getUSTXcount(String code,int length)
{
	int count=0;
	if(!Tools.isMath(code) || length<=0) return 0;
	ArrayList<Promotion> list=new ArrayList<Promotion>();
	list=PromotionHelper.getBrandListByCode(code,length);
	if(list!=null&&list.size()>0)
	{
		
		for(Promotion p:list)
		{
			
			if(p!=null)
			{
				count++;
			}
				

		}
		return count;
		
	}
	
	return 0;
			
}



%>
<%if ("mqwyjf1203q".equals(session.getAttribute("d1lianmengsubad"))){
	session.removeAttribute("d1lianmengsubad");
	response.sendRedirect("http://www.d1.com.cn/zhuanti/20120328WangYi/index.jsp");
	return;
} %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网（原名D1便利网），国内领先的个人时尚扮靓商城,支持全国货到付款，北京、上海、天津用户网上购物满99免运费，其他城市网上购物货付满199元免运费。想通过网上购物买到名牌商品，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<meta name="keywords" content="D1优尚网-D1优尚-网上购物,网上商城,北京,上海,广州,浙江,优尚购物网,购物网站,网上超市,电子商城,在线购物,电子商务,购买" />
<title>D1优尚网-时尚网上购物商城,在线销售化妆品、名表、饰品、女装、男装等个人扮靓物品</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/indexnew.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/indexnew/ystx.js")%>"></script>
<style type="text/css">
body{margin:0;padding:0}
.mod_top_banner{height:35px;width:100%;background:url(http://imgcache.qq.com/vipstyle/act/caibei_110826_tips/img/bg2.png);color:#333333;font-size:12px}
	.mod_top_banner a{color:#0066cc;text-decoration:none;}
	.mod_top_banner .redf{color:red;font-weight:bolder;}
	.mod_top_banner .main_area{width:980px;margin:0 auto;height:35px;}
	.mod_top_banner .sale_tip{float:left;width:630px;height:35px;line-height:35px;padding-left:32px;background:url(http://imgcache.qq.com/vipstyle/act/caibei_110826_tips/img/bg.png) no-repeat left -32px}
	.mod_top_banner .login_status{float:right;width:260px;height:35px;}
	.mod_top_banner .login_status a{float:left;}
	.mod_top_banner .login_status img{border:none}
	.mod_top_banner .login_btn{padding-right:10px;border-right:#add9fb 1px solid;height:16px;margin-top:10px}
	.mod_top_banner .login_span{ float:left;color:#777;height:16px;margin-top:10px;line-height:16px;}
	.mod_top_banner .my_caibei{padding-left:10px;border-left:#fff 1px solid;height:16px;margin:10px 0 0 10px;line-height:16px}

</style>
<script>
function ShowTuanNew() {
    $.ajax({
        type: "get",
        dataType: "html",
        url: "/ajax/html/getTuanNew.jsp",
        cache: false,
        data: {},
        success: function(strHtml) {
            if (typeof strHtml != 'undefined') {
            	$('#sc').empty();
                $(strHtml).appendTo($('#sc'));
            }
        },beforeSend: function() {},
        complete: function() {xsms2011_new('sc');}
    });
};


function xsms2011_new(id) {
	$('#'+id+' .countdown').each(function(){
		var b = $(this).attr('time');
		if(b){
			var ttime = new retime(b, this);
            ttime.sTime(ttime);
		}
	});
};


//document.writeln("<div id=\"sc\" class=\"oldstyle\"><\/div>");
setTimeout("closeSC()", 8000);
function closeSC(){
	
	$("#sc").text("");
	$("#sc").append("<div style=\"width: 352px;text-align:center; height:42px;background: url('http://images.d1.com.cn/Index/tck.jpg')\"><span onclick=\"javascript:openSC()\" style=\"cursor:pointer; float:right; padding-right:5px; margin-top:12px;\"><img src=\"http://images.d1.com.cn/Index/Cha-1.gif\"/></span></div>");
	$("#sc").animate({width:"350"},500,function(){});$("#sc").animate({height:"42"},500,function(){});
	$("#sc").removeClass("oldstyle");
	$("#sc").addClass('newstyle');	
	//$("#sc").resize(function(){var f_top = $(window).scrollTop() + $(window).height() + $("#sc").outerHeight();$('#sc').css('top',f_top);});
}


function openSC()
{
	//ShowTuanNew();
	$("#sc").text("");
	$("#sc").append("<div style=\"width: 352px;text-align:center; height:42px;background: url('http://images.d1.com.cn/Index/tck.jpg')\"><span onclick=\"javascript:closeSC()\" style=\"cursor:pointer; float:right; padding-right:5px; margin-top:12px;\"><img src=\"http://images.d1.com.cn/Index/cha.gif\"/></span></div>");
	$("#sc").append("<div style=\"width:322px;padding-top:10px; padding-left:9px; padding-right:5px;\"><table cellspacing=\"0\" cellpadding=\"0\" border=\"0\"><tr><td width=\"152\" colspan=\"2\">");
	$("#sc").append("<a href=\"\" target=\"_blank\"><img src=\"http://images.d1.com.cn/shopadmin/splimg/201204/2012-4-5_hyli_418X249.jpg\" alt=\"\" style=\"border:none;\" width=\"332\" height=\"138\"></a>");
	$("#sc").append("</td></tr></table></div>");
	
	$("#sc").removeClass("newstyle");
	$("#sc").addClass('oldstyle');
	$("#sc").animate({width:"350"},500,function(){});$("#sc").animate({height:"232"},500,function(){});
	
	//$("#sc").resize(function(){var f_top = $(window).scrollTop() + $(window).height() - $("#sc").outerHeight();$('#sc').css('top',f_top);});

}
</script>
</head>
<body>
<div id="wrapper">
<%
		if(session.getAttribute("headShow") !=null && session.getAttribute("jifenurl") !=null && !Tools.isNull(session.getAttribute("jifenurl").toString())  && !Tools.isNull(session.getAttribute("headShow").toString())){
			%>	
			<div class="mod_top_banner">
	<div class="main_area">
		<div class='sale_tip'><%=session.getAttribute("headShow").toString() %></div>
		<div class='login_status'>
			
			<a class='my_caibei' href="<%=session.getAttribute("jifenurl").toString()%>">我的彩贝积分</a>
		</div>
	</div>
</div>
		<%}
		%>
   <!-- 头部 -->
   <%@include file="/inc/head.jsp" %>
   
   <!-- 头部结束 -->
   <!-- page开始 -->
	<div id="page">
	<div id="sc" class="oldstyle">
	<div style="width: 352px;text-align:center; height:42px;background: url('http://images.d1.com.cn/Index/tck.jpg')"><span onclick="javascript:closeSC()" style="cursor:pointer; float:right; padding-right:5px; margin-top:12px;"><img src="http://images.d1.com.cn/Index/cha.gif"/></span></div>
		<div style="width:322px;padding-top:10px; padding-left:9px; padding-right:5px;">
		<table cellspacing="0" cellpadding="0" border="0"><tr><td width="152" colspan="2">
		<a href="/tuan/index.jsp" target="_blank">
		<img src="http://images.d1.com.cn/shopadmin/splimg/201204/2012-4-5_hyli_418X249.jpg" alt="" style="border:none;" width="332" height="138"></a>
		</td></tr>
		
		</table></div>
	</div>
	<!-- banner -->
	<% 
	   ArrayList<Promotion>  bannerList=new ArrayList<Promotion>();
	   bannerList=PromotionHelper.getBrandListByCode("2781", 1);
	   if(bannerList!=null&&bannerList.size()>0)
	   {%>
		<div class="topbanner">
		<a href="<%= Tools.clearHTML(bannerList.get(0).getSplmst_url()) %>" target="_blank"><img src="<%= bannerList.get(0).getSplmst_picstr() %>" width="980" height="60" border="0" /></a>
	     </div>
	   <%}
	
	%>

	<!-- banner结束 -->
	<% ArrayList<Promotion>  recommendList=new ArrayList<Promotion>();%>
	
	<div class="top_c">
	
             <div id="slideBox"><%
             //滚动广告推荐
              recommendList = PromotionHelper.getBrandListByCode("2771" , -1);
             if(recommendList != null && !recommendList.isEmpty()){
            	 int size = recommendList.size();
            	 StringBuilder sb1 = new StringBuilder();
            	 StringBuilder sb2 = new StringBuilder();
            	 StringBuilder sb3 = new StringBuilder();
            	 for(int i=0;i<size;i++){
            		 Promotion recommend = recommendList.get(i);
            		 String url = StringUtils.encodeUrl(recommend.getSplmst_url());
            		 String title = Tools.clearHTML(recommend.getSplmst_name());
            		 sb1.append("<li><a href=\"").append(url).append("\" target=\"_blank\"><img alt=\"").append(title).append("\" height=\"340\" width=\"980\" src=\"").append(recommend.getSplmst_picstr()).append("\" /></a></li>");
            		 sb2.append("<li");
            		 sb3.append("<li");
            		 if(i==0){
            			 sb2.append(" class=\"active\"");
            			 sb3.append(" class=\"active\"");
            		 }
            		 sb2.append("><a href=\"").append(url).append("\" target=\"_blank\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>");
            		 sb3.append("><a href=\"").append(url).append("\" target=\"_blank\">").append(title).append("</a></li>");
            	 }
             %>
                <ul id="show_pic" style="left:0px"><%=sb1.toString() %></ul>
                <div id="slideText"></div>
				<ul id="iconBall"><%=sb2.toString() %></ul>
				<ul id="textBall"><%=sb3.toString() %></ul><%
			} %>
            </div>
	        
        </div>
        
       
	
	    
	    <!-- 热门分类-->
          <div class="blayout hot_fl">
		   <div class="hot_fl_left">
		       <img src="http://images.d1.com.cn/Index/images/rmfl.jpg" />
			   <div class="flcontet" id="flcontet">
			      <div class="flcontent_sub" style="height:60px;">
                     <span><a href="/html/cosmetic/" target="_blank">化妆品</a></span>
                     <%=getHotAssort("2746") %>
				  </div>
				  <div class="flcontent_sub" id="Div1">
                     <span><a href="/html/cloth/" target="_blank">潮流女装</a></span>
                     <%=getHotAssort("2747") %>
				  </div>
				  <div class="flcontent_sub" id="Div2">
                     <span><a href="/html/man/" target="_blank">品质男装</a></span>
                     <%=getHotAssort("2748") %>
				  </div>
				  <div class="flcontent_sub" id="Div3">
                     <span><a href="/html/ornament/" target="_blank">精美饰品</a></span>
                     <%=getHotAssort("2749") %>
				  </div>
				  <div class="flcontent_sub_1">
                     <span><a href="/html/shoebag/" target="_blank">名品箱包</a></span>
                     <%=getHotAssort("2750") %>
				  </div>
			   </div>
		   </div>
		   <script type="text/javascript">
		   $(function(){
			  $('#flcontet > div').each(function(){
				  var className = $(this).attr('className');
				  $(this).hover(function(){
					  $(this).attr('className','flmouseover');
				  },function(){
					  $(this).attr('className',className);
				  });
			  }); 
		   });
		   </script>
		   
		   <!-- 优品尚志 -->
		   <div class="hot_fl_right">
		      <span style="display:block;  width:268px;  padding:0px; margin:0px; background:#ebebeb; color:#a73c50; ">
		      <table border="0" cellspacing="0" cellpadding="0">
		        <tr style=" background:url(http://images.d1.com.cn/Index/YPSZ.jpg)">
		        <td width="210"> 
		        </td>
		         <td style=" border:solid 1px #c2c2c2; padding:0px;" ><a href="javascript:void(0)" onclick="upszlb()"><img src="http://images.d1.com.cn/Index/left_cli.jpg" style="vertical-align:middle; "/></a></td>
		      
		        <td style="border:solid 1px #c2c2c2; border-left:none; padding:0px;"><a href="javascript:void(0)" onclick="upszlb()"><img src="http://images.d1.com.cn/Index/right_cli.jpg" style="vertical-align:middle; "/></a></td>
		         </tr>
		    </table> 
		     
		     </span>
		     
		     <%= getUpsz("2774",2) %>
		      
		       
		      
		     
		   </div>
		   
		   <!-- 优品尚志结束 -->
		</div>
        <!-- 热门分类结束-->  
         <!-- 限时特卖-->
        <div class="blayout hot_male" id="xstm_201211"></div>
        <!-- 限时特卖结束-->
        <!-- 时尚推新 -->
         <div class="blayout sstx" >
         <h2 style=" border-bottom:none; padding-top:0px;"><img src="http://images.d1.com.cn/Index/ShiShangTuiXin.jpg" width="980" height="42"></img></h2>
         <br/>
         
         <div id="focus">
         <ul>
		 <%= getUSTX("2780",100) %>
		 </ul>
		 <div class='preNext pre2012'>
		 <img id="tprev1" src="http://images.d1.com.cn/Index/l_red1.jpg"  onmouseover="pn_over(this,this.src)" onmouseout="pn_out(this,this.src)" width="60" height="60"/>
		 </div>
		 <div class='preNext next2012' >
		 <img src="http://images.d1.com.cn/Index/r_red1.jpg"  onmouseover="pn_over(this,this.src)" onmouseout="pn_out(this,this.src)" width="60" height="60"/>
		 </div>
	 
	   </div>
	   
      </div>

        
        <!-- 时尚推新结束 -->
        
        <div class="clear"></div>
        
        
         <!-- 护肤品-->
         <div class="blayout cosmetics">
         	<%=getKeyWord("2721") %>
        	<h1><a href="/html/cosmetic/" title="护肤品" target="_blank">护肤品</a></h1>
        	<table>
        	<tr>
        	<td width="418">
        	   <div class="img_list" ><%
            recommendList = PromotionHelper.getBrandListByCode("2722" , 3);
            if(recommendList != null && !recommendList.isEmpty()){
           		int size = recommendList.size();
           		Promotion[] recommendArr = new Promotion[3];
           		String[] recommendStr = new String[3];
           		for(int i=0;i<size;i++){
           			recommendArr[i] = recommendList.get(i);
           			recommendStr[i] = Tools.clearHTML(recommendArr[i].getSplmst_name());
           		}
           		String url1=StringUtils.encodeUrl(recommendArr[0].getSplmst_url());
       			if(url1.startsWith("http://www.d1.com.cn/html/brand/brand")){
       					String str1="http://www.d1.com.cn/html/brand/brand";
       					String str=url1.substring(str1.length(),url1.length()-4);
       					url1="/html/brand/index.jsp?id="+str;
       				}
       			String url2=StringUtils.encodeUrl(recommendArr[1].getSplmst_url());
       			if(url2.startsWith("http://www.d1.com.cn/html/brand/brand")){
       					String str1="http://www.d1.com.cn/html/brand/brand";
       					String str=url2.substring(str1.length(),url2.length()-4);
       					url2="/html/brand/index.jsp?id="+str;
       				}
       			String url3=StringUtils.encodeUrl(recommendArr[2].getSplmst_url());
       			if(url3.startsWith("http://www.d1.com.cn/html/brand/brand")){
       					String str1="http://www.d1.com.cn/html/brand/brand";
       					String str=url3.substring(str1.length(),url3.length()-4);
       					url3="/html/brand/index.jsp?id="+str;
       				}
           		if(recommendArr[0] != null){ %>
        		<div class="m_b10" style=" width:418px;  _margin-bottom:10px;"><a href="<%=url1 %>" title="<%=recommendStr[0] %>" target="_blank"><img src="<%=recommendArr[0].getSplmst_picstr() %>" alt="<%=recommendStr[0] %>" width="418" height="249" /></a></div><%
        		}if(recommendArr[1] != null){ %>
        		<div class="f_l m_r10" style="float:left"><a href="<%=url2 %>" title="<%=recommendStr[1] %>" target="_blank"><img src="<%=recommendArr[1].getSplmst_picstr() %>" alt="<%=recommendStr[1] %>" width="204" height="135"/></a></div><%
        		}if(recommendArr[2] != null){ %>
        		<div class="f_l" style="float:left; _margin-left:10px;"><a href="<%=url3%>" title="<%=recommendStr[2] %>" target="_blank"><img src="<%=recommendArr[2].getSplmst_picstr() %>" alt="<%=recommendStr[2] %>" width="204" height="135"/></a></div><%
        		%>
        		
        		<%}
            } %>
            
            </div>
        	</td>
        	<td>
        	 
            <%=getGoodsList("6762",8,120,120,0) %>
        	</td>
        	</tr>
        	
        	</table>
        	
        	
            
           
            <div class="hot_s">
        		<h3 >护肤品热门品牌推荐</h3>
                <div class="rollbox">
	            	<a href="javascript:void(0)" class="leftbtn" hidefocus id="left"></a>
		           	<div id="demo" >
			            <table border="0"  cellpadding="0">
			                <tr>
			                    <td id="demo1" valign="top">
			                     <table border="0" align="center" cellpadding="0" cellspacing="0">
			                            <tr valign="top" ><%
			                            recommendList = PromotionHelper.getBrandListByCode("2723" , -1);
			                            if(recommendList != null && !recommendList.isEmpty()){
			                            	for(Promotion recommend : recommendList){
			                            		String title = Tools.clearHTML(recommend.getSplmst_name());
			                            		String url=StringUtils.encodeUrl(recommend.getSplmst_url());
			            	           			if(url.startsWith("http://www.d1.com.cn/html/brand/brand")){
			            	           				//	out.print("<script>alert('ssssssss')</script>");
			            	           					String str1="http://www.d1.com.cn/html/brand/brand";
			            	           					String str=url.substring(str1.length(),url.length()-4);
			            	           					url="/html/brand/index.jsp?id="+str;
			            	           				}
			                            		%>
			                               <td align="left"><a href="<%=url%>" target="_blank" title="<%=title %>"><img src="<%=recommend.getSplmst_picstr() %>" style=" width:100px; height:40px;" alt="<%=title %>" /></a></td><%
			                            }} %>
			                            </tr>
			                        </table>
			                    </td>
			         
			                    <td id="demo2" valign="top"></td>
			                </tr>
			            </table>
			        </div>
	        	<a href="javascript:void(0)" class="rightbtn" hidefocus id="right"></a>
		    	</div>
        	</div>
        </div>
        <!--护肤品结束-->
        
         <!--女装-->
         <div class="blayout women">
         	<%=getKeyWord("2724") %>
        	<h1><a href="/html/cloth/" title="女装" target="_blank">女装</a></h1>
            <div class="women_show">
              <div id="sslideBox"><%
              recommendList = PromotionHelper.getBrandListByCode("2725" , -1);
              if(recommendList != null && !recommendList.isEmpty()){
            	  int size = recommendList.size();
              %>
              	<ul id="spic" style="left: 0px"><%
              	  for(int i=0;i<size;i++){
              		Promotion recommend = recommendList.get(i);
              		String title = Tools.clearHTML(recommend.getSplmst_name());
              	%>
              		<li><a href="<%=StringUtils.encodeUrl(recommend.getSplmst_url()) %>" title="<%=title %>" target="_blank"><img src="<%=recommend.getSplmst_picstr() %>" height="545" width="255" alt="<%=title %>" /></a></li><%
              	  } %>
              	</ul>
              	<ul id="sla"><li></li></ul>
              	<ul id="iconBall3"><%
              	for(int i=0;i<size;i++){
              	%>
              		<li<%if(i==0){ %> class="active"<%} %>></li><%
              	} %>
              	</ul><%
              } %>
				<ul id="sra"><li></li></ul>
			  </div>
            </div>
            <%=getGoodsList("6763",8,160,200,1) %>
        </div>
        <!--女装结束-->
          <!--男装-->
         <div class="blayout menswear">
         	<%=getKeyWord("2730") %>
        	<h1><a href="/html/man/" title="男装" target="_blank">男装</a></h1>
             <div class="man_show">
              <div id="sslideBox1"><%
              recommendList = PromotionHelper.getBrandListByCode("2775" , -1);
              if(recommendList != null && !recommendList.isEmpty()){
            	  int size = recommendList.size();
              %>
              	<ul id="spic1" style="left: 0px"><%
              	  for(int i=0;i<size;i++){
              		Promotion recommend = recommendList.get(i);
              		String title = Tools.clearHTML(recommend.getSplmst_name());
              	%>
              		<li><a href="<%=StringUtils.encodeUrl(recommend.getSplmst_url()) %>" title="<%=title %>" target="_blank"><img src="<%=recommend.getSplmst_picstr() %>" height="545" width="255" alt="<%=title %>" /></a></li><%
              	  } %>
              	</ul>
              	<ul id="sla1"><li></li></ul>
              	<ul id="iconBall4"><%
              	for(int i=0;i<size;i++){
              	%>
              		<li<%if(i==0){ %> class="active"<%} %>></li><%
              	} %>
              	</ul><%
              } %>
				<ul id="sra1"><li></li></ul>
			  </div>
            </div>
            <%=getGoodsList("7266",8) %>
        </div>
        <!--男装结束-->
	   
	        <!--饰品-->
        <div class="blayout jewelry">
        	<%=getKeyWord("2726") %>
        	<h1><a href="/html/ornament/" title="饰品" target="_blank">饰品</a></h1><%
            recommendList = PromotionHelper.getBrandListByCode("2727" , 5);
            if(recommendList != null && !recommendList.isEmpty()){
           		int size = recommendList.size();
           		Promotion[] recommendArr = new Promotion[5];
           		String[] recommendStr = new String[5];
           		for(int i=0;i<size;i++){
           			recommendArr[i] = recommendList.get(i);
           			recommendStr[i] = Tools.clearHTML(recommendArr[i].getSplmst_name());
           		}
           		%>
           	
           		<div style=" width:385px; margin-right:10px; float:left"><%
           		if(recommendArr[0] != null){ %>
        		<div style=" margin-bottom:10px;"><a href="<%=StringUtils.encodeUrl(recommendArr[0].getSplmst_url()).replace("aspx", "jsp") %>" title="<%=recommendStr[0] %>" target="_blank"><img src="<%=recommendArr[0].getSplmst_picstr() %>" width="385" height="220" alt="<%=recommendStr[0] %>" /></a></div><%
        		}if(recommendArr[1] != null){ %>
        		<div style=" float:left;  margin-right:8px;"><a href="<%=StringUtils.encodeUrl(recommendArr[1].getSplmst_url()).replace("aspx", "jsp") %>" title="<%=recommendStr[1] %>" target="_blank"><img src="<%=recommendArr[1].getSplmst_picstr() %>"  width="188" height="165" alt="<%=recommendStr[1] %>" /></a></div><%
        		}if(recommendArr[2] != null){ %>
        		<div style=" float:left;"><a href="<%=StringUtils.encodeUrl(recommendArr[2].getSplmst_url()).replace("aspx", "jsp") %>" title="<%=recommendStr[2] %>" target="_blank"><img src="<%=recommendArr[2].getSplmst_picstr() %>"  width="188" height="165" alt="<%=recommendStr[2] %>" /></a></div><%
        		}%></div>
        		<div style=" width:162px; float:left; "><%
        		if(recommendArr[3] != null){ %>
        			<div ><a href="<%=StringUtils.encodeUrl(recommendArr[3].getSplmst_url()).replace("aspx", "jsp") %>" title="<%=recommendStr[3] %>" target="_blank"><img src="<%=recommendArr[3].getSplmst_picstr() %>" width="162" height="144" alt="<%=recommendStr[3] %>" /></a></div><%
        		}if(recommendArr[4] != null){ %>
        			<div class="clear" style=" margin-top:10px;"><a href="<%=StringUtils.encodeUrl(recommendArr[4].getSplmst_url()).replace("aspx", "jsp") %>" title="<%=recommendStr[4] %>" target="_blank"><img src="<%=recommendArr[4].getSplmst_picstr() %>" width="162" height="242" alt="<%=recommendStr[4] %>" /></a></div><%
        		} %></div><%
            }%>
            <%=getGoodsList("6764",6,120,120,0) %>
            <div class="clear"></div>
        </div>
         <!--饰品结束-->
         
        <!-- 女包-->
        <div class="blayout handbug">
        	<%=getKeyWord("2728") %>
        	<h1><a href="/html/shoebag/" title="女包" target="_blank">女包</a></h1>
            <div class="f_r" style="width:415px;"><%
            recommendList = PromotionHelper.getBrandListByCode("2729" , 3);
            if(recommendList != null && !recommendList.isEmpty()){
           		int size = recommendList.size();
           		Promotion[] recommendArr = new Promotion[3];
           		String[] recommendStr = new String[3];
           		for(int i=0;i<size;i++){
           			recommendArr[i] = recommendList.get(i);
           			recommendStr[i] = Tools.clearHTML(recommendArr[i].getSplmst_name());
           		}
           		if(recommendArr[0]!=null){ %>
        		<div class="m_b10"><a href="<%=StringUtils.encodeUrl(recommendArr[0].getSplmst_url()) %>" title="<%=recommendStr[0] %>" target="_blank"><img src="<%=recommendArr[0].getSplmst_picstr() %>" alt="<%=recommendStr[0] %>" width="412" height="200" /></a></div><%
        		}if(recommendArr[1]!=null){ %>
        		<div class="f_l m_r10"><a href="<%=StringUtils.encodeUrl(recommendArr[1].getSplmst_url()) %>" title="<%=recommendStr[1] %>" target="_blank"><img src="<%=recommendArr[1].getSplmst_picstr() %>" alt="<%=recommendStr[1] %>" width="201" height="181"/></a></div><%
        		}if(recommendArr[2]!=null){ %>
        		<div class="f_l"><a href="<%=StringUtils.encodeUrl(recommendArr[2].getSplmst_url()) %>" title="<%=recommendStr[2] %>" target="_blank"><img src="<%=recommendArr[2].getSplmst_picstr() %>" alt="<%=recommendStr[2] %>" width="201" height="181"/></a></div><%
        		}
            } %></div>
            <%=getGoodsList("6765",8,120,120,0) %>
            <div class="clear"></div>
        </div>
        <!-- 女包结束-->
        
        
       
        <!-- 名表-->
        <div class="blayout watch">
        	<%=getKeyWord("2737") %>
        	<h1><a href="/html/watch/" title="名表" target="_blank">名表</a></h1>
            <div style=" float:left;">
            	<div id="container">
		        	<div id="example">
            	    	<div id="slides" class="m_b10"><%
	            	    	recommendList = PromotionHelper.getBrandListByCode("2738" , -1);
	            	    	if(recommendList != null && !recommendList.isEmpty()){
	            	    	%>
						    <ul id="dpic" style="left: 0px"><%
						    	for(Promotion recommend : recommendList){
						    		String title = Tools.clearHTML(recommend.getSplmst_name());
						    %>
						    	<li><a href="<%=StringUtils.encodeUrl(recommend.getSplmst_url()) %>" title="<%=title %>" target="_blank"><img src="<%=recommend.getSplmst_picstr() %>" alt="<%=title %>" height="278" width="385" /></a></li><%
						    	} %>
						    </ul><%
						    } %>
					        <a href="###" class="prev" title="上一张"><img src="http://images.d1.com.cn/Index/images/dl.png" width="30" height="278" alt="上一张"></a>
					        <a href="###" class="next" title="下一张"><img src="http://images.d1.com.cn/Index/images/dr.png" width="30" height="278" alt="下一张"></a>	
				        </div>
				    </div>
				</div>
                <div class="f_l"><%
                recommendList = PromotionHelper.getBrandListByCode("2739" , 1);
                if(recommendList != null && !recommendList.isEmpty()){
                	Promotion recommend = recommendList.get(0);
                	String title = Tools.clearHTML(recommend.getSplmst_name());
                %>
                	<a href="<%=StringUtils.encodeUrl(recommend.getSplmst_url()) %>" title="<%=title %>" target="_blank"><img src="<%=recommend.getSplmst_picstr() %>" alt="<%=title %>" width="415" height="115" /></a><%
               	} %>
                </div>
            </div>
            <%=getGoodsList("6770",8,120,120,0) %>
            <div class="clear"></div>
            <div class="hot_s">
        		<h3>手表热门品牌推荐</h3>
                <div class="rollbox2">
	               	<a href="javascript:void(0)" class="leftbtn" hidefocus id="left1"></a>
			           <div id="demo_s" >
	        	        <table border="0"  cellpadding="0">
	               		    <tr>
	                       		<td id="demo1_s" valign="top">
	                       			<table border="0" align="center" cellpadding="0" cellspacing="0">
	                             		<tr valign="top"><%
	                             		recommendList = PromotionHelper.getBrandListByCode("2740" , -1);
	                             		if(recommendList != null && !recommendList.isEmpty()){
	                             			for(Promotion recommend : recommendList){
	                             				String title = Tools.clearHTML(recommend.getSplmst_name());
	                             				String url=StringUtils.encodeUrl(recommend.getSplmst_url());
	                    	           			if(url.startsWith("http://www.d1.com.cn/html/brand/brand")){
	                    	           				//	out.print("<script>alert('ssssssss')</script>");
	                    	           					String str1="http://www.d1.com.cn/html/brand/brand";
	                    	           					String str=url.substring(str1.length(),url.length()-4);
	                    	           					url="/html/brand/index.jsp?id="+str;
	                    	           				}
	                    	           			if(url.startsWith("http://www.d1.com.cn/html/mini/mininew")){
	                    	           				//	out.print("<script>alert('ssssssss')</script>");
	                    	           					String str1="http://www.d1.com.cn/html/mini/mininew";
	                    	           					String str=url.substring(str1.length(),url.length()-4);
	                    	           					url="/html/mini/index.jsp?id="+str;
	                    	           				}
	                             		%>
	                                  		<td align="left"><a href="<%=url %>" title="<%=title %>" target="_blank"><img src="<%=recommend.getSplmst_picstr() %>" style=" width:100px; height:40px;" alt="<%=title %>" /></a></td><%
	                                  	}} %>
	                              		</tr>
	            	           		</table>
	                       		</td>
			                   <td id="demo2_s" valign="top"></td>
	        	            </tr>
	               		</table>
	            	</div>
	            	<a href="javascript:void(0)" class="rightbtn" hidefocus id="right1"></a>
            	</div>
            </div>
                    </div>
        <!--名表结束-->    
       
       
       
        <div class="clear"></div>
        
        
         <!-- 会员积分-->
        <div class="content">
         <div class="layout_box menmber">
            <h2><a href="/jifen/index.jsp" target="_blank" class="more"><em>&gt;&gt;</em>更多兑换礼品</a>会员专区</h2><%
            List<PromotionProduct> recommendProList = null;
            recommendProList = PromotionProductHelper.getPromotionProductByCode("6771" , 100);
            if(recommendProList != null && !recommendProList.isEmpty()){
            	int size = recommendProList.size();
            	int count = 0;
            %>
            <ul class="goods_list"><%
            	for(int i=0;i<size&&count<5;i++){
            		PromotionProduct recommend = recommendProList.get(i);
            		Product product = ProductHelper.getById(recommend.getSpgdsrcm_gdsid());
            		if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
            		String title = Tools.clearHTML(recommend.getSpgdsrcm_gdsname());
            		Award award = AwardHelper.getByProductId(product.getId());
            		if(award == null) continue;
            %>
            	<li><dl>
            		<dt><a href="/jifen/index.jsp" title="<%=title %>" target="_blank"><img src="http://images.d1.com.cn/<%=product.getGdsmst_otherimg3() %>" alt="<%=title %>" width="120" height="120"/></a></dt>
            		<dd class="name"><a href='/jifen/index.jsp' title="<%=title %>" target='_blank'><%=title %></a></dd>
            		<dd><strong><%=Tools.longValue(award.getAward_value()) %>积分</strong><del>￥<%=product.getGdsmst_saleprice() %></del></dd>
            	</dl></li><%
            		count++;
            	} %>
            </ul><%
            } %>
        </div>
        <div class="right_side about_us">
          <div class="layout_box">
            <h2>D1影响力</h2><%
            recommendList = PromotionHelper.getBrandListByCode("2742" , 4);
            if(recommendList != null && !recommendList.isEmpty()){
            	int size = recommendList.size();
            %>
            <ul class="news_list"><%
            	for(int i=0;i<size;i++){
            		Promotion recommend = recommendList.get(i);
            		String title = Tools.clearHTML(recommend.getSplmst_name());
            %>
            	<li><a href="<%=StringUtils.encodeUrl(recommend.getSplmst_url()) %>" target='_blank' title="<%=title %>"<%if(i==1){ %> style="color:#ad4456"<%} %>><%=title %></a></li><%
            	} %>
            </ul><%
            } %>
          </div>
          <div class="layout_box">
            <h2>关注D1</h2>
            <p class="brand1"><a href="http://weibo.com/d1ys" target=_blank><img src="http://images.d1.com.cn/Index/images/xlwb.jpg" alt="新浪微博" /></a><a href="http://t.qq.com/d1_com_cn" target=_blank><img src="http://images.d1.com.cn/Index/images/txwb.jpg" alt="腾讯微博" /></a><a href="http://t.sohu.com/home" target=_blank><img src="http://images.d1.com.cn/Index/images/shwb.jpg" alt="搜狐微博" /></a></p>
          </div>
        </div>
        </div>
        <!-- 会员积分结束-->
		<div class="clear"></div>
	</div>
	<div class="clear"></div>
        
        
	</div>
   
   
   
</div>
<div class="clear"></div>
<%@include file="/inc/foot.jsp" %>


<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/indexnew/main.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/indexnew/retime.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
<script type="text/javascript">
$(function() {
    $('#slides').slides({
        preload: true,
        preloadImage: 'http://images.d1.com.cn/images2012/New/Loading.gif',
        play: 3000,
        pause: 2500,
        hoverPause: true,
        animationStart: function() {
            $('.caption').animate({
                bottom: -35
            }, 100);
        },
        animationComplete: function(current) {
            $('.caption').animate({
                bottom: 0
            }, 200);
            if (window.console && console.log) {
                // example return of current slide number
                console.log(current);
            };
        }
    });
   
});
function marqueeScroll(id,id1,id2,align,speed,lb,rb){
	var demo = $('#'+id),demo1 = $('#'+id1),demo2 = $('#'+id2);
	demo2.html(demo1.html());
	var demo_s=demo.get(0),demo1_s=demo1.get(0),demo2_s=demo2.get(0);
	function Marqueeleft_s() {//向左滚动
        if (demo2_s.offsetWidth - demo_s.scrollLeft <= 0){
            demo_s.scrollLeft -= demo1_s.offsetWidth;
        }else{
            demo_s.scrollLeft++;
        }
    };
    function Marqueeright_s() {//向右滚动
        if (demo2_s.offsetWidth - demo_s.scrollLeft >= 930) {
            demo_s.scrollLeft += demo1_s.offsetWidth;
        }else{
        	demo_s.scrollLeft--;
        }
    };
    var MyMar_s = setInterval(Marqueeleft_s, speed)//自动开始滚动
    Direction1 = align; //设定初始方向为向左滚
    
    demo.mouseover(function(){
    	clearInterval(MyMar_s);
    }).mouseout(function(){
    	if (Direction1 == 'Left') {
            MyMar_s = setInterval(Marqueeleft_s, speed)
        } else if (Direction1 == 'Right') {
            MyMar_s = setInterval(Marqueeright_s, speed)
        }
    });
    $('#'+lb).click(function(){
    	clearInterval(MyMar_s);
        MyMar_s = setInterval(Marqueeleft_s, speed)
        Direction1 = 'Left';
    });
    $('#'+rb).click(function(){
    	clearInterval(MyMar_s);
        MyMar_s = setInterval(Marqueeright_s, speed)
        Direction1 = 'Right';
    });
}



function upszlb()
{
    if(document.getElementById("ypsz_1").style.display=="block")
    	{
    	document.getElementById("ypsz_1").style.display="none";
    	document.getElementById("ypsz_2").style.display="block";
    	}
    else
    	{
    	document.getElementById("ypsz_2").style.display="none";
    	document.getElementById("ypsz_1").style.display="block";
    	}
}
setInterval("upszlb()",3000);

function mdm_over(obj)
{
    document.getElementById("div_"+obj).style.display="block";
}


 function mdm_out(obj)
{
    document.getElementById("div_"+obj).style.display="none";
	
}
 
 function pn_over(obj,url)
 {
    obj.src=url.substring(0,url.indexOf(".jpg")-1)+ ".jpg";
   
 }


  function pn_out(obj,url)
 {
	  obj.src=url.substring(0,url.indexOf(".jpg"))+ "1.jpg";
	  
 }
  $(document).ready(function() {
		ShowXSTM();
		marqueeScroll("demo_s","demo1_s","demo2_s",'Left',20,'left1','right1');
		marqueeScroll("demo","demo1","demo2",'Left',20,'left','right');
		//ShowTuanNew();
		xsms2011_new('sc');
		$(".img_list").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
		$(".goods_list").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
	});
 </script>
</body>
</html>