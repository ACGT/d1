<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="../islogin.jsp" %>
<%!
    private static int getAllCount(String gdsid)
    {
	     ArrayList<BuyLimitDtl> bldlist=new ArrayList<BuyLimitDtl>();
	     List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	     clist.add(Restrictions.eq("gdsbuyonedtl_gdsid", gdsid));
	     SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	     SimpleDateFormat df3=new SimpleDateFormat("yyyy-MM-dd");
	     String stime=df3.format(new Date())+" 00:00:00";
	     String etime =df3.format(new Date())+" 23:59:59";
	     try {
	    	 Date starttime=df2.parse(stime); 
		     Date endtime=df2.parse(etime);
		     clist.add(Restrictions.ge("gdsbuyonedtl_createtime", starttime));
		     clist.add(Restrictions.le("gdsbuyonedtl_createtime", endtime));

	     } catch (ParseException e) {
	    	   e.printStackTrace();
	     }
	     List<BaseEntity> blist=Tools.getManager(BuyLimitDtl.class).getList(clist, null, 0, 100);
	     if(blist!=null&&blist.size()>0)
	     {
	    	 return blist.size();
	     }
	     return 0;
    }
private static int Exits(String mbrid)
{
	int result=0;
     ArrayList<BuyLimitDtl> bldlist=new ArrayList<BuyLimitDtl>();
     List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
     clist.add(Restrictions.ge("gdsbuyonedtl_mstid",new Long(62)));
     clist.add(Restrictions.le("gdsbuyonedtl_mstid",new Long(65)));
     clist.add(Restrictions.eq("gdsbuyonedtl_mbrid",new Long(mbrid)));
     SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
     SimpleDateFormat df3=new SimpleDateFormat("yyyy-MM-dd");
     String stime="2012-09-12 00:00:00";
     String etime ="2012-09-28 23:59:59";
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
    		    if(bld.getGdsbuyonedtl_gdsid()!=null&&(bld.getGdsbuyonedtl_gdsid().equals("02103005")||bld.getGdsbuyonedtl_gdsid().equals("02103004")||bld.getGdsbuyonedtl_gdsid().equals("02103003")||bld.getGdsbuyonedtl_gdsid().equals("02103002") )){
    		    	//7日之内只可领一次
    		    	if(bld.getGdsbuyonedtl_createtime().getTime()+7*Tools.DAY_MILLIS>System.currentTimeMillis()){
    		    	result++;
    		    	}
    		    }
    		 }
    	 }
     }
     return result;
}
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
%>
<%
boolean istx=false;//中秋
boolean isnormal=false;
boolean isnormalp=false;
/*String cartshopcode="00000000";
if(session.getAttribute("Cart_ShopCode")!=null){
cartshopcode= session.getAttribute("Cart_ShopCode").toString();
}*/
//判断购物车中是否有物品
//List<Cart> list = CartShopCodeHelper.getCartItems(request,response,cartshopcode);
List<Cart> list = CartHelper.getCartItems(request,response);
if(list == null || list.isEmpty()){
	out.print("{\"success\":false,\"message\":\"购物车中没有物品，无法下单！\"}");
	return;
}
boolean birthf=false;
int gdsfeecount=0;
for(Cart cart_1:list){
	if(cart_1.getType().longValue()==19){
		birthf=true;
	}
	 if(cart_1.getMoney().floatValue()==0f&&cart_1.getType().longValue()==13){
		 gdsfeecount++;
	 }
	 if(gdsfeecount>=2){
		 out.print("{\"success\":false,\"message\":\"0元兑换商品一个订单只能兑换一个！\"}");
			return;
	 }
	if(cart_1.getType().longValue()>=0){
		Product p_1 = (Product)Tools.getManager(Product.class).get(cart_1.getProductId());
		
		
		if(p_1!=null){
			//量少提醒和卖完就下的商品检查一下虚拟库存够不够
			if(p_1.getGdsmst_stocklinkty()!=null&&(p_1.getGdsmst_stocklinkty().longValue()==1||p_1.getGdsmst_stocklinkty().longValue()==2)){
				int countInCart_1239 = CartHelper.getCartProductCount(request, response, p_1, cart_1.getSkuId());//购物车里已经订购的数量
				if(countInCart_1239+CartItemHelper.getProductOccupyStock(p_1.getId(), cart_1.getSkuId())>ProductHelper.getVirtualStock(p_1.getId(), cart_1.getSkuId())){
					out.print("{\"success\":false,\"message\":\"您好！商品【"+StringUtils.clearHTML(p_1.getGdsmst_gdsname())+"】库存不足，请在购物车删除该商品后重新下单！\"}");
					return;
				}
			}
			//1元抢购商品是否控制在每天20个数量
	      // if(cart_1.getType().longValue()==14&&getAllCount(p_1.getId())>=20)
	       //{
	    	 //  out.print("{\"success\":false,\"message\":\"对不起！商品【"+StringUtils.clearHTML(p_1.getGdsmst_gdsname())+"】已抢购完，请在购物车删除该商品后重新下单！\"}");
				//return;
	      // }
			//除了积分兑换还有其他商品
			if(cart_1.getType().longValue()==2 || cart_1.getType().longValue()==13){
				isnormal=true;
			}
			if(cart_1.getType().longValue()!=2 && cart_1.getType().longValue()!=13 && cart_1.getType().longValue()!=14){
				isnormalp=true;
			}
			if((cart_1.getProductId().equals("02103005")||cart_1.getProductId().equals("02103004")||cart_1.getProductId().equals("02103003")||cart_1.getProductId().equals("02103002") )&&cart_1.getType().longValue()==14){
				istx=true;
			}
			
	       if(cart_1.getType().longValue()==14 && !Tools.isNull(cart_1.getGiftType())){
				ArrayList<TaiLi2012> tllist=getexist(cart_1.getGiftType());
				if(tllist!=null && tllist.size()>0){
					TaiLi2012 tl=tllist.get(0);
					if(tl.getTaili2012_status().longValue()==1){
						out.print("{\"success\":false,\"message\":\"该台历号已经使用过！\"}");
						return;
					}
					
					tl.setTaili2012_mbrid(new Long(lUser.getId()));
					tl.setTaili2012_update(new Date());
					tl.setTaili2012_status(new Long(1));
					Tools.getManager(TaiLi2012.class).update(tl, false);
				}
			}
		}
		
	}
}
if(birthf){
	BirthGds birthgds=(BirthGds)Tools.getManager(BirthGds.class).findByProperty("birthgds_mbrid", Tools.parseLong(lUser.getId()));
	if(birthgds==null){
		out.print("{\"success\":false,\"message\":\"生日礼物领取错误请删除重新领取！\"}");
	   	return;
	}else if(birthgds!=null&&birthgds.getBirthgds_status().longValue()==2){
		out.print("{\"success\":false,\"message\":\"生日礼物已经领取过不能重复领取！\"}");
	   	return;
	}
}
int results=Exits(lUser.getId());
	if(results>0 && istx){
	out.print("{\"success\":false,\"message\":\"您已经参加过中秋巨献活动！\"}");
   	return;
	}

String addressId = request.getParameter("addressId");

UserAddress address = UserAddressHelper.getById(addressId);
if(address == null){
	out.print("{\"success\":false,\"message\":\"找不到收货人！\"}");
	return;
}
if(!lUser.getId().equals(String.valueOf(address.getMbrcst_mbrid()))){//不是一个人
	out.print("{\"success\":false,\"message\":\"收货人地址错误！\"}");
	return;
}
String payId = request.getParameter("payId");
PayMethod pay = PayMethodHelper.getById(payId);
if(pay == null){
	out.print("{\"success\":false,\"message\":\"找不到支付方式！\"}");
	return;
}
String deliver = request.getParameter("deliver");
if(Tools.isNull(deliver)){
	out.print("{\"success\":false,\"message\":\"请选择送货时间！\"}");
	return;
}
String ticketId = request.getParameter("ticketId");
String ticketType = null;
if(!Tools.isNull(ticketId)){
	String ticket_type = "0";
	if(ticketId.startsWith("crd")){//折扣券
		ticketId = ticketId.substring(3);
		ticket_type = "1";
		
		TicketCrd tc = TicketHelper.getCrdById(ticketId);
		if(tc == null){
			out.print("{\"success\":false,\"message\":\"找不到优惠券！\"}");
			return;
		}
		if(!TicketHelper.validTicketCrd(request,response,payId,tc)){
			out.print("{\"success\":false,\"message\":\"优惠券错误，请重新选择！\"}");
			return;
		}
	}else if("brdtkt".equals(ticketId)){//品牌减免
		ticket_type = "2";
	}
	else if("bjhdtkt".equals(ticketId)){//半价活动
		ticket_type = "3";
	}else{//减免券
		Ticket ticket = TicketHelper.getById(ticketId);
		if(ticket == null){
			out.print("{\"success\":false,\"message\":\"找不到优惠券！\"}");
			return;
		}
		if(!TicketHelper.validTicket(request,response,payId,ticket)){
			out.print("{\"success\":false,\"message\":\"优惠券错误，请重新选择！\"}");
			return;
		}
		ticket_type = "0";
	}
	ticketType = ticket_type;
}else{
	ticketId = null;
	ticketType = null;
}
boolean isUsePrepay = false;//是否使用预存款
String userPrepay = request.getParameter("userPrepay");
if("1".equals(userPrepay)){
	isUsePrepay = true;
}
String memo = request.getParameter("memo");


OrderCache order = OrderHelper.createOrderFromCart(request,response,addressId,payId,deliver,ticketId,ticketType,isUsePrepay,memo);

//OrderCache order = OrderHelper.createOrderSMFromCart(request,response,addressId,payId,deliver,ticketId,ticketType,isUsePrepay,memo,cartshopcode);

if(order != null && order.getId() != null){
	session.setAttribute("OrderCacheId" , order.getId());
	out.print("{\"success\":true,\"message\":\"下单成功！\"}");
	return;
}else{
	out.print("{\"success\":false,\"message\":\"下单失败，可能是兑换码已经使用过，或积分换购的积分不够，或免费免费商品已领取过！如果没有使用兑换码，请稍后重试\"}");
	return;
}

%>