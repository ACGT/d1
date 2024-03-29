<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/html/productpublic.jsp"%><%@page import="org.hibernate.*,java.util.Comparator"%><%!
public static ArrayList<DhGdsM> getdhgdsmList(String card){
	ArrayList<DhGdsM> rlist = new ArrayList<DhGdsM>();

			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("dhgdsm_card",card));
			List<BaseEntity> list = Tools.getManager(DhGdsM.class).getList(clist, null, 0, 100);
			
			if(list!=null){
				for(BaseEntity be:list){
					DhGdsM pp = (DhGdsM)be;
                     rlist.add(pp);
				}
			}
	return rlist ;
}

%>
<%
String id = request.getParameter("id");
if(Tools.isNull(id))id=request.getParameter("gdsid");
id="01415154";
Product product = ProductHelper.getById(id);
if(product == null){
     response.sendRedirect("/404.jsp");
	out.print("商品不存在！");
	return;
}

//if(product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()!=1){
//	response.sendRedirect("/index.jsp");
//	return;
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

String dxid = Tools.getCookie(request,"rcmdusr_rcmid");
float dxprice = 0f;
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



if(!Tools.isNull(dxid) && Tools.floatCompare(dxprice, memberprice) !=0 ){
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
	    style = "<span class='mbrprice'>￥" + Tools.getFormatMoney(hyprice) + "</span>";
	}
}




String category = "";//最小的类别，在下面初始化了。

//获取所有参与兑换的商品
List<DhGdsM> dhgdsmList = getdhgdsmList("mqdd1208spxs");


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
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=gname %></title>
<meta name="keywords" content="<%=Tools.clearHTML(product.getGdsmst_gdsname()+(product.getGdsmst_keyword()==null?"":product.getGdsmst_keyword())) %>" />
<meta name="description" content="优尚网热卖产品<%=Tools.clearHTML(product.getGdsmst_gdsname())%>，在这你可以看到<%=Tools.clearHTML(product.getGdsmst_gdsname())%>的图片、评价、价格以及用户对他的使用感受，告诉你<%=Tools.clearHTML(product.getGdsmst_gdsname())%>怎么样，让您买的放心，用的开心。" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/gdsinfo.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/comment.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/static.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/gdscoll.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gdsmstlistCart.js")%>"></script>
<style type="text/css">
<!--
#cardno {
	height: 25px;
	_height: 24px;
	width: 150px;
	border:none;
	vertical-align:middle;
	background:#FFE7E7;
	font-size: 14px;
}
.cardm {
	color: #FC7C17;
	font-size: 14px;
}
.commname {
	color: #FC7C17;
	font-size: 12px;
}
.lin {
	border-bottom-width: 1px;
	border-bottom-style: dashed;
	border-bottom-color: #666666;
}
-->
</style>
</head>

<body>
 
<!--头部-->
<%@include file="/inc/head.jsp" %>
<!-- 头部结束--><%
if(!Tools.isNull(rackCode)){
%>
<script type="text/javascript">
stepNavAction('<%
if(rackCode.startsWith("017001")){
	out.print("html/cloth/index");
}else if(rackCode.startsWith("017002")){
	out.print("html/man/index");
}else if(rackCode.startsWith("014")){
	out.print("html/cosmetic/index");
}else if(rackCode.startsWith("015009")){
	out.print("html/ornament/index");
}else if(rackCode.startsWith("017005")){
	out.print("html/shoebag/index");
}else if(rackCode.startsWith("015002")){
	out.print("html/watch/index");
}
%>');
</script><%
} %>
<!-- 中间内容-->
<div id="center">
	
		 <!-- banner -->


		 <!-- 商品展示-->
	    <div class="goodsshow">
		    
			 
			 <!--商品展示右侧-->
			<div class="gs_right">
			     <!-- 商品展示-->
			    <div class="goods_new">
					<div class="gs_right_title">
					<h1 id="gdstitle"><%=gname %>
					</h1>
					</div>
					<hr class="newhr"/>
					<!-- 商品展示-->
					<div class="gs_right_spimg">
							<img src="http://images.d1.com.cn/images2012/market/dd/400-400-2.jpg" width="400" height="400" />
							
							<div class="share">
								<img src="/res/images/product/share.jpg" />
								<a href="javascript:void((function(s,d,e,r,l,p,t,z,c) {var%20f='http://v.t.sina.com.cn/share/share.php?appkey=2833634960',u=z||d.location,p=['&url=',e(u),'& title=',e(t||d.title),'&source=',e(r),'&sourceUrl=',e(l),'& content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a() {if(!window.open([f,p].join(''),'mb', ['toolbar=0,status=0,resizable=1,width=600,height=500,left=',(s.width- 600)/2,',top=',(s.height-600)/2].join('')))u.href=[f,p].join('');}; if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();}) (screen,document,encodeURIComponent,'','','<%=ProductHelper.getImageTo400(product) %>','<%=fxcontent %>','http://www.d1.com.cn/gdsinfo/<%=id %>.asp','utf-8'));" title="分享到新浪微博" rel="nofollow"><img src="/res/images/product/sina.jpg" alt="分享到新浪微博" /></a>
								<a title="分享到搜狐微博" href="javascript:void((function(s,d,e,r,l,p,t,z,c){var f='http://t.sohu.com/third/post.jsp?',u=z||d.location,p=['&url=',e(u),'&title=',e(t||d.title),'&content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a(){if(!window.open([f,p].join(''),'mb',['toolbar=0,status=0,resizable=1,width=660,height=470,left=',(s.width-660)/2,',top=',(s.height-470)/2].join('')))u.href=[f,p].join('');};if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();})(screen,document,encodeURIComponent,'','','<%=ProductHelper.getImageTo400(product) %>','<%=fxcontent %>','http://www.d1.com.cn/gdsinfo/<%=id %>.asp','utf-8'));" rel="nofollow"><img src="/res/images/product/sohuwb.jpg" width="18" height="17" alt="分享到搜狐微博" /></a>
								<a href="javascript:void(0)" onclick="postToWb();return false;" title="转播到腾讯微博" rel="nofollow"><img src="/res/images/product/wb.jpg" alt="转播到腾讯微博" /></a>
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
			                        document.write(['<a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?',s.join('&'),'" target="_blank" title="分享到QQ空间" rel="nofollow"><img src="/res/images/product/qq.jpg" alt="分享到QQ空间" /></a>'].join(''));
			                        })();
								</script>
							</div>
					</div>
					<!-- 商品展示结束-->
				 	<!--商品信息说明-->
				     <div class="gs_right_spContent">
                         <table border="0" cellpadding="0" cellspacing="0" width="100%">
						  
						     <tr>
							     <td colspan="3">
								     <div class="spgg">
								     <!--   <DIV class=skuname1 id=skuname2>
      <P>选择：<FONT id=sizecount2></FONT></P>
      <UL>
        <LI><A hideFocus title="橘色"  onclick=choosegdsid(this) 
        href="javascript:void(0);" attr="02000182"><IMG 
        src="http://images.d1.com.cn/shopadmin/d1gdsimg/2012/05/02/02000182_s_0.jpg"> </A><BR><BR><BR>橘色</LI>
        <LI><A hideFocus title="蓝色"  onclick=choosegdsid(this) 
        href="javascript:void(0);" attr="02000213"><IMG src="http://images.d1.com.cn/shopadmin/d1gdsimg/2012/05/02/02000181_s_1.jpg"> 
        </A><BR><BR><BR>蓝色</LI></UL></DIV>
      <SCRIPT type=text/javascript>$('#sizecount2').html('橘色');</SCRIPT>-->
      <%String gdsarrstr="";
      String selectgdsid = "";
                            
									    if(dhgdsmList != null){
									    	
										    	%><div id="skuname2" class="skuname1">
									           	<p><span style="color:#FC7C17;">第一步</span>选择商品：<font id="sizecount2"></font></p>
									    		<ul><%
									    		String selectSku2 = "";
									    		String title="";
									    		int i=1;
										    	for(DhGdsM dhgds : dhgdsmList){
										    		title=dhgds.getDhgdsm_title();
										    		
										    		String gId = Tools.trim(dhgds.getDhgdsm_gdsid());
										    		Product goods = ProductHelper.getById(gId);
										    		//if(goods!=null&&goods.getGdsmst_validflag().longValue()==1)
										    		//{
										    		%><li <%if(i==1){ %> class="select"<%} %>>
										    	<A hideFocus title="<%=title %>" ptitle="<%=goods.getGdsmst_gdsname() %>" onclick=choosegdsid(this)  href="javascript:void(0);" attr="<%=dhgds.getDhgdsm_gdsid()%>" <%if(i==1){ %> class="current"<%} %>><img  height=80 width=80 src="<%=ProductHelper.getImageTo80(goods) %>" />
										    		</a>
										    		<br/><br/><br/><%=dhgds.getDhgdsm_title()%></li><%
										    		//}
										    		if (i==1){
										    			selectSku2=dhgds.getDhgdsm_title();
										    			selectgdsid=dhgds.getDhgdsm_gdsid();
										    			gdsarrstr=gId;
										    		}
										    		else{
										    		gdsarrstr=gdsarrstr+","+gId;
										    		}
										    		i++;
										    	}
										    	gdsarrstr=gdsarrstr+","+id;
										    	%></ul>
										    	</div>
										    	<script type="text/javascript">$('#sizecount2').html('<%=selectSku2 %>');</script><%
										        }
						
									    
									    ///sku
									   // if(!Tools.isNull(skuname1)){
									    	int showsku=0;
									    	//if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==0||product.getGdsmst_stocklinkty().longValue()==3)){
									    	//	showsku=0;
									    	//}
									    	//System.out.println(showsku);
										    List<Sku> skuList = SkuHelper.getSkuListViaProductIdO(selectgdsid,showsku);
										    if(skuList != null && !skuList.isEmpty()){
										    	int size = skuList.size();
										    	%><div id="skuname" class="skuname">
										    	<div style="float:left;"><p><span style="color:#FC7C17;">第二步</span>选择颜色和尺寸：<font id="sizecount"><%=size==1?skuList.get(0).getSkumst_sku1():"未选择" %></font></p>
										   </div>
										    		<div style="float:right; padding-right:15px;">
										    		<p>
										    			   <font id="ccdzb" style=" color:#020399; cursor:hand;" onmouseover="ccdzb()" onmouseout="ccdzb1()">(尺寸对照表)</font></p>
										    			   </div>
										    		      <div id="ccdzb_img" style="float:left; position:absolute;display:none;clear:both;" onmouseover="ccdzb()" onmouseout="ccdzb1()">
										    		     
										    		       <img src="http://images.d1.com.cn/market/1206/wydh/fm9stx2_27.jpg" border="0"/>
										    		   
										    		     
										    		 </div>
<div style="clear:both;"></div>
										    		<ul>
										    		<%
										    		for(int i=0;i<size;i++){
										    			Sku sku = skuList.get(i);
										    			String skuname = sku.getSkumst_sku1();
										    			if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
										    				if(CartItemHelper.getProductOccupyStock(product.getId(), sku.getId())<ProductHelper.getVirtualStock(product.getId(), sku.getId())){
											    				%><li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a></li><%
										    				}
										    				else
										    				{
										    					if(sku.getSkumst_vstock().longValue()==0){ %>
										    						<li><a href="javascript:void(0);" title="售罄"   hidefocus="true"  style="height:21px;line-height:21px;padding:0 9px;border:1px solid #dcdddd;background:#fff;color:#dcdddd;text-decoration:none;"><span><%=skuname %></span></a></li>
										    					<%}
										    					else
										    					{%>
										    						<li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a></li>
										    					<%}
										    				}
										    			}else{
										    	
										    			%><li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname %></span></a></li><%
										    			  
										    			}
										    		}
										    		%>

										    		</ul>
										    	</div><%
										    }else{
										    	%>
										    	<div id="skuname" class="skuname"></div>
										   <% }
									    //}
									    endprice = (Tools.floatCompare(dxprice,0)==0 ? Tools.getFormatMoney(memberprice) : Tools.getFormatMoney(dxprice));
									    %>

									 </div>
								 </td>
							 </tr>
							 <tr><td colspan="3" height="38">
							 <table width="338" height="50" border="0" cellpadding="0" cellspacing="0">
  <tr>
  <td colspan="2"><p><span style="color:#FC7C17;">第<span id="sstep">二</span>步：</span>输入兑换码，放入购物车</p></td>
  </tr>
  <tr>
    <td width="110" height="50" valign="middle"><span class="cardm" style="color:#D4000E;font-weight:bold;">请输入兑换码：</span></td>
    <td width="234" style="background:url('http://images.d1.com.cn/market/1206/wydh/cardno_03.jpg') no-repeat;" valign="bottom">
    <div style="float:left;padding-left:10px;height:26px;_height:24px;padding-bottom:11px;"> <input type="text" style="width:180px" name="cardno" id="cardno" style="border:none;"/></div>
   
    </td>
  </tr>
</table></td></tr>
							 <tr height="45"><td colspan="3" valign="middle"><%
							//if(ifhavegds == 0){
								//if(validflag == 1||validflag == 4){
								//	if(ProductStockHelper.canBuy(product)){
							 %><a href="javascript:void(0)" onclick="ShowAJaxdh()"><img src="/res/images/product/frgwc.jpg" /></a>
							  <div class="frgwc_div" id="frgwc" style="display:none;">
							    <span style="position:relative;overflow:hidden;">
							    	<font id="countgdsmst1">1</font>件商品加入购物车
							    	<a href="###" class="ui-dialog-titlebar-close ui-corner-all" onclick="$('#frgwc').hide();"><span class="ui-icon ui-icon-closethick">close</span></a>
							    </span>
								<ul>
								<li>
								    <img src="http://images.d1.com.cn<%=product.getGdsmst_smallimg() %>" id="cardimg" width="80" height="80" />
									<div style="height:80px;"> <font style="_font-size:12px; "><b>
                                        <div id="spname1" style="font-weight:bold;padding-bottom:10px;"></div></b></font>
									<br/><br/>
									    加入数量：<font id="countgdsmst2">1</font><br/>
									    总计金额:￥<font id="countgdsmst3">59</font><br/>
									</div>
								
								</li>
								</ul>
								<div class="gwcbtn"><a href="/flow.jsp" target="_blank" onclick="display_hide('frgwc');"><img src="/res/images/viewcart.gif" alt="查看购物车" /></a><a href="javascript:void(0)" onclick="display_hide('frgwc')"><img src="http://images.d1.com.cn/Index/images/jxgw.jpg" alt="继续购物" /></a>							</div>
							 </div>
							      <%
									//}else{
										%><!--  <img src="/res/images/product/yxj.gif" align="absmiddle" />--><%
									//}
								//}else{
									%><!-- <img src="/res/images/product/yxj.gif" align="absmiddle" />--><%
								//}
							// }%></td></tr>
						 </table>		 
					 </div>
					  <!--商品信息说明结束-->
				  </div>
				 <!-- 商品展示结束-->
				<div class="clear"></div>
				
				 
				 <!--商品信息描述-->
				 <div style=" text-align:left;" ><a name="cmt"></a>
				 <hr style=" border:5px solid #fff" />
					<div id="goodsinfotab" class="zh_title"><a href="javascript:void(0)" class="newa">商品信息</a></div>
					<div class="clear"></div>
					<div id="content_list_info">
					<!-- 商品信息-->
					<span style="display:none">
					 <div class="goods_info">
					   
						<div class="goods_content_list">
							<img src="http://images.d1.com.cn/images2012/market/dd/yibufen.jpg"></img>
						</div>
						
						<div class="gstitle"><img src="/res/images/product/spxq.jpg" />商品详情</div>					
						    
						<div class="goods_content goods_info_con">
						
						<table id="__01" width="750" height="3993" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01415154" target="_blank"><img src="http://images.d1.com.cn/market/1209/dangdang/sps_01.jpg" alt="" width="750" height="62" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01415154" target="_blank"><img src="http://images.d1.com.cn/market/1209/dangdang/sps_02.jpg" alt="" width="750" height="562" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01415154" target="_blank"><img src="http://images.d1.com.cn/market/1209/dangdang/sps_03.jpg" alt="" width="750" height="562" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01517337" target="_blank"><img src="http://images.d1.com.cn/market/1209/dangdang/sps_04.jpg" alt="" width="750" height="87" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01517337" target="_blank"><img src="http://images.d1.com.cn/market/1209/dangdang/sps_05.jpg" alt="" width="750" height="409" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1209/dangdang/sps_06.jpg" width="750" height="528" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1209/dangdang/sps_07.jpg" width="750" height="654" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01516990" target="_blank"><img src="http://images.d1.com.cn/market/1209/dangdang/sps_08.jpg" alt="" width="750" height="91" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01516990" target="_blank"><img src="http://images.d1.com.cn/market/1209/dangdang/sps_09.jpg" alt="" width="750" height="390" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1209/dangdang/sps_10.jpg" width="750" height="426" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1209/dangdang/sps_11.jpg" width="750" height="222" alt=""></td>
	</tr>
</table>
						</div>
						
						<%=getBrandName(product) %>
					 </div>
					 </span>
					<!--商品信息结束-->
					
					</div>
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
							 <a href="<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><img src="<%=ProductHelper.getImageTo80(goods) %>" alt="<%=title %>" align="middle" width="60" height="60" /></a>
							 <div class="gs_left_content_r">
							 	<a href="<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><%=title %></a><br/>
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
						     <div class="gs_left_ltitle" style=" text-align:left; padding-left:15px;">浏览本商品的顾客还看过</div>
							 <div class="gs_left_content"><%
							 for(int i=0;i<size;i++){
								 Product goods = ProductHelper.getById(linklist[i]);
								 if(goods==null)continue;
								 String title = Tools.clearHTML(goods.getGdsmst_gdsname());

							 %>
							  	<div class="gs_left_content_sub">
									<a href="<%=ProductHelper.getProductUrl(goods).trim() %>" target="_blank"><img src="<%=ProductHelper.getImageTo80(goods) %>" align="middle" width="60" height="60" /></a>
									<div class="gs_left_content_r">
										<a href="<%=ProductHelper.getProductUrl(goods).trim() %>" target="_blank"><%=title %></a><br/>
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
				     <div class="gs_left_ltitle" style=" text-align:left; padding-left:15px;">本类热卖排行 </div>
					 <div class="gs_left_content"><%
					 for(RackcodeTop codeTop : hotList){
						 Product goods = ProductHelper.getById(codeTop.getRcktop_gdsid());
						 String title = Tools.clearHTML(goods.getGdsmst_gdsname());

					 %>
					  	<div class="gs_left_content_sub">
							<a href="<%=ProductHelper.getProductUrl(goods).trim() %>" target="_blank"><img src="<%=ProductHelper.getImageTo80(goods) %>" align="middle" width="60" height="60" /></a>
							<div class="gs_left_content_r">
								<a href="<%=ProductHelper.getProductUrl(goods).trim() %>" target="_blank"><%=title %></a><br/>
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
							 <a href="<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><img src="<%=ProductHelper.getImageTo80(goods) %>" alt="<%=title %>" align="middle" width="60" height="60" /></a>
							 <div class="gs_left_content_r">
							 	<a href="<%=ProductHelper.getProductUrl(goods) %>" title="<%=title %>" target="_blank"><%=title %></a><br/>
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
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/market.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
<script type="text/javascript">
$(document).ready(function(){
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
});


function ccdzb()
{
  var top=$('#skuname').offset().top+$('#skuname p').height()-5;
  var right=$(document).width()-($(".gs_right").offset().left+$(".gs_right").width());
  $("#ccdzb_img").css("top",top);
  $("#ccdzb_img").css("left",right+200);
  $("#ccdzb_img").css("display","block");

}
function ccdzb1()
{
	$("#ccdzb_img").css("display","none");
}
//选择不同色商品
function choosegdsid(obj){
    var skuid = $("#skuname2");
    if (skuid.length==0) return;
    var skuid = skuid.find("li");
    var s="";
    if (skuid.length > 0){
    	skuid.each(function(){
    		$(this).removeClass('select').find("a").removeClass("current");
    	});
    	$(obj).parent().addClass("select").find("a").addClass("current");
    	 var skuItem = skuid.find("a");
    	skuItem.each(function(){
    		if($(this).hasClass('current')){
    			s = $(this).attr("attr");
      		}
    	});
    	$("#sstep").html("二");
    	$('#sizecount2').html($(obj).attr("title"));
    	$('#gdstitle').html($(obj).attr("ptitle"));
    	$('#skuname').html('');
    }
    if(s=="01517337"){
    	$("#sstep").html("三");
    	 $.ajax({
    			type: "get",
    			dataType: "json",
    			url: 'moresku.jsp',
    			cache: false,
    			data: {gdsid:s},
    			error: function(XmlHttpRequest){
    				alert("SKU错误！");
    			},success: function(json){
    				if(json.success){
    					$('#skuname').html(json.content);
    				}else{
    					alert("SKU错误！");
    				}
    			},beforeSend: function(){
    			},complete: function(){
    			}
    		});
    }
   
}
//遍历规格
function BLGG2dh(){
	var skuid = $("#skuname2");
    if (skuid.length==0){
    	return '';
    }
    var skuItem = skuid.find("a");
    var s = '';
    if(skuItem.length>0){
    	skuItem.each(function(){
    		if($(this).hasClass('current')){
    			s = $(this).attr("attr");
    			return false;
    		}
    	});
    }
    return s;
}

//放入购物车操作
function ShowAJaxdh(){
	var cardno=$('#cardno').val();
	var sku2=BLGG2();
	if(typeof sku2 == 'undefined'){
		sku2 = "";
	}
	var skuys=BLGG2dh();
	if(typeof skuys == 'undefined'){
		skuys = "";
	}
	//alert(cardno);
	$.ajax({
		type: "get",
		dataType: "json",
		url: 'dddhInCart.jsp',
		cache: false,
		data: {gdsid:skuys,cardno:cardno,skuId:sku2},
		error: function(XmlHttpRequest){
			$.alert("加入购物车出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.success){
			//	alert(json.cardimg);
				//$('#cardimg').src=json.cardimg;
				//$('cardimg').src="'"+json.cardimg+"'";
				//$('cardimg').src='http://www.baidu.com/img/baidu.gif';
				document.getElementById("cardimg").src=json.cardimg;
				$("#spname1").html(json.pname);
				$('#frgwc').show();
			}else{
				$.alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
};



</script>

</body>
</html>