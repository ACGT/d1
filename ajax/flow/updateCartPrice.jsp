<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!
static void updateCartPrice(HttpServletRequest request,HttpServletResponse response,Cart cart){
	if(UserHelper.isPtVip(request, response)){
		if(cart.getType().longValue()==1||cart.getType().longValue()==10){//正常商品重新计算会员价格
			String productId = cart.getProductId();
			Product product = (Product)Tools.getManager(Product.class).get(productId);
			if(product!=null&&cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue()*Const.PT_VIP_DISCOUNT,2)){
				//白金会员价格要打95折,白金价格=会员价*0.95
				cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue()*Const.PT_VIP_DISCOUNT,2));
				cart.setIp(request.getRemoteHost());
				cart.setPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.PT_VIP_DISCOUNT,2));
				Tools.getManager(Cart.class).update(cart, false);
			}
		}
	}else if(UserHelper.isVip(request, response)){//如果是VIP会员
		if(cart.getType().longValue()==1||cart.getType().longValue()==10){//正常商品重新计算会员价格
			String productId = cart.getProductId();
			Product product = (Product)Tools.getManager(Product.class).get(productId);
			if(product!=null&&cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue()*Const.VIP_DISCOUNT,2)){
				//白金会员价格要打95折,白金价格=会员价*0.95
				cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue()*Const.VIP_DISCOUNT,2));
				cart.setIp(request.getRemoteHost());
				cart.setPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.VIP_DISCOUNT,2));
				Tools.getManager(Cart.class).update(cart, false);
			}
		}
	}else{//普通会员或者未登录状态
		//System.out.print("qqqqqqqqqqqqqqqqqqqqqq");
		if(cart.getType().longValue()==1||cart.getType().longValue()==10){//正常商品重新计算会员价格
			String productId = cart.getProductId();
			Product product = (Product)Tools.getManager(Product.class).get(productId);
			
			if(product!=null&&cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue(),2)){
				//如果购物车里的价格不是会员价，修改之
				cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue(),2));
				cart.setIp(request.getRemoteHost());
				cart.setPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue(),2));
				Tools.getManager(Cart.class).update(cart, false);
			}
		}
	}
}
%>
<%
ArrayList<Cart> carts =CartHelper. getCartItems(request,response);
if(carts==null||carts.size()==0){
	out.print("0");
	return;
}
int k=0;
for(int i=0;i<carts.size();i++){
	Cart cart = carts.get(i);
	if(cart.getType().longValue()==9){
		String dxid = "160";
		if(!Tools.isNull(dxid)){
			ProductExpPriceItem expitem = ProductExpPriceHelper.getExpPrice(cart.getProductId(),dxid);
			if(expitem != null){
				Tools.setCookie(response,"rcmdusr_rcmid","",-1);
				Cookie rcmdusr_rcmid = new Cookie("rcmdusr_rcmid", null);
				rcmdusr_rcmid.setPath("/");
				rcmdusr_rcmid.setMaxAge(0);//直接过期
				response.addCookie(rcmdusr_rcmid);
				
				String title=cart.getTitle();
				Product product=ProductHelper.getById(cart.getProductId());
				if(product!=null){
					title=Tools.clearHTML(product.getGdsmst_gdsname());
				}
				cart.setTitle(title);
				cart.setType(new Long(1));
				if(Tools.getManager(Cart.class).update(cart, true)){
					updateCartPrice(request,response,cart);
					k++;
				}
				
			}
		}
		
	}
	
}
out.print(k+"");
%>
