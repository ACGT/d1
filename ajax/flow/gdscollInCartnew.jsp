<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %>
<%!
/**
 * 把搭配商品加入购物车
 * @param request
 * @param response
 * @param packageId 商品搭配id
 * @param pmap key=商品id，value=skuid如果有sku的话
 * @return -1=商品搭配不存在，-2商品搭配的明细为空，-3=传入的商品id不是套餐里的商品，-4=套餐已经加过一次了，-5=购物车超过100条记录了
 */
public static int addGdscollToCart(HttpServletRequest request,HttpServletResponse response,String packageId,HashMap<String,String> pmap) {
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
	
	ArrayList<Cart> cartList = CartHelper.getCartItems(request, response);
	
	if(cartList!=null&&cartList.size()>100)return -5;
	Iterator<String> it2 = pmap.keySet().iterator();
	while(it2.hasNext()){
		String ppid = it2.next();//商品id
		
		Gdscolldetail ppi123 = null ;
		
	
	    Product pc = (Product)Tools.getManager(Product.class).get(ppid);
	    if(pc!=null&&pc.getGdsmst_ifhavegds().longValue()==0&&pc.getGdsmst_validflag().longValue()==1)
	    {
			Cart cart = new Cart();
			cart.setParentId("0");
			cart.setSkuId(pmap.get(ppid));
			cart.setAmount(new Long(1));//数量
			cart.setProductId(pc.getId());
			cart.setOldPrice(pc.getGdsmst_memberprice());
			cart.setVipPrice(Tools.getFloat(pc.getGdsmst_memberprice().floatValue()*Const.VIP_DISCOUNT,2));
			cart.setType(new Long(1));
			cart.setTitle(pc.getGdsmst_gdsname());
			cart.setShopcode(pc.getGdsmst_shopcode());
			CartHelper.addCart(request,response,cart);
	    }
		
	}
         
	
	
	
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
if(code == null || !Tools.isMath(code)){
	out.print("{\"code\":1,message:\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
	return;
}

Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(code);
if(code==null)
{
	out.print("{\"code\":1,message:\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
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
if(ids == null || ids.length < 1){
	out.print("{\"code\":1,message:\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
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
//System.out.print("productlist="+itemsize);
//if(list == null || size != gdlist.size()){
	//out.print("{\"code\":1,message:\"您选择的商品"+str+"已下架或缺货，无法购买该组合！\"}");
	//return;
//}
//判断是否有SKU，如果有SKU则弹出SKU的选择层。
//存在SKU
String skuId = request.getParameter("skuId");
System.out.print(skuId);
if(Tools.isNull(skuId)){//用户没有传递sku过来。则判断物品是否需要sku，如果不需要，则直接加入购物车，如果需要，则需要弹出sku选择框
	int isHaveSku = 0;
	float memberprice = 0;
    float pktprice = 0;
	List<Map<String,Object>> gdsList = new ArrayList<Map<String,Object>>();
	List<Map<String,Object>> gdsList2 = new ArrayList<Map<String,Object>>();
	HashMap<String,String> goodsMap = new HashMap<String,String>();
	for(int i=0;i<size;i++){
		Product product = productlist.get(i);
		
		memberprice += Tools.floatValue(product.getGdsmst_memberprice());
    	
    	
		Map<String,Object> gdsMap = new HashMap<String,Object>();
		gdsMap.put("id",product.getId());
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
		goodsMap.put(product.getId(),null);
	}
	if(isHaveSku == 0){//则直接加入购物车。
		int error = addGdscollToCart(request,response,code,goodsMap);
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
		map.put("oldPrice",Tools.getFormatMoney(memberprice));
		map.put("price" , Tools.getFormatMoney(memberprice-pktprice));
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
	int error = addGdscollToCart(request,response,code,goodsMap);
	out.print(getErrorJSON(error,request,response));
	return;
}
%>