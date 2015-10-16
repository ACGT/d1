<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%!
public static long getUseScoreshop(String mbrid,String shopcode) {
	ArrayList<UsrPoint> list = getUserScoreInfoshop(mbrid,shopcode);
	long realsocre=0;
	if(list!=null){
		for(UsrPoint userScore:list){
			if(userScore.getUsrpoint_score()!=null && (userScore.getUsrpoint_score().longValue() != 0)){
				realsocre+=userScore.getUsrpoint_score().longValue();
			}
		}
		
	}
	return realsocre;
}
public static ArrayList<UsrPoint> getUserScoreInfoshop(String mbrid,String shopcode){
	ArrayList<UsrPoint> rlist = new ArrayList<UsrPoint>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("usrpoint_mbrid", new Long(mbrid)));
	clist.add(Restrictions.eq("usrpoint_shopcode",shopcode));
	List<Order> olist= new ArrayList<Order>();
	olist.add(Order.desc("usrpoint_createdate"));
	List<BaseEntity> list = Tools.getManager(UsrPoint.class).getList(clist, olist, 0, 1000);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((UsrPoint)be);
	}
	return rlist ;
}
 
private static int getTicketsnum(String userId,String cardno,float gdsvalue,float tktvalue){
	if(Tools.isNull(userId))return 0;
	ArrayList<Ticket> list = new ArrayList<Ticket>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("tktmst_mbrid", new Long(userId)));

	clist.add(Restrictions.eq("tktmst_cardno", cardno));//0 未使用
	clist.add(Restrictions.eq("tktmst_gdsvalue", new Float(gdsvalue)));
	clist.add(Restrictions.eq("tktmst_value", new Float(tktvalue)));
	clist.add(Restrictions.eq("tktmst_memo", "积分兑换创建"));
	clist.add(Restrictions.ge("id", "1856903"));
	List<Order> olist = new ArrayList<Order>();
	
	List<BaseEntity> rlist = Tools.getManager(Ticket.class).getList(clist, null, 0, 1000);
	if(rlist==null||rlist.size()==0)return 0;
	
	
	return rlist.size() ;
}

private static int getAwardUsenum(String userId,long awardid){
	if(Tools.isNull(userId))return 0;
	ArrayList<AwardUseLog> list = new ArrayList<AwardUseLog>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("scrchgawd_mbrid", new Long(userId)));

	clist.add(Restrictions.eq("scrchgawd_awardid", new Long(awardid)));//0 未使用
	clist.add(Restrictions.eq("scrchgawd_status", new Long(1)));
	clist.add(Restrictions.ge("id", "106447"));
	List<Order> olist = new ArrayList<Order>();
	
	List<BaseEntity> rlist = Tools.getManager(AwardUseLog.class).getList(clist, null, 0, 1000);
	if(rlist==null||rlist.size()==0)return 0;
	
	
	return rlist.size() ;
}
%><%
String id = request.getParameter("id");
Award award = (Award)Tools.getManager(Award.class).get(id);
if(award==null){
	out.print("{\"code\":1,\"message\":\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
	return;
}

Product product = ProductHelper.getById(award.getAward_gdsid());
String skuId = request.getParameter("skuId");
int cartCount = 0;
if(product!=null){
	
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

	ArrayList<Cart> allCartList = CartHelper.getCartItems(request, response);
	
	if(allCartList!=null){
		for(Cart c_23894:allCartList){
			if(product.getId().equals(c_23894.getProductId())){
				cartCount+=c_23894.getAmount().intValue();
			}
		}
	}
	
	if(product.getGdsmst_buylimit()!=null&&product.getGdsmst_buylimit().intValue()>0){
	
		if(cartCount+1>product.getGdsmst_buylimit().intValue()){
			out.print("{\"code\":1,\"message\":\"对不起，该商品限购"+product.getGdsmst_buylimit().intValue()+"个！\"}");
			return;
		}
	}


	//检查购物车
	//CartHelper.checkCartError(request,response);
	
	String type = request.getParameter("type");
	if(!"1".equals(type)) type = "0";
	int t = Tools.parseInt(type);//查看是否要强制加入购物车。
	
	//判断是否有SKU，如果有SKU则弹出SKU的选择层。
	//存在SKU
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
			out.print("{\"code\":3,\"message\":\""+message+"\"}");
			return;
		}
		if(!SkuHelper.hasInSkuList(product , skuId)){
			out.print("{\"code\":1,\"message\":\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
			return;
		}
	}else{
		skuId = null;
	}
	//不存在SKU则直接加入购物车，但是需要判断购物车中是否有这件物品。
	if(CartHelper.hasInCart(product,skuId,request,response) && t==0){
		out.print("{\"code\":2,\"message\":\"\"}");
		return;
	}
}

if(lUser==null){
	out.print("{\"code\":1,\"message\":\"您必须<a href='/ushop_weixin/login.html'>登录</a>才能兑换！\"}");
	return;
}

if (award.getAward_price().floatValue()==0f&&!"00000000".equals(award.getAward_gdsid())){
	int maxgdsnum=getAwardUsenum(lUser.getId(),Tools.parseLong(award.getId()) );
	if(cartCount+maxgdsnum>=2){
		out.print("{\"code\":1,\"message\":\"对不起此商品一个用户最多只能兑换两个！\"}");
		return;
	}
	}
if (award.getAward_price().floatValue()>0f&&!"00000000".equals(award.getAward_gdsid())){
	int maxgdsnum=getAwardUsenum(lUser.getId(),Tools.parseLong(award.getId()) );
	if(cartCount+maxgdsnum>=5){
		out.print("{\"code\":1,\"message\":\"对不起此商品一个用户最多只能兑换五个！\"}");
		return;
	}
	}

if("00000000".equals(award.getAward_gdsid())){//00000000直接兑换成优惠券，不用加入购物车了
	synchronized(lUser){
		float ppoint = award.getAward_value().floatValue();//兑换商品的积分值
		String shopcode="14031201";
		float upoint = getUseScoreshop(lUser.getId(),shopcode);//用户的总积分
		if(ppoint+CartHelper.getCartTotalPoint(request,response)>upoint);
		long cartpoint=0;//购物车积分
		ArrayList<Cart> clist=CartHelper.getCartItems(request, response);
		if(clist!=null&&clist.size()>0)
		{
			for(Cart c:clist)
			{
				cartpoint+=c.getPoint().longValue();
			}
		}
		if(ppoint>upoint){
			out.print("{\"code\":1,\"message\":\"您的积分不够兑换此优惠券！\"}");
			return;
		}
		if(cartpoint>0&&(upoint-cartpoint)<ppoint)
		{
			out.print("{\"code\":1,\"message\":\"您的积分不够兑换此优惠券,请删除购物车中积分换购的商品在进行兑换！\"}");
			return;
		}
		float gdsvalue=0f;
		float tktvalue=0f;
		if("3".equals(id)){//15元优惠券，购物满50可以使用
			gdsvalue=50f;
			tktvalue=15f;
		}else if("36".equals(id)){//30元优惠券，购物满200可以使用
			gdsvalue=200f;
			tktvalue=30f;
		}else if("66".equals(id)){//5元优惠券，不限购物金额
			gdsvalue=5f;
			tktvalue=5f;
		}else if("67".equals(id)){//10元优惠券，不限购物金额
			gdsvalue=10f;
			tktvalue=10f;
		}else if("92".equals(id)){//20元优惠券，购物满100可以使用
			gdsvalue=100f;
			tktvalue=20f;
		}else if("294".equals(id)){//50元优惠券，购物满300可以使用
			gdsvalue=300f;
			tktvalue=50f;
		}else if("526".equals(id)){//300减100元优惠券
			gdsvalue=300f;
			tktvalue=100f;
		}else if("787".equals(id)){//200减50元优惠券
			gdsvalue=200f;
			tktvalue=50f;
		}else if("479".equals(id)){//20元优惠券，全场无限制使用
			gdsvalue=20f;
			tktvalue=20f;
		}else if("480".equals(id)){//100元优惠券，购物满200可以使用
			gdsvalue=200f;
			tktvalue=100f;
		}else if("1359".equals(id)){//30元优惠券，购物满100可以使用
			gdsvalue=150f;
			tktvalue=30f;
		}
		
		
		
	//	int maxnum=getTicketsnum(lUser.getId(),"pjifeng"+lUser.getId(),gdsvalue,tktvalue);
		//System.out.println("优惠券张数："+maxnum);
		//if (maxnum>=5){
		//	out.print("{\"code\":1,\"message\":\"对不起此券一个用户最多只能兑换5张！\"}");
		//	return;
		//}
		
		Ticket t789 = new Ticket();
		t789.setTktmst_createdate(new Date());
		t789.setTktmst_downflag(new Long(1));
		//t789.setTktmst_gdsvalue(new Float(gdsmoney));
		t789.setTktmst_ifcrd(new Long(0));//不是减免券挂出来的
		t789.setTktmst_mbrid(new Long(lUser.getId()));//会员id
		t789.setTktmst_memo("积分兑换创建");
		t789.setTktmst_payid(new Long(-1));//pay id
		
		t789.setTktmst_validatee(new Date(System.currentTimeMillis()+30*Tools.DAY_MILLIS));
		t789.setTktmst_validates(new Date());
		t789.setTktmst_sodrid("");//订单id
		t789.setTktmst_type("003007");//积分换券
		//t789.setTktmst_value(new Float(ticket_cut_money));
		t789.setTktmst_validflag(new Long(0));//标记为未使用
		t789.setTktmst_uodrid("");
		t789.setTktmst_cardno("pjifeng"+lUser.getId());
		t789.setTktmst_baihuo(new Long(0));
		t789.setTktmst_shopcodes("11111111");
		String awardId = award.getId();
		
		if("3".equals(awardId)){//15元优惠券，购物满50可以使用
			t789.setTktmst_gdsvalue(new Float(50));
			t789.setTktmst_value(new Float(15));
			t789.setTktmst_rackcode("000");
		}else if("36".equals(awardId)){//30元优惠券，购物满200可以使用
			t789.setTktmst_gdsvalue(new Float(200));
			t789.setTktmst_rackcode("000");
			t789.setTktmst_value(new Float(30));
		}else if("66".equals(awardId)){//5元优惠券，不限购物金额
			t789.setTktmst_gdsvalue(new Float(0));
			t789.setTktmst_value(new Float(5));
			t789.setTktmst_rackcode("000");
		}else if("67".equals(awardId)){//10元优惠券，不限购物金额
			t789.setTktmst_gdsvalue(new Float(10));
			t789.setTktmst_value(new Float(10));
			t789.setTktmst_rackcode("000");
		}else if("92".equals(awardId)){//20元优惠券，购物满100可以使用
			t789.setTktmst_gdsvalue(new Float(100));
			t789.setTktmst_value(new Float(20));
			t789.setTktmst_rackcode("000");
		}else if("294".equals(awardId)){//50元优惠券，购物满300可以使用
			t789.setTktmst_gdsvalue(new Float(300));
			t789.setTktmst_value(new Float(50));
			t789.setTktmst_rackcode("000");
		}else if("526".equals(awardId)){//300减100元优惠券
			t789.setTktmst_gdsvalue(new Float(300));
			t789.setTktmst_value(new Float(100));
			t789.setTktmst_rackcode("000");
		}else if("787".equals(awardId)){//200减50元优惠券
			t789.setTktmst_gdsvalue(new Float(200));
			t789.setTktmst_value(new Float(50));
			t789.setTktmst_rackcode("000");
		}else if("479".equals(awardId)){//20元优惠券，全场无限制使用
			t789.setTktmst_gdsvalue(new Float(20));
			t789.setTktmst_value(new Float(20));
			t789.setTktmst_rackcode("000");
		}else if("480".equals(awardId)){//100元优惠券，购物满200可以使用
			t789.setTktmst_gdsvalue(new Float(400));
			t789.setTktmst_value(new Float(100));
			t789.setTktmst_rackcode("017");
		}else if("1359".equals(awardId)){//30元优惠券，购物满100可以使用
			t789.setTktmst_gdsvalue(new Float(150));
			t789.setTktmst_value(new Float(30));
			t789.setTktmst_rackcode("017");
		}
		
		//开始扣用户积分
		long total_point_for_cut = (long)ppoint ;//需要多少积分
		UsrPoint us = new UsrPoint();
		us.setUsrpoint_createdate(new Date());
		us.setUsrpoint_mbrid(new Long(lUser.getId()));
		us.setUsrpoint_usescore(new Long(0));
		us.setUsrpoint_shopcode(shopcode);
		us.setUsrpoint_score(new Long(-total_point_for_cut));
		us.setUsrpoint_type(new Long(-2));
		Tools.getManager(UsrPoint.class).create(us);
		/*
		List<SimpleExpression> clist123 = new ArrayList<SimpleExpression>();
		clist123.add(Restrictions.eq("usrscore_mbrid", new Long(lUser.getId())));
		clist123.add(Restrictions.gt("usrscore_realscr", new Float(0)));
		
		List<Order> olist123 = new ArrayList<Order>();
		olist1234.add(Order.asc("usrscore_createdate"));
		
		List<BaseEntity> listus123 = Tools.getManager(UserScore.class).getList(clist123, null, 0, 1000);//用户所有积分记录
		if(listus123!=null&&listus123.size()>0){
			for(int i=0;i<listus123.size();i++){
				UserScore us = (UserScore)listus123.get(i);
				if(total_point_for_cut>0){
					if(us.getUsrscore_realscr()!=null){
						if(us.getUsrscore_realscr().longValue()>=total_point_for_cut){
							us.setUsrscore_realscr(Tools.getFloat(new Float(us.getUsrscore_realscr().longValue()-total_point_for_cut),2));
							Tools.getManager(UserScore.class).update(us, false);
							total_point_for_cut = 0;//扣完了
						}else{
							total_point_for_cut = total_point_for_cut-us.getUsrscore_realscr().longValue();
							us.setUsrscore_realscr(new Float(0));
							Tools.getManager(UserScore.class).update(us, false);
						}
					}
				}
			}
		}
		*/
		Tools.getManager(Ticket.class).create(t789);//创建兑换生成的优惠券
		
		AwardUseLog aul = new AwardUseLog();
		aul.setScrchgawd_applytime(new Date());
		aul.setScrchgawd_awardid(new Long(award.getId()));
		aul.setScrchgawd_mbrid(new Long(lUser.getId()));
		aul.setScrchgawd_mbrmst_haddr("");
		aul.setScrchgawd_mbrmst_name(lUser.getMbrmst_name());
		aul.setScrchgawd_mbrmst_postcode("");
		aul.setScrchgawd_mbrmst_usephone("");
		aul.setScrchgawd_name(lUser.getMbrmst_name());
		aul.setScrchgawd_status(new Long(1));
		aul.setScrchgawd_uid(lUser.getMbrmst_uid());
		aul.setScrchgawd_updtime(new Date());
		
		Tools.getManager(AwardUseLog.class).create(aul);
		
		if(!Tools.isNull(t789.getId())){
			out.print("{\"code\":1,\"message\":\"兑换成功，优惠券请在<a href='http://www.d1.com.cn/user/ticket.jsp' target='_blank' style='color:#f00;'>我的优惠券</a>中点击查看！\"}");
			return;
		}else{
			out.print("{\"code\":1,\"message\":\"兑换失败！\"}");
			return;
		}
	}//end synchronized
}



if(product!=null){
	//量少提醒和卖完就下的商品检查一下虚拟库存够不够
	if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
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
}




int s = CartHelper.addJifenProductToCart(request,response,award.getAward_gdsid(),skuId,award.getId());
switch(s){
	case 1:
		//获得购物车总金额和总商品数量
		int totalCount = CartHelper.getTotalProductCount(request,response);
		float totalAmmount = CartHelper.getTotalPayMoney(request,response);
		
		out.print("{\"code\":0,\"message\":\"\",\"totalCount\":"+totalCount+",\"totalAmount\":\""+Tools.getFormatMoney(totalAmmount)+"\"}");
		break;
	case -1:
		out.print("{\"code\":1,\"message\":\"找不到商品信息。\"}");
		break;
	case -2:
		out.print("{\"code\":1,\"message\":\"该商品不是积分兑换商品。\"}");
		break;
	case -3:
		out.print("{\"code\":1,\"message\":\"您必须<a href='/login.jsp'>登录</a>才能兑换！\"}");
		break;
	case -4:
		out.print("{\"code\":1,\"message\":\"您的积分不够兑换此商品！\"}");
		break;
	case -6:
		out.print("{\"code\":1,\"message\":\"您的购物车超过了100条记录，请先提交再继续购买！\"}");
		break;
	default:
		out.print("{\"code\":1,\"message\":\"兑换物品发生错误，请稍后再试！\"}");
}

%>