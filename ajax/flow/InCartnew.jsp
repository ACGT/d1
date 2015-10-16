<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %>
<%!
public boolean JudgeIsMoblie(HttpServletRequest request) {
    boolean isMoblie = false;
    String[] mobileAgents = { "iphone", "android", "phone", "mobile", "wap", "netfront", "java", "opera mobi",
            "opera mini", "ucweb", "windows ce", "symbian", "series", "webos", "sony", "blackberry", "dopod",
            "nokia", "samsung", "palmsource", "xda", "pieplus", "meizu", "midp", "cldc", "motorola", "foma",
            "docomo", "up.browser", "up.link", "blazer", "helio", "hosin", "huawei", "novarra", "coolpad", "webos",
            "techfaith", "palmsource", "alcatel", "amoi", "ktouch", "nexian", "ericsson", "philips", "sagem",
            "wellcom", "bunjalloo", "maui", "smartphone", "iemobile", "spice", "bird", "zte-", "longcos",
            "pantech", "gionee", "portalmmm", "jig browser", "hiptop", "benq", "haier", "^lct", "320x320",
            "240x320", "176x220", "w3c ", "acs-", "alav", "alca", "amoi", "audi", "avan", "benq", "bird", "blac",
            "blaz", "brew", "cell", "cldc", "cmd-", "dang", "doco", "eric", "hipt", "inno", "ipaq", "java", "jigs",
            "kddi", "keji", "leno", "lg-c", "lg-d", "lg-g", "lge-", "maui", "maxo", "midp", "mits", "mmef", "mobi",
            "mot-", "moto", "mwbp", "nec-", "newt", "noki", "oper", "palm", "pana", "pant", "phil", "play", "port",
            "prox", "qwap", "sage", "sams", "sany", "sch-", "sec-", "send", "seri", "sgh-", "shar", "sie-", "siem",
            "smal", "smar", "sony", "sph-", "symb", "t-mo", "teli", "tim-", "tosh", "tsm-", "upg1", "upsi", "vk-v",
            "voda", "wap-", "wapa", "wapi", "wapp", "wapr", "webc", "winw", "winw", "xda", "xda-",
            "Googlebot-Mobile" };
    if (request.getHeader("User-Agent") != null) {
        for (String mobileAgent : mobileAgents) {
            if (request.getHeader("User-Agent").toLowerCase().indexOf(mobileAgent) >= 0) {
                isMoblie = true;
                break;
            }
        }
    }
    return isMoblie;
}
public static ArrayList<PromotionProduct> getPProductByCodeGdsid(String code,String id){
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();

			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
			clist.add(Restrictions.eq("spgdsrcm_gdsid",id));
			List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, null, 0, 100);
			
			if(list!=null){
				for(BaseEntity be:list){
					PromotionProduct pp = (PromotionProduct)be;
					rlist.add(pp);
				}
			}
		
	
	return rlist ;
}

//获取白金独享商品列表
private static ArrayList<PromotionProduct> getbjdxlist(String gdsid)
{
	ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code", new Long("8322")));
	clist.add(Restrictions.eq("spgdsrcm_gdsid", gdsid));
	clist.add(Restrictions.ge("spgdsrcm_enddate", new Date()));
	clist.add(Restrictions.le("spgdsrcm_begindate", new Date()));
	List<Order> olist = new ArrayList<Order>();
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, 1000);
	if(clist==null||clist.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((PromotionProduct)be);
	}
	return rlist ;
}
%>
<%
String gdsid = request.getParameter("gdsid");//商品编号
Product product = ProductHelper.getById(gdsid);
//String  gdsReferer=Tools.getCookie(request, "gdsReferer");
String gdsReferer="";
if (session.getAttribute("gdsReferer")!=null){
	gdsReferer=session.getAttribute("gdsReferer").toString();
}
if (URLDecoder.decode(gdsReferer).indexOf(gdsid+"\":")==-1){
	gdsReferer="";
	
}else{
	gdsReferer=URLDecoder.decode(gdsReferer);
JSONObject  jsonob = JSONObject.fromObject(gdsReferer); 
Map<String, Object> mapref = (Map)jsonob;
gdsReferer=mapref.get(gdsid).toString();
if (gdsReferer.length()>=400){
	gdsReferer=gdsReferer.substring(0, 380);
}
}

if(product == null){
	out.print("{\"success\":false,\"message\":\"商品不存在，请刷新页面！\"}");
	return;
}

//商品数量
int iCount = Tools.parseInt(request.getParameter("count"));
if(iCount <= 0) iCount = 1;

//商品是否在架上
if(Tools.longValue(product.getGdsmst_validflag()) != 1){
	out.print("{\"success\":false,\"message\":\"对不起，您选购的商品现在暂时性脱销，请您过一段时间再来购买。\"}");
	return;
}



ArrayList<PromotionProduct> list1= getPProductByCodeGdsid("8085",gdsid);
ArrayList<PromotionProduct> list2= getPProductByCodeGdsid("8086",gdsid);
ArrayList<PromotionProduct> bjdxlist= getbjdxlist(gdsid);
boolean b=false;
if(list1!=null && list1.size()>0 && list2!=null && list2.size()>0 ){
	b=true;
}
boolean sfbjdx=false;
PromotionProduct pbjdx=new PromotionProduct();
if(bjdxlist!=null&&bjdxlist.size()>0)
{
	sfbjdx=true;
	pbjdx=bjdxlist.get(0);
}
//缺货标识
long ifhaveges = Tools.longValue(product.getGdsmst_ifhavegds());
if(ifhaveges == 3 && !b){
	out.print("{\"success\":false,\"message\":\"您好！此商品为非卖品，不能单独订购！\"}");
	return;
}
if(ifhaveges == 2){
	out.print("{\"success\":false,\"message\":\"对不起，此商品暂时缺货！\"}");
	return;
}


if(product.getGdsmst_buylimit()!=null&&product.getGdsmst_buylimit().intValue()>0){
	ArrayList<Cart> allCartList = CartHelper.getCartItems(request, response);
	int cartCount = 0;
	if(allCartList!=null){
		for(Cart c_23894:allCartList){
			if(product.getId().equals(c_23894.getProductId())){
				cartCount+=c_23894.getAmount().intValue();
			}
		}
	}
	if(cartCount+iCount>product.getGdsmst_buylimit().intValue()){
		out.print("{\"success\":false,\"message\":\"对不起，该商品限购"+product.getGdsmst_buylimit().intValue()+"个！\"}");
		return;
	}
}

if(ifhaveges == 1){//有到货日期
	Date ifhaveDate = product.getGdsmst_ifhavedate(); 
	if(ifhaveDate != null){//那就是有到货期限。
		long spanDay = (ifhaveDate.getTime()-System.currentTimeMillis())/Tools.DAY_MILLIS+1;
		if(spanDay > 0){
			out.print("{\"success\":false,\"message\":\"此商品暂时缺货，预计"+spanDay+"天到货！\"}");
			return;
		}else{
			out.print("{\"success\":false,\"message\":\"对不起，此商品暂时缺货，近期将到货！\"}");
			return;
		}
	}else{
		out.print("{\"success\":false,\"message\":\"对不起，此商品暂时缺货，近期将到货！\"}");
		return;
	}
}
String skuId = null;
if(SkuHelper.hasSku(product)){
	//判断sku
	skuId = request.getParameter("skuId");
	if(Tools.isNull(skuId)){
		out.print("{\"success\":false,\"message\":\"您好！请选择"+product.getGdsmst_skuname1()+"！\"}");
		return;
	}
	if(!SkuHelper.hasInSkuList(product , skuId)){
		out.print("{\"success\":false,\"message\":\"您好！您选择的"+product.getGdsmst_skuname1()+"不存在，请重新选择！\"}");
		return;
	}
}

//量少提醒和卖完就下的商品检查一下虚拟库存够不够
if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
	int countInCart_1239 = CartHelper.getCartProductCount(request, response, product, skuId);//购物车里已经订购的数量
	if(iCount+countInCart_1239+CartItemHelper.getProductOccupyStock(product.getId(), skuId)>ProductHelper.getVirtualStock(product.getId(), skuId)){
		int i_239489 = ProductHelper.getVirtualStock(product.getId(), skuId)-CartItemHelper.getProductOccupyStock(product.getId(), skuId)-countInCart_1239;
		if(i_239489<=0){
			out.print("{\"success\":false,\"message\":\"您好！该商品已售完！\"}");
		}else{
			out.print("{\"success\":false,\"message\":\"您好！该商品只剩"+i_239489+"个！\"}");
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

//用户没有选择促销方式，存储过程463-499
if(iDiscid == -1){
	
}else{
	//计算折扣后的价格。
}
//判断价格是否为0
/*if(memberprice == 0 || vipprice == 0){
	out.print("{\"success\":false,\"message\":\"对不起，此商品价格正在调整中，请您过一段时间再来购买！\"}");
	return;
}*/

boolean msflag=CartHelper.getmsflag(product);
boolean isdx=false;
String dxid=Tools.getCookie(request,"rcmdusr_rcmid");

if(!Tools.isNull(dxid)){
	
	ProductExpPriceItem expitem = ProductExpPriceHelper.getExpPrice(gdsid,dxid);
	if(expitem != null){	
		isdx=true;
	}
}

String shopcode="00000000";
if(product.getGdsmst_shopcode()!=null&&!product.getGdsmst_shopcode().equals("08102301"))shopcode=product.getGdsmst_shopcode();

Date nowday=new Date();

if(JudgeIsMoblie(request)&&!isdx){
	ArrayList<PromotionProduct> listphone= getPProductByCodeGdsid("9377",gdsid);
	
	if(listphone!=null && listphone.size()>0 ){
		PromotionProduct phonepp=listphone.get(0);
		if(phonepp!=null){
		Date sdate=phonepp.getSpgdsrcm_begindate();
		Date edate=phonepp.getSpgdsrcm_enddate();

		if(phonepp.getSpgdsrcm_tjprice()!=null&&nowday.getTime()>=sdate.getTime()
		&&edate.getTime()> nowday.getTime()){

			//放入购物车
			Cart cart = new Cart();
			cart.setParentId("0");
			cart.setSkuId(skuId);
			cart.setAmount(new Long(iCount));//数量
			cart.setProductId(gdsid);
			cart.setPrice(phonepp.getSpgdsrcm_tjprice().floatValue());
			cart.setOldPrice(product.getGdsmst_memberprice());
			cart.setVipPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.VIP_DISCOUNT,2));
			cart.setType(new Long(22));
			cart.setTitle("【手机独享】"+product.getGdsmst_gdsname());
			cart.setRefererurl(gdsReferer);
			cart.setShopcode(shopcode);
			CartHelper.addCart(request,response,cart);
			out.print("{\"success\":true,\"message\":\"添加成功！\"}");
			return;
		}
		}
	}
}





/*if("01411487".equals(gdsid)){
System.out.println(msflag+"=====商品价格修改22===="+product.getGdsmst_msprice()+"========"+isdx);
}
*/

boolean ismiaoshao=false;
SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
if(product.getGdsmst_promotionstart()!=null&&product.getGdsmst_promotionend()!=null&&product.getGdsmst_msprice()!=null){
	Date sdate=product.getGdsmst_promotionstart();
	Date edate=product.getGdsmst_promotionend();	

	if(nowday.getTime()>=sdate.getTime()&&edate.getTime()> nowday.getTime()
			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
			&&product.getGdsmst_msprice().floatValue()>=0f){
		ismiaoshao = true;
	}

}
SgGdsDtl sg=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid", gdsid);
if(ismiaoshao){

if(sg!=null){
	//System.out.println(sg.getSggdsdtl_maxnum().longValue()+"--------"+sg.getSggdsdtl_realbuynum().longValue());
	if(sg.getSggdsdtl_maxnum().longValue()<=sg.getSggdsdtl_realbuynum().longValue()
			||sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue()<=0){
	out.print("{\"success\":false,\"message\":\"您好！商品【"+StringUtils.clearHTML(product.getGdsmst_gdsname())+"】已经被抢光！\"}");
	return;
	}
}
}

if(sfbjdx&&lUser!=null&&UserHelper.isPtVip(lUser)&&pbjdx!=null&&pbjdx.getSpgdsrcm_tjprice()!=null)
{
	//放入购物车
	Cart cart = new Cart();
	cart.setParentId("0");
	cart.setSkuId(skuId);
	cart.setAmount(new Long(iCount));//数量
	cart.setProductId(gdsid);
	cart.setPrice(pbjdx.getSpgdsrcm_tjprice()!=null?pbjdx.getSpgdsrcm_tjprice().floatValue():product.getGdsmst_memberprice());
	cart.setOldPrice(product.getGdsmst_memberprice());
	cart.setVipPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.VIP_DISCOUNT,2));
	cart.setType(new Long(17));
	cart.setTitle("[白金独享商品]"+product.getGdsmst_gdsname());
	cart.setRefererurl(gdsReferer);
	cart.setShopcode(shopcode);
	CartHelper.addCart(request,response,cart);
	out.print("{\"success\":true,\"message\":\"添加成功！\"}");
	return;
}else if(!isdx&&product.getGdsmst_msprice()!=null
		&&msflag&&product.getGdsmst_msprice().floatValue()>=0f){
	 
	String  gdstxt="【秒杀】";
	 if(sg!=null){
		 
		 if(sg.getSggdsdtl_status().longValue()==1){
			 gdstxt="【闪购】";
			// System.out.println(sg.getSggdsdtl_realbuynum().longValue()+iCount+"---------------------------");
			 sg.setSggdsdtl_realbuynum(new Long(sg.getSggdsdtl_realbuynum().longValue()+iCount));
				Tools.getManager(SgGdsDtl.class).update(sg, true);
		 }
	 if(sg.getSggdsdtl_limitgroup().longValue()>0){
	    ArrayList<Cart> allCartList = CartHelper.getCartItems(request, response);
	    int cartCount = 0;
	    if(allCartList!=null){
		  for(Cart c_23894:allCartList){
			SgGdsDtl sgc=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid", c_23894.getProductId());
		    if(sgc!=null&&sg.getSggdsdtl_limitgroup().longValue()==sgc.getSggdsdtl_limitgroup().longValue()){
		    	out.print("{\"success\":false,\"message\":\"您好！购物车已经存在此闪购组里的商品。此闪购组的商品一个订单只能订购一个！\"}");
		    	return;
		    }
		}
	   }
	  }
	 }
	
	
	Cart cart = new Cart();
	cart.setParentId("0");
	cart.setSkuId(skuId);
	cart.setAmount(new Long(iCount));//数量
	cart.setProductId(gdsid);
	cart.setPrice(product.getGdsmst_msprice());
	cart.setOldPrice(product.getGdsmst_memberprice());
	cart.setVipPrice(product.getGdsmst_msprice());
	cart.setType(new Long(20));
	cart.setShopcode(shopcode);
	cart.setTitle(gdstxt+product.getGdsmst_gdsname());
	cart.setRefererurl(gdsReferer);
	CartHelper.addCart(request,response,cart);
	out.print("{\"success\":true,\"message\":\"添加成功！\"}");
	return;
	
}else{
	//放入购物车
	Cart cart = new Cart();
	cart.setParentId("0");
	cart.setSkuId(skuId);
	cart.setAmount(new Long(iCount));//数量
	cart.setProductId(gdsid);
	cart.setOldPrice(product.getGdsmst_memberprice());
	cart.setPrice(product.getGdsmst_memberprice());
	cart.setVipPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.VIP_DISCOUNT,2));
	cart.setType(new Long(1));
	cart.setShopcode(shopcode);
	cart.setTitle(product.getGdsmst_gdsname());
	cart.setRefererurl(gdsReferer);
	CartHelper.addCart(request,response,cart);
	out.print("{\"success\":true,\"message\":\"添加成功！\"}");
	return;
}



%>