<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%Tools.setCookie(response,"rcmdusr_rcmid","110",(int)(Tools.DAY_MILLIS/1000*1)); %>
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
<%Tools.setCookie(response,"rcmdusr_rcmid","110",(int)(Tools.DAY_MILLIS/1000*1));
String id = request.getParameter("id");
if(Tools.isNull(id))id=request.getParameter("gdsid");
id="01517367";
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


String style = Tools.getFormatMoney(oldmemberprice);


//List<DhGdsM> dhgdsmList2 = getdhgdsmList("mqwy1211fj");

String category = "";//最小的类别，在下面初始化了。


int score=CommentHelper.getLevelView(id);//显示星级
int contentcount=CommentHelper.getCommentLength(id);;

//评论

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
<meta name="keywords" content="<%=gname %>" />
<meta name="description" content="优尚网热卖产品<%=gname %>，在这你可以看到<%=gname %>怎么样，让您买的放心，用的开心。" />
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
.spgg1{border:solid 1px #dfdfdf; background-color:#f9f9f9;padding:10px 0 10px 10px;line-height:20px;}
.spgg1 img{ border:solid 1px #dfdfdf; vertical-align:text-bottom;}
.spgg1 .otherimg{ border:solid 1px #892e3f;}
.spgg1 .minus{margin:3px 5px 0 0;float:left;}
.spgg1 .add{margin:3px 0 0 5px;float:left;}
.spgg1 .minus img,.spgg1 .add img{display:inline; border:none;}
.spgg1 span{display:block;padding-right:0px 2px 2px 0px;float:left;}
.spgg1 .otherspan{  border:solid 1px #892e3f;}
.spgg1 .num{width:25px; height:15px; border:solid 1px #ccc; text-align:center; float:left;}
.cspan{ border:none;}
.spgg1 .skuname{overflow:hidden;_zoom:1;}
.spgg1 .skuname p{height:24px;line-height:24px;}
.spgg1 .skuname ul{width:200px;line-height:25px;_zoom:1;margin-bottom:5px;_margin-bottom:5px;*margin-bottom:5px;}
.spgg1 .skuname li{float:left; position:relative; display:inline; padding:1px; height:23px; margin-bottom:5px;*zoom:1;*vertical-align:middle;_vertical-align:middle; margin:0px 5px 5px 0px;}
.spgg1 .skuname li a{display:block;float:left;white-space:nowrap;height:21px;line-height:21px;overflow:hidden;padding:0 9px;border:1px solid #595757;background:#fff;color:#595757;text-decoration:none;cursor:pointer;}
.spgg1 .skuname li a:hover,.spgg1 .skuname li a:active{height:21px;line-height:21px;margin:-1px;padding:0 9px;border:2px solid #FF6701;text-decoration:none; }
.spgg1 .skuname li.select a:link,.spgg1 .skuname li.select a:visited,.spgg1 .skuname li.select a:hover,.spgg1 .skuname li.select a:active{height:21px;line-height:21px;padding:0 9px;border:2px solid #FF6701;background:#fff;color:#595757;text-decoration:none;cursor:pointer; margin:-1px;}
.spgg1 .skuname li i{ display:none;}
.skuname li.select i{ display: block;position: absolute;right: 0;bottom: 0;width: 12px;height: 12px;overflow: hidden;text-indent: -9999em;background: url('http://images.d1.com.cn/images2012/index2012/AUGUST/dg.png');}
.spgg1 .skuname1{padding-bottom:10px;overflow:hidden;_zoom:1;}
.spgg1.skuname1 p{height:24px;line-height:24px;}
.spgg1 .skuname1 ul{width:330px;overflow:hidden;_zoom:1;margin-bottom:5px;_margin-bottom:5px;*margin-bottom:5px;}
.spgg1 .skuname1 li{float:left; margin-right:9px; height:80px; color:#333; text-align:center; }
.spgg1 .skuname1 li img{ border:0px;height:50px;width:50px;}
.spgg1 .skuname1 li a:link,.spgg1 .skuname1 li a:visited{display:block;float:left;padding:1px;white-space:nowrap;margin:0px;height:50px;line-height:50px;overflow:hidden;border:1px solid #ccc;background:#fff;color:#ccc;text-decoration:none;cursor:pointer;}
.spgg1 .skuname1 li a:hover,.spgg1 .skuname1 li a:active{height:50px;line-height:50px;padding:0px;border:2px solid #ccc;text-decoration:none;}
.spgg1 .skuname1 li.select a:link,.spgg1 .skuname1 li.select a:visited,.spgg1 .skuname1 li.select a:hover,.spgg1 .skuname1 li.select a:active{height:50px;line-height:50px;padding:0px;border:2px solid #f50;background:#fff;color:#ccc;text-decoration:none;cursor:pointer;}

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

<div align="center"><img src="http://images.d1.com.cn/market/1206/wydh/wydh120601.jpg" width="980" height="45"></div>	 
		 <!-- 商品展示-->
	    <div class="goodsshow">
		    
			 
			 <!--商品展示右侧-->
			<div class="gs_right">
			     <!-- 商品展示-->
			    <div class="goods_new">
					<hr class="newhr"/>
					<!-- 商品展示-->
					<div class="gs_right_spimg">
							<img src="http://images.d1.com.cn/market/1302/wydh/mgh.jpg" width="400" height="400" />
							<div class="fdtp"><img src="/res/images/product/fdtp.jpg" style="border:none;" align="top" /><a href="http://images.d1.com.cn/<%=product.getGdsmst_bigimg() %>" target="_blank">&nbsp;点击放大图片</a></div>
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
                         <tr><td colspan="3" ><h1 style="font-size:16px;"><%=gname %></h1></td></tr>
                          <tr><td colspan="3" >&nbsp;</td></tr>
                         <tr>
							      <td width="150">会员价：<%=style %></td>
								  <td width="100">市场价：￥<%=Tools.getFormatMoney(saleprice) %></td>
								  <td width="100">
									  
								  </td>
							 </tr>
							 
                         <tr height="40">
							     <td colspan="3">
							     	<div style="float:left; padding-top:6px;">顾客评分：</div>
							     	<div class="sa<%=score %>" style="float:left;" ></div>
								    <div style="float:left; padding-top:6px;"><a href="#cmt2" onclick="$('#goodsinfotab > a:eq(1)').click();" rel="nofollow">(已有<%=contentcount %>人评价)</a></div>
								 </td>
						     </tr>
						    <tr>
							     <td colspan="3">
								 	<div class="spgg"><%
									     ///sku
									    if(!Tools.isNull(skuname1)){
									    	int showsku=1;
									    	if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==0||product.getGdsmst_stocklinkty().longValue()==3)){
									    		showsku=0;
									    	}
									    	//System.out.println(showsku);
										    List<Sku> skuList = SkuHelper.getSkuListViaProductIdO(id,showsku);
										    if(skuList != null && !skuList.isEmpty()){
										    	int size = skuList.size();
										    	%><div id="skuname" class="skuname">
										    		<p><span style="color:#FC7C17;">第一步</span>选择<%=skuname1 %>：<font id="sizecount"><%=size==1?skuList.get(0).getSkumst_sku1():"未选择" %></font>
										    		<% ArrayList<GdsAtt> list=GdsAttHelper.getGdsAttByGdsid(id);
										    		   if(list!=null&&list.size()>0)
										    		   {
										    			   if(list.get(0).getGdsatt_content().length()>0)
										    			   {
										    		    %>
										    			   <font id="ccdzb" style=" color:#020399; cursor:hand;" onmouseover="ccdzb()" onmouseout="ccdzb1()">(尺寸对照表)</font></p>
										    		      <div id="ccdzb_img" style="position:absolute;display:none;" onmouseover="ccdzb()" onmouseout="ccdzb1()">
										    		      <%= list.get(0).getGdsatt_content() %>
										    		       </div>
										    		
										    		   <%  }
										    		   }
										    		   else
										    		   {%>
										    			   </p>
										    		   <%}
										    		%>
										    		
										    		<ul>
										    		<%
										    		for(int i=0;i<size;i++){
										    			Sku sku = skuList.get(i);
										    			String skuname = sku.getSkumst_sku1();
										    			if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
										    				if(CartItemHelper.getProductOccupyStock(product.getId(), sku.getId())<ProductHelper.getVirtualStock(product.getId(), sku.getId())){
											    				%><li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname%></span>	</a>									    		</a>
										    		</li><%
										    				}
										    				else
										    				{
										    					if(sku.getSkumst_vstock().longValue()==0){ %>
										    						<li><a href="javascript:void(0);" title="售罄"   hidefocus="true"  style="height:21px;line-height:21px;padding:0 9px;border:1px solid #dcdddd;background:#fff;color:#dcdddd;text-decoration:none;"><span><%=skuname%></span>	</a>			</li>
										    					<%}
										    					else
										    					{%>
										    						<li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname%></span>	</a>			</li>
										    					<%}
										    				}
										    			}else{
										    	
										    			%><li<%if(size==1){ %> class="select"<%} %>><a href="javascript:void(0);" title="<%=skuname %>" attr="<%=sku.getId() %>" onclick="chooseskuname1(this)" hidefocus="true"<%if(size==1){ %> class="current"<%} %>><span><%=skuname%></span>	</a>			</li><%
										    			  
										    			}
										    		}
										    		%>
	
										    		</ul>
										    	</div><%
										    }
									    }
									    endprice = (Tools.floatCompare(dxprice,0)==0 ? Tools.getFormatMoney(memberprice) : Tools.getFormatMoney(dxprice));
									    %>
										
									 </div>
								 </td>
							 </tr>
							 <tr><td colspan="3" height="38">
							 <table width="338" height="50" border="0" cellpadding="0" cellspacing="0">
  
  <tr>
  <td colspan="2"><span style="color:#FC7C17;">第二步</span>输入兑换码，放入购物车</td>
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
									    总计金额:￥<font id="countgdsmst3">29</font><br/>
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
					<div id="goodsinfotab" class="zh_title"><a href="javascript:void(0)" class="newa">商品信息</a><a href="javascript:void(0)">顾客评论</a></div>
					<div class="clear"></div>
					<div id="content_list_info">
					<!-- 商品信息-->
					<span style="display:none">
					 <div class="goods_info">
					   
					   <%
					       if(!Tools.isNull(product.getGdsmst_stdvalue1())||!Tools.isNull(product.getGdsmst_stdvalue2())||!Tools.isNull(product.getGdsmst_stdvalue3())||!Tools.isNull(product.getGdsmst_stdvalue4())||!Tools.isNull(product.getGdsmst_stdvalue5())
					    		   ||!Tools.isNull(product.getGdsmst_stdvalue6())||!Tools.isNull(product.getGdsmst_stdvalue7())||!Tools.isNull(product.getGdsmst_stdvalue8())){
					    //if(!Tools.isNull(getGGInfo(product))){ --%>
					    <div class="gstitle"><img src="/res/images/product/Info.jpg" />商品基本信息</div>
						<div class="goods_content_list">
							<%=getGGInfo(product) %>
						</div>
						<%} %>
						<div class="gstitle"><img src="/res/images/product/spxq.jpg" />商品详情</div>					
						    
						<div class="goods_content goods_info_con">
						
						    <% String aaa= product.getGdsmst_detailintruduce();
						       aaa=aaa.replace("‘","'");
						       aaa=aaa.replace("’","'");
						       out.print(aaa);	   
						    %>
						    
						   
						
						   
						</div>
						
						<%=getBrandName(product) %>
					 </div>
					 </span>
					<!--商品信息结束-->
					
					<span style="display:none;"></span>
					
					<!-- 商品评论开始 -->
					<hr style=" border:5px solid #fff" />
					<div style="line-height:1px;height:1px;baclground:#FFF;"><a name="cmt2"></a></div>
					<div class="zh_title" id="commLink"><a href="javascript:void(0)" class="newa">顾客评论</a></div>
					<!--顾客评论-->
					<span>
					    	<div style="padding-top:10px; font-size:14px; font-weight:bold; color:#000;"><a name="cmtCnt"></a>
					    		<img src="http://images.d1.com.cn/Index/images/gkpl_star.jpg" style="vertical-align:text-bottom" />顾客评论
					    	</div>
					    	<%
					    	 int commentLength = CommentHelper.getCommentLength(id);
					    	int PAGE_SIZE = 10 ;
					    	PageBean pBean = new PageBean(commentLength,PAGE_SIZE,1);
					    	
					    	List<Comment> commentlist = CommentHelper.getCommentList(id,pBean.getStart(),PAGE_SIZE);
					    	if(commentlist != null && !commentlist.isEmpty()){
					    		int avgscore=CommentHelper.getLevelView(id);
					    	%>
					    	<div style="background-color:#F4F4F4;">
								<table cellpadding="0" cellspacing="0" style="margin-left:10px; margin-right:20px; margin-top:10px; margin-bottom:10px; width:95%; line-height:28px;">
									<tr>
					                  <td><div style="float:left">
					                        <div style="float:left;font-size:12px">购买过的顾客评分 |</div>
					                         <div class="sa<%=avgscore %>" style="float:left;" ></div>
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
					                             <span><%=hfusername %></span><br></br>
					                             <span><%=level %></span>
					                            </div>
					                       
					                        </div>
					                        <div class="i-item">
					                        <div class="o-topic">
					                          <div style="float:left"><strong class="topic">
					                            <label style="font-weight:bold">评分：</label>
					                            </strong>
					                            <img src="/res/images/user/gds_star<%=comment.getGdscom_level() %>.jpg" /></div>
					                            
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
						           	<%if(pBean.getCurrentPage()>1){ %><a href="#cmtCnt" onclick="pro_comment('<%=id %>',1);">首页</a><%}%><%if(pBean.hasPreviousPage()){%><a href="#cmtCnt" onclick="pro_comment('<%=id %>',<%=pBean.getPreviousPage() %>);">上一页</a><%}%><%
						           	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
						           		if(i==1){
						           		%><span class="curr"><%=i %></span><%
						           		}else{
						           		%><a href="#cmtCnt" onclick="pro_comment('<%=id %>',<%=i %>);"><%=i %></a><%
						           		}
						           	}%>
						           	<%if(pBean.hasNextPage()){%><a href="#cmtCnt" onclick="pro_comment('<%=id %>',<%=pBean.getNextPage() %>);">下一页</a><%}%>
						           	<%if(pBean.getCurrentPage()<pBean.getTotalPages()){%><a href="#cmtCnt" onclick="pro_comment('<%=id %>',<%=pBean.getTotalPages() %>);">尾页</a><%} %>
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
                  <div class="clear"></div>
				</div>
				 
				 <!--商品信息描述结束-->
				 <div class="clear"></div>
				
			</div>
		     <!--商品展示右侧结束-->
		     
		     <!--商品展示左侧-->
			  <div class="gs_left">
		  
			
			 <!--购买过本商品的用户还购买过-->
			 <% 
			
		    	
			 List<Comment> commentlist2 =CommentHelper.getCommentList(id,0,15);
			 if(commentlist2 != null && !commentlist2.isEmpty()){					
				 int size = commentlist2.size();				 
				 %>
			 
				 <div class="gs_left_por">
				     <div class="gs_left_ltitle" style=" text-align:left; padding-left:15px;">购买过的顾客怎么说：</div><%
				
					 %>
					 <div class="gs_left_content" style="padding-right:5px;"><%
							 SimpleDateFormat forday = new SimpleDateFormat("yyyy-MM-dd");
					 for(Comment comm : commentlist2){
					 String commname = getUid(comm.getGdscom_uid());
					 %>
			           <table width="100%" class="lin" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="62%" height="30" align="left"><span class="commname"><%=commname %></span></td>
    <td width="38%" align="right"><span class="date-comment">
					                           <%=forday.format(comm.getGdscom_createdate()) %>
					                            </span></td>
  </tr>
  <tr>
    <td height="23" colspan="2" align="left" style="line-height:26px;" class="comment-content"><%=comm.getGdscom_content() %> </td>
  </tr>
</table><%
						} %>
						 <div style="height:30px;text-align:right; padding-top:5px;"><a href="#cmt2" style=" color:#8A2B3F;font-weight:bold;font-size:13px;" onclick="$('#goodsinfotab > a:eq(1)').click();" rel="nofollow">更多评论>></a></div>
					 </div><%
				 	 %>
				 </div>
				 <!-- 浏览过该商品的用户还浏览过商品-->
				 <%} %>
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
function   cbclick(obj){
	  if(obj.checked)
	   $("#trzp").show();
	  else{
		  $("#trzp").hide();
		    
	  }
		 
	} 
//遍历规格
function BLGG2dh(){
	var skuid = $("#skuname");
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
//选择不同色商品
function choosegdsid2(obj){
  var skuid = $("#skuname4");
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
  	$('#sizecount4').html($(obj).attr("title"));
  }
  if($('#skuname3').length>0) {
	  
	  $.ajax({
			type: "get",
			dataType: "json",
			url: '/market/1209/wydhpj/wydhmoresku2.jsp',
			cache: false,
			data: {gdsid:s},
			error: function(XmlHttpRequest){
				alert("SKU错误！");
			},success: function(json){
				if(json.success){
					$('#skuname3').html(json.content);
				}else{
					alert("SKU错误！");
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
	  }
 
}
function ccdzb3()
{
  var top=$('#skuname4').offset().top+$('#skuname4 p').height()-5;
  var right=$(document).width()-($(".gs_right").offset().left+$(".gs_right").width());
  $("#ccdzb_img2").css("top",top);
  $("#ccdzb_img2").css("left",right+200);
  $("#ccdzb_img2").css("display","block");

}
function ccdzb4()
{
	$("#ccdzb_img2").css("display","none");
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
//遍历赠品编号
function BLGG2zp(){
	var skuid = $("#skuname4");
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
//赠品遍历规格
function BLGG3zp(){
	var skuid = $("#skuname3");
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
function chooseskuname3(obj){
    var skuid = $("#skuname3");
    if (skuid.length==0) return;
    var skuid = skuid.find("li");
    if (skuid.length > 0){
    	skuid.each(function(){
    		$(this).removeClass('select').find("a").removeClass("current");
    	});
    	$(obj).parent().addClass("select").find("a").addClass("current");
    	$('#sizecount3').html($(obj).attr("title"));
    }
}
//放入购物车操作
function ShowAJaxdh(){
	var cardno=$('#cardno').val();
	var sku2=BLGG2();
	if(typeof sku2 == 'undefined'){
		sku2 = "";
	}
	//alert(cardno);
	$.ajax({
		type: "get",
		dataType: "json",
		url: '/market/1301/wydhwz/incart.jsp',
		cache: false,
		data: {gdsid:'01517367',cardno:cardno,skuId:sku2},
		error: function(XmlHttpRequest){
			$.alert("加入购物车出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.success){
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