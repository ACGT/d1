<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="function.jsp" %><%
String id = request.getParameter("id");
String gdsid = request.getParameter("gdsid");
String skuId = request.getParameter("skuId");

Cart cart = CartHelper.getById(id);

if(cart == null){
	out.print("{\"error\":-1,\"message\":\"记录不存在！\",\"content\":\"\"}");
	return;
}
if(cart.getProductId()!=null&&!cart.getProductId().trim().equals(gdsid)){
	out.print("{\"error\":-2,\"message\":\"商品信息不正确！\",\"content\":\"\"}");
	return;
}

Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());

//商品数量
int iCount = Tools.parseInt(request.getParameter("count"));
if(iCount <= 0) iCount = 1;

//商品是否在架上
if(Tools.longValue(product.getGdsmst_validflag()) != 1){
	out.print("{\"error\":-3,\"message\":\"对不起，您选购的商品现在暂时性脱销，请您过一段时间再来购买。\"}");
	return;
}

if(SkuHelper.hasSku(product)){
	//判断sku
	if(Tools.isNull(skuId)){
		out.print("{\"error\":-4,\"message\":\"您好！请选择"+product.getGdsmst_skuname1()+"！\"}");
		return;
	}
	if(!SkuHelper.hasInSkuList(product , skuId)){
		out.print("{\"error\":-5,\"message\":\"您好！您选择的"+product.getGdsmst_skuname1()+"不存在，请重新选择！\"}");
		return;
	}
}

//量少提醒和卖完就下的商品检查一下虚拟库存够不够
if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
	int countInCart_1239 = CartHelper.getCartProductCount(request, response, product, skuId);//购物车里已经订购的数量
	if(iCount+countInCart_1239+CartItemHelper.getProductOccupyStock(product.getId(), skuId)>ProductHelper.getVirtualStock(product.getId(), skuId)){
		int i_239489 = ProductHelper.getVirtualStock(product.getId(), skuId)-CartItemHelper.getProductOccupyStock(product.getId(), skuId)-countInCart_1239;
		if(i_239489<=0){
			out.print("{\"error\":-6,\"message\":\"您好！该商品已售完！\"}");
		}else{
			out.print("{\"error\":-7,\"message\":\"您好！该商品只剩"+i_239489+"个！\"}");
		}
		return;
	}
}

//更新skuid
boolean result = CartHelper.updateCartSkuId(request,response,id,skuId);
if(result)
{
	out.print("{\"error\":0,\"message\":\"修改规格成功！\"}");
}
else{
	out.print("{\"error\":-8,\"message\":\"修改规格失败！\"}");
	return;
}


%>