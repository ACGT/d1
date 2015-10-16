<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc//header.jsp"%><%@include file="/inc/islogin.jsp" %><%!
private static String MsgUrlTogo(String strMsg, String strUrl){
	StringBuilder stbScript = new StringBuilder();
	stbScript.append("<script type=\"text/javascript\">");
	stbScript.append("alert('").append(strMsg).append("!');");
	if(Tools.isNull(strUrl)) strUrl = PubConfig.get("HomePage");
	stbScript.append("location.href='").append(strUrl).append("';");
	stbScript.append("</script>");
	
	return stbScript.toString();
}

%><%
if(lUser==null) {
	out.print(MsgUrlTogo("请先登陆 ！","/login.jsp?url=/html/zt2012/wangyijh0112/wygift.jsp"));
	return;
}
	Product searchProduct = (Product)Tools.getManager(Product.class).get("01205253");
	if(searchProduct!=null){
		if (searchProduct.getGdsmst_validflag()==1){
			boolean blngds=true;
			ArrayList<Cart> cartList = CartHelper.getCartItems(request, response);	
			if(cartList!=null){
				for(Cart c123:cartList){
					if(c123.getType().longValue()==15&&c123.getProductId().equals("01205253")){
						blngds=false;
					}
				}
			}
			if(blngds){
			Cart cart =new Cart();
			cart.setAmount(new Long(1));
			cart.setCookie(CartHelper.getCartCookieValue(request, response));
			cart.setCreateDate(new Date());
			cart.setHasChild(new Long(0));
			cart.setHasFather(new Long(0));
			cart.setIp(request.getRemoteHost());
			cart.setMoney(new Float(0));
			cart.setOldPrice(new Float(0));
			cart.setPoint(new Long(0));
			cart.setPrice(new Float(0));
			cart.setSkuId("");
			cart.setTuanCode("");//注意parentId值
			cart.setProductId("01205253");
			cart.setType(new Long(15));
			cart.setUserId(CartHelper.getCartUserId(request, response));
			cart.setVipPrice(new Float(0));
			cart.setTitle("【网易刊赠品】"+searchProduct.getGdsmst_gdsname());
			Tools.getManager(Cart.class).create(cart);
			out.print(MsgUrlTogo("添加赠品 成功 ！","/flow.jsp"));
			return;
			}
			else{
				out.print(MsgUrlTogo("购物车已经添加过此赠品 ！","/flow.jsp"));
				return;
			}
		}
		else{
			out.print(MsgUrlTogo("赠品已经下架 ！","/flow.jsp"));
			return;
		}
	}
%>