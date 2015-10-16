<%@ page contentType="text/html; charset=UTF-8" %><%@page import="java.math.BigDecimal,java.text.DecimalFormat"%>
<%@include file="../../inc/header.jsp" %><%@include file="/html/productpublic.jsp" %>
<%!
/**
 * 把搭配商品加入购物车
 * @param request
 * @param response
 * @param packageId 商品搭配id
 * @param pmap key=商品id，value=skuid如果有sku的话
 * @return -1=商品搭配不存在，-2商品搭配的明细为空，-3=传入的商品id不是套餐里的商品，-4=套餐已经加过一次了，-5=购物车超过100条记录了
 */
public static int addGdscollToCart(HttpServletRequest request,HttpServletResponse response,String packageId,HashMap<String,String> pmap,String twohttpurl) {
	Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(packageId);
	if(gdscoll==null)
	{
		return -1;
	}
	ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid(gdscoll.getId());
	if(gdlist==null||gdlist.size()==0)
	{
		return -2;
	}
	
	//ArrayList<Cart> cartList = CartHelper.getCartItems(request, response);
	
	//if(cartList!=null&&cartList.size()>100)return -5;
	//Iterator<String> it2 = pmap.keySet().iterator();
	//while(it2.hasNext())
	//{
		//String ppid = it2.next();//商品id
		///boolean flag = false ;
		//for(BaseEntity be:gdlist){
			//Gdscolldetail ppi = (Gdscolldetail)be;
			//if(ppi.getGdscolldetail_gdsid().equals(ppid)){
			//	flag = true ;
			//	break ;
			//}
		//}
		
		//if(!flag){
		//	return -3;
		//}
	//}
	//判断该套餐是否添加到购物车内
	//ArrayList<Cart> cartList =CartHelper.getCartItems(request, response);
	
	///if(cartList!=null&&cartList.size()>100)return -5;
	
	//Cart cartAdded = null ;//该套餐是否加过购物车
	//if(cartList!=null){
		//for(Cart c23:cartList){
			//if(c23.getType().longValue()==-6&&gdscoll.getId().equals(c23.getProductId())){
				//cartAdded = c23 ;
				//break;
			//}
		//}
	//}
	//加入购物车
	
	///if(cartAdded==null){//第一次加入套餐
		//System.out.println("d1gjlincart:"+twohttpurl);
		Cart pcart = new Cart();
		pcart.setAmount(new Long(1));
		pcart.setCreateDate(new Date());
		pcart.setCookie(CartHelper.getCartCookieValue(request,response));
		pcart.setHasChild(new Long(1));
		pcart.setHasFather(new Long(0));
		pcart.setIp(request.getRemoteHost());
		pcart.setMoney(new Float(0));
		pcart.setOldPrice(new Float(0));
		pcart.setPoint(new Long(0));
		pcart.setPrice(new Float(0));//后面会修改Price的
		pcart.setTitle("【搭配购买】"+Tools.clearHTML(gdscoll.getGdscoll_title()));
		pcart.setType(new Long(-6));//-1表示虚拟商品
		pcart.setVipPrice(new Float(0));
		pcart.setUserId(CartHelper.getCartUserId(request,response));
		pcart.setProductId(gdscoll.getId());//这里放入套餐的id
		
		Tools.getManager(Cart.class).create(pcart);
		
		Iterator<String> it3 = pmap.keySet().iterator();
		
		float total_money_pcart = 0,old_total_money_pcart=0;//本次套餐单价，原价
		float zk=0.95f;
		while(it3.hasNext()){
			String ppid = it3.next();//商品id
			
			Gdscolldetail ppi123 = null ;
			for(BaseEntity be:gdlist){
				Gdscolldetail gd=(Gdscolldetail)be;				
				if(gd.getGdscolldetail_gdscrollid().equals(ppid)){
					ppi123 = gd ;
					break ;
				}
			}

			//创建套餐子项
			Product pc = (Product)Tools.getManager(Product.class).get(ppid);
			Cart ccart = new Cart();
			ccart.setAmount(new Long(1));
			ccart.setCreateDate(new Date());
			ccart.setCookie(CartHelper.getCartCookieValue(request,response));
			ccart.setHasChild(new Long(0));
			ccart.setHasFather(new Long(1));
			ccart.setIp(request.getRemoteHost());
			ccart.setMoney(Tools.getFloat((int)(pc.getGdsmst_memberprice().floatValue()*zk),2));//套餐的价格
			ccart.setOldPrice(Tools.getFloat(pc.getGdsmst_memberprice(), 2));
			ccart.setPoint(new Long(0));
			ccart.setSkuId(pmap.get(ppid));
			ccart.setPrice(Tools.getFloat((int)(pc.getGdsmst_memberprice().floatValue()*zk),2));
			ccart.setTitle("【搭配购买】"+Tools.clearHTML(pc.getGdsmst_gdsname()));
			ccart.setProductId(pc.getId());
			ccart.setType(new Long(16));//16表示搭配商品
			ccart.setVipPrice(Tools.getFloat(Const.PT_VIP_DISCOUNT*(float)(pc.getGdsmst_memberprice().floatValue()*zk), 2));
			ccart.setUserId(CartHelper.getCartUserId(request,response));
			ccart.setParentId(pcart.getId());
			ccart.setRefererurl(twohttpurl);
			
			Tools.getManager(Cart.class).create(ccart);
			
			total_money_pcart+=ccart.getPrice().floatValue();
			old_total_money_pcart+=pc.getGdsmst_memberprice().floatValue();
		}
		
		pcart.setPrice(Tools.getFloat(total_money_pcart,2));
		pcart.setOldPrice(Tools.getFloat((int)old_total_money_pcart, 2));
		pcart.setMoney(Tools.getFloat(pcart.getAmount().longValue()*total_money_pcart,2));
		
		Tools.getManager(Cart.class).update(pcart, false);//修改套餐单价
	//}else{//多次加入同一个套餐，不允许
		//return -4 ;
	//}
	
	
	
	//while(it2.hasNext()){
		//String ppid = it2.next();//商品id		
		//Gdscolldetail ppi123 = null ;	
	
	    //Product pc = (Product)Tools.getManager(Product.class).get(ppid);
	    //if(pc!=null&&pc.getGdsmst_ifhavegds().longValue()==0&&pc.getGdsmst_validflag().longValue()==1)
	   // {
		//	Cart cart = new Cart();
			//cart.setParentId("0");
			//cart.setSkuId(pmap.get(ppid));
			//cart.setAmount(new Long(1));//数量
			//cart.setProductId(pc.getId());
			//cart.setOldPrice(pc.getGdsmst_memberprice());
			//cart.setVipPrice(Tools.getFloat(pc.getGdsmst_memberprice().floatValue()*Const.VIP_DISCOUNT,2));
			//cart.setType(new Long(1));
			//cart.setTitle(pc.getGdsmst_gdsname());
			//cart.setShopcode(pc.getGdsmst_shopcode());
			//CartHelper.addCart(request,response,cart);
	   // }
		
	//}
         
	
	
	
	CartHelper.updateAllCartItems(request,response);
	
	return 1;
}
private static String getErrorJSON(int error  , HttpServletRequest request , HttpServletResponse response){
	String str = null;
	switch(error){
		case 1:
			//获得购物车总金额和总商品数量
			int totalCount = CartHelper.getTotalProductCount(request,response);
			float totalAmmount = CartHelper.getTotalPayMoney(request,response);
			
			str = "{\"code\":0,\"message\":\"\",\"totalCount\":"+totalCount+",\"totalAmount\":\""+Tools.getFormatMoney(totalAmmount)+"\"}";
			break;
		case -1:
			str = "{\"code\":1,message:\"找不到商品组合信息。\"}";
			break;
		case -2:
			str = "{\"code\":1,message:\"商品组合明细为空！\"}";
			break;
		case -3:
			str = "{\"code\":1,message:\"您传入的商品不是该组合中！\"}";
			break;
		case -4:
			str = "{\"code\":1,message:\"您已经加过了此商品组合。\"}";
			break;
		case -5:
			str = "{\"code\":1,message:\"您的购物车超过了100条记录，请先提交再继续购买！\"}";
			break;
		default:
			str = "{\"code\":1,message:\"加入购物车发生错误，请稍后再试！\"}";
	}
	return str;
}


%><%
String code = request.getParameter("code");


if(code == null || !Tools.isNumber(code)){
	out.print("{\"code\":1,message:\"很抱歉，您输入的搭配编号不正确，请确认后重试。\"}");
	return;
}

Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(code);
if(gdscoll==null)
{
	out.print("{\"code\":1,message:\"很抱歉，您输入的搭配编号不正确搭配不存在，请确认后重试。\"}");
	return;
}

ArrayList<Gdscolldetail> list=GdscollHelper.getGdscollBycollid(gdscoll.getId());
if(list==null||list.size()==0)
{
	out.print("{\"code\":1,message:\"该搭配下没有物品信息！\"}");
	return;
	}

int itemsize=list.size();

String id = request.getParameter("id");
if(Tools.isNull(id)){
	out.print("{\"code\":1,message:\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
	return;
}


String[] ids = id.split(",");
if(ids == null || ids.length < 2){
	out.print("{\"code\":1,message:\"很抱歉，您至少选择一个搭配商品。\"}");
	return;
}
String str = "";
List<Product> productlist = new ArrayList<Product>();

for(String gdsid : ids){
	for(int i=0;i<itemsize;i++){
		Gdscolldetail gd=(Gdscolldetail)list.get(i);
		if(gd!=null&&gd.getGdscolldetail_gdsid().toString().equals(gdsid))
		{
			Product product = ProductHelper.getById(gdsid);
			if(ProductHelper.isShow(product)&&ProductStockHelper.canBuy(product)){
				productlist.add(product);
				
			}else{
				str += "，<font color='red'>"+Tools.clearHTML(product.getGdsmst_gdsname())+"</font>";
			}
		}
	}
		
}


if(str.length() > 0){
	str = "&nbsp;"+str.substring(1)+"&nbsp;";
	
}

int size = productlist.size();

//------------------------记录商品来源链接--------------------------------------
String twohttpurl=request.getHeader("Referer");
if(Tools.isNull(twohttpurl))twohttpurl=request.getHeader("referer");
if (!Tools.isNull(twohttpurl)){
	try{
		twohttpurl =java.net.URLDecoder.decode(twohttpurl,"UTF-8");
 }
 catch(Exception ex){
	  ex.printStackTrace();
 }
}
//----------------------------------------------------------------------------



//System.out.print("productlist="+size);
//if(list == null || size != gdlist.size()){
	//out.print("{\"code\":1,message:\"您选择的商品"+str+"已下架或缺货，无法购买该组合！\"}");
	//return;
//}
//判断是否有SKU，如果有SKU则弹出SKU的选择层。
//存在SKU
String skuId = request.getParameter("skuId");
//System.out.print(skuId);
if(Tools.isNull(skuId)){//用户没有传递sku过来。则判断物品是否需要sku，如果不需要，则直接加入购物车，如果需要，则需要弹出sku选择框
	int isHaveSku = 0;
	float memberprice = 0;
	float memberprice1 = 0;
    float pktprice = 0;
	List<Map<String,Object>> gdsList = new ArrayList<Map<String,Object>>();
	List<Map<String,Object>> gdsList2 = new ArrayList<Map<String,Object>>();
	HashMap<String,String> goodsMap = new HashMap<String,String>();
	float zk=0.95f;
	for(int i=0;i<size;i++){
		Product product = productlist.get(i);
		memberprice += Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()*zk),2);
		memberprice1+=product.getGdsmst_memberprice().floatValue();
		
		
		Map<String,Object> gdsMap = new HashMap<String,Object>();
		gdsMap.put("id",product.getId().trim());
		gdsMap.put("title",Tools.clearHTML(product.getGdsmst_gdsname()));
		gdsMap.put("pic",ProductHelper.getImageTo80(product));
		gdsMap.put("url",ProductHelper.getProductUrl(product));
		if(ProductHelper.hasSku(product)){
			isHaveSku++;
			gdsMap.put("skuname",product.getGdsmst_skuname1());
			String message = "";
			List<Sku> skuList = SkuHelper.getSkuListViaProductId(product.getId());
			if(skuList != null && !skuList.isEmpty()){
				for(Sku sku : skuList){
					message += sku.getId()+"_"+sku.getSkumst_sku1()+"#";
				}
			}
			if(message.endsWith("#")) message = message.substring(0,message.length()-1);
			gdsMap.put("skulist",message);
			gdsList.add(gdsMap);
		}else{
			gdsList2.add(gdsMap);
		}
		//获取尺寸对照表
    	ArrayList<GdsAtt> gdsattlist=GdsAttHelper.getGdsAttByGdsid(product.getId());
		if(product.getGdsmst_sizeid()!=null && product.getGdsmst_sizeid()>0){
			String sizeinfo=getsizeinfo(product);
			if(!Tools.isNull(sizeinfo)){
				gdsMap.put("ccdes",sizeinfo);
			}
				
		}
		else{
			if(gdsattlist!=null&&gdsattlist.size()>0&&gdsattlist.get(0)!=null&&gdsattlist.get(0).getGdsatt_content()!=null){
				gdsMap.put("ccdes",gdsattlist.get(0).getGdsatt_content());
			}
		}
	
		goodsMap.put(product.getId(),null);
	}
	if(isHaveSku == 0){//则直接加入购物车。
		int error = addGdscollToCart(request,response,code,goodsMap,twohttpurl);
		out.print(getErrorJSON(error,request,response));
		return;
		
		
		//int error = CartHelper.addPackageProductToCart(request,response,code,goodsMap);
		//out.print(getErrorJSON(error,request,response));
		//return;
	}else{
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("code",new Integer(4));
		map.put("list",gdsList);
		map.put("otherList",gdsList2);
		map.put("oldPrice",Tools.getFormatMoney(memberprice1));
		map.put("price" ,memberprice);
		map.put("title","请选择组合商品属性：");
		out.print(JSONObject.fromObject(map));
		return;
	}
}else{//用户传递了sku过来了。则需要判断多个条件。
	String[] skuArray = skuId.split(",");
	if(skuArray == null || skuArray.length != size){
		//System.out.print(skuArray.length+">>>>>>>>>>>>>>>>>>>>>>>>");
		out.print("{\"code\":1,message:\"传入参数错误，请重新再试！\"}");
		return;
	}
	int isHaveSku = 0;
	HashMap<String,String> goodsMap = new HashMap<String,String>();
	for(int i=0;i<size;i++){
		Product product = productlist.get(i);
		String s = skuArray[i];
		if(Tools.isNull(s) || "#".equals(s)) s = null;
		if(ProductHelper.hasSku(product)){
			if(!SkuHelper.hasInSkuList(product , s)){
				//out.print("{\"code\":1,message:\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
				//return;
			}
		}
		goodsMap.put(product.getId(),s);
		
		//量少提醒和卖完就下的商品检查一下虚拟库存够不够
		if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
			int countInCart_1239 = CartHelper.getCartProductCount(request, response, product, s);//购物车里已经订购的数量
			if(1+countInCart_1239+CartItemHelper.getProductOccupyStock(product.getId(), s)>ProductHelper.getVirtualStock(product.getId(), s)){
				int i_239489 = ProductHelper.getVirtualStock(product.getId(), s)-CartItemHelper.getProductOccupyStock(product.getId(), s)-countInCart_1239;
				if(i_239489<=0){
					out.print("{\"code\":1,\"message\":\"您好！商品【"+product.getGdsmst_gdsname()+"】已售完！\"}");
				}else{
					out.print("{\"code\":1,\"message\":\"您好！商品【"+product.getGdsmst_gdsname()+"】只剩"+i_239489+"个！\"}");
				}
				return;
			}
		}
	}
	//System.out.print(code);
	int error = addGdscollToCart(request,response,code,goodsMap,twohttpurl);
	out.print(getErrorJSON(error,request,response));
	return;
}
%>