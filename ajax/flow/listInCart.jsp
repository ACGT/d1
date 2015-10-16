<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%!
public static ArrayList<PromotionProduct> getPProductByCodeGdsid(String code,String id){
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
			clist.add(Restrictions.eq("spgdsrcm_gdsid",id));
			List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, null, 0, 100);
			
			if(list!=null){
				for(BaseEntity be:list){
					PromotionProduct pp = (PromotionProduct)be;
					rlist.add(pp);
				}
			}
		
	
	return rlist ;
}

//获取白金独享商品列表
private static ArrayList<PromotionProduct> getbjdxlist(String gdsid)
{
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code", new Long("8322")));
	clist.add(Restrictions.eq("spgdsrcm_gdsid", gdsid));
	clist.add(Restrictions.ge("spgdsrcm_enddate", new Date()));
	clist.add(Restrictions.le("spgdsrcm_begindate", new Date()));
	List<Order> olist = new ArrayList<Order>();
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, 1000);
	if(clist==null||clist.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((PromotionProduct)be);
	}
	return rlist ;
}
%><%
String id = request.getParameter("id");
Product product = ProductHelper.getById(id);
if(product == null){
	out.print("{\"code\":1,message:\"很抱歉，您输入的信息不正确，请确认后重试！\"}");
	return;
}

//商品是否在架上
if(Tools.longValue(product.getGdsmst_validflag()) != 1){
	out.print("{\"code\":1,\"message\":\"对不起，您选购的商品现在暂时性脱销，请您过一段时间再来购买。\"}");
	return;
}
//缺货标识
long ifhaveges = Tools.longValue(product.getGdsmst_ifhavegds());
if(ifhaveges == 3){
	out.print("{\"code\":1,\"message\":\"您好！此商品为非卖品，不能单独订购！\"}");
	return;
}
if(ifhaveges == 2){
	out.print("{\"code\":1,\"message\":\"对不起，此商品暂时缺货！\"}");
	return;
}
if(ifhaveges == 1){//有到货日期
	Date ifhaveDate = product.getGdsmst_ifhavedate(); 
	if(ifhaveDate != null){//那就是有到货期限。
		long spanDay = (ifhaveDate.getTime()-System.currentTimeMillis())/Tools.DAY_MILLIS+1;
		if(spanDay > 0){
			out.print("{\"code\":1,\"message\":\"此商品暂时缺货，预计"+spanDay+"天到货！\"}");
			return;
		}else{
			out.print("{\"code\":1,\"message\":\"对不起，此商品暂时缺货，近期将到货！\"}");
			return;
		}
	}else{
		out.print("{\"code\":1,\"message\":\"对不起，此商品暂时缺货，近期将到货！\"}");
		return;
	}
}

//检查购物车
//CartHelper.checkCartError(request,response);

String type = request.getParameter("type");
if(!"1".equals(type)) type = "0";
int t = Tools.parseInt(type);//查看是否要强制加入购物车。

//判断是否有SKU，如果有SKU则弹出SKU的选择层。
//存在SKU
String skuId = request.getParameter("skuId");
if(ProductHelper.hasSku(product)){
	if(skuId == null){
		String message = product.getGdsmst_skuname1()+":";
		List<Sku> skuList = SkuHelper.getSkuListViaProductId(product.getId());
		if(skuList != null && !skuList.isEmpty()){
			for(Sku sku : skuList){
				message += sku.getId()+"_"+sku.getSkumst_sku1()+"#";
			}
		}
		if(message.endsWith("#")) message = message.substring(0,message.length()-1);
		out.print("{\"code\":3,message:\""+message+"\"}");
		return;
	}
	if(!SkuHelper.hasInSkuList(product , skuId)){
		out.print("{\"code\":1,message:\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
		return;
	}
}else{
	skuId = null;
}

//直接加入购物车。，数量默认1.
String count = request.getParameter("count");
if(!Tools.isMath(count)) count = "1";
else if(Long.parseLong(count) <= 0 || Long.parseLong(count) > 999) count = "1";
	
int countNum = (new Integer(count)).intValue();//订购数量
int countInCart = 0 ;//购物车里的已购买数量

if(product.getGdsmst_buylimit()!=null&&product.getGdsmst_buylimit().longValue()>0){//有购买次数限制
	ArrayList<Cart> cartList234355 = CartHelper.getCartItems(request, response);
	if(cartList234355!=null&&cartList234355.size()>0){
		for(Cart c746745:cartList234355){
			if(product.getId().endsWith(c746745.getProductId())){
				countInCart+=c746745.getAmount().intValue();
			}
		}
	}
	
	if(countInCart+countNum>product.getGdsmst_buylimit().intValue()){//超出限购次数
		out.print("{\"code\":1,message:\"很抱歉，该商品限购"+product.getGdsmst_buylimit()+"次。\"}");
		return;
	}
}

//量少提醒和卖完就下的商品检查一下虚拟库存够不够
if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
	int countInCart_1239 = CartHelper.getCartProductCount(request, response, product, skuId);//购物车里已经订购的数量
	if(countNum+countInCart_1239+CartItemHelper.getProductOccupyStock(product.getId(), skuId)>ProductHelper.getVirtualStock(product.getId(), skuId)){
		int i_239489 = ProductHelper.getVirtualStock(product.getId(), skuId)-CartItemHelper.getProductOccupyStock(product.getId(), skuId)-countInCart_1239;
		if(i_239489<=0){
			out.print("{\"code\":1,\"message\":\"您好！该商品已售完！\"}");
		}else{
			out.print("{\"code\":1,\"message\":\"您好！该商品只剩"+i_239489+"个！\"}");
		}
		return;
	}
}

String gdsReferer="";
if (session.getAttribute("gdsReferer")!=null){
	gdsReferer=session.getAttribute("gdsReferer").toString();
}
if (URLDecoder.decode(gdsReferer).indexOf(id+"\":")==-1){
	gdsReferer="";
	
}else{
	gdsReferer=URLDecoder.decode(gdsReferer);
JSONObject  jsonob = JSONObject.fromObject(gdsReferer); 
Map<String, Object> mapref = (Map)jsonob;
gdsReferer=mapref.get(id).toString();
if (gdsReferer.length()>=400){
	gdsReferer=gdsReferer.substring(0, 380);
}
}

ArrayList<PromotionProduct> list1= getPProductByCodeGdsid("8085",id);
ArrayList<PromotionProduct> list2= getPProductByCodeGdsid("8086",id);
ArrayList<PromotionProduct> bjdxlist= getbjdxlist(id);
boolean b=false;
if(list1!=null && list1.size()>0 && list2!=null && list2.size()>0 ){
	b=true;
}
boolean sfbjdx=false;
PromotionProduct pbjdx=new PromotionProduct();
if(bjdxlist!=null&&bjdxlist.size()>0)
{
	sfbjdx=true;
	pbjdx=bjdxlist.get(0);
}



String shopcode="00000000";
//System.out.println(shopcode+"+++++++++++++++++++++"+product.getGdsmst_shopcode().equals("08102301"));
if(product.getGdsmst_shopcode()!=null&&!product.getGdsmst_shopcode().equals("08102301"))shopcode=product.getGdsmst_shopcode();
//System.out.println(shopcode+"+++++++++++++++++++++"+product.getGdsmst_shopcode().equals("08102301"));
boolean msflag=CartHelper.getmsflag(product);
boolean isdx=false;
String dxid=Tools.getCookie(request,"rcmdusr_rcmid");
if(!Tools.isNull(dxid)){
	
	ProductExpPriceItem expitem = ProductExpPriceHelper.getExpPrice(id,dxid);
	if(expitem != null){	
		isdx=true;
	}
}



Date nowday=new Date();
boolean ismiaoshao=false;
SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
if(product.getGdsmst_promotionstart()!=null&&product.getGdsmst_promotionend()!=null&&product.getGdsmst_msprice()!=null){
	Date sdate=product.getGdsmst_promotionstart();
	Date edate=product.getGdsmst_promotionend();	

	if(nowday.getTime()>=sdate.getTime()&&edate.getTime()> nowday.getTime()
			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
			&&product.getGdsmst_msprice().floatValue()>=0f){
		ismiaoshao = true;
	}

}
SgGdsDtl sg=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid", id);
if(ismiaoshao){

if(sg!=null){
	//System.out.println(sg.getSggdsdtl_maxnum().longValue()+"--------"+sg.getSggdsdtl_realbuynum().longValue());
	if(sg.getSggdsdtl_maxnum().longValue()<=sg.getSggdsdtl_realbuynum().longValue()
			||sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue()<=0){
	out.print("{\"success\":false,\"message\":\"您好！商品【"+StringUtils.clearHTML(product.getGdsmst_gdsname())+"】已经被抢光！\"}");
	return;
	}
}
}
	
//不存在SKU则直接加入购物车，但是需要判断购物车中是否有这件物品。
if(CartHelper.hasInCart(product,skuId,request,response) && t==0){
	out.print("{\"code\":2,\"message\":\"\"}");
	return;
}else{
	if(sfbjdx&&lUser!=null&&UserHelper.isPtVip(lUser)&&pbjdx!=null&&pbjdx.getSpgdsrcm_tjprice()!=null)
	{
		//放入购物车
		Cart cart = new Cart();
		cart.setParentId("0");
		cart.setSkuId(skuId);
		cart.setAmount(new Long(count));//数量
		cart.setProductId(id);
		cart.setPrice(pbjdx.getSpgdsrcm_tjprice()!=null?pbjdx.getSpgdsrcm_tjprice().floatValue():product.getGdsmst_memberprice());
		cart.setOldPrice(product.getGdsmst_memberprice());
		cart.setVipPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.VIP_DISCOUNT,2));
		cart.setType(new Long(17));
		cart.setTitle("[白金独享商品]"+product.getGdsmst_gdsname());
		cart.setRefererurl(gdsReferer);
		cart.setShopcode(shopcode);
		CartHelper.addCart(request,response,cart);
	}else if(!isdx&&product.getGdsmst_msprice()!=null
			&&msflag&&product.getGdsmst_msprice().floatValue()>=0f){
		 
		String  gdstxt="【秒杀】";
		 if(sg!=null){
			 
			 if(sg.getSggdsdtl_status().longValue()==1){
				 gdstxt="【闪购】";
				// System.out.println(sg.getSggdsdtl_realbuynum().longValue()+iCount+"---------------------------");
				 sg.setSggdsdtl_realbuynum(new Long(sg.getSggdsdtl_realbuynum().longValue()+Tools.parseLong(count)));
					Tools.getManager(SgGdsDtl.class).update(sg, true);
			 }
		 if(sg.getSggdsdtl_limitgroup().longValue()>0){
		    ArrayList<Cart> allCartList = CartHelper.getCartItems(request, response);
		    int cartCount = 0;
		    if(allCartList!=null){
			  for(Cart c_23894:allCartList){
				SgGdsDtl sgc=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid", c_23894.getProductId());
			    if(sgc!=null&&sg.getSggdsdtl_limitgroup().longValue()==sgc.getSggdsdtl_limitgroup().longValue()){
			    	out.print("{\"success\":false,\"message\":\"您好！购物车已经存在此闪购组里的商品。此闪购组的商品一个订单只能订购一个！\"}");
			    	return;
			    }
			}
		   }
		  }
		 }
		
		
		Cart cart = new Cart();
		cart.setParentId("0");
		cart.setSkuId(skuId);
		cart.setAmount(new Long(count));//数量
		cart.setProductId(id);
		cart.setPrice(product.getGdsmst_msprice());
		cart.setOldPrice(product.getGdsmst_memberprice());
		cart.setVipPrice(product.getGdsmst_msprice());
		cart.setType(new Long(20));
		cart.setShopcode(shopcode);
		cart.setTitle(gdstxt+product.getGdsmst_gdsname());
		cart.setRefererurl(gdsReferer);
		CartHelper.addCart(request,response,cart);
		
	}else{
		//放入购物车
		Cart cart = new Cart();
		cart.setParentId("0");
		cart.setSkuId(skuId);
		cart.setAmount(new Long(count));//数量
		cart.setProductId(id);
		cart.setOldPrice(product.getGdsmst_memberprice());
		cart.setVipPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.VIP_DISCOUNT,2));
		cart.setType(new Long(1));
		cart.setShopcode(shopcode);
		cart.setTitle(product.getGdsmst_gdsname());
		cart.setRefererurl(gdsReferer);
		CartHelper.addCart(request,response,cart);
	}

	
	//获得购物车总金额和总商品数量
	int totalCount = CartHelper.getTotalProductCount(request,response);
	float totalAmount = CartHelper.getTotalPayMoney(request,response);
	
	out.print("{\"code\":0,\"message\":\"\",\"totalCount\":"+totalCount+",\"totalAmount\":\""+Tools.getFormatMoney(totalAmount)+"\"}");
	return;
}
%>