<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

/*try{
	 dStartDate =fmt.parse("2013-05-1");
	 endDate=fmt2.parse("2013-04-30 23:59:59");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print("{\"success\":false,\"urlflag\":false,\"message\":\"对不起活动已经结束！\"}");
	return;
}
String  isPingAn = Tools.getCookie(request,"PINGAN");
if (!Tools.isNull(isPingAn)){
	out.print("{\"success\":false,\"urlflag\":false,\"message\":\"您好，平安用户不能参与领券活动！\"}");
	return;
}*/
if(lUser==null) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}
boolean isbj=UserHelper.isPtVip(request, response);
if(!isbj){
	out.print("{\"code\":1,message:\"只有白金用户才可以领取此礼物！\"}");
	return;
}
//System.out.println("周年领券手机验证："+lUser.getMbrmst_phoneflag());
if(lUser.getMbrmst_phoneflag()==null||lUser.getMbrmst_phoneflag().longValue()==0){
		session.setAttribute("zntkturl", "/user/birth.jsp");
	out.print("{\"code\":1,message:\"对不起请<a href='/newlogin/valitel.jsp' target='_blank'>认证手机</a>然后再来领生日礼物！\"}");
	return;
}
UserVip bjbirth=(UserVip)Tools.getManager(UserVip.class).get(lUser.getId());
Date nowday=new Date();
Date dStartDate=Tools.addDate(nowday, -10); 
Date endDate=Tools.addDate(nowday, 10); 
Date sDate=fmt.parse("2013-04-5");
SimpleDateFormat fmtmd2 = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmtmd = new SimpleDateFormat("MM-dd");
long histime=fmtmd2.parse(fmtmd2.format(sDate)).getTime();
long stime=fmtmd.parse(fmtmd.format(dStartDate)).getTime();
long etime=fmtmd.parse(fmtmd.format(endDate)).getTime();
long birtime=fmtmd.parse(fmtmd.format(lUser.getMbrmst_birthday())).getTime();
long sbirtime=fmtmd2.parse(fmtmd2.format(bjbirth.getBjvip_createtime())).getTime();
//System.out.println(lUser.getMbrmst_birthday());
//System.out.println(fmtmd.format(dStartDate));
//System.out.println(fmtmd.format(endDate));
///System.out.println(birtime+"====="+stime+"======"+etime);
if(birtime>=stime&&birtime<=etime){
String gid = request.getParameter("id");
boolean bjzp=PromotionProductHelper.getPProductByCodeGdsidExist("9601",gid);
if(!bjzp){
	out.print("{\"code\":1,message:\"很抱歉，你的商品并非白金生日赠品！\"}");
	return;
}
Product product = ProductHelper.getById(gid);
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
ArrayList<Cart> cartList = CartHelper.getCartItems(request, response);	
boolean hasOne = false ;
if(cartList!=null){
	for(Cart c123:cartList){
		if(c123.getType().longValue()==19){
			hasOne = true ;
			break;
		}
	}
}

if(hasOne){
	out.print("{\"code\":1,message:\"一个人只能领取一个生日礼物！\"}");
	return;
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


	
 long mbrid= Tools.parseLong(lUser.getId());
	BirthGds birthgds=(BirthGds)Tools.getManager(BirthGds.class).findByProperty("birthgds_mbrid",new Long(mbrid));

	if(birthgds == null||birthgds.getBirthgds_status().longValue()==1) {
		
	
		Cart cart = new Cart();
		cart.setAmount(new Long(1));
		cart.setCookie(CartHelper.getCartCookieValue(request, response));
		cart.setCreateDate(new Date());
		cart.setHasChild(new Long(0));
		cart.setHasFather(new Long(0));
		cart.setIp(request.getRemoteHost());
		cart.setMoney(new Float(0));
		cart.setOldPrice(product.getGdsmst_memberprice());
		cart.setPoint(new Long(0));
		cart.setPrice(new Float(0));
		cart.setSkuId(skuId);//?
		cart.setTuanCode("");//注意parentId值
		cart.setProductId(gid);
		cart.setType(new Long(19));
		cart.setUserId(CartHelper.getCartUserId(request, response));
		cart.setVipPrice(product.getGdsmst_memberprice());
		cart.setTitle("【生日礼物】"+Tools.clearHTML(product.getGdsmst_gdsname()));
		Tools.getManager(Cart.class).create(cart);
		if(birthgds == null){
		BirthGds birth=new BirthGds();
		birth.setBirthgds_gdsid(gid);
		birth.setBirthgds_mbrid(new Long(mbrid));
		birth.setBirthgds_status(new Long(1));
		birth.setBirthgds_memo("生日礼物领取");
		birth.setBirthgds_update(new Date());
		Tools.getManager(BirthGds.class).create(birth);
		}
		int totalCount = CartHelper.getTotalProductCount(request,response);
		float totalAmmount = CartHelper.getTotalPayMoney(request,response);
		out.print("{\"code\":0,\"message\":\"\",\"totalCount\":"+totalCount+",\"totalAmount\":\""+Tools.getFormatMoney(totalAmmount)+"\"}");
		return;
	}else{
	out.print("{\"code\":1,\"message\":\"对不起您已经领过了生日礼物！\"}");
	return;
	}
	}else{
		out.print("{\"code\":1,\"message\":\"对不起您的生日不在领礼物的时间范围！\"}");
		return;
	}




%>