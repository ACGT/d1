<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
 static ArrayList<TaiLi2012> getexist(String cardno){
	ArrayList<TaiLi2012> rlist = new ArrayList<TaiLi2012>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("taili2012_cardno",cardno));
	List<BaseEntity> list = Tools.getManager(TaiLi2012.class).getList(clist, null, 0, 1);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((TaiLi2012)be);
	}
	return rlist ;
}
%><%
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
Date dStartDate=null;
try{
	   	 dStartDate =fmt.parse("2013-02-01");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print("{\"code\":1,message:\"该台历券兑换已经过期！\"}");
	return;
}
String tailino=request.getParameter("tailino");
String gdsid=request.getParameter("id");

if(Tools.isNull(gdsid)){
	out.print("{\"code\":1,message:\"参数错误！\"}");	
	return;
}
if(!"01721234".equals(gdsid) && !"01415776".equals(gdsid)){
	out.print("{\"code\":1,message:\"参数错误！\"}");	
	return;
}
Product product=ProductHelper.getById(gdsid);
if(product==null){
	out.print("{\"code\":1,message:\"参数错误！\"}");	
	return;
}

ArrayList<Cart> cartList = CartHelper.getCartItems(request, response);	

boolean hasOne = false ;
if(cartList!=null){
	for(Cart c123:cartList){
		if(c123.getType().longValue()==14&& (c123.getProductId().equals("01721234") ||c123.getProductId().equals("01415776") )){
			hasOne = true ;
			break;
		}
	}
}

if(hasOne){
	out.print("{\"code\":1,message:\"一个订单最多只能有一个台历活动商品！\"}");	
	return;
}
if(Tools.isNull(tailino)){
	out.print("{\"code\":1,message:\"请输入台历号！\"}");	
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
	ArrayList<TaiLi2012> list=getexist(tailino);
	if(list!=null && list.size()>0){
		TaiLi2012 tl=list.get(0);
		//台历号正确记录session
		//session.setAttribute("tlcode", tailino);
		if(tl.getTaili2012_status().longValue()==1){
			out.print("{\"code\":1,message:\"您已参加过该月份的台历活动！\"}");	
			return;
		}
		
		Cart cart = new Cart();
		cart.setParentId("0");
		cart.setSkuId(skuId);
		cart.setAmount(new Long(1));//数量
		cart.setProductId(gdsid);
		cart.setMoney(Tools.getFloat(0, 2));
		cart.setPrice(Tools.getFloat(0, 2));
		cart.setOldPrice(product.getGdsmst_memberprice());
		cart.setVipPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.VIP_DISCOUNT,2));
		cart.setType(new Long(14));
		cart.setTitle("【台历1月份活动】"+product.getGdsmst_gdsname());
		cart.setShopcode(product.getGdsmst_shopcode());
		cart.setGiftType(tailino);
		CartHelper.addCart(request,response,cart);

		int totalCount = CartHelper.getTotalProductCount(request,response);
		float totalAmmount = CartHelper.getTotalPayMoney(request,response);
		out.print("{\"code\":0,\"message\":\"\",\"totalCount\":"+totalCount+",\"totalAmount\":\""+Tools.getFormatMoney(totalAmmount)+"\"}");
		return;
	}else{
		out.print("{\"code\":1,message:\"台历号输入错误，请输入台历号_1！\"}");
	}
	return;

%>