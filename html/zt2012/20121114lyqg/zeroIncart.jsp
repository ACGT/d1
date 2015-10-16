<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!private static int Exits(String mbrid)
{
	int result=0;
     ArrayList<BuyLimitDtl> bldlist=new ArrayList<BuyLimitDtl>();
     List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
     clist.add(Restrictions.ge("gdsbuyonedtl_mstid",new Long(72)));
     clist.add(Restrictions.le("gdsbuyonedtl_mstid",new Long(88)));
     clist.add(Restrictions.eq("gdsbuyonedtl_mbrid",new Long(mbrid)));
    
	 List<BaseEntity> blist=Tools.getManager(BuyLimitDtl.class).getList(clist, null, 0, 10);
     if(blist!=null&&blist.size()>0)
     {
    	 for(BaseEntity be:blist)
    	 {
    		 if(be!=null){
    		    BuyLimitDtl bld=(BuyLimitDtl)be;
    		    String gdsidlist="01721296,02000798,01417340,01205265,01721267,01516298,01517339,01517367,01417341,01515298,01512603,01417192,01516654,01517413,01205266,01512449,01517439";
    		    if(bld.getGdsbuyonedtl_gdsid()!=null&& gdsidlist.indexOf(bld.getGdsbuyonedtl_gdsid())>=0){
    		    	result++;
    		    	
    		    }
    		 }
    	 }
     }
     return result;
} %>
<%
String gdsidlist="01721296,02000798,01417340,01205265,01721267,01516298,01517339,01517367,01417341,01515298,01512603,01417192,01516654,01517413,01205266,01512449,01517439";
SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
String end="2012-12-31 00:00:00";
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
	out.print("{\"code\":1,message:\"参数不正确！\"}");
	return;
}
Product product=ProductHelper.getById(productid);
if(product == null){
	out.print("{\"code\":1,message:\"很抱歉，您输入的信息不正确，请确认后重试！\"}");
	return;
}
int results=Exits(lUser.getId());
if(results>0)
{
	out.print("{\"code\":1,\"message\":\"对不起，您已经参加过活动！\"}");
	return;
}
//商品是否在架上
if(Tools.longValue(product.getGdsmst_validflag()) != 1){
	out.print("{\"code\":1,\"message\":\"对不起，您选购的商品现在暂时性脱销，请您过一段时间再来购买。\"}");
	return;
}
//缺货标识
long ifhaveges = Tools.longValue(product.getGdsmst_ifhavegds());
if(ifhaveges == 3){
	out.print("{\"code\":1,\"message\":\"您好！此商品为非卖品，不能单独订购！\"}");
	return;
}
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
			out.print("{\"code\":1,message:\"该活动的商品您只能免费领取一件\"}");
			return;
		}
		
	}
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
	cart.setSkuId(skuId);
	cart.setTuanCode("");//注意parentId值
	cart.setProductId(productid);
	cart.setType(new Long(14));
	cart.setUserId(CartHelper.getCartUserId(request, response));
	cart.setVipPrice(new Float(0));
	cart.setTitle("【0元领取】"+productname);
	Tools.getManager(Cart.class).create(cart);
	//response.sendRedirect("/flow.jsp");
	//return;
	int totalCount = CartHelper.getTotalProductCount(request,response);
		float totalAmmount = CartHelper.getTotalPayMoney(request,response);
		out.print("{\"code\":0,\"message\":\"\",\"totalCount\":"+totalCount+",\"totalAmount\":\""+Tools.getFormatMoney(totalAmmount)+"\"}");
		return;

%>