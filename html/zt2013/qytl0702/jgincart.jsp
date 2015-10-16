<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!
private static int Exits(String mbrid)
{
	int result=0;
     ArrayList<BuyLimitDtl> bldlist=new ArrayList<BuyLimitDtl>();
     List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
     clist.add(Restrictions.ge("gdsbuyonedtl_mstid",new Long(96)));
     clist.add(Restrictions.le("gdsbuyonedtl_mstid",new Long(97)));
     clist.add(Restrictions.eq("gdsbuyonedtl_mbrid",new Long(mbrid)));
     SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
     SimpleDateFormat df3=new SimpleDateFormat("yyyy-MM-dd");
     String stime="2013-07-1 00:00:00";
     String etime ="2013-07-31 23:59:59";
     try {
    	 Date starttime=df2.parse(stime); 
	     Date endtime=df2.parse(etime);
	     clist.add(Restrictions.ge("gdsbuyonedtl_createtime", starttime));
	     clist.add(Restrictions.le("gdsbuyonedtl_createtime", endtime));

     } catch (ParseException e) {
    	   e.printStackTrace();
     }
	 List<BaseEntity> blist=Tools.getManager(BuyLimitDtl.class).getList(clist, null, 0, 10);
     if(blist!=null&&blist.size()>0)
     {
    	 for(BaseEntity be:blist)
    	 {
    		 if(be!=null){
    		    BuyLimitDtl bld=(BuyLimitDtl)be;
   
    		    if(bld.getGdsbuyonedtl_gdsid()!=null){
                    result++;
    		    }
    		 }
    	 }
     }
     return result;
}
%>
<%
SimpleDateFormat   df=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
String end="2013-08-1 00:00:00";
if(df.parse(end).before(new Date())){
	out.print("{\"code\":1,\"message\":\"该活动已结束！\"}");
	return;
}
String sessioncard="";
if(session.getAttribute("tlcardno")!=null){
	sessioncard=session.getAttribute("tlcardno").toString();
}
if(Tools.isNull(sessioncard)){
	out.print("{\"code\":1,\"message\":\"请先激活台历号后再来购物！\"}");
	return;
}
Tuandh tuandh=null;
tuandh=(Tuandh)Tools.getManager(Tuandh.class).findByProperty("tuandh_cardno", sessioncard);
if(tuandh!=null){
	if (tuandh.getTuandh_mid().longValue()!=5){
		out.print("{\"code\":1,\"message\":\"请先激活台历号后再来购物！\"}");
		return;
	}
	if(tuandh.getTuandh_status().longValue()==2){
		out.print("{\"code\":1,message:\"该台历号已经用过或商品已经放入购物车！\"}");
		return;
	}
}else{
	out.print("{\"code\":1,\"message\":\"请先激活台历号后再来购物！\"}");
	return;
}
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>Login_Dialog();<%
	return;
}

String gdsid = request.getParameter("id");//商品编号
Product product = ProductHelper.getById(gdsid);

if(product == null){
	out.print("{\"code\":1,\"message\":\"商品不存在，请刷新页面！\"}");
	return;
}
String gdslist="01414170,01416654,01416653,01517056,03000521,01721329,01512603,01714283,01721331";
if(gdslist.indexOf(gdsid)==-1){
	out.print("{\"code\":1,message:\"兑换商品错误！\"}");
	return;
}

//商品数量
int iCount = 1;
//request.getParameter("count")!=null&&request.getParameter("count").length()>0?Tools.parseInt(request.getParameter("count")):0;
//if(iCount <= 0) iCount = 1;

//商品是否在架上
if(Tools.longValue(product.getGdsmst_validflag()) != 1){
	out.print("{\"code\":1,\"message\":\"对不起，您选购的商品现在暂时性脱销，请您过一段时间再来购买。\"}");
	return;
}
//缺货标识
long ifhaveges = Tools.longValue(product.getGdsmst_ifhavegds());
//if(ifhaveges == 3){
	//out.print("{\"code\":1,\"message\":\"您好！此商品为非卖品，不能单独订购！\"}");
	//return;
//}
if(ifhaveges == 2){
	out.print("{\"code\":1,\"message\":\"对不起，此商品暂时缺货！\"}");
	return;
}

ArrayList<Cart> allCartList = CartHelper.getCartItems(request, response);
if(product.getGdsmst_buylimit()!=null&&product.getGdsmst_buylimit().intValue()>0){	
	int cartCount = 0;
	if(allCartList!=null){
		for(Cart c_23894:allCartList){
			if(product.getId().equals(c_23894.getProductId())){
				cartCount+=c_23894.getAmount().intValue();
			}
		}
	}
	if(cartCount+iCount>product.getGdsmst_buylimit().intValue()){
		out.print("{\"code\":1,\"message\":\"对不起，该商品限购"+product.getGdsmst_buylimit().intValue()+"个！\"}");
		return;
	}
}
int results=Exits(lUser.getId());
if(results>0)
{
	out.print("{\"code\":1,\"message\":\"对不起，您已经参加过活动！\"}");
	return;
}

if(allCartList!=null){
	for(Cart c_23894:allCartList){
		//if(product.getId().equals(c_23894.getProductId())&&c_23894.getType().longValue()==14){
			if(c_23894.getType().longValue()==14){
			out.print("{\"code\":1,\"message\":\"对不起，您已经抢购过商品！\"}");
			return;
		}
	}
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


//量少提醒和卖完就下的商品检查一下虚拟库存够不够
if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
	int countInCart_1239 = CartHelper.getCartProductCount(request, response, product, skuId);//购物车里已经订购的数量
	if(iCount+countInCart_1239+CartItemHelper.getProductOccupyStock(product.getId(), skuId)>ProductHelper.getVirtualStock(product.getId(), skuId)){
		int i_239489 = ProductHelper.getVirtualStock(product.getId(), skuId)-CartItemHelper.getProductOccupyStock(product.getId(), skuId)-countInCart_1239;
		if(i_239489<=0){
			out.print("{\"code\":1,\"message\":\"您好！该商品已售完！\"}");
		}else{
			out.print("{\"code\":1,\"message\":\"您好！该商品只剩"+i_239489+"个！\"}");
		}
		return;
	}
}
//判断促销语的问题
String promotionword = product.getGdsmst_promotionword();//促销语句
if(!Tools.isNull(promotionword)){
	long today = System.currentTimeMillis();
	Date promotionStart = product.getGdsmst_promotionstart();//促销开始时间
	Date promotionEnd = product.getGdsmst_promotionend();//促销结束时间
	if(today < (promotionStart != null?promotionStart.getTime():0) || today > (promotionEnd !=null?promotionEnd.getTime():0)){
		promotionword = "";
	}
}
//判断物品的促销方式
String sltDiscID =request.getParameter("sltDiscID");
int iDiscid = -1;//促销方式的ID
if(Tools.isMath(sltDiscID)){
	iDiscid = Integer.parseInt(sltDiscID);
}

//商品价格
float memberprice = Tools.floatValue(product.getGdsmst_memberprice());//会员价
float vipprice = Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.VIP_DISCOUNT,2);//vip价


float price=1f;

//放入购物车
Cart cart = new Cart();
cart.setParentId("0");
cart.setSkuId(skuId);
cart.setAmount(new Long(iCount));//数量
cart.setProductId(gdsid);
cart.setMoney(Tools.getFloat(price, 2));
cart.setPrice(Tools.getFloat(price, 2));
cart.setOldPrice(product.getGdsmst_memberprice());
cart.setVipPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.VIP_DISCOUNT,2));
cart.setType(new Long(14));
cart.setTitle("【台历兑换商品】"+product.getGdsmst_gdsname());
cart.setShopcode(product.getGdsmst_shopcode());
CartHelper.addCart(request,response,cart);

tuandh.setTuandh_status(new Long(2));
tuandh.setTuandh_mbrid(new Long(lUser.getId()));
tuandh.setTuandh_dhtime(new Date());
Tools.getManager(Tuandh.class).update(tuandh, false);

int totalCount = CartHelper.getTotalProductCount(request,response);
float totalAmmount = CartHelper.getTotalPayMoney(request,response);
out.print("{\"code\":0,\"message\":\"\",\"totalCount\":"+totalCount+",\"totalAmount\":\""+Tools.getFormatMoney(totalAmmount)+"\"}");
return;
%>