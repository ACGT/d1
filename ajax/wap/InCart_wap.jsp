<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%
String gdsid = request.getParameter("gdsid");//商品编号
Product product = ProductHelper.getById(gdsid);

if(product == null){
	out.print("{\"success\":false,\"message\":\"商品不存在，请刷新页面！\"}");
	return;
}

//商品数量
int iCount = Tools.parseInt(request.getParameter("count"));
if(iCount <= 0) iCount = 1;

//商品是否在架上
if(Tools.longValue(product.getGdsmst_validflag()) != 1){
	out.print("{\"success\":false,\"message\":\"对不起，您选购的商品现在暂时性脱销，请您过一段时间再来购买。\"}");
	return;
}
//缺货标识
long ifhaveges = Tools.longValue(product.getGdsmst_ifhavegds());
if(ifhaveges == 3){
	out.print("{\"success\":false,\"message\":\"您好！此商品为非卖品，不能单独订购！\"}");
	return;
}
if(ifhaveges == 2){
	out.print("{\"success\":false,\"message\":\"对不起，此商品暂时缺货！\"}");
	return;
}


if(product.getGdsmst_buylimit()!=null&&product.getGdsmst_buylimit().intValue()>0){
	ArrayList<Cart> allCartList = CartHelper.getCartItems(request, response);
	int cartCount = 0;
	if(allCartList!=null){
		for(Cart c_23894:allCartList){
			if(product.getId().equals(c_23894.getProductId())){
				cartCount+=c_23894.getAmount().intValue();
			}
		}
	}
	if(cartCount+iCount>product.getGdsmst_buylimit().intValue()){
		out.print("{\"success\":false,\"message\":\"对不起，该商品限购"+product.getGdsmst_buylimit().intValue()+"个！\"}");
		return;
	}
}

if(ifhaveges == 1){//有到货日期
	Date ifhaveDate = product.getGdsmst_ifhavedate(); 
	if(ifhaveDate != null){//那就是有到货期限。
		long spanDay = (ifhaveDate.getTime()-System.currentTimeMillis())/Tools.DAY_MILLIS+1;
		if(spanDay > 0){
			out.print("{\"success\":false,\"message\":\"此商品暂时缺货，预计"+spanDay+"天到货！\"}");
			return;
		}else{
			out.print("{\"success\":false,\"message\":\"对不起，此商品暂时缺货，近期将到货！\"}");
			return;
		}
	}else{
		out.print("{\"success\":false,\"message\":\"对不起，此商品暂时缺货，近期将到货！\"}");
		return;
	}
}
String skuId = null;
if(SkuHelper.hasSku(product)){
	//判断sku
	skuId = request.getParameter("skuId");
	if(Tools.isNull(skuId)){
		out.print("{\"success\":false,\"message\":\"您好！请选择"+product.getGdsmst_skuname1()+"！\"}");
		return;
	}
	if(!SkuHelper.hasInSkuList(product , skuId)){
		out.print("{\"success\":false,\"message\":\"您好！您选择的"+product.getGdsmst_skuname1()+"不存在，请重新选择！\"}");
		return;
	}
}

//量少提醒和卖完就下的商品检查一下虚拟库存够不够
if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
	int countInCart_1239 = CartHelper.getCartProductCount(request, response, product, skuId);//购物车里已经订购的数量
	if(iCount+countInCart_1239+CartItemHelper.getProductOccupyStock(product.getId(), skuId)>ProductHelper.getVirtualStock(product.getId(), skuId)){
		int i_239489 = ProductHelper.getVirtualStock(product.getId(), skuId)-CartItemHelper.getProductOccupyStock(product.getId(), skuId)-countInCart_1239;
		if(i_239489<=0){
			out.print("{\"success\":false,\"message\":\"您好！该商品已售完！\"}");
		}else{
			out.print("{\"success\":false,\"message\":\"您好！该商品只剩"+i_239489+"个！\"}");
		}
		return;
	}
}
//判断促销语的问题
String promotionword = product.getGdsmst_promotionword();//促销语句
if(!Tools.isNull(promotionword)){
	long today = System.currentTimeMillis();
	Date promotionStart = product.getGdsmst_promotionstart();//促销开始时间
	Date promotionEnd = product.getGdsmst_promotionend();//促销结束时间
	if(today < (promotionStart != null?promotionStart.getTime():0) || today > (promotionEnd !=null?promotionEnd.getTime():0)){
		promotionword = "";
	}
}
//判断物品的促销方式
String sltDiscID =request.getParameter("sltDiscID");
int iDiscid = -1;//促销方式的ID
if(Tools.isMath(sltDiscID)){
	iDiscid = Integer.parseInt(sltDiscID);
}

//商品价格
float memberprice = Tools.floatValue(product.getGdsmst_memberprice());//会员价
float vipprice = Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.VIP_DISCOUNT,2);//vip价

//用户没有选择促销方式，存储过程463-499
if(iDiscid == -1){
	
}else{
	//计算折扣后的价格。
}
//判断价格是否为0
if(memberprice == 0 || vipprice == 0){
	out.print("{\"success\":false,\"message\":\"对不起，此商品价格正在调整中，请您过一段时间再来购买！\"}");
	return;
}
//放入购物车
Cart cart = new Cart();
cart.setParentId("0");
cart.setSkuId(skuId);
cart.setAmount(new Long(iCount));//数量
cart.setProductId(gdsid);
cart.setOldPrice(product.getGdsmst_memberprice());
cart.setVipPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.VIP_DISCOUNT,2));
cart.setType(new Long(1));
cart.setTitle(product.getGdsmst_gdsname());
CartHelper.addCart(request,response,cart);
out.print("{\"success\":true,\"message\":\"添加成功！\"}");
return;
%>