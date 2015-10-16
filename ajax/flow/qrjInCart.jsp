<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
static ArrayList<BuyLimit> getBuyLimit(String gdsid){
	ArrayList<BuyLimit> rlist = new ArrayList<BuyLimit>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsbuyonemst_gdsid", gdsid));
	clist.add(Restrictions.le("gdsbuyonemst_starttime", new Date()));
	clist.add(Restrictions.ge("gdsbuyonemst_endtime", new Date()));
	//加入排序条件
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("gdsbuyonemst_createtime"));
	
	List<BaseEntity> list = Tools.getManager(BuyLimit.class).getList(clist, olist, 0, 100);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((BuyLimit)be);
	}
	return rlist ;
}
static ArrayList<BuyLimit> getBuyLimit2(String gdsid){
	ArrayList<BuyLimit> rlist = new ArrayList<BuyLimit>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsbuyonemst_gdsid", gdsid));
	
	List<BaseEntity> list = Tools.getManager(BuyLimit.class).getList(clist, null, 0, 100);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((BuyLimit)be);
	}
	return rlist ;
}
static ArrayList<BuyLimitDtl> getBuyLimitDtl(String mainid,String gdsid,String mbrid){
	ArrayList<BuyLimitDtl> rlist = new ArrayList<BuyLimitDtl>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsbuyonedtl_mstid", new Long(mainid)));
	clist.add(Restrictions.eq("gdsbuyonedtl_gdsid", gdsid));
	clist.add(Restrictions.eq("gdsbuyonedtl_mbrid",new Long(mbrid)));
	
	List<BaseEntity> list = Tools.getManager(BuyLimitDtl.class).getList(clist, null, 0, 100);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((BuyLimitDtl)be);
	}
	return rlist ;
}
%>
<%
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}
String strgdsidOne="01720204";
String oldproduct="01719683";
ArrayList<BuyLimit> limitlist= getBuyLimit(strgdsidOne);
if(limitlist==null || limitlist.size()==0){
	out.print("{\"code\":1,message:\"对不起，该活动不在活动范围内！\"}");
	return;
}else{
	ArrayList<BuyLimit> limitlist2= getBuyLimit2(oldproduct);
	if(limitlist2!=null){
		for(BuyLimit limit2: limitlist2){
			ArrayList<BuyLimitDtl> list= getBuyLimitDtl(limit2.getId(),limit2.getGdsbuyonemst_gdsid().trim(),lUser.getId());
			if(list!=null && list.size()>0){
				out.print("{\"code\":1,message:\"对不起，您已领取过该商品！\"}");
				return;
			}
		}
	}
	for(BuyLimit limit :limitlist){
		ArrayList<BuyLimitDtl> list= getBuyLimitDtl(limit.getId(),limit.getGdsbuyonemst_gdsid().trim(),lUser.getId());
		int limitcount=limit.getGdsbuyonemst_count().intValue();
		if(list!=null){
			if(list.size()>=limitcount){
				out.print("{\"code\":1,message:\"对不起，您已领取过该商品！\"}");
				return;
			}
		}
	}
	
}
//检查购物车

	//直接加入购物车。，数量默认1.
	String count = request.getParameter("count");
	if(!Tools.isMath(count)) count = "1";
	else if(Long.parseLong(count) <= 0 || Long.parseLong(count) > 999) count = "1";
	String productname="";
	float ftuanprice=0;

    Product product=ProductHelper.getById(strgdsidOne);
    if(product!=null){
    	productname=product.getGdsmst_gdsname().trim();
    }
	
	ArrayList<Cart> cartList = CartHelper.getCartItems(request, response);	

	boolean hasOne = false ;
	if(cartList!=null){
		for(Cart c123:cartList){
			if(c123.getType().longValue()==14&&c123.getProductId().equals(strgdsidOne)){
				hasOne = true ;
				break;
			}
		}
	}
	
	if(hasOne){
		out.print("{\"code\":1,message:\"您的购物车已加入此商品！\"}");
		return;
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
	cart.setSkuId("");
	cart.setTuanCode("");//注意parentId值
	cart.setProductId(strgdsidOne);
	cart.setType(new Long(14));
	cart.setUserId(CartHelper.getCartUserId(request, response));
	cart.setVipPrice(new Float(0));
	cart.setTitle("【情人节礼物】"+productname);
	Tools.getManager(Cart.class).create(cart);
	//response.sendRedirect("/flow.jsp");
	//return;
	int totalCount = CartHelper.getTotalProductCount(request,response);
		float totalAmmount = CartHelper.getTotalPayMoney(request,response);
		out.print("{\"code\":0,\"message\":\"\",\"totalCount\":"+totalCount+",\"totalAmount\":\""+Tools.getFormatMoney(totalAmmount)+"\"}");
		return;

%>