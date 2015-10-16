<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="function.jsp" %><%!
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
//String shopcode=request.getParameter("shopcode");//商户拆单
//session.setAttribute("Cart_ShopCode", shopcode);
//List<Cart> list = CartShopCodeHelper.getCartItems(request,response,shopcode);
List<Cart> list = CartHelper.getCartItems(request,response);

//限制type=14的赠品金额，必须满足59才允许提交
boolean hasGift14 = false ;
boolean isqc=false;

int hasGift14gdsid = 0 ;
boolean isbrand=false;
boolean istx=false;//中秋
boolean isnormal=false;
boolean isnormalp=false;
boolean isgq=false;//国庆
boolean iszfqr=false;//绽放秋日
boolean hastl=false;//购物车时候有台历
String gdsidlist="02200096,02200097,02200095,02200094,03200050,03200049,03200064";
//String plist="02000791,02000792,02000793,02000795,02000794,02000796,02000797";//打底裤
//int ddknum=0;
boolean isddk=false;
boolean istl=false;

boolean year=false;

String xlpid="01517437";
boolean iszippo=false;boolean iszippozp=false;
int zippo=0;int zippozp=0;
int countRcode=0;
int countXl=0;
if(list!=null){
	for(Cart c_23049:list){
		if(c_23049.getType().longValue()==14 && c_23049.getTitle().trim().indexOf("0元抢购")>0){
			isqc=true;
		}
		if(c_23049.getType().longValue()==14 && !Tools.isNull(c_23049.getTuanCode())){
			hasGift14gdsid = 1 ;
			hasGift14 = true ;
			//break;
		}
		if(c_23049.getType().longValue()==14){
			hasGift14 = true ;
			//System.out.print("totalVisiable_1");	
			//break;
		}
		/**
		Product p=ProductHelper.getById(c_23049.getProductId());
		
		if(p!=null && "020004".equals(p.getGdsmst_rackcode().trim())){
			long discountendDate = Tools.dateValue(p.getGdsmst_discountenddate());//应该是秒杀结束的时间。
			long currentTime = System.currentTimeMillis();
			float hyprice = 0;
			if(discountendDate >= currentTime && discountendDate <= currentTime+Tools.MONTH_MILLIS ){
				countRcode++;//毛衣的件数
			}
		}
		if((c_23049.getType().longValue()==14 || c_23049.getType().longValue()==0) && xlpid.equals(c_23049.getProductId())){
			countXl++;//毛衣链个数
		}
		**/
		//九月份台历  是否购物车只有活动商品
		
		//System.out.print(c_23049.getGiftType()+"zzzzzzzzzzzzz");
		
		/**
		if(c_23049.getType().longValue()==14 && !Tools.isNull(c_23049.getGiftType())){
			ArrayList<TaiLi2012> tllist=getexist(c_23049.getGiftType().replace("_9", "_1"));
			if(tllist!=null && tllist.size()>0){
				istl=true;
				//break;
			}
		}
		//除了积分兑换还有其他商品
		if(c_23049.getType().longValue()==2 || c_23049.getType().longValue()==13){
			isnormal=true;
		}
		if(c_23049.getType().longValue()!=2 && c_23049.getType().longValue()!=13 && c_23049.getType().longValue()!=14){
			isnormalp=true;
		}
		if((c_23049.getProductId().equals("02103005")||c_23049.getProductId().equals("02103004")||c_23049.getProductId().equals("02103003")||c_23049.getProductId().equals("02103002") )&&c_23049.getType().longValue()==14){
			istx=true;
		}
		
		if(c_23049.getType().longValue()==0 && ("03200001".equals(c_23049.getProductId()) || "03200002".equals(c_23049.getProductId()))){
			isfm = true ;
			//break;
		}
		if(c_23049.getType().longValue()==0 && "01411903".equals(c_23049.getProductId())){
			isjiandao = true ;
			//break;
		}**/
		//判断佰草集、欧莱雅活动特价
		//System.out.print(c_23049.getType()+"WWWWWWWWWWWWW");
		if(c_23049.getType().longValue()==9){
			String dxid = "160";
			if(!Tools.isNull(dxid)){
				ProductExpPriceItem expitem = ProductExpPriceHelper.getExpPrice(c_23049.getProductId(),dxid);
				if(expitem != null){
					isbrand=true;
				//	break;
				}
			}
			
		}
		if(c_23049.getType().longValue()==14 && (c_23049.getProductId().equals("02300189") || c_23049.getProductId().equals("02300190")) ){
			isgq=true;
		}
		if(c_23049.getType().longValue()==14 && (gdsidlist.indexOf(c_23049.getProductId())>=0)&& c_23049.getPrice()==0){
			iszfqr=true;
		}
		if(c_23049.getType().longValue()==14 && (c_23049.getProductId().equals("01721234") || c_23049.getProductId().equals("01415776")) ){
			istl=true;
		}
		//if(c_23049.getType().longValue()==13 && (plist.indexOf(c_23049.getProductId())>=0)){
		//	isddk=true;
		//}
		//if(c_23049.getType().longValue()==14 && (plist.indexOf(c_23049.getProductId())>=0)){
		//	ddknum++;
		//}
		if(c_23049.getType().longValue()==13 && ("01511126".equals(c_23049.getProductId()))){
			iszippo=true;zippo++;
		}
		if(c_23049.getType().longValue()==14 && ("01511167".equals(c_23049.getProductId()))){
			iszippozp=true; zippozp++;
		}
		/*if(c_23049.getType().longValue()==14 && ("01404571".equals(c_23049.getProductId()))){
			year=true;
		}*/
		
		//if(c_23049.getType().longValue()==14 && ("01205279".equals(c_23049.getProductId()))){
		//	hastl=true;
		//}
	}
}
//if(hastl && CartHelper.getTotalPayMoney(request, response)<4){
	//out.print("{\"error\":-12,\"content\":\"\"}");
	//return;
//}
/*if(year && CartHelper.getTotalRackcodePayMoney(request, response,"014")<299){
	out.print("{\"error\":-13,\"content\":\"\"}");
	return;
}*/


if(istl && CartHelper.getTotalPayMoney(request, response)<2){
	out.print("{\"error\":-10,\"content\":\"\"}");
	return;
}

if(!iszippo && iszippozp){//没zippo 但有zippo赠品
	out.print("{\"error\":-8,\"content\":\"\"}");
	return;
}
if(zippozp>zippo){//赠品数大于zippo数
	out.print("{\"error\":-9,\"content\":\"\"}");
	return;
}

/**
if(isgq && CartHelper.getTotalPayMoney(request, response)<299){
	out.print("{\"error\":-4,\"content\":\"\"}");//有type=14的赠品，但是金额没有299元，不让提交
	return;
}
if(iszfqr && CartHelper.getTotalPayMoney(request, response)<299){
	out.print("{\"error\":-2,\"content\":\"\"}");//有type=14的赠品，但是金额没有299元，不让提交
	return;
}

if(CartHelper.getTotalPayMoney(request, response)>=150 && CartHelper.getTotalPayMoney(request, response)<299){
	float lastmoney=299-CartHelper.getTotalPayMoney(request, response);
	out.print("{\"error\":-3,\"content\":\""+lastmoney+"\"}");
	return;
}
if(countXl>countRcode){
	out.print("{\"error\":-7,\"content\":\"\"}");
	return;
}
if(!isnormalp && isnormal && istx){//购物车只有积分换购商品和免费领的拖鞋
	out.print("{\"error\":-5,\"content\":\"\"}");
	return;
}
//if(hasGift14){
	//if(CartHelper.getTotalPayMoney(request, response)<59 && hasGift14gdsid!=1 && !isgb && !ishwy){
		//out.print("{\"error\":-2,\"content\":\"\"}");//有type=14的赠品，但是金额没有59元，不让提交
		//return;
	//}
	//if(hasGift14gdsid==1 && CartHelper.getTotalPayMoney(request, response)<2 && !isgb && !ishwy){
		//out.print("{\"error\":-3,\"content\":\"\"}");//有type=14的赠品，但是金额没有59元，不让提交
		//return;
	//}
	//if(CartHelper.getTotalPayMoney(request, response)<300  && isgb){
		//out.print("{\"error\":-4,\"content\":\"\"}");//有type=14的赠品，但是金额没有300元，不让提交
		//return;
	//}
	//if(CartHelper.getTotalRackcodePayMoney(request, response,"014")<299  && ishwy){
		//out.print("{\"error\":-5,\"content\":\"\"}");//参加红五月活动，化妆品金额不满299
		//return;
	//}
//}

/**
if(CartHelper.getTotalPayMoney(request, response)<259){
	float lastmoney=259-CartHelper.getTotalPayMoney(request, response);
	out.print("{\"error\":-8,\"content\":\""+lastmoney+"\"}");//订单金额不足259的时候提示你还差xxx元即可获得以下赠品，显示指甲套
	return;
}

if(CartHelper.getTotalPayMoney(request, response)>=259 && CartHelper.getTotalPayMoney(request, response)<399 && !isjiandao){
	float lastmoney=399-CartHelper.getTotalPayMoney(request, response);
	out.print("{\"error\":-7,\"content\":\""+lastmoney+"\"}");//259-399之间的显示，恭喜您已经获得了指甲套，再购买xxx即可获得帽子（未领指甲套的情况）
	return;
}
if(CartHelper.getTotalPayMoney(request, response)>=259 && CartHelper.getTotalPayMoney(request, response)<399 && isjiandao){
	float lastmoney=399-CartHelper.getTotalPayMoney(request, response);
	out.print("{\"error\":-9,\"content\":\""+lastmoney+"\"}");//259-399之间的显示，恭喜您已经获得了指甲套，再购买xxx即可获得帽子（领了指甲套的情况）
	return;
}

if(CartHelper.getTotalPayMoney(request, response)>=399 && !isfm && !isjiandao){
	out.print("{\"error\":-1,\"content\":\"\"}");//没有选择赠品
	return;
}	
**/
//根据登陆状态不同和是否选择赠品，跳转到不同页面
if(lUser == null){	
	response.setHeader("_d1-Ajax","2");
	int totalGift_1 = 0 ,totalVisiable_1 = 0;//选择的免费赠品数
	ArrayList<Cart> cList123 = CartShopCodeHelper.getCartItems(request, response,"00000000");
	for(Cart cart_1:cList123){
		if(cart_1.getType().longValue()==0)totalGift_1++;
	}
	
	ArrayList<GiftHelper.GiftGoods> giftList = GiftHelper.getCartVisiableGiftProducts(request, response);
	if(giftList!=null){
		for(GiftHelper.GiftGoods gg_77p:giftList){
			if(gg_77p.isIsfree()){
				totalVisiable_1++;
			}
		}
	}
	if(totalVisiable_1>0&&totalGift_1==0){
		%>Login_Dialog("/flow.jsp");<%
	}else{
		if(isbrand){
			%>Login_Dialog("/flow.jsp");<%
				
		}else{
		%>Login_Dialog("/flowCheck.jsp");<%
			}
	}
	return;
}
//点击结算的时候的检查。

if(list == null || list.isEmpty()){//购物车为空
	Map<String,Object> map = new HashMap<String,Object>();
	map.put("error",new Integer(2));
	map.put("cart_goods_area",(lUser!=null?"您的购物车中没有商品，快去挑选商品吧&nbsp;&nbsp;<a href='/index.jsp'>回到首页&gt;&gt;</a>":"如果您上次退出时，购物车中有商品，那么商品已自动保存，<a href='/login.jsp'>请登录后查看&gt;&gt;</a>"));
	out.print(JSONObject.fromObject(map));
	return;
}
boolean isError = false;
//自动删除的物品list
String deleteStr = "";
List<String> delete_list = new ArrayList<String>();
List<Cart> deleteCartList = CartHelper.updateAllCartItems(request,response);
if(deleteCartList != null && !deleteCartList.isEmpty()){
	deleteStr +="自动删除物品：";
	for(Cart c : deleteCartList){
		delete_list.add(c.getId()+"_0_"+(Tools.isNull(c.getSkuId())?"0":c.getSkuId()));
		deleteStr += "["+c.getTitle()+"]&nbsp;&nbsp;";
	}
	isError = true;
}

if(isError){
	//库存不足的物品list
	List<Map<String,Object>> update_list = new ArrayList<Map<String,Object>>();
	//主商品相关联的list
	List<Map<String,Object>> gift_list = new ArrayList<Map<String,Object>>();
	
	//总金额区域
	StringBuilder totalMoneySb = new StringBuilder();
	totalMoneySb.append("商品总计：<font style=\"font-size:13px; font-weight:bold;\" id=\"total_Count\">").append(CartHelper.getTotalProductCount(request,response)).append("</font>件");
	totalMoneySb.append("<font style=\"color:#d80100; font-size:16px; font-weight:bold; margin-left:30px;\">应付总额：<span id=\"total_Price\">").append(CartHelper.getTotalPayMoney(request,response)).append("</span>元</font>");
	//totalMoneySb.append("商品总计：<font style=\"font-size:13px; font-weight:bold;\" id=\"total_Count\">").append(CartShopCodeHelper.getTotalProductCount(request,response,shopcode)).append("</font>件");
	//totalMoneySb.append("<font style=\"color:#d80100; font-size:16px; font-weight:bold; margin-left:30px;\">应付总额：<span id=\"total_Price\">").append(CartShopCodeHelper.getTotalPayMoney(request,response,shopcode)).append("</span>元</font>");
	
	Map<String,Object> map = new HashMap<String,Object>();
	map.put("error",new Integer(1));
	
	Map<String,Object> content_map = new HashMap<String,Object>();
	
	//赠品
	List<GiftHelper.GiftGoods> giftList = GiftHelper.getCartVisiableGiftProducts(request,response);
	int giftCount = (giftList == null ? 0 : giftList.size());
	
	content_map.put("delete_goods_key",delete_list);//删除的物品
	content_map.put("tishi_delete_favor",deleteStr);//删除赠品的提示
	content_map.put("update_goods_key" , update_list);//库存不足的
	content_map.put("have_gift_goods_key",gift_list);//主物品关联的赠品
	content_map.put("favor_out_cart",new Integer(giftCount));//赠品数量
	content_map.put("zengpin_area",zengpinArea(request,response,giftList));//赠品区域
	content_map.put("total_area",totalMoneySb.toString());//总金额的HTML代码
	
	map.put("content",content_map);
	
	out.print(JSONObject.fromObject(map));
}else{
	int totalGift_1 = 0 ,totalVisiable_1 = 0;//选择的赠品数
	ArrayList<Cart> cList123 = CartHelper.getCartItems(request, response);
	for(Cart cart_1:cList123){
		if(cart_1.getType().longValue()==0)totalGift_1++;
	}
	
	ArrayList<GiftHelper.GiftGoods> giftList = GiftHelper.getCartVisiableGiftProducts(request, response);
	if(giftList!=null){
		for(GiftHelper.GiftGoods gg_77p:giftList){
			if(gg_77p.isIsfree()){
				totalVisiable_1++;
			}
		}
	}
	
	if(totalVisiable_1>0&&totalGift_1==0){
		out.print("{\"error\":-1,\"content\":\"\"}");//没有选择赠品
		return;
	}else{
		if(isbrand){
		User user=UserHelper.getById(lUser.getId());
		if(user!=null && user.getMbrmst_finishdate()!=null){//不是第一次购物
			out.print("{\"error\":-6,\"content\":\"\"}");
				return;
			}else{
				out.print("{\"error\":0,\"content\":\"\"}");//完全没有错误。
				return;
				}
		}else{
		out.print("{\"error\":0,\"content\":\"\"}");//完全没有错误。
		return;
		}
	}
}
%>