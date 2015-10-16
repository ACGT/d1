<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%
String rec_key = request.getParameter("id");
int indexChar = -1;
if(rec_key == null || (indexChar=rec_key.indexOf("_")) == -1){
	out.print("{\"code\":1,\"message\":\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
	return;
}

String id = rec_key.substring(0,indexChar);
String c = rec_key.substring(indexChar+1);

if(!Tools.isMath(id)){
	out.print("{\"code\":1,\"message\":\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
	return;
}

Product product = null;
GiftHelper.GiftGoods giftGoods = null;

if("0".equals(c)){//普通赠品
	GiftItem item = (GiftItem)Tools.getManager(GiftItem.class).get(id);
	if(item == null){
		out.print("{\"code\":1,\"message\":\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
		return;
	}
	List<GiftHelper.GiftGoods> giftList = GiftHelper.getCartVisiableGiftProducts(request,response);
	boolean isInGift = false;
	if(giftList != null && !giftList.isEmpty()){
		for(GiftHelper.GiftGoods gg : giftList){
			if(gg.getType() == 0 && item.getId().equals(gg.getGiftItemId())){
				isInGift = true;
				giftGoods = gg;
				break;
			}
		}
	}
	if(!isInGift){
		out.print("{\"code\":1,\"message\":\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
		return;
	}
	product = ProductHelper.getById(item.getGiftrckdtl_gdsid());
}else if("1".equals(c)){//多品赠品
	GiftGroupItem item = (GiftGroupItem)Tools.getManager(GiftGroupItem.class).get(id);
	if(item == null){
		out.print("{\"code\":1,\"message\":\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
		return;
	}
	List<GiftHelper.GiftGoods> giftList = GiftHelper.getCartVisiableGiftProducts(request,response);
	boolean isInGift = false;
	if(giftList != null && !giftList.isEmpty()){
		for(GiftHelper.GiftGoods gg : giftList){
			if(gg.getType() == 1 && item.getId().equals(gg.getGiftItemId())){
				isInGift = true;
				giftGoods = gg;
				break;
			}
		}
	}
	if(!isInGift){
		out.print("{\"code\":1,\"message\":\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
		return;
	}
	product = ProductHelper.getById(item.getGiftgrpdtl_gdsid());
}else{
	out.print("{\"code\":1,\"message\":\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
	return;
}

if(product == null){
	out.print("{\"code\":1,\"message\":\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
	return;
}

ArrayList<Cart> clist = CartHelper.getCartItems(request, response);
if(clist!=null){
	for(Cart cc1234:clist){
		if(cc1234.getType().longValue()==0&&product.getId().equals(cc1234.getParentId())){
			out.print("{\"code\":1,\"message\":\"很抱歉，该赠品已经加入购物车了，请不要重复加入。\"}");
			return;
		}
	}
}

//商品是否在架上
if(Tools.longValue(product.getGdsmst_validflag()) != 1){
	out.print("{\"code\":1,\"message\":\"对不起，您选购的商品现在暂时性脱销，请您过一段时间再来购买。\"}");
	return;
}
//缺货标识
long ifhaveges = Tools.longValue(product.getGdsmst_ifhavegds());
/* if(ifhaveges == 3){
	out.print("{\"code\":1,\"message\":\"您好！此商品为非卖品，不能单独订购！\"}");
	return;
} */
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
		
		if(skuList != null && skuList.size()>0){
			for(Sku sku : skuList){
				if(sku!=null){
					message += sku.getId()+"_"+sku.getSkumst_sku1()+"#";
				}
			}
		}
		
		if(message.endsWith("#")) message = message.substring(0,message.length()-1);
		out.print("{\"code\":3,\"message\":\""+message+"\"}");
		return;
	}
	if(!SkuHelper.hasInSkuList(product , skuId)){
		out.print("{\"code\":1,\"message\":\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
		return;
	}
}else{
	skuId = null;
}

//量少提醒和卖完就下的商品检查一下虚拟库存够不够
if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
	int countInCart_1239 = CartHelper.getCartProductCount(request, response, product, skuId);//购物车里已经订购的数量
	if(1+countInCart_1239+CartItemHelper.getProductOccupyStock(product.getId(), skuId)>ProductHelper.getVirtualStock(product.getId(), skuId)){
		int i_239489 = ProductHelper.getVirtualStock(product.getId(), skuId)-CartItemHelper.getProductOccupyStock(product.getId(), skuId)-countInCart_1239;
		if(i_239489<=0){
			out.print("{\"code\":1,\"message\":\"您好！该商品已售完！\"}");
		}else{
			out.print("{\"code\":1,\"message\":\"您好！该商品只剩"+i_239489+"个！\"}");
		}
		return;
	}
}

//不存在SKU则直接加入购物车，但是需要判断购物车中是否有这件物品。
if(CartHelper.hasInCart(product,skuId,request,response) && t==0){
	out.print("{\"code\":2,\"message\":\"\"}");
	return;
}else{
	int s = CartHelper.addGiftProductToCart(request,response,giftGoods,skuId);
	switch(s){
		case 1:
			//获得购物车总金额和总商品数量
			int totalCount = CartHelper.getTotalProductCount(request,response);
			float totalAmmount = CartHelper.getTotalPayMoney(request,response);
			
			out.print("{\"code\":0,\"message\":\"\",\"totalCount\":"+totalCount+",\"totalAmount\":\""+Tools.getFormatMoney(totalAmmount)+"\"}");
			break;
		case -2:
			out.print("{\"code\":1,\"message\":\"找不到商品信息。\"}");
			break;
		case -5:
			out.print("{\"code\":1,\"message\":\"您已经加过一次赠品了，不能再次加入！\"}");
			break;
		case -6:
			out.print("{\"code\":1,\"message\":\"此类赠品已经在购物车里增加过，如要更换其它赠品请删除购物车里的赠品后再重新选择！\"}");
			break;
		default:
			out.print("{\"code\":1,\"message\":\"加入购物车发生错误，请稍后再试！\"}");
	}
}
%>