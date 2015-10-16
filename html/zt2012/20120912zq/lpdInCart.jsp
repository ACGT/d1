<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%
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
//if(ifhaveges == 3){
//	out.print("{\"code\":1,\"message\":\"您好！此商品为非卖品，不能单独订购！\"}");
//	return;
//}
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
	
//不存在SKU则直接加入购物车，但是需要判断购物车中是否有这件物品。
if(CartHelper.hasInCart(product,skuId,request,response) && t==0){
	out.print("{\"code\":2,\"message\":\"\"}");
	return;
}else{
	//放入购物车
	Cart cart = new Cart();
	cart.setParentId("0");
	cart.setSkuId(skuId);
	cart.setAmount(new Long(count));//数量
	cart.setProductId(product.getId());
	cart.setOldPrice(product.getGdsmst_memberprice());
	cart.setVipPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.VIP_DISCOUNT,2));
	cart.setType(new Long(1));
	cart.setTitle(Tools.clearHTML(product.getGdsmst_gdsname()));
	cart.setPrice(Tools.getFloat(product.getGdsmst_memberprice(), 2));
	cart.setShopcode(product.getGdsmst_shopcode());
	CartHelper.addCart(request,response,cart);
	
	//获得购物车总金额和总商品数量
	int totalCount = CartHelper.getTotalProductCount(request,response);
	float totalAmount = CartHelper.getTotalPayMoney(request,response);
	
	out.print("{\"code\":0,\"message\":\"\",\"totalCount\":"+totalCount+",\"totalAmount\":\""+Tools.getFormatMoney(totalAmount)+"\"}");
	return;
}
%>