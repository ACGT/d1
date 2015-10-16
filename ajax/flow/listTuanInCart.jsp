<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%
String id = request.getParameter("id");
ProductGroup pg = (ProductGroup)Tools.getManager(ProductGroup.class).get(id);
if(pg == null){
	out.print("{\"code\":1,message:\"很抱歉，您输入的信息不正确，请确认后重试！\"}");
	return;
}

Product product = ProductHelper.getById(pg.getTgrpmst_gdsid());

if(product == null){
	out.print("{\"code\":1,message:\"很抱歉，您输入的信息不正确，请确认后重试！\"}");
	return;
}

//加上限购次数判断
int limitCount115 = 0;
if(product.getGdsmst_buylimit()!=null){
	limitCount115 = product.getGdsmst_buylimit().intValue();
}
if(limitCount115>0){//如果有数量限制
	ArrayList<Cart> list = CartHelper.getCartItems(request,response);
	int total = 0 ;//购物车里已经有几个了
	if(list!=null){
		for(Cart c:list){
			if(c.getType().longValue()==6&&c.getProductId()!=null
					&&c.getProductId().equals(product.getId())){
				total+=c.getAmount().intValue();
			}
		}
	}
	
	if(total+1>limitCount115){
		out.print("{\"code\":1,\"message\":\"对不起，您最多只能团购"+limitCount115+"个。\"}");
		return;
	}
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
	//直接加入购物车。，数量默认1.
	String count = request.getParameter("count");
	if(!Tools.isMath(count)) count = "1";
	else if(Long.parseLong(count) <= 0 || Long.parseLong(count) > 999) count = "1";
	
	int s = CartHelper.addTuanProductToCart(request,response,id,skuId,Tools.parseInt(count));
	
	switch(s){
		case 1:
			//获得购物车总金额和总商品数量
			int totalCount = CartHelper.getTotalProductCount(request,response);
			float totalAmmount = CartHelper.getTotalPayMoney(request,response);
			
			out.print("{\"code\":0,\"message\":\"\",\"totalCount\":"+totalCount+",\"totalAmount\":\""+Tools.getFormatMoney(totalAmmount)+"\"}");
			break;
		case -1:
			out.print("{\"code\":1,message:\"找不到团购信息。\"}");
			break;
		case -2:
			out.print("{\"code\":1,message:\"找不到商品信息。\"}");
			break;
		case -3:
			out.print("{\"code\":1,message:\"此物品已经超过团购数量限制！\"}");
			break;
		case -4:
			out.print("{\"code\":1,message:\"购买团购物品发生错误，请稍后再试！\"}");
			break;
		case -5:
			out.print("{\"code\":1,message:\"您的购物车超过了100条记录，请先提交再继续购买！\"}");
			break;
		case -6:
			out.print("{\"code\":1,message:\"此物品还未开始团购！\"}");
			break;
		case -7:
			out.print("{\"code\":1,message:\"团购已结束，感谢您的关注！\"}");
			break;
		case -8:
			out.print("{\"code\":1,message:\"团购数量发生错误！\"}");
			break;
		default:
			out.print("{\"code\":1,message:\"购买团购物品发生错误，请稍后再试！\"}");
	}
}
%>