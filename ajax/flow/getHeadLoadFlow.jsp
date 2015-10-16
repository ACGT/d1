<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%
//查看购物车中是否有物品，没有则跳转
//CartHelper.checkCartError(request,response);

//Map<String,Object> map = new HashMap<String,Object>();

List<Cart> list = CartHelper.getCartItems(request,response);
if(list == null || list.isEmpty()){
	out.print("<table><tr><td width=\"60px\" height=\"40\"></td><td width=\"250px\" align=\"center\">您的购物车中暂无商品!</td><td width=\"100px\"></td></tr></table><div class=\"area_info\"><div style=\"float:left;\"><span>购物车中有<em>"+CartHelper.getTotalProductCount(request, response)+"</em>件商品</span>&nbsp;&nbsp;金额总计：<em>￥00.00</em></div><a href=\"/flow.jsp\" target=_blank style=\"float:right; margin-right:10px; \"><img src=\"http://images.d1.com.cn/images2012/New/viewcart.gif\" style=\" vertical-align:middle;\"/></a></div>");
	return;
}
long totalGoods = 0;//物品总数
float totalPrice = 0f;//总金额
StringBuilder sb = new StringBuilder();
sb.append("<table>");
for(Cart cart : list){
	Product pro = ProductHelper.getById(cart.getProductId());
	if(pro == null) continue;
	long amount = Tools.longValue(cart.getAmount());//数量
	totalGoods += amount;
	float money = Tools.floatValue(cart.getMoney());//总计
	totalPrice += money;
	String smallimg=pro.getGdsmst_smallimg();
	if(!Tools.isNull(smallimg)){
		if(smallimg.startsWith("/shopimg/gdsimg")){
			smallimg = "http://images1.d1.com.cn"+smallimg.trim();
		}else{
			smallimg = "http://images.d1.com.cn"+smallimg.trim();
		}
		}
	sb.append("<tr><td width=\"60px\" height=\"60\" style=\"text-align:center\"><img src=\"").append(smallimg).append("\" width=\"50\" height=\"50\"></td>");
	sb.append("<td width=\"250px\"><a href=\"/product/").append(cart.getProductId()).append("\" target=\"_blank\">").append(pro.getGdsmst_gdsname()).append("</a></td>");
	sb.append("<td width=\"100px\" style=\"text-align:center\"><em>￥").append(Tools.getFormatMoney(Tools.floatValue(cart.getPrice()))).append("</em> x ").append(amount).append("</td>");
}
sb.append("</table>");
sb.append("<div class=\"area_info\"><div style=\"float:left;\"><span style=\"display:block; float:left;\">购物车中有<em id=\"headFlow_totalGoods\">").append(totalGoods).append("</em>件商品&nbsp;&nbsp;金额总计：<em>￥").append(Tools.getFormatMoney(totalPrice)).append("</em></span></div><a href=\"http://www.d1.com.cn/flow.jsp\" target=_blank style=\"float:right; margin-right:10px; \"><img src=\"http://images.d1.com.cn/images2012/New/viewcart.gif\" style=\" vertical-align:middle;\"/></a></div>");
out.print(sb.toString());
%>