<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="function.jsp" %><%

List<Cart> list = CartHelper.getCartItems(request,response);

//限制type=14的赠品金额，必须满足59才允许提交
boolean hasGift14 = false ;
boolean isqrj=false;
int hasGift14gdsid = 0 ;
if(list!=null){
	for(Cart c_23049:list){
		if(c_23049.getTitle().trim().indexOf("情人节")>0){
			isqrj=true;
		}
		
		if(c_23049.getType().longValue()==14 && !Tools.isNull(c_23049.getTuanCode())){
			hasGift14gdsid = 1 ;
			hasGift14 = true ;
			break;
		}
		if(c_23049.getType().longValue()==14){
			hasGift14 = true ;
			break;
		}
	}
}
if(hasGift14){
	if(CartHelper.getTotalPayMoney(request, response)<59 && hasGift14gdsid!=1 && !isqrj){
		out.print("{\"error\":-2,\"content\":\"\"}");//有type=14的赠品，但是金额没有59元，不让提交
		return;
	}
	if(hasGift14gdsid==1 && CartHelper.getTotalPayMoney(request, response)<2 && !isqrj){
		out.print("{\"error\":-3,\"content\":\"\"}");//有type=14的赠品，但是金额没有59元，不让提交
		return;
	}
	if(CartHelper.getTotalPayMoney(request, response)<299  && isqrj){
		out.print("{\"error\":-4,\"content\":\"\"}");//有type=14的赠品，但是金额没有299元，不让提交
		return;
	}
	
}

//根据登陆状态不同和是否选择赠品，跳转到不同页面
if(lUser == null){
	Map<String,Object> map = new HashMap<String,Object>();
		map.put("error",new Integer(9));
		out.print(JSONObject.fromObject(map));
return;
}
//点击结算的时候的检查。

if(list == null || list.isEmpty()){//购物车为空
	Map<String,Object> map = new HashMap<String,Object>();
	map.put("error",new Integer(2));
	map.put("cart_goods_area",(lUser!=null?"您的购物车中没有商品，快去挑选商品吧&nbsp;&nbsp;<a href='/mindex.jsp'>回到首页&gt;&gt;</a>":"如果您上次退出时，购物车中有商品，那么商品已自动保存，<a href='/wap/login.jsp'>请登录后查看&gt;&gt;</a>"));
	out.print(JSONObject.fromObject(map));
	return;
}
boolean isError = false;
//自动删除的物品list
String deleteStr = "";
List<String> delete_list = new ArrayList<String>();
List<Cart> deleteCartList = CartHelper.updateAllCartItems(request,response);
if(deleteCartList != null && !deleteCartList.isEmpty()){
	deleteStr +="自动删除物品：";
	for(Cart c : deleteCartList){
		delete_list.add(c.getId()+"_0_"+(Tools.isNull(c.getSkuId())?"0":c.getSkuId()));
		deleteStr += "["+c.getTitle()+"]&nbsp;&nbsp;";
	}
	isError = true;
}

if(isError){
	//库存不足的物品list
	List<Map<String,Object>> update_list = new ArrayList<Map<String,Object>>();
	//主商品相关联的list
	List<Map<String,Object>> gift_list = new ArrayList<Map<String,Object>>();
	
	//总金额区域
	StringBuilder totalMoneySb = new StringBuilder();
	totalMoneySb.append("商品总计：<font style=\"font-size:13px; font-weight:bold;\" id=\"total_Count\">").append(CartHelper.getTotalProductCount(request,response)).append("</font>件");
	totalMoneySb.append("<font style=\"color:#d80100; font-size:16px; font-weight:bold; margin-left:30px;\">应付总额：<span id=\"total_Price\">").append(CartHelper.getTotalPayMoney(request,response)).append("</span>元</font>");
	
	Map<String,Object> map = new HashMap<String,Object>();
	map.put("error",new Integer(1));
	
	Map<String,Object> content_map = new HashMap<String,Object>();
	
	//赠品
	List<GiftHelper.GiftGoods> giftList = GiftHelper.getCartVisiableGiftProducts(request,response);
	int giftCount = (giftList == null ? 0 : giftList.size());
	
	content_map.put("delete_goods_key",delete_list);//删除的物品
	content_map.put("tishi_delete_favor",deleteStr);//删除赠品的提示
	content_map.put("update_goods_key" , update_list);//库存不足的
	content_map.put("have_gift_goods_key",gift_list);//主物品关联的赠品
	content_map.put("favor_out_cart",new Integer(giftCount));//赠品数量
	content_map.put("zengpin_area",zengpinArea(request,response,giftList));//赠品区域
	content_map.put("total_area",totalMoneySb.toString());//总金额的HTML代码
	
	map.put("content",content_map);
	
	out.print(JSONObject.fromObject(map));
}else{
	int totalGift_1 = 0 ,totalVisiable_1 = 0;//选择的赠品数
	ArrayList<Cart> cList123 = CartHelper.getCartItems(request, response);
	for(Cart cart_1:cList123){
		if(cart_1.getType().longValue()==0)totalGift_1++;
	}
	
	ArrayList<GiftHelper.GiftGoods> giftList = GiftHelper.getCartVisiableGiftProducts(request, response);
	if(giftList!=null){
		for(GiftHelper.GiftGoods gg_77p:giftList){
			if(gg_77p.isIsfree()){
				totalVisiable_1++;
			}
		}
	}
	
	if(totalVisiable_1>0&&totalGift_1==0){
		out.print("{\"error\":-1,\"content\":\"\"}");//没有选择赠品
		return;
	}else{
		out.print("{\"error\":0,\"content\":\"\"}");//完全没有错误。
		return;
	}
}
%>