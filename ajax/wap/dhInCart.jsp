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
String strgdsdh_code = request.getParameter("id");
if(lUser==null) {
	out.print("{\"code\":99,\"message\":\"请先登陆！\"}");
	return;
}
if(Tools.isNull(strgdsdh_code)){
	out.print("{\"code\":1,\"message\":\"兑换码不能为空！\"}");
	return;
}
strgdsdh_code=strgdsdh_code.trim();
Long Tuandh_mid=0L;
String strgdsid="";
String title="";
String gdsid = request.getParameter("gdsid");
boolean isnew=false;
String tgid="";String num="";String last2num="";
if(strgdsdh_code.length()>10){//可能是ticketgroup的记录
	 tgid = strgdsdh_code.substring(0,strgdsdh_code.length()-10);
	  num = strgdsdh_code.substring(strgdsdh_code.length()-10);//10位数
	last2num = num.substring(num.length()-2);
}

if(StringUtils.isDigits(num)){
	TuandhGroup tg = (TuandhGroup)Tools.getManager(TuandhGroup.class).findByProperty("tuandhgroup_title", tgid);
	if(tg!=null){
		isnew=true;
		title=tg.getTuandhgroup_memo();
		Tuandh_mid=tg.getTuandhgroup_mid();
		if(Tools.dateValue(tg.getTuandhgroup_validatee())<System.currentTimeMillis()){
			out.print("{\"code\":1,\"message\":\"该兑换活动已经结束！\"}");
			return;
		}	
		int sum = 0 ;
		for(int i=0;i<8;i++){//前8位加起来
			sum+=new Integer(num.charAt(i)+"").intValue();
		}
		String sum2 = (sum+tg.getTuandhgroup_checkcode().longValue())+"";
		if(sum2.length()>2)sum2=sum2.substring(sum2.length()-2);//取最后两位
		else if(sum2.length()<2)sum2="0"+sum2 ;//补0，没有这种情况
		if(last2num.equals(sum2)){//符合规则
		strgdsid=tg.getTuandhgroup_gdsid();
		Tuandh tuan = (Tuandh)Tools.getManager(Tuandh.class).findByProperty("tuandh_cardno", strgdsdh_code);
		if(tuan!=null){
			if(tuan.getTuandh_status().intValue()==2){
				out.print("{\"code\":1,\"message\":\"该兑换码已经兑换过！\"}");
				return;
			}
		}else{
			//未刮开过添加一条新纪录
			Tuandh t=new Tuandh();
			t.setTuandh_cardno(strgdsdh_code);
			t.setTuandh_createtime(tg.getTuandhgroup_createdate());
			t.setTuandh_endtime(tg.getTuandhgroup_validatee());
			t.setTuandh_gdsid(tg.getTuandhgroup_gdsid());
			t.setTuandh_memo(tg.getTuandhgroup_memo());
			t.setTuandh_title(tg.getTuandhgroup_memo());
			t.setTuandh_dhprice(tg.getTuandhgroup_dhprice());
			t.setTuandh_maxbuycount(tg.getTuandhgroup_maxbuycount());
			t.setTuandh_shipfee(tg.getTuandhgroup_shipfee());
			t.setTuandh_fee(tg.getTuandhgroup_fee());
			t.setTuandh_status(new Long(1));
			t.setTuandh_yztime(new Date());
			t.setTuandh_mbrid(new Long(lUser.getId()));
			t.setTuandh_mid(tg.getTuandhgroup_mid());
			try{
				Tools.getManager(Tuandh.class).create(t);
				}catch(Exception e){
					
				}
		}
		
		}else{
			out.print("{\"code\":1,\"message\":\"该兑换码不存在！\"}");
			return;
		}
	}
	
}

Tuandh tuandh=null;

	 tuandh=(Tuandh)Tools.getManager(Tuandh.class).findByProperty("tuandh_cardno", strgdsdh_code);
	if(tuandh==null){
		out.print("{\"code\":1,\"message\":\"该兑换码不存在！\"}");
		return;
	}
	if(tuandh.getTuandh_status().longValue()==2){
		out.print("{\"code\":1,\"message\":\"该兑换码已经兑换过！\"}");
		return;
	}
	if(Tools.dateValue(tuandh.getTuandh_endtime())<System.currentTimeMillis())
	{
		out.print("{\"code\":1,\"message\":\"该兑换活动已经结束！\"}");
		return;
	}
	 strgdsid=tuandh.getTuandh_gdsid();
	 Tuandh_mid=tuandh.getTuandh_mid();
	 title=tuandh.getTuandh_title();
	String memo=tuandh.getTuandh_memo();

if(!Tools.isNull(gdsid)&&!gdsid.equals(strgdsid)&&(memo!=null&&memo.indexOf(gdsid)==-1)){
	out.print("{\"code\":1,\"message\":\"很抱歉，选择商品有误，请联系管理员\"}");
	return;
}
if(Tools.isNull(gdsid)){
	gdsid=strgdsid;
}
Product product = ProductHelper.getById(gdsid);
if(product == null){
	out.print("{\"code\":1,\"message\":\"很抱歉，您输入的信息不正确，请确认后重试！\"}");
	return;
}

//商品是否在架上
if(Tools.longValue(product.getGdsmst_validflag()) != 1&&Tools.longValue(product.getGdsmst_validflag()) != 4){
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
//CartHelper.checkCartError(request,response);

String type = request.getParameter("type");
if(!"1".equals(type)) type = "0";
int t = Tools.parseInt(type);//查看是否要强制加入购物车。

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
		out.print("{\"code\":3,\"gdsid\":\""+strgdsid+"\",\"message\":\""+message+"\"}");
		return;
	}
	if(!SkuHelper.hasInSkuList(product , skuId)){
		out.print("{\"code\":1,\"message\":\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
		return;
	}
}else{
	skuId = null;
}
boolean b=false;
//不存在SKU则直接加入购物车，但是需要判断购物车中是否有这件物品。
if(false && t==0){
	out.print("{\"code\":2,\"message\":\"\"}");
	return;
}else{
	//直接加入购物车。，数量默认1.
	String count = request.getParameter("count");
	if(!Tools.isMath(count)) count = "1";
	else if(Long.parseLong(count) <= 0 || Long.parseLong(count) > 999) count = "1";
   ArrayList<Cart> cartList = CartHelper.getCartItems(request, response);	
	boolean hasOne = false ;
	boolean hasOnezero = false ;
	int cartnumdh=0;
	if(cartList!=null){
		for(Cart c123:cartList){
			if(c123.getType().longValue()==13&&c123.getProductId().equals(strgdsid)){
				cartnumdh++;
			}
			if(c123.getType().longValue()==13&&c123.getPrice().floatValue()==0f){
				hasOnezero=true;
			}
		}
	}
	
	int tuanmaxnum=1;
	if(tuandh.getTuandh_maxbuycount()!=null)tuanmaxnum=tuandh.getTuandh_maxbuycount().intValue();
	if(cartnumdh>=tuanmaxnum){
		out.print("{\"code\":1,\"message\":\"对不起已经超过了单个订单最大兑换数量，请先下完此单，再从新兑换！\"}");
		return;
	}
	if(cartList!=null){
		for(Cart c123:cartList){
			if(strgdsdh_code.equals(c123.getTuanCode())){
				hasOne = true ;
				break;
			}
			}
		}
	if(hasOne){
		out.print("{\"code\":1,\"message\":\"此兑换码已经放入购物车！\"}");
		return;
	}
	float ftuanprice=tuandh.getTuandh_dhprice().floatValue();
	if(hasOnezero&&ftuanprice==0f){
		out.print("{\"code\":1,\"message\":\"不要太贪噢，一张订单只能领取一件免费商品！\"}");
		return;
	}
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
	cart.setShopcode(product.getGdsmst_shopcode());
	cart.setUserId(CartHelper.getCartUserId(request, response));
	cart.setVipPrice(Tools.getFloat(new Float(ftuanprice),2));
	cart.setTitle("【"+title+"】"+Tools.clearHTML(product.getGdsmst_gdsname()));
	
	Tools.getManager(Cart.class).create(cart);
	if(!isnew && tuandh!=null){
		tuandh.setTuandh_status(new Long(1));
		tuandh.setTuandh_yztime(new Date());
		tuandh.setTuandh_mbrid(new Long(lUser.getId()));
		Tools.getManager(Tuandh.class).update(tuandh, false);
	}
		//获得购物车总金额和总商品数量
		int totalCount = CartHelper.getTotalProductCount(request,response);
		float totalAmmount = CartHelper.getTotalPayMoney(request,response);
		
		out.print("{\"code\":0,\"message\":\"\",\"totalCount\":"+totalCount+",\"totalAmount\":\""+Tools.getFormatMoney(totalAmmount)+"\"}");
		return;
}
%>