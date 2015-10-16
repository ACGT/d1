<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*"%><%@include file="inc/header.jsp"%><%@include file="/ajax/flow/function.jsp"%><%!
public static String getPProductByCodeGdsid(String code,String brandcode){
	String gdsid="";
	ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code,100);
	if(list!=null && list.size()>0){
			for(PromotionProduct pProduct:list){
			Product product=ProductHelper.getById(pProduct.getSpgdsrcm_gdsid().trim());
			if(product!=null){
			if(!Tools.isNull(brandcode) && !brandcode.equals(product.getGdsmst_brand().trim())){
			 continue;
			}
			gdsid=pProduct.getSpgdsrcm_gdsid();
			}
			}
	}
	return gdsid;
}
//获得推荐商品列表
private static List<Product> getRelatedGdsList(ArrayList<Cart> list){
	if(list == null || list.isEmpty()) return null;
	
	Set<String> gdsIDSet = new HashSet<String>();//显示的ID
	Set<String> hideGdsIDSet = new HashSet<String>();//不显示的ID
	
	//购物车中推荐商品
	for(Cart cart : list){
		if(Tools.longValue(cart.getType()) == 1){//普通物品
			ProductRelated re = ProductRelatedHelper.getById(cart.getProductId());
			if(re != null){
				String relategds = re.getRelatedgoods_relatedgdsid();
				if(relategds != null){
					String[] gdsArray = relategds.split(",");
					for(String str : gdsArray){
						gdsIDSet.add(str);
					}
				}
				hideGdsIDSet.add(re.getId());
			}
			Product product = ProductHelper.getById(cart.getProductId());
			if(ProductHelper.isShow(product)){
				String strLinkGds = product.getGdsmst_linkgds();
				if(!Tools.isNull(strLinkGds)){
					String strLeft1 = strLinkGds.substring(0,1);
					//第一个字符不是数字，则截取。
					if(!Tools.isMath(strLeft1)){
						strLinkGds = strLinkGds.substring(1);
					}
					String strRight1 = strLinkGds.substring(strLinkGds.length() - 1);
					//最后一个不是数字，则截取
					if(!Tools.isMath(strRight1)){
						strLinkGds = strLinkGds.substring(0,strLinkGds.length()-1);
					}
					strLinkGds = strLinkGds.replace(";",",");
					String[] linkgdsArray = strLinkGds.split(",");
					if(linkgdsArray != null && linkgdsArray.length>0){
						for(String str : linkgdsArray){
							gdsIDSet.add(str);
						}
					}
				}
			}
		}
	}
	
	if(hideGdsIDSet != null && !hideGdsIDSet.isEmpty()){
		Iterator<String> it = hideGdsIDSet.iterator();
		while(it.hasNext()){
			String value = it.next();
			if(gdsIDSet.contains(value)){
				gdsIDSet.remove(value);
			}
		}
	}
	
	List<Product> goodsList = null;
	if(gdsIDSet != null && !gdsIDSet.isEmpty()){
		goodsList = new ArrayList<Product>();
		Iterator<String> it = gdsIDSet.iterator();
		while(it.hasNext()){
			Product product = ProductHelper.getById(it.next());
			if(ProductHelper.isShow(product)){
				GiftProduct gp = GiftHelper.getGiftProductByGId(product.getId());
				if(gp == null){
					goodsList.add(product);
				}
			}
		}
	}
	
	if(goodsList != null && !goodsList.isEmpty()){
		Collections.sort(goodsList , new SalePriceComparator());
	}
	
	return goodsList;
}

%><%
//查看购物车中是否有物品，没有则跳转
//CartHelper.checkCartError(request,response);

CartHelper.updateAllCartItems(request, response);

//获得用户一级的商品
ArrayList<Cart> cartList = CartHelper.getCartItemsOrder(request,response);

int member = 0;//普通会员或者未登录会员
if(UserHelper.isPtVip(request, response)){//如果是白金会员，修改价格
	member = 2;
}else if(UserHelper.isVip(request, response)){//如果是VIP会员
	member = 1;
}
long totalGoods = 0;//物品总数
float totalPrice = 0f;//总金额
boolean isgb=false;//是否含有赠品（庆祝改版活动）
boolean bwydxflag=false;//网易兑换独享
boolean otherdhflag=false;//当当兑换、领奖台兑换、艺龙兑换
boolean isgq=false;//国庆
boolean iszfqr=false;//绽放秋日
String gdsidlist="02200096,02200097,02200095,02200094,03200050,03200049";
String subaddx="";
String dxtitle="";
String wycode="";
int wycount=16;
String pid="";
String pid2="";

if(cartList != null && !cartList.isEmpty()){
	 for(Cart cart : cartList){
		 String id = cart.getId();
		 String title = cart.getTitle();//物品名称
		 if(cart.getType().longValue()==13 && !bwydxflag && !otherdhflag){
			if( title.indexOf("网易")>=0){
			 bwydxflag=true;
			}else if(title.indexOf("当当兑换")>=0||title.indexOf("领奖台兑换")>=0||title.indexOf("艺龙兑换")>=0){
			 otherdhflag=true;
			}
			
		 }
		 if(cart.getType().longValue()==14 && ("02300190".equals(cart.getProductId()) || "02300189".equals(cart.getProductId()))){
			 pid=cart.getProductId();
			 if("02300190".equals(cart.getProductId())){
				 pid2="02300189";
			 }else if("02300189".equals(cart.getProductId())){
				 pid2="02300190";
			 }
			 isgq=true;
		 }
		  if(cart.getType().longValue()==14 && gdsidlist.indexOf(cart.getProductId())>=0){
			  pid=cart.getProductId();
			  iszfqr=true;
		  } 
	 }
}
if (bwydxflag||otherdhflag){

	if (bwydxflag){
		subaddx="110";
		dxtitle="网易独享";
		wycode="7272";
	}else{
		subaddx="185";
		dxtitle="兑换独享";
		wycode="7933";
	}
	Tools.setCookie(response,"rcmdusr_rcmid",subaddx,(int)(Tools.DAY_MILLIS/1000*1));
}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚---购物车</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head2012.css")%>" rel="stylesheet" type="text/css" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/scar.css")%>" rel="stylesheet" type="text/css" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/flow/flow1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/flow/scrollCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/thickbox_plus.js")%>"></script>
<style type="text/css">
.d1actt{width:480px;float:left;}
.d1actp{ width:240px; float:right;}
.d1actttile{background: #7abd54;float:left; margin:0px 15px;height:22px;padding:0px 15px 0px 15px; line-height:21px;color:#fff;display: block;}
.d1actmore{background: #f0424e;float:left; margin:0px 15px;height:22px;padding:0px 15px 0px 15px; line-height:21px;color:#fff;display: block;}
.d1actmore a{color:#fff}
.deactspan{float:left; height:22px;padding:0px 15px 0px 15px; line-height:21px;display: block; }
.zplist{ width:885px; list-style:none;margin:0px; padding:0px;}
.zplist li{ float:left;margin-left:20px;_margin-left:15px; width:200px; overflow:hidden;height:190px;}
.zplist li p{display:block;float:left;}
.zplist li .newp{ padding-left:5px; text-align:left; color:#7f7f7f; float:left; width:85px;overflow:hidden; font-family:'微软雅黑'; line-height:18px;}
.zplist li .cspan{ display:block; margin-top:5px;color:#cb0000;}
.zplist li .cspan2{ display:block; margin-top:5px;color:#000000;}
.zpclstxt{color:#333; text-align:left;padding-left:10px;font-size:14px;font-weight:bold;border:none;}
.zplisttit{background:#ddd; color:#dc0000;text-align:left;padding-left:10px;font-size:14px;font-weight:bold; border_bottom:dashed 1px #cdcdcd;}

</style>
</head>

<body>
<div class="clear"></div>
<%@include file="/inc/head3.jsp" %>

     <!--购物车页面-->
	    <div class="carcenter"><a name="cart_top"></a>
		     <div class="content">
		    
		     <!--<a href="http://www.d1.com.cn/zhuanti/20130115qcqrj/qrj.jsp " target="_blank">
		         <img src="http://images.d1.com.cn/images2012/index2012/des/20130116880X1102.jpg"/>
		     </a>-->
		  
			 <!--购物车logo-->
			 <div class="car_logo">
			     <img src="http://images.d1.com.cn/images2012/New/flow/sc_logo.jpg" usemap="#flogo"/>
			 </div>
			  
			  <!--购物车logo结束-->	 
			   <div style="clear:both;"></div>
		<div style="+margin-top:10px;+margin-bottom:10px; padding-bottom:15px;  " >
			 <!--  <a href="http://www.d1.com.cn/zhuanti/201309/fkys0922/" style=" width:885px; display:block; margin:0px auto;" target="_blank"><img src="http://images.d1.com.cn/images2013/index/flow0922.jpg"/></a> -->
			  
			 </div>
    <div style="clear:both;"></div>
			 
			   <!--购物车内容-->
			      <div class="car_content">
			      
				      <div class="car_title">我挑选的商品清单</div>
				      <div id="delete_favor" class="tip_box" style="display:none;"></div>
					  <div class="car_tip">温馨提示：1.选购清单中的商品无法保留库存，请您及时结算。2.商品价格、赠品及库存将以订单提交时为准。</div>
                      <div class="goods_list" id="cart_goods_area"><%
                    		  SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      				Date endDate4=null;
      				Date ndate=new Date();
      				try{
      					endDate4 =fmt2.parse("2014-05-31 00:00:00");
      					 }
      				catch(Exception ex){
      					ex.printStackTrace();
      				}

                    		float getshopactmoney=  CartHelper.getShopActCutMoney(request, response);
                        ArrayList<ShpMst> shpmstlist=CartShopCodeHelper.getCartShopCode(request, response);
                      long allactmoney=0;
                      if(shpmstlist!=null){
                    	  int shpmstcount=1;
                    	  int smcount=shpmstlist.size();
                    	
                      for(ShpMst shpmst:shpmstlist){
                    	  String shopcode=shpmst.getId();
                    	  if(shopcode.equals("08102301"))shopcode="00000000";
                      	  ArrayList<Cart> cartList2 = CartShopCodeHelper.getCartItemsOrder(request, response, shopcode);
                      	Collections.sort(cartList2,new ActComparator());
                      	  String zpid="0";
                          long smtotalGoods = 0;//商户物品总数
                    	  float smtotalPrice = 0f;//商户总金额
                      boolean hastl=false;//购物车时候有台历
                      int havesku=0;//大于0代表没选择sku
                      long shopactmoney=0;
                            if(cartList2 != null && !cartList2.isEmpty()){
                            	String parentId = null;//本次循环的父级ID
                            %> <!-- <input name="shopcode" id="shopcode" type="radio" value="<%=shopcode %>" <%if (shpmstcount==1) {%>checked="checked" <%} %>/> -->&nbsp;&nbsp;如下商品，由&nbsp;<%=shpmst.getShpmst_shopname() %>&nbsp;负责发货
                            <%=shopcode.equals("00000000")&&ndate.getTime()<endDate4.getTime()?"<span style=\"color:red\">&nbsp;&nbsp;D1优尚自营产品满100元送五芳斋鲜肉粽（2只）</span>":"" %>
                             <table width="885" style=" border-top:dashed 1px #ccc;" border="0" cellpadding="0" cellspacing="0">
                                <tr class="th"><th width="158"></th><th width="300" style="text-align:left;">商品名称/编号</th><th width="100">规格</th><th width="80">会员价</th><th width="80">成交价</th><th width="86">数量</th><th width="81">小计</th></tr><%
								int actid=0;
                                int oldactid=0;
                                 for(Cart cart : cartList2){
									 String id = cart.getId();
									 String title = cart.getTitle();//物品名称
									
									 if(cart.getType().longValue()==14 && title.indexOf("改版")>=0){
										 isgb=true;
										 zpid=cart.getId().trim();
									 }
									 Product product = ProductHelper.getById(cart.getProductId());
									 if(cart.getType().longValue()==14 && "01205279".equals(cart.getProductId())){
										 hastl=true;
									 }
									  
									 Sku sku = SkuHelper.getById(cart.getSkuId());
									 float oldPrice = Tools.floatValue(cart.getOldPrice());//会员价，单价
									 float price = Tools.floatValue(cart.getPrice());//成交单价
									 long amount = Tools.longValue(cart.getAmount());//数量
									 long type = Tools.longValue(cart.getType(),1);//类型
									 if(cart.getType().longValue()>=0||cart.getType().longValue()==-5){
										 totalGoods += amount;
										 smtotalGoods += amount;
									 }
									 float money = Tools.floatValue(cart.getMoney());//总计
									 if(type >= 0) {
										 totalPrice += money;
										 smtotalPrice += money;
									 }
									 float prefrePrice = oldPrice*amount-money;//优惠
									 if(prefrePrice < 0) prefrePrice = 0;
									 boolean hasFather = Tools.longValue(cart.getHasFather(),0)==1?true:false;//是否有父类
									 if(hasFather) parentId = cart.getParentId();
									 else parentId = null;
									 String rec_key = cart.getId()+"_0_"+(Tools.isNull(cart.getSkuId())?"0":cart.getSkuId());
									 String goodsId = null;
									 if(product!=null)
									 {
										 goodsId=product.getId();
									 }
					
									 boolean isShowInfo = ((type==3||type==4||type==5|type==8||type==12||type==16)?false:true);//是否显示物品的详情
									 //购物车ID_[0/1是否是积分换购的物品]_skuId
									 if(cart.getActid()!=null){
										 actid=cart.getActid().intValue();
									 }else{
										 oldactid=0;
									 }
									 if(oldactid!=actid){
										 D1ActTb d1act=CartHelper.getShopAct(cartList2, shopcode, actid+"");
										 float d1actpmoney=CartHelper.getCartShopActPayMoney(request,response,d1act);
										 long actmoney=0;
										 if(d1act!=null){
											String showactt="活动商品购满"+d1act.getD1acttb_snum1()+"元，即可享受满减";
											String showactt2="";
											
											 if(cart.getActmoney()!=null&&cart.getActmoney().longValue()>0){
												 if(d1act.getD1acttb_snum3().floatValue()>0f&&d1actpmoney>=d1act.getD1acttb_snum3().floatValue()){
													 actmoney=d1act.getD1acttb_enum3();
													 showactt="活动商品已购满"+d1act.getD1acttb_snum3()+"元，已减"+actmoney+"元";
													
												    }else if(d1act.getD1acttb_snum2().floatValue()>0f&&d1actpmoney>=d1act.getD1acttb_snum2().floatValue()){
												    	actmoney=d1act.getD1acttb_enum2();
												    	showactt="活动商品已购满"+d1act.getD1acttb_snum2()+"元，已减"+actmoney+"元";
													}else if(d1act.getD1acttb_snum1().floatValue()>0f&&d1actpmoney>=d1act.getD1acttb_snum1().floatValue()){
														actmoney=d1act.getD1acttb_enum1();
														showactt="活动商品已购满"+d1act.getD1acttb_snum1()+"元，已减"+actmoney+"元";
													}
												 showactt2	="减免：¥"+actmoney;
												 shopactmoney+=actmoney;
											 }
										String fxtxt="";
										if(actmoney >0)fxtxt="<span class=\"d1actttile\">减免："+actmoney+"元</span>";
										String acttxt="";
										String goshopurl="";
										if(d1act.getD1acttb_acttype().longValue()==0){
											acttxt="满减";
											if(!Tools.isNull(d1act.getD1acttb_gourl())){
												goshopurl=d1act.getD1acttb_gourl();
											}else{
											if(shpmst!=null&&shpmst.getShpmst_index().longValue()==1&&
													!Tools.isNull(shpmst.getShpmst_shopsname())){
											goshopurl="http://www.d1.com.cn/shop/"+shpmst.getShpmst_shopsname();
											}else{
												if(shpmst!=null)goshopurl="http://www.d1.com.cn/shopbrand.jsp?sc="+shpmst.getId();
											}
												
											}
										}
										
										if(d1act.getD1acttb_acttype().longValue()==1){
											acttxt="专区满减";
											if(!Tools.isNull(d1act.getD1acttb_gourl())){
												goshopurl=d1act.getD1acttb_gourl();
											}else{
											goshopurl="http://www.d1.com.cn/html/result_rec.jsp?aid="+d1act.getD1acttb_ppcode();
											}
										}
										if(d1act.getD1acttb_acttype().longValue()==2){
											acttxt="品牌满减";
											goshopurl="http://www.d1.com.cn/shopbrand.jsp?sc="+d1act.getD1acttb_shopcode()+"&brand="+d1act.getD1acttb_brandcode();

										}
                                				 
                                 %>	
                                 <tr class="th" ><th   bgcolor="#dbeefd" colspan="7"><div class="d1actt"><span class="d1actttile">满减</span><span class="deactspan">&nbsp;<%=showactt %></span><span class="d1actmore"><a href="<%=goshopurl %>" target="_blank">查看活动</a></span></div><div class="d1actp"><span class="deactspan"><%=d1actpmoney %></span><%=fxtxt%></div> </th></tr>
                                 <%}
                                 } %>
                                 
								  <tr type="<%=type %>" id="cart_<%=rec_key %>"<%if(parentId != null){ %> parentId="<%=parentId %>" class="suitTitle"<%} else {%> style="background:#FFFDDD;" <%}%> rec_key="<%=rec_key %>">
								  
								  <%
								  if(product != null){
								  %>
								      <td class="cartl" height="100"><a href="<%=ProductHelper.getProductUrl(product) %>" title="<%=title %>" target="_blank"><img src="<%=ProductHelper.getImageTo80(product) %>" alt="<%=title %>" /></a></td>
								      <td class="othertd"><%if(Tools.longValue(product.getGdsmst_specialflag()) == 1){ %><img src="http://images.d1.com.cn/images2012/New/flow/noticket.gif" align="absmiddle" alt="该商品不能使用优惠券" />&nbsp;<%} %><%=title %><br/><%=goodsId %><br/><%if(!hasFather){ %><a href="###" id="del_<%=rec_key %>" class="del_link" onclick="clickRemove(this,<%=type %>,'<%=rec_key %>','<%=Tools.longValue(cart.getHasChild()) %>');">删除</a>&nbsp;&nbsp;<%} %><a href="###" onclick="addFavorite('<%=goodsId %>');" class="fav_link">加入收藏</a>
								           <%
								               if(product.getGdsmst_ifhavegds()!=null&&product.getGdsmst_ifhavegds().longValue()==0)
								               {
								            	   if(product.getGdsmst_stocklinkty()!=null&&product.getGdsmst_stocklinkty().longValue()==0)
								            	   {
								            		   if(product.getGdsmst_ifhavedate()!=null&&product.getGdsmst_ifhavedate().after(new Date())){
								            			   Date ifhaveDate=product.getGdsmst_ifhavedate();
								            			   if(sku!=null)
										            	   {
										            		   if(sku.getSkumst_vstock()!=null&&sku.getSkumst_vstock().longValue()==0)
										            		   {
										            			   out.print("<br/><font style=\"color:#f66500\">该商品预计"+(ifhaveDate.getMonth()+1)+"月"+ifhaveDate.getDate()+"日到货，建议您单独下单购买。</font>");
															   	
										            		   }
										            	   }
										            	   else
										            	   {			
										            		   if(product.getGdsmst_ifhavegds()!=null&&product.getGdsmst_ifhavegds().longValue()==0){
										            		   out.print("<br/><font style=\"color:#f66500\">该商品预计"+(ifhaveDate.getMonth()+1)+"月"+ifhaveDate.getDate()+"日到货，建议您单独下单购买。</font>");
										            	       }
										            	   }
								            		   }
								            	   }
								            	  
								               }
								           %>
								      </td><%
								  }else{
								  %>
									 <td class="othertd" colspan="2" height="40" style="padding-left:20px;">
									 <font style="color:#Be0404"><%=title %></font>&nbsp;&nbsp;<%if(!hasFather){ %><a href="###" id="del_<%=rec_key %>" class="del_link" onclick="clickRemove(this,<%=type %>,'<%=rec_key %>','<%=Tools.longValue(cart.getHasChild()) %>');">删除</a>&nbsp;&nbsp;<%} %></td><%
								  } %>
									  <td>
									  <%
									  if(cart.getHasChild().longValue()>0){
										  out.print("");
									  }
									  else{
										if(sku!=null&&sku.getSkumst_sku1()!=null&&sku.getSkumst_sku1().length()>0)
										{
										   out.print(sku.getSkumst_sku1());
										}
										else{
											if(!Tools.isNull(product.getGdsmst_skuname1())){
												String skuname1=product.getGdsmst_skuname1();
												int showsku=1;
												if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==0||product.getGdsmst_stocklinkty().longValue()==3)){
													showsku=0;
												}
											    List<Sku> skuList = SkuHelper.getSkuListViaProductIdO(goodsId,showsku);
											    if(skuList != null && !skuList.isEmpty()){
											    	havesku++;
											    	%>
											    	<a href="javascript:void(0)" onclick="rechoosesku('<%= goodsId%>','<%=id %>','<%= skuname1 %>')">请选择<%=skuname1 %></a>

											    <%}
											    else{
											    	out.print("无");
											    }
											}
											else{
												out.print("无");
											}
										}
									  }
									  %>
									  
                                     </td><%
									if(isShowInfo){		  
									%>
									<td><span><%=Tools.getFormatMoney(cart.getOldPrice().floatValue()) %></span></td>
									<td><span id="price_<%=rec_key %>"><%= (int)money/amount %></span></td>
									  
									  <td><%
									  if(hasFather || type==0 || type==13 || type==15 || type==-5 ||type==14|| type==2||type==18||type==19||(product!=null&&product.getGdsmst_buylimit()!=null&&product.getGdsmst_buylimit().intValue()>0)){
										 %><span id="num_span_<%=rec_key %>"><%=amount %></span><%
									  }else{
									  %>
									  	<a href='###' title='减1' class="num_minus" onclick="addorminus('minus','<%=id %>','<%=rec_key %>');"><img src='http://images.d1.com.cn/images2012/New/flow/j_a.gif' /></a>
									  	<input type='text' id='num_input_<%=rec_key %>' objNum='<%=amount %>' onkeyup="this.value=this.value.replace(/[^\d]/g,'');" onblur="updatecart('<%=id %>','<%=rec_key %>');" onkeypress="if((arguments[0] || window.event).keyCode==13){updatecart('<%=id %>','<%=rec_key %>');$.addEvent();}" name='txtChange<%=rec_key %>' class="amount" maxlength='4' value='<%=amount %>' />
									  	<a href='###' title='加1' class="num_add" onclick="addorminus('add','<%=id %>','<%=rec_key %>');"><img src='http://images.d1.com.cn/images2012/New/flow/a_j.gif' /></a><%
									  } %></td>
										<td><font color="#FF0000" id="subtotal_<%=rec_key %>"><%=Tools.getFormatMoney(money) %></font></td><%
									}else{
										%>
										<td>-</td>
										<td>-</td>
										<td><span id="num_span_<%=rec_key %>"><%=amount %></span></td>
										<td><font color="#FF0000">-</font></td><%
									} %>
								  </tr><%
								  
								  if(cart.getActid()!=null){
										 oldactid=cart.getActid().intValue();
									 }else{
										 oldactid=0;
									 }
                                 } 
                                 allactmoney+=shopactmoney;
                                 %>
								  </table>
								  <input type="hidden" id="havesku" name="havesku" value="<%=havesku %>"/>
								  <%}
                      if(smcount>1){
                      %> <div class="goods_list tailtd" id="total_area<%=shopcode%>"<%if(smtotalGoods == 0 ){ %> style="display:none;"<%} %>>
												  	
								  	商品总计：<font style="font-size:13px; font-weight:bold;" id="total_Count"><%=smtotalGoods %></font>件
								  	<%if(shopactmoney>0){ %>
								  	&nbsp;&nbsp;优惠金额：<%=shopactmoney %>元&nbsp;
								  	<%} %>
									 <font style=" color:#d80100; font-size:16px; font-weight:bold; margin-left:30px;">应付总额：<span id="total_Price"><%=Tools.getFormatMoney(smtotalPrice-shopactmoney) %></span>元</font>
								  </div>
                      <%}shpmstcount+=1;
                                 }
								  }else{
									 %><p class="notCart"><%=lUser!=null?"您的购物车中没有商品，快去挑选商品吧&nbsp;&nbsp;<a href='/'>回到首页&gt;&gt;</a>":"如果您上次退出时，购物车中有商品，那么商品已自动保存，<a href='/login.jsp'>请登录后查看&gt;&gt;</a>" %></p><% 
								  }%>
								  </div>
								  <div class="goods_list tailtd" id="total_area"<%if(totalGoods == 0 ){ %> style="display:none;"<%} %>>
								  	<%
								  	if(isgb && totalPrice<300){
								  		
								  		%>	
								  		<span style="color:#D0752C">您只需再购买<%=300-totalPrice %>元，就可以换购所选商品了。</span>
								  	<%}
								  	%>
								  	
								  	购物车商品总计：<font style="font-size:13px; font-weight:bold;" id="total_Count"><%=totalGoods %></font>件
								  		<%if(allactmoney>0){ %>
								  		&nbsp;&nbsp;优惠金额：<%=allactmoney %>元&nbsp;
								  		<%} %>
									 <font style=" color:#d80100; font-size:16px; font-weight:bold; margin-left:30px;">应付总额：<span id="total_Price"><%=Tools.getFormatMoney(totalPrice-allactmoney) %></span>元</font>
								  </div> <%
								  //来源
								  String httpReferer = request.getHeader("referer");
								  if(Tools.isNull(httpReferer)) httpReferer = "/";
								
								  %>
								 
					
				
					 <div id="check_btn_area" class="goods_list resultbtn" style="<%if(totalGoods == 0){ %>display:none;<%} %>" >
								  	 <font color="#9f2d47" >×&nbsp;</font><a href="###" onclick="clearCart(this);">清空购物车列表</a>
									 <a href="<%=httpReferer %>" ><img src="http://images.d1.com.cn/images2012/New/flow/sc_jxgw.gif" alt="继续购物" style="margin-left:25px;_margin-left:20px;" align="top" /></a>
									 <input id="checkout" type="image" src="http://images.d1.com.cn/images2012/New/flow/sc_ljjs.gif" title="立即结算" style="margin-right:20px;_margin-right:15px;" />
					
							 
								  </div>
								  <div style="clear:both;"></div>
								  
								  <script type="text/javascript">
								  var isGift = 0;
								  </script>
								  <div class="goods_list">
								  <table width="885" border="0" cellpadding="0" cellspacing="0">
								  <tr>
								   <td colspan="7" class="mstext">		
								   	<%float m_fltBrdTktPrice = CartHelper.getBrandCutMoney(request,response);//品牌减免总金额。
               
								   if(m_fltBrdTktPrice>0){
                                           %>
								   
								     <font color="#FF0000" style="font-weight:bold;">本订单满足满减活动，优惠金额将在下一步结算页面扣减。&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font><br/>
								     <%}
								  
								     %>
								   				
								   	<!--<a href="http://www.d1.com.cn/html/notice.jsp" target="_blank" style="color:#f00; font-weight:bold;">2013年春节，快递公司送货时间说明，详见《D1优尚网2013年春节假期服务说明》</a>	<br/>  -->				   
									 【免运费规则】<br/>
                                     1.	在线支付：实际支付金额满<font color="#a22d48" style="font-weight:bold">100</font>元免运费；不满足条件时，每单收取<font color="#a22d48" style="font-weight:bold">10</font>元运费。<br/>
                                     2.货到付款：全国每单收取<font color="#a22d48" style="font-weight:bold">10</font>元运费。<br>
								   </td>
								  </tr>
								  </table>
								  </div>
								 
								  <div class="goods_list" id="zengpin_area">
		 <%=zengpinArea2014(request,response) %>
				 </div>
				 <!-- 赠品新样式 结束 -->
				 
								   <%

									if (bwydxflag||otherdhflag){
									%>
								  <div class="goods_list" id="wangyidhdx">
								  <%
								  
								  
								  List<PromotionProduct> listwydx = PromotionProductHelper.getPromotionProductByCode(wycode,wycount);
										  int sizewy = listwydx.size();
								  %>
								   <table width="885" border="0" cellpadding="0" cellspacing="0">
	                               <tr class="othergoods">
								    <td colspan="7">
								    <div class="car_title" style=" margin-top:0px;"><%=dxtitle %></div>
								   </td>
								  </tr>
								  <tr class="trwydx">
								  <td colspan="7">
                                  <div class="wydxcon">
                                    <div id="wydxcarousel_container">
                                      <div id="wydxcarousel_inner">
                                           <ul id="wydxcarousel_ul"><%
                                        String dxcode=subaddx;
                                           for(int i=0;i<sizewy;i++){
                                        	   PromotionProduct spgdsrcm = listwydx.get(i);
                                        	   Product product = ProductHelper.getById(spgdsrcm.getSpgdsrcm_gdsid());
                                        	   String title="";
                                        	   if (Tools.isNull(spgdsrcm.getSpgdsrcm_gdsname())){
                                        	    title = Tools.clearHTML(product.getGdsmst_gdsname());
                                        	   }
                                        	   else{
                                        		title = spgdsrcm.getSpgdsrcm_gdsname();
                                        	   }
                                        	   if (title.length()>30){
                                        		   title=title.substring(0,30);
                                        	   }
                                        	   
                                        	   boolean booldx=false;
                              				 float dxprice=0;
                              				 String str="独享价";
                                        	   if(!Tools.isNull(dxcode)){
                                 				  ProductExpPrice rcmdusr=(ProductExpPrice)Tools.getManager(ProductExpPrice.class).findByProperty("rcmdusr_rcmid", new Long(dxcode));

                                 				  if(rcmdusr!=null 
                                 				    	&& System.currentTimeMillis()>rcmdusr.getRcmdusr_startdate().getTime() 
                                 				    	&& System.currentTimeMillis()<rcmdusr.getRcmdusr_enddate().getTime()
                                 				    	){
                                 				    	booldx=true;
                                 				    	ProductExpPriceItem rcmdgds=(ProductExpPriceItem)ProductExpPriceHelper.getExpPrice(product.getId(), dxcode);
                                 				    	if(rcmdgds!=null){dxprice=rcmdgds.getRcmdgds_memberprice();
                                 				    	}
                                 	                    }
                                 				 }
                                           %>
										     <li>
										     	<a href="http://www.d1.com.cn/product/<%=product.getId()%>" title="<%=title %>" target="_blank"><img alt="<%=title %>" src="<%=ProductHelper.getImageTo160(product) %>" class="wydxpic" /></a>
											    <a href="http://www.d1.com.cn/product/<%=product.getId()%>" title="<%=title %>" class="wydxtitle" target="_blank"><%=title%></a>
												<div align="center">
												<%if(booldx && dxprice>0){%>
											   <span class="wydxspan2">会员价￥<%=Tools.getFormatMoney(Tools.floatValue(product.getGdsmst_memberprice())) %></span>&nbsp;&nbsp;
												<span class="wydxspan1"><%=str%>:￥<%=Tools.getFormatMoney(Tools.floatValue(dxprice)) %></span>
													<%		}
												else{%>
												<span class="wydxspan1">会员价￥<%=Tools.getFormatMoney(Tools.floatValue(product.getGdsmst_memberprice())) %></span>&nbsp;&nbsp;
												<span class="wydxspan2">市场价:￥<%=Tools.getFormatMoney(Tools.floatValue(product.getGdsmst_saleprice())) %></span>												
												<%} %>
												</div>
												<%
												if(Tools.longValue(product.getGdsmst_ifhavegds()) == 0 && ProductStockHelper.canBuy(product)){
												%>
												<div align="center"><a href="###" attr="<%=product.getId() %>" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2011/sales/tm004.gif" class="wydxadd" /></a></div>
												<%
												}else{
												%>
												<a href="###"><img src="http://images.d1.com.cn/images2012/New/product/qh.jpg" /></a><%
												} %>
											 </li><%
										  } %>
										  </ul>
                                         </div>
                                  	</div>
                                  </div>
								  </td>
							  </tr>
							</table>
							<div style="clear:both:"></div>
							</div>
							<%}%>
								  
								  
								  
								  
								  <%
								  if(lUser != null){
									  List list123 = FavoriteHelper.getByUserId(lUser.getId(),0,10);
									  List<Favorite> list = new ArrayList<Favorite>();
									  if(list123!=null){
										  for(int i=0;i<list123.size();i++){
											  Favorite fa = (Favorite)list123.get(i);
											  Product product = ProductHelper.getById(fa.getGdswil_gdsid());
											  if(!ProductHelper.isShow(product)) continue;
											  else{
												  list.add(fa);
											  }
										  }
									  }
									  if(list != null && !list.isEmpty()){
								  %>
								  <div class="goods_list" id="favorite">
								  <table width="885" border="0" cellpadding="0" cellspacing="0">
								  <tr>
								  <td colspan="7" class="subtitle">收藏的商品</td>
								  </tr>
								  <!--收藏商品列表-->
								  <tr>
								  <td colspan="7"><table width="885" border="0" cellpadding="0" cellspacing="0" class="subtable"><%
								  for(int i=0;i<list.size()&&i<5;i++){
									  Favorite fa = (Favorite)list.get(i);
									  Product product = ProductHelper.getById(fa.getGdswil_gdsid());
									  String title = Tools.clearHTML(product.getGdsmst_gdsname());
									  String id = product.getId();
								  %>
									<tr<%if(i==list.size()-1||i==4){ %> style="border-bottom:none;"<%} %>>
										<td class="fal"><a href="<%=ProductHelper.getProductUrl(product) %>" title="<%=title %>" target="_blank"><img src="<%=ProductHelper.getImageTo80(product) %>" alt="<%=title %>" /></a></td>
								    	<td class="othertd"><a href="<%=ProductHelper.getProductUrl(product) %>" title="<%=title %>" target="_blank"><%=title %></a><br/><%=id %><br/><a href="###" onclick="delFavorite('<%=fa.getId() %>',this)">删除</a>&nbsp;&nbsp;<a href="###" attr="<%=id %>" onclick="addCart(this);">放入购物车</a></td>
									</tr><%
									} %>
									</table>
								  </td>
								  </tr>
								  </table>
								  </div><%
								  }} %>
								  <%
								  if(lUser != null){
									  ArrayList<Cart> list_123 = CartHelper.getCartItemsViaUserId(lUser.getId());
									  
									  ArrayList<Cart> list = new ArrayList<Cart>();
									  if(list_123!=null&&list_123.size()>0){
										  for(Cart c7788:list_123){
											  if(c7788.getType().longValue()!=1)continue;
											  if(c7788.getCookie()!=null&&c7788.getCookie().equals(CartHelper.getCartCookieValue(request, response)))continue;
											  Product product = ProductHelper.getById(c7788.getProductId());
											  if(!ProductHelper.isShow(product)) continue;
											  list.add(c7788);
										  }
									  }
									  if(list != null && !list.isEmpty()){
										  int size = list.size();
								  %>
								  <div class="goods_list" id="favorite">
								  <table width="885" border="0" cellpadding="0" cellspacing="0">
								  <tr>
								  <td colspan="7" class="subtitle">历史购物车</td>
								  </tr>
								  <!--历史购物车-->
								  <tr>
								  <td colspan="7"><table width="885" border="0" cellpadding="0" cellspacing="0" class="subtable"><%
								  for(int i=0,j=0;i<size&&j<5;i++){
									  Cart c57 = list.get(i);
									  Product product = ProductHelper.getById(c57.getProductId());
									  String title = Tools.clearHTML(product.getGdsmst_gdsname());
									  String id = product.getId();
								  %>
									<tr<%if(i==size-1 || i==4){ %> style="border-bottom:none;"<%} %>>
										<td class="fal"><a href="<%=ProductHelper.getProductUrl(product) %>" title="<%=title %>" target="_blank"><img src="<%=ProductHelper.getImageTo80(product) %>" alt="<%=title %>" /></a></td>
								    	<td class="othertd"><a href="<%=ProductHelper.getProductUrl(product) %>" title="<%=title %>" target="_blank"><%=title %></a><br/><%=id %><br/><a href="###" attr="<%=id %>" onclick="addCart(this);">放入购物车</a></td>
									</tr><%
									j++;
									} %>
									</table>
								  </td>
								  </tr>
								  </table>
								  </div><%
								  }} %>
												  <!--收藏商品列表结束-->
								  <div class="goods_list">
								  
								 <%
								 List<Product> list = getRelatedGdsList(cartList);
								 if(list != null && !list.isEmpty()){
									 int size = list.size();
									 int pageSize = 4;
									 if(size > pageSize) {
										 if(size % 4 != 0) size = size-size%4;
									 }
								 %>
								 <!--主编推荐商品-->
								 <table width="885" border="0" cellpadding="0" cellspacing="0">
	                               <tr class="othergoods">
								    <td colspan="7">
								    <div class="car_title" style=" margin-top:0px;">主编推荐商品</div>
								   </td>
								  </tr>
								  <tr class="trscroll">
								  <td colspan="7">
                                  <div class="con" style="overflow:hidden;_zoom:1;">
                                    <div id="carousel_container">
                                       <div id="left_scroll_1"<%if(size < 5){ %> style="visibility:hidden;"<%} %>></div>
                                       <div id="carousel_inner_1">
                                           <ul id="carousel_ul_1"><%
                                           for(int i=0;i<size;i++){
                                        	   Product product = list.get(i);
                                        	   String title = Tools.clearHTML(product.getGdsmst_gdsname());
                                           %>
										     <li>
										     	<a href="<%=ProductHelper.getProductUrl(product) %>" title="<%=title %>" target="_blank"><img alt="<%=title %>" src="<%=ProductHelper.getImageTo160(product) %>" class="pic" /></a>
											    <a href="<%=ProductHelper.getProductUrl(product) %>" title="<%=title %>" class="title" target="_blank"><%=title %></a>
												<span class="span1">￥<%=Tools.getFormatMoney(Tools.floatValue(product.getGdsmst_memberprice())) %></span><span class="span2">￥<%=Tools.getFormatMoney(Tools.floatValue(product.getGdsmst_saleprice())) %></span><br/><%
												if(Tools.longValue(product.getGdsmst_ifhavegds()) == 0 && ProductStockHelper.canBuy(product)){
												%>
												<a href="###" attr="<%=product.getId() %>" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2011/sales/tm004.gif" class="add" /></a><%
												}else{
												%>
												<a href="###"><img src="http://images.d1.com.cn/images2012/New/product/qh.jpg" /></a><%
												} %>
											 </li><%
										  } %>
										  </ul>
                                         </div>
                                         <div id="right_scroll_1"<%if(size < 5){ %> style="visibility:hidden;"<%} %>></div>
                                  	</div>
                                  </div>
								  </td>
							  </tr>
							</table><%
							if(size > 4){
							%><script type="text/javascript">
							new Seller_NewScroll();
							</script><%
							} %>
							<!--主编推荐商品结束--><%
							} %>
					    </div>
				  </div>
			   <!--购物车内容结束-->
				 
			 </div>
		
		</div>
	 <!--购物车页面结束-->
	 <div id="locListDiv" class="box_window">
	 	<div class="content"></div>
	 	<div class="c_b"></div>
	</div>
	<map name="flogo" id="flogo">
	   <area shape="rect" coords="0,0,145,65" href="/" target="_blank"></area>
	</map>
</body>

<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-25292063-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
  function tlInCart(obj){
		//$.alert("活动已结束");
	//$.inCart(obj,{ajaxUrl:'/html/zt2012/tlInCart.jsp',width:450,align:'center'});
	$.ajax({
		type: "get",
		dataType: "json",
		url: '/html/zt2012/tlInCart.jsp',
		cache: false,
		data: {id:'01205279'},
		error: function(XmlHttpRequest){
			$.alert("加入购物车出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.code==0){
				$.close();
				location.href="flow.jsp";
			}else{
				$.alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	}); 
	}
</script>


<%
String Dspeqifa=  Tools.getCookie(request,"EQIFA");
String DspSubad= Tools.getCookie(request,"d1.com.cn.peoplercm.subad");
if((!Tools.isNull(Dspeqifa)||(DspSubad!=null&&DspSubad.startsWith("mqyqfdsp")))){
	String userid="";
	if(lUser!=null)userid=lUser.getId();
	DecimalFormat df2 = new DecimalFormat("0.00");
	if(cartList!=null&&cartList.size()>0){
%>
<!--亿玛DSP部署  -->
<script type="text/javascript"> 

  var _adwq = _adwq || []; 

  _adwq.push(['_setAccount', 'tuu20']); 

  _adwq.push(['_setDomainName', '.d1.com.cn']); 

  _adwq.push(['_trackPageview']); 

</script> 

<script type="text/javascript" src="http://d.emarbox.com/js/adw.js?adwa=tuu20"></script> 

<script type="text/javascript"> 
    _adwq.push([ '_setDataType', 
        'cart'  
    ]); 
    _adwq.push([ '_setCustomer', 
        '<%=userid%>'   //1234567是一个例子，请换成当前登陆用户ID或用户名 
    ]); 
    // 下面代码是商品组代码，根据订单中包括多少种商品来部署，每种商品部署一组 
    //商品组一组开始 
    <%for(Cart cart:cartList){
    	String gdsid=cart.getProductId();
     
    	 Product product = ProductHelper.getById(gdsid);
          if(product==null)continue;
    	String rackcode=product.getGdsmst_rackcode();
    	Directory dir = DirectoryHelper.getById(rackcode);
    %>
    _adwq.push(['_setItem', 
        '<%=gdsid %>',    // 09890是一个例子，请填入商品编号  - 必填项 
        '<%=cart.getTitle() %>',       // 电视是一个例子，请填入商品名称  - 必填项 
        '<%=df2.format(cart.getPrice()) %>',    // 12.00是一个例子，请填入商品金额  - 必填项 
        '<%=cart.getAmount() %>',        // 1是一个例子，请填入商品数量  - 必填项 
        '<%=rackcode %>',     // A123是一个例子，请填入商品分类编号  - 必填项 
        '<%=dir.getRakmst_rackname() %>'        // 家电是一个例子，请填入商品分类名称  - 必填项 
    ]); 
    <%}%>
    //商品组一组结束 

    // 下面是提交订单代码，此段代码必须放在以上代码后面 - 必填项 
    _adwq.push([ '_trackTrans' ]); 
</script> 


<%}} %>

</html>