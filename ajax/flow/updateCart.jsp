<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="function.jsp" %>
<%!
//获取闪购信息
public static SgGdsDtl getSgGdsDtlByGdsid(String gdsid) {
	return (SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid",gdsid);
}

//获取闪购组信息
public static ArrayList<SgGdsDtl> getSgGdsDtlByLimitgroup(Long limitgroup) {
	ArrayList<SgGdsDtl> rlist = new ArrayList<SgGdsDtl>();

	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sggdsdtl_limitgroup",limitgroup));
	List<BaseEntity> list = Tools.getManager(SgGdsDtl.class).getList(clist, null, 0, 100);
	
	if(list!=null){
		for(BaseEntity be:list){
			SgGdsDtl pp = (SgGdsDtl)be;
			rlist.add(pp);
		}
	}


	return rlist ;	
}
%>
<%


String car_id = request.getParameter("car_id");
String goods_number = request.getParameter("goods_number");
String rec_key = request.getParameter("rec_key");

Cart cart = CartHelper.getById(car_id);

if(cart == null){
	out.print("{\"error\":-1,\"message\":\"\",\"content\":\"\"}");
	return;
}


Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());

long type = Tools.longValue(cart.getType());
//赠品和套餐类物品，不能修改数量。
if(Tools.longValue(cart.getHasFather() , 0) == 1 || type==0 || type==13 || type==15 || type==-5 ||type==14|| type==2||type==18||type==19||(product!=null&&product.getGdsmst_buylimit()!=null&&product.getGdsmst_buylimit().intValue()>0)){
	out.print("{\"error\":-1,\"message\":\"\",\"content\":\"\"}");
	return;
}
if(!Tools.isMath(goods_number) || "0".equals(goods_number)){
	out.print("{\"error\":-1,\"message\":\"\",\"content\":\"\"}");
	return;
}
if(Tools.isNull(rec_key)){
	out.print("{\"error\":-1,\"message\":\"\",\"content\":\"\"}");
	return;
}
int number = Integer.parseInt(goods_number);
//最多购买限次
/* long buylimit = Tools.longValue(product.getGdsmst_buylimit(),0);
if((buylimit == 0 && number > 999) || (buylimit > 0 && number > buylimit)){
	out.print("{\"error\":-2,\"message\":\"此商品您最多只能购买"+(buylimit==0?999:buylimit)+"件！\",\"content\":\"\"}");
	return;
} */

//量少提醒和卖完就下的商品检查一下虚拟库存够不够
if(product!=null&&product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
	if(number+CartItemHelper.getProductOccupyStock(product.getId(), cart.getSkuId())>ProductHelper.getVirtualStock(product.getId(), cart.getSkuId())){
		out.print("{\"error\":-2,\"message\":\"该商品库存不足！修改失败！\"}");
		return;
	}
}
if(product!=null){
//查询是否有闪购限购产品
SgGdsDtl sggds = getSgGdsDtlByGdsid(product.getId());
if(sggds!=null){
List<SgGdsDtl> sggdsdtlList = getSgGdsDtlByLimitgroup(sggds.getSggdsdtl_limitgroup());
if(sggds.getSggdsdtl_limitgroup()>0) {
	if(number > 1) {
		out.print("{\"error\":-2,\"message\":\"对不起，您选购的商品是限量闪购商品,只能选购1件。\"}");
		return;
	}
}
}
}
String[] keyArr = rec_key.split("_");
if(keyArr == null || keyArr.length!=3){
	out.print("{\"error\":-1,\"message\":\"\",\"content\":\"\"}");
	return;
}
//再看库存,InCart.jsp
//更新数量
List<Cart> deleteCartList = CartHelper.updateCartAmount(request,response,car_id,number);

//删除的物品。
String deleteStr = "";
List<String> delete_list = new ArrayList<String>();
if(deleteCartList != null && !deleteCartList.isEmpty()){
	deleteStr +="自动删除物品：";
	for(Cart c : deleteCartList){
		delete_list.add(c.getId()+"_0_"+(Tools.isNull(c.getSkuId())?"0":c.getSkuId()));
		deleteStr += "["+c.getTitle()+"]&nbsp;&nbsp;";
	}
}

Map<String,Object> goods_Map = new HashMap<String,Object>();

//物品关联的子类
List<Map<String,Object>> child_List = new ArrayList<Map<String,Object>>();
//获取子cart列表
ArrayList<Cart> childCart = CartHelper.getCartItemsViaParentId(cart.getId());
//修改所有子节点数量，支付价在后面修改
if(childCart!=null&&!childCart.isEmpty()){
	for(Cart c : childCart){
		Map<String,Object> childMap = new HashMap<String,Object>();
		String c_rec_key = c.getId()+"_0_"+(Tools.isNull(c.getSkuId())?"0":c.getSkuId());
		childMap.put("goods_number" , c.getAmount());
		//会员价格
		float oldPrice = Tools.floatValue(c.getOldPrice())*Tools.longValue(c.getAmount());
		childMap.put("prefrePrice" , Tools.getFormatMoney(oldPrice - Tools.floatValue(c.getMoney())));//优惠价格
		childMap.put("subtotal",Tools.getFormatMoney(Tools.floatValue(c.getMoney())));//总价
		childMap.put("rec_key",c_rec_key);
		child_List.add(childMap);
		
		if(c.getType().longValue()>=0){
			Product p_9k = (Product)Tools.getManager(Product.class).get(c.getProductId());
			
			//量少提醒和卖完就下的商品检查一下虚拟库存够不够
			if(p_9k!=null&&p_9k.getGdsmst_stocklinkty()!=null&&(p_9k.getGdsmst_stocklinkty().longValue()==1||p_9k.getGdsmst_stocklinkty().longValue()==2)){
				if(cart.getAmount().intValue()+CartItemHelper.getProductOccupyStock(p_9k.getId(), c.getSkuId())>ProductHelper.getVirtualStock(p_9k.getId(), c.getSkuId())){
					out.print("{\"error\":-2,\"message\":\"部分商品库存不足！修改失败！\"}");
					return;
				}
			}
		}
	}
}
float getshopactmoney=  CartHelper.getShopActCutMoney(request, response);
//总金额区域
float totalPrice = CartHelper.getTotalPayMoney(request,response);

StringBuilder totalMoneySb = new StringBuilder();
totalMoneySb.append("商品总计：<font style=\"font-size:13px; font-weight:bold;\" id=\"total_Count\">").append(CartHelper.getTotalProductCount(request,response)).append("</font>件");
if(getshopactmoney>0){ 
	totalMoneySb.append("&nbsp;&nbsp;优惠金额："+getshopactmoney +"元&nbsp;");
	} 
totalMoneySb.append("<font style=\"color:#d80100; font-size:16px; font-weight:bold; margin-left:30px;\">应付总额：<span id=\"total_Price\">").append(Tools.getFormatMoney(totalPrice)).append("</span>元</font>");



//初始化数据
goods_Map.put("goods_number",cart.getAmount());//物品数量
goods_Map.put("subtotal",cart.getMoney());//总价
goods_Map.put("delete_goods_key",delete_list);//删除的物品
goods_Map.put("tishi_delete_favor",deleteStr);//自动删除物品的提示
goods_Map.put("child_goods",child_List);
goods_Map.put("total_area",totalMoneySb.toString());//总金额的HTML代码
goods_Map.put("zengpin_area","");//赠品换购显示区域
goods_Map.put("favor_out_cart",new Integer(0));//赠品换购的数量
goods_Map.put("totalPrice",new Float(totalPrice));//购物车总金额
goods_Map.put("cart_type",cart.getType());
//会员价格
float oldPrice = Tools.floatValue(cart.getOldPrice())*Tools.longValue(cart.getAmount());
//goods_Map.put("oldPrice" , new Float(oldPrice));//会员价
//goods_Map.put("vipPrice" , new Float(Tools.floatValue(cart.getVipPrice())*Tools.longValue(cart.getAmount())));//VIP价
goods_Map.put("prefrePrice" , new Float(oldPrice - Tools.floatValue(cart.getMoney())));//优惠价格

//生成json
Map<String,Object> map = new HashMap<String,Object>();
map.put("error",new Integer(0));
map.put("message","");
map.put("content",goods_Map);
out.print(JSONObject.fromObject(map));
%>