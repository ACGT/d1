<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
String gdsidlist="01407682,01414912,01410269,01416566,01417246,01406371";
SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
String end="2013-02-25 00:00:00";
if(new Date().after(df.parse(end))){
	out.print("{\"code\":1,message:\"该活动已结束！\"}");
	return;
}
String productid=request.getParameter("id");
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}
if(Tools.isNull(productid)){
	out.print("{\"code\":1,message:\"参数不正确！\"}");
	return;
}
if(gdsidlist.indexOf(productid)<0){
	out.print("{\"code\":1,message:\"参数不正确！"+productid+"\"}");
	return;
}
Product product=ProductHelper.getById(productid);
if(product == null){
	out.print("{\"code\":1,message:\"很抱歉，您输入的信息不正确，请确认后重试！\"}");
	return;
}

//商品是否在架上
if(Tools.longValue(product.getGdsmst_validflag()) != 1){
	out.print("{\"code\":1,\"message\":\"对不起，您选购的商品现在暂时性脱销，请您过一段时间再来购买。\"}");
	return;
}
//缺货标识
long ifhaveges = Tools.longValue(product.getGdsmst_ifhavegds());
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
int countNum=1;
//量少提醒和卖完就下的商品检查一下虚拟库存够不够
if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
	int countInCart_1239 = CartHelper.getCartProductCount(request, response, product, skuId);//购物车里已经订购的数量
	if(countNum+countInCart_1239+CartItemHelper.getProductOccupyStock(product.getId(), skuId)>ProductHelper.getVirtualStock(product.getId(), skuId)){
		int i_239489 = ProductHelper.getVirtualStock(product.getId(), skuId)-CartItemHelper.getProductOccupyStock(product.getId(), skuId)-countInCart_1239;
		if(i_239489<=0){
			out.print("{\"code\":1,\"message\":\"您好！该商品已售完！\"}");
		}else{
			out.print("{\"code\":1,\"message\":\"您好！该商品只剩"+i_239489+"个！\"}");
		}
		return;
	}
}

	//直接加入购物车。，数量默认1.
	String count = request.getParameter("count");
	if(!Tools.isMath(count)) count = "1";
	else if(Long.parseLong(count) <= 0 || Long.parseLong(count) > 999) count = "1";
	String productname="";
	float ftuanprice=0;
	
	    if(product!=null){
	    productname=product.getGdsmst_gdsname().trim();
	    }
   ArrayList<Cart> cartList = CartHelper.getCartItems(request, response);	

	boolean hasOne = false ;
	String gid="";
	if(cartList!=null){
		for(Cart c123:cartList){
			if(c123.getType().longValue()==14 && (gdsidlist.indexOf(c123.getProductId())>=0)){
				gid=c123.getProductId();
				hasOne = true ;
				break;
			}
		}
	}
	
	if(hasOne){
		if(productid.equals(gid)){
			out.print("{\"code\":1,message:\"您的购物车已加入此商品！\"}");
			return;
		}else{
			out.print("{\"code\":1,message:\"此专区商品每个订单限抢一个！\"}");
			return;
		}
		
	}
	String start="2013-01-16 00:00:00";

	long n1 = df.parse(start).getTime();
	long n2 = df.parse(df.format(new Date())).getTime();
	long diff = Math.abs(n2 - n1);

	diff /= 3600 * 1000 * 24;
	if(diff<=0){
		diff=1;
	}
	float price=0f;
	if("01407682".equals(productid)){
		price=30f;
	}else if("01414912".equals(productid) ){
		price=45f;
	}else if("01410269".equals(productid) ){
		price=39f;
	}
	else if("01416566".equals(productid) ){
		price=50f;
	}else if("01417246".equals(productid) ){
		price=29f;
	}else if("01406371".equals(productid) ){
		price=75f;
	}
	price=price+diff-1;
	if(price==0){
		out.print("{\"code\":1,message:\"很抱歉，您输入的信息不正确，请确认后重试！\"}");
		return;
	}
	//放入购物车

	
	Cart cart =new Cart();
	cart.setAmount(new Long(1));
	cart.setCookie(CartHelper.getCartCookieValue(request, response));
	cart.setCreateDate(new Date());
	cart.setHasChild(new Long(0));
	cart.setHasFather(new Long(0));
	cart.setIp(request.getRemoteHost());
	cart.setMoney(Tools.getFloat(price, 2));
	cart.setPrice(Tools.getFloat(price, 2));
	cart.setOldPrice(product.getGdsmst_memberprice());
	cart.setVipPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.VIP_DISCOUNT,2));
	cart.setSkuId(skuId);
	cart.setTuanCode("");//注意parentId值
	cart.setProductId(productid);
	cart.setType(new Long(14));
	cart.setUserId(CartHelper.getCartUserId(request, response));
	cart.setVipPrice(new Float(0));
	cart.setTitle("【化妆品疯狂购】"+productname);
	Tools.getManager(Cart.class).create(cart);
	//response.sendRedirect("/flow.jsp");
	//return;
	int totalCount = CartHelper.getTotalProductCount(request,response);
		float totalAmmount = CartHelper.getTotalPayMoney(request,response);
		out.print("{\"code\":0,\"message\":\"\",\"totalCount\":"+totalCount+",\"totalAmount\":\""+Tools.getFormatMoney(totalAmmount)+"\"}");
		return;

%>