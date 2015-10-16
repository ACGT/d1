<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %>
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
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}
Long Tuandh_mid=0L;
String strgdsid="";
String title="";
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
			out.print("{\"code\":1,message:\"该兑换活动已经结束！\"}");
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
				out.print("{\"code\":1,message:\"该兑换码已经兑换过！\"}");
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
			out.print("{\"code\":1,message:\"该兑换码不存在！\"}");
			return;
		}
	}
	
}

Tuandh tuandh=null;
if(!isnew){
	 tuandh=(Tuandh)Tools.getManager(Tuandh.class).findByProperty("tuandh_cardno", strgdsdh_code);
	if(tuandh==null){
		out.print("{\"code\":1,message:\"该兑换码不存在！\"}");
		return;
	}
	if(tuandh.getTuandh_status().longValue()==2){
		out.print("{\"code\":1,message:\"该兑换码已经兑换过！\"}");
		return;
	}
	if(Tools.dateValue(tuandh.getTuandh_endtime())<System.currentTimeMillis())
	{
		out.print("{\"code\":1,message:\"该兑换活动已经结束！\"}");
		return;
	}
	 strgdsid=tuandh.getTuandh_gdsid();
	 Tuandh_mid=tuandh.getTuandh_mid();
	 title=tuandh.getTuandh_title();
}

if(Tuandh_mid!=6){
	out.print("{\"code\":1,message:\"此兑换码错误！\"}");
	return;
}

Product product = ProductHelper.getById(strgdsid);
if(product == null){
	out.print("{\"code\":1,message:\"很抱歉，您输入的信息不正确，请确认后重试！\"}");
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
	
	float ftuanprice=0;
	String strgdsidOne="";


    if("01410915".equals(strgdsid)){//2014-1-1结束
    	ftuanprice=0;b=true;
    }else if("03300070".equals(strgdsid)){
    	ftuanprice=0;b=true;
    }else if("01415028".equals(strgdsid)){
    	ftuanprice=89;
    }else if("01417367".equals(strgdsid)){
    	ftuanprice=25;
    }else if("01417359".equals(strgdsid)){
    	ftuanprice=29;
    }else if("01417386".equals(strgdsid)){
    	ftuanprice=69;
    }else if("01412912".equals(strgdsid)){
    	ftuanprice=59;
    }else if("01517687".equals(strgdsid)){
    	ftuanprice=99;
    }else if("01511732".equals(strgdsid)){
    	ftuanprice=69;
    }else if("03001147".equals(strgdsid)){
    	ftuanprice=39;
    }else if("02001030".equals(strgdsid)){
    	ftuanprice=25;
    }else if("01517382".equals(strgdsid)){
    	ftuanprice=89;
    }else if("03000902".equals(strgdsid)){
    	ftuanprice=99;
    }else if("01516553".equals(strgdsid)){
    	ftuanprice=139;
    }else if("04000467".equals(strgdsid)){
    	ftuanprice=49;
    }else if("01205354".equals(strgdsid)){
    	ftuanprice=75;   
    }else if("03000779".equals(strgdsid)){
    	ftuanprice=49; 
    }else if("04000003".equals(strgdsid)&&strgdsdh_code.startsWith("mqd1311a")){//下面2014-1-16号结束
    	ftuanprice=19; 
    }else if("01517876".equals(strgdsid)){
    	ftuanprice=69;   
    }else if("01417597".equals(strgdsid)){
    	ftuanprice=39;   
    }else if("01417578".equals(strgdsid)){
    	ftuanprice=49;   
    }else if("01417340".equals(strgdsid)&&strgdsdh_code.startsWith("mqd1311g")){
    	ftuanprice=39;   
    }else if("01205303".equals(strgdsid)){
    	ftuanprice=9.9f;  
    }else if("03000779".equals(strgdsid)&&strgdsdh_code.startsWith("mqdd1312tjx")){//2014-2-1
    	ftuanprice=0;b=true;
    }else if("02200265".equals(strgdsid)&&(strgdsdh_code.startsWith("mqdd1312mx")||strgdsdh_code.startsWith("mq131226j"))){ 
    	ftuanprice=0;b=true;
    }else if("02001597".equals(strgdsid)&&strgdsdh_code.startsWith("mqdd1312my")){ 
    	ftuanprice=0;b=true;
    }else if("04000543".equals(strgdsid)&&(strgdsdh_code.startsWith("mqdd1312mz")||strgdsdh_code.startsWith("mq131226i"))){ 
    	ftuanprice=0;b=true;
    }else if("01417694".equals(strgdsid)&&strgdsdh_code.startsWith("mqdd1312tje")){ 
    	ftuanprice=0;b=true;
    }else if("01417331".equals(strgdsid)&&strgdsdh_code.startsWith("mqdd1312yjf")){ 
    	ftuanprice=0;b=true;
    }else if("01417584".equals(strgdsid)&&strgdsdh_code.startsWith("mqdd1312ejg")){ 
    	ftuanprice=0;b=true;
    }else if("01205287".equals(strgdsid)&&strgdsdh_code.startsWith("mqdd1312sjh")){ 
    	ftuanprice=0;b=true;
    }else if("01417607".equals(strgdsid)&&strgdsdh_code.startsWith("mqdd1312me")){ 
    	ftuanprice=0;b=true;
    }else if("01417691".equals(strgdsid)&&strgdsdh_code.startsWith("mqdd1312mf")){ 
    	ftuanprice=0;b=true;
    }else if("01417611".equals(strgdsid)&&strgdsdh_code.startsWith("mqdd1312mg")){ 
    	ftuanprice=0;b=true;
    }else if("01511839".equals(strgdsid)&&strgdsdh_code.startsWith("mqdd1312tja")){ 
    	ftuanprice=0;b=true;
    }else if("01517871".equals(strgdsid)&&strgdsdh_code.startsWith("mqdd1312yjb")){ 
    	ftuanprice=0;b=true;
    }else if("01517623".equals(strgdsid)&&strgdsdh_code.startsWith("mqdd1312rjc")){ 
    	ftuanprice=0;b=true;
    }else if("01517612".equals(strgdsid)&&strgdsdh_code.startsWith("nqdd12ma")){ 
    	ftuanprice=0;b=true;
    }else if("01515468".equals(strgdsid)&&strgdsdh_code.startsWith("mqdd1312mb")){ 
    	ftuanprice=0;b=true;
    }else if("01516824".equals(strgdsid)&&(strgdsdh_code.startsWith("mqdd1312mc")||strgdsdh_code.startsWith("mq131226g"))){ 
    	ftuanprice=0;b=true;
    }else if("01517648".equals(strgdsid)&&strgdsdh_code.startsWith("mq131226e")){ 
    	ftuanprice=0;b=true;
    }else if("01517611".equals(strgdsid)&&strgdsdh_code.startsWith("mq131226f")){ 
    	ftuanprice=0;b=true;
    }else if("03000778".equals(strgdsid)&&strgdsdh_code.startsWith("mq131226h")){ 
    	ftuanprice=0;b=true;
    }else if("01417456".equals(strgdsid)){
    	ftuanprice=79; 
    }else if("01415807".equals(strgdsid)){
    	ftuanprice=35; 
    }else if("01413063".equals(strgdsid)){
    	ftuanprice=75; 
    }else if("01409938".equals(strgdsid)){
    	ftuanprice=69; 
    }else if("01409954".equals(strgdsid)){
    	ftuanprice=79; 
    }else if("01417535".equals(strgdsid)){
    	ftuanprice=19; 
    }else if("01417614".equals(strgdsid)){
    	ftuanprice=15;
    }else if("01415488".equals(strgdsid)){
    	ftuanprice=29; 
    }else if("01417756".equals(strgdsid)){
    	ftuanprice=9.9f; 
    }else if("01408176".equals(strgdsid)){
    	ftuanprice=42; 
    }else if("01414938".equals(strgdsid)){
    	ftuanprice=55; 
    }else if("01410218".equals(strgdsid)){
    	ftuanprice=39; 
    }else if("01417341".equals(strgdsid)){
    	ftuanprice=9.9f; 
    }else if("01416804".equals(strgdsid)){
    	ftuanprice=29; 
    }else if("01417491".equals(strgdsid)){
    	ftuanprice=29; 
    }else if("01413703".equals(strgdsid)){
    	ftuanprice=25; 
    }else if("01721268".equals(strgdsid)){
    	ftuanprice=25; 
    }else if("02003538".equals(strgdsid)){
    	ftuanprice=69; 
    }else if("03001646".equals(strgdsid)&&strgdsdh_code.startsWith("mqdd1312nf")){
    	ftuanprice=99; 
    }else if("03000776".equals(strgdsid)){
    	ftuanprice=69; 
    }else if("01517056".equals(strgdsid)){
    	ftuanprice=9.9f; 
    }else if("01517521".equals(strgdsid)){
    	ftuanprice=119; 
    }else if("01517639".equals(strgdsid)){
    	ftuanprice=59; 
    }else if("01517867".equals(strgdsid)){
    	ftuanprice=69; 
    }else if("01517590".equals(strgdsid)){
    	ftuanprice=109; 
    }else if("01511975".equals(strgdsid)){
    	ftuanprice=129; 
    }else if("01517762".equals(strgdsid)){
    	ftuanprice=69; 
    }else if("01517028".equals(strgdsid)){
    	ftuanprice=109; 
    }else if("01510245".equals(strgdsid)){
    	ftuanprice=89; 
    }else if("01517892".equals(strgdsid)){
    	ftuanprice=69; 
    }else if("01517875".equals(strgdsid)){
    	ftuanprice=79; 
    }else if("01517874".equals(strgdsid)){
    	ftuanprice=109; 
    }else if("01517866".equals(strgdsid)){
    	ftuanprice=65;
    }else if("01517758".equals(strgdsid)){
    	ftuanprice=65;
    }else if("01517890".equals(strgdsid)){
    	ftuanprice=59;
    }else if("01205400".equals(strgdsid)){
    	ftuanprice=100;
    }else if("01517888".equals(strgdsid)){
    	ftuanprice=49;
    }else if("01517891".equals(strgdsid)){
    	ftuanprice=59;
    }else if("02300233".equals(strgdsid)){
    	ftuanprice=25;
    }else if("02007512".equals(strgdsid)){
    	ftuanprice=7.9f;
    }else if("01205375".equals(strgdsid)){
    	ftuanprice=35;
    }else if("03003099".equals(strgdsid)){
    	ftuanprice=49;
    }else if("01517681".equals(strgdsid)){
    	ftuanprice=69;
    }else if("01517877".equals(strgdsid)){
    	ftuanprice=49;
    }else if("01417359".equals(strgdsid)){
    	ftuanprice=29;
    }else if("01720843".equals(strgdsid)){//以下2014-03-1结束
    	ftuanprice=25;
    }else if("03001646".equals(strgdsid)&&strgdsdh_code.startsWith("mqdd140106o")){
    	ftuanprice=89;
    }else if("01417340".equals(strgdsid)&&strgdsdh_code.startsWith("mqdd140106p")){
    	ftuanprice=29;
    }else if("02002019".equals(strgdsid)){
    	ftuanprice=19;
    }else if("04000003".equals(strgdsid)&&strgdsdh_code.startsWith("mqdd140106r")){
    	ftuanprice=9.9f; 
    }else if("01518007".equals(strgdsid)){
    	ftuanprice=49;
    }else if("04000718".equals(strgdsid)){
    	ftuanprice=19;
    }else if("02007859".equals(strgdsid)){
    	ftuanprice=39;
    }else if("01205396".equals(strgdsid)){
    	ftuanprice=29;
    }else if("01205397".equals(strgdsid)){
    	ftuanprice=19;
    }else if("01205398".equals(strgdsid)){
    	ftuanprice=19;
    }else if("02007521".equals(strgdsid)){
    	ftuanprice=39;
    }else if("03100504".equals(strgdsid)){
    	ftuanprice=75;
    }else if("03003434".equals(strgdsid)){
    	ftuanprice=69;
    }else if("01517928".equals(strgdsid)){
    	ftuanprice=9.9f;
    }else if("05001203".equals(strgdsid)){//有效期：2014.02.28
    	ftuanprice=69;
    }else if("01205420".equals(strgdsid)){
    	ftuanprice=25;
    }else if("01518254".equals(strgdsid)){
    	ftuanprice=15;
    }else if("01518205".equals(strgdsid)){
    	ftuanprice=69;
    }else if("03003508".equals(strgdsid)){
    	ftuanprice=49;
    }else if("02008100".equals(strgdsid)){
    	ftuanprice=49;
    }else if("03300029".equals(strgdsid)){
    	ftuanprice=59;
    }else if("03003469".equals(strgdsid)){
    	ftuanprice=49;
    }else if("03002766".equals(strgdsid)){
    	ftuanprice=79;
    }else if("03300043".equals(strgdsid)){
    	ftuanprice=79;
    }else if("01512997".equals(strgdsid)){
    	ftuanprice=79;
    }else if("01505433".equals(strgdsid)){
    	ftuanprice=219;
    }else if("01517903".equals(strgdsid)){
    	ftuanprice=19;
    }else if("01516814".equals(strgdsid)){
    	ftuanprice=49;
    }else if("01517547".equals(strgdsid)){
    	ftuanprice=59;
    }	

if(ftuanprice==0 && !b){
		out.print("{\"code\":1,message:\"商品兑换错误！\"}");
		return;
	}
	
	ArrayList<Cart> cartList = CartHelper.getCartItems(request, response);	
	boolean hasOne = false ;
	if(cartList!=null){
		for(Cart c123:cartList){
			if(c123.getType().longValue()==13&&c123.getProductId().equals(strgdsidOne)){
				hasOne = true ;
				break;
			}
		}
	}
	
	if(hasOne){
		out.print("{\"code\":1,message:\"一个订单最多只能兑换一个此商品！\"}");
		return;
	}

	hasOne = false ;
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
	cart.setProductId(strgdsid);
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