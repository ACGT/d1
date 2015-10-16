<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!

private int getTuandhLength(String strgdsid,String mbrid){
	ArrayList<Tuandh> list=new ArrayList<Tuandh>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("tuandh_gdsid", strgdsid));
	clist.add(Restrictions.eq("tuandh_status", new Long(2)));
	clist.add(Restrictions.eq("tuandh_mbrid", new Long(mbrid)));
	clist.add(Restrictions.eq("tuandh_mid", new Long(4)));
	clist.add(Restrictions.gt("tuandh_endtime", new Date()));
	return Tools.getManager(Tuandh.class).getLength(clist);
	
}
%>
<%
String strgdsdh_code = request.getParameter("cardno");
String strgdsdh_giftgds = request.getParameter("giftgds");
String zpsku=request.getParameter("zpsku");
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}
if(strgdsdh_code!=null&&!strgdsdh_code.startsWith("mq139yj140522a")&&!strgdsdh_code.startsWith("mq139yj1406a")){
	out.print("{\"code\":1,message:\"兑换码错误请从新输入！\"}");
	return;
}
Tuandh tuandh=(Tuandh)Tools.getManager(Tuandh.class).findByProperty("tuandh_cardno", strgdsdh_code);
if(tuandh==null){
	out.print("{\"success\":false,message:\"该兑换码不存在！\"}");
	return;
}
if(tuandh.getTuandh_status().longValue()==2){
	out.print("{\"success\":false,message:\"该兑换码已经兑换过！\"}");
	return;
}
if(Tools.dateValue(tuandh.getTuandh_endtime())<System.currentTimeMillis())
{
	out.print("{\"success\":false,message:\"该兑换活动已经结束！\"}");
	return;
}
String gdsid = request.getParameter("gdsid");
Product product = ProductHelper.getById(gdsid);
if(product == null){
	out.print("{\"success\":false,message:\"很抱歉，您输入的信息不正确，请确认后重试！\"}");
	return;
}

//商品是否在架上
if(Tools.longValue(product.getGdsmst_validflag()) != 1&&Tools.longValue(product.getGdsmst_validflag()) != 4){
	out.print("{\"success\":false,\"message\":\"对不起，您选购的商品现在暂时性脱销，请您过一段时间再来购买。\"}");
	return;
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
		out.print("{\"success\":false,message:\""+message+"\"}");
		return;
	}
	if(!SkuHelper.hasInSkuList(product , skuId)){
		out.print("{\"success\":false,message:\"请您选择颜色和尺码。\"}");
		return;
	}
}else{
	skuId = null;
}
//赠品
if (!Tools.isNull(strgdsdh_giftgds) && Tools.isNull(zpsku)){
	out.print("{\"success\":false,message:\"请选择赠品颜色。\"}");
	return;
}
//不存在SKU则直接加入购物车，但是需要判断购物车中是否有这件物品。
//if(false && t==0){
//	out.print("{\"success\":false,\"message\":\"\"}");
//	return;
//}else{
	//直接加入购物车。，数量默认1.

	if(!"01205775".equals(tuandh.getTuandh_gdsid().trim())){
		out.print("{\"code\":1,message:\"兑换商品错误！\"}");
		return;
	}
	
	ArrayList<Cart> cartList = CartHelper.getCartItems(request, response);	
	boolean hasOne = false ;
	if(cartList!=null){
		for(Cart c123:cartList){
			if(strgdsdh_code.equals(c123.getTuanCode())){
				hasOne = true ;
				break;
			}
			}
		}
	if(hasOne){
		out.print("{\"code\":1,message:\"此兑换码已经放入购物车！\"}");
		return;
	}
	if(tuandh.getTuandh_mid()!=47){
		out.print("{\"code\":1,message:\"此兑换码错误！\"}");
		return;
	}
	
	//量少提醒和卖完就下的商品检查一下虚拟库存够不够
	/*if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
		int countInCart_1239 = CartHelper.getCartProductCount(request, response, product, skuId);//购物车里已经订购的数量
		if(1+countInCart_1239+CartItemHelper.getProductOccupyStock(product.getId(), skuId)>ProductHelper.getVirtualStock(product.getId(), skuId)){
			int i_239489 = ProductHelper.getVirtualStock(product.getId(), skuId)-CartItemHelper.getProductOccupyStock(product.getId(), skuId)-countInCart_1239;
			if(i_239489<=0){
				out.print("{\"code\":1,\"message\":\"您好！该商品已售完！\"}");
			}else{
				out.print("{\"code\":1,\"message\":\"您好！该商品只剩"+i_239489+"个！\"}");
			}
			return;
		}
	}
	*/
	float ftuanprice=0;
	Cart cart = new Cart();
	cart.setAmount(new Long(1));
	cart.setCookie(CartHelper.getCartCookieValue(request, response));
	cart.setCreateDate(new Date());
	cart.setHasChild(new Long(0));
	cart.setHasFather(new Long(0));
	cart.setIp(request.getRemoteHost());
	cart.setMoney(Tools.getFloat(new Float(ftuanprice),2));
	cart.setOldPrice(Tools.getFloat(new Float(ftuanprice),2));
	cart.setPoint(new Long(0));
	cart.setPrice(Tools.getFloat(new Float(ftuanprice),2));
	cart.setSkuId(skuId);//?
	cart.setTuanCode(strgdsdh_code);//注意parentId值
	cart.setProductId(gdsid);
	cart.setType(new Long(13));
	cart.setUserId(CartHelper.getCartUserId(request, response));
	cart.setVipPrice(Tools.getFloat(new Float(ftuanprice),2));
	cart.setTitle("【"+tuandh.getTuandh_title()+"】"+Tools.clearHTML(product.getGdsmst_gdsname()));
	
	Tools.getManager(Cart.class).create(cart);
	/*加19元包邮可以获得原价39元的 02103359  【红门鞋业】夏季新款人字拖鞋波西米亚风格
	 
	加29元包邮可以获得原价59元的 01517871  NARY 耐瑞 时尚情侣简约手表
	 
	加39元包邮可以获得原价59元的 01519320 【香港集福轩】天然西瓜晶/碧玺108颗*6mm佛珠手链 +六字真言
	 
	加59元包邮可以获得原价79元的 03100864【MUDIYU 木低语】MUDIYU男士休闲凉鞋917
	*/
	if (!Tools.isNull(strgdsdh_giftgds)){
		float ftuanprice2=0f;
		String gdstitle="";
		String shopcode="00000000";
         if(strgdsdh_giftgds.equals("02103359")){
        	 ftuanprice2=29f;
        	 gdstitle="【红门鞋业】夏季新款人字拖鞋波西米亚风格";
         }else  if(strgdsdh_giftgds.equals("01517871")){
        	 ftuanprice2=39f;
        	 gdstitle="NARY 耐瑞 时尚情侣简约手表";
         }else  if(strgdsdh_giftgds.equals("01519320")){
        	 ftuanprice2=49f;
        	 gdstitle="【香港集福轩】天然西瓜晶/碧玺108颗*6mm佛珠手链 +六字真言";
         }else  if(strgdsdh_giftgds.equals("01519290")){
        	 ftuanprice2=69f;
        	 gdstitle="【YOUSOO】景泰蓝手镯韩版镂空珐琅镀金手镯(彩色)";
         }
        	 
		if(ftuanprice2>0f){
		Cart cart2 = new Cart();
		cart2.setAmount(new Long(1));
		cart2.setCookie(CartHelper.getCartCookieValue(request, response));
		cart2.setCreateDate(new Date());
		cart2.setHasChild(new Long(0));
		cart2.setHasFather(new Long(0));
		cart2.setIp(request.getRemoteHost());
		cart2.setMoney(Tools.getFloat(new Float(ftuanprice2),2));
		cart2.setOldPrice(Tools.getFloat(new Float(ftuanprice2),2));
		cart2.setPoint(new Long(0));
		cart2.setPrice(Tools.getFloat(new Float(ftuanprice2),2));
		cart2.setSkuId(zpsku);//?
		cart2.setTuanCode("");//注意parentId值
		cart2.setProductId(strgdsdh_giftgds);
		cart2.setType(new Long(14));
		cart2.setUserId(CartHelper.getCartUserId(request, response));
		cart2.setVipPrice(Tools.getFloat(new Float(ftuanprice2),2));
		cart2.setTitle(gdstitle);
		cart2.setShopcode(shopcode);
		
		Tools.getManager(Cart.class).create(cart2);
		}
		}
		tuandh.setTuandh_status(new Long(1));
		tuandh.setTuandh_yztime(new Date());
		tuandh.setTuandh_mbrid(new Long(lUser.getId()));
		Tools.getManager(Tuandh.class).update(tuandh, false);
	
		//获得购物车总金额和总商品数量
		int totalCount = CartHelper.getTotalProductCount(request,response);
		float totalAmmount = CartHelper.getTotalPayMoney(request,response);
		String cardimg="http://images.d1.com.cn/market/1405/"+gdsid+"_"+skuId.trim()+".jpg";
		String color="";
		Sku sku=SkuHelper.getById(skuId);
		if(sku!=null){
			color=sku.getSkumst_sku1();
		}
		String pname="【予扬】笔记本冰垫 夏季水垫 汽车冰垫 多功能坐垫椅垫座垫（"+color+"）";
		out.print("{\"success\":true,\"message\":\"添加成功！\",\"cardimg\":\""+cardimg+"\",\"pname\":\""+pname+"\"}");
		return;
//}
%>