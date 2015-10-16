<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%
//检查删除主物品的时候是否需要删除关联的物品。
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
Cart c = CartHelper.getById(keyArr[0]);

if(c == null){
	out.print("{\"error\":-1,\"content\":\"\"}");
	return;
}
//赠品和套餐类物品，不能删除
long type = Tools.longValue(c.getType());
if(Tools.longValue(c.getHasFather() , 0) == 1 || type==0){
	out.print("{\"error\":-1,\"content\":\"\"}");
	return;
}
//物品
Product pro = ProductHelper.getById(c.getProductId());

//查看该物品是否有子类
if(Tools.longValue(c.getHasChild())==1){//有
	StringBuilder sb = new StringBuilder();
	List<Cart> list = CartHelper.getCartItemsViaParentId(c.getId());
	if(list != null && !list.isEmpty()){
		for(Cart cart : list){
			Product product = ProductHelper.getById(cart.getProductId());
			if(product != null){
				sb.append("<br/><font>“</font>").append(product.getGdsmst_gdsname()).append("<font>”</font>");
			}
		}
	}
	//查看是否有全局赠品
	if(sb.length() > 0){
		sb.insert(0,"<font color='#CA0809'>您确定要删除该"+(type==-1?"组合":"商品")+"吗？以下物品也会随之删除！</font><span class='pop_info'>");
		sb.append("</span>");
		out.print("{\"error\":1,\"content\":\""+sb.toString()+"\"}");
	}else{
		out.print("{\"error\":0,\"content\":\"\"}");
	}
}else{
	//没有子类查看是否有全局的赠品
	out.print("{\"error\":0,\"content\":\"\"}");
}
%>