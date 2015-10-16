<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="/ajax/flow/function.jsp" %><%
String rec_key = request.getParameter("rec_key");

if(rec_key == null){
	out.print("{\"error\":-1,\"content\":\"\"}");
	return;
}
String[] keyArr = rec_key.split("_");
if(keyArr == null || keyArr.length!=3){
	out.print("{\"error\":-1,\"content\":\"\"}");
	return;
}
Cart cart = CartHelper.getById(keyArr[0]);

if(cart == null){
	out.print("{\"error\":-1,\"content\":\"\"}");
	return;
}
//有父类的都不许删除，不能删除
if(Tools.longValue(cart.getHasFather() , 0) == 1){
	out.print("{\"error\":-1,\"content\":\"\"}");
	return;
}
//主商品相关联的子类
List<String> child_list = new ArrayList<String>();
//获取子cart列表
ArrayList<Cart> childCart = CartHelper.getCartItemsViaParentId(cart.getId());
//记录所有的子节点，需要删除的。
if(childCart!=null&&!childCart.isEmpty()){
	for(Cart c : childCart){
		String c_rec_key = c.getId()+"_0_"+(Tools.isNull(c.getSkuId())?"0":c.getSkuId());
		child_list.add(c_rec_key);
	}
}
//删除购物车
ArrayList<Cart> deleteCartList = CartHelper.deleteCart(request,response,keyArr[0]);

//删除的物品。
String deleteStr = "";
List<String> delete_list = new ArrayList<String>();
if(deleteCartList != null && !deleteCartList.isEmpty()){
	deleteStr +="自动删除：";
	for(Cart c : deleteCartList){
		delete_list.add(c.getId()+"_0_"+(Tools.isNull(c.getSkuId())?"0":c.getSkuId()));
		deleteStr += "["+c.getTitle()+"]&nbsp;&nbsp;";
	}
}

int recalculate = Tools.floatValue(cart.getMoney())>0?1:0;//删除的物品的价格是否大于0

//购物车中有物品
Map<String,Object> map = new HashMap<String,Object>();
map.put("error",new Integer(0));

//赠品
List<GiftHelper.GiftGoods> giftList = GiftHelper.getCartVisiableGiftProducts(request,response);
int giftCount = (giftList == null ? 0 : giftList.size());

Map<String,Object> content_map = new HashMap<String,Object>();
content_map.put("favor_out_cart",new Integer(giftCount));//赠品数量
content_map.put("zengpin_area",zengpinArea(request,response,giftList));//赠品区域
content_map.put("tishi_delete_favor","");//删除赠品的提示
content_map.put("child_goods",child_list);//主物品关联的子类
content_map.put("recalculate",new Integer(recalculate));//删除的物品的价格是否大于0
content_map.put("delete_goods_key",delete_list);//删除的物品
content_map.put("tishi_delete_favor",deleteStr);//自动删除物品的提示

if(recalculate > 0){
	//总金额区域
	StringBuilder totalMoneySb = new StringBuilder();
	totalMoneySb.append("<font style=\"color:#d80100; font-size:16px; font-weight:bold;\">应付总额：<span id=\"total_Price\">").append(CartHelper.getTotalPayMoney(request,response)).append("</span>元</font>");
	
	content_map.put("total_area",totalMoneySb.toString());//总金额的HTML代码
}
map.put("content",content_map);
map.put("hasContent",new Integer(1));

ArrayList<Cart> list = CartHelper.getCartItems(request,response);

//购物车中没有物品了。
if(list == null || list.isEmpty()){
	Map<String,Object> map_998 = new HashMap<String,Object>();
	map_998.put("error",new Integer(2));
	map_998.put("content",content_map);
	map_998.put("hasContent",new Integer(1));
	map_998.put("cart_goods_area",(lUser!=null?"您的购物车中没有商品，快去挑选商品吧&nbsp;&nbsp;<a href='/mindex.jsp'>回到首页&gt;&gt;</a>":"如果您上次退出时，购物车中有商品，那么商品已自动保存，<a href='/wap/login.jsp'>请登录后查看&gt;&gt;</a>"));
	out.print(JSONObject.fromObject(map_998));
	return;
}

out.print(JSONObject.fromObject(map));
%>