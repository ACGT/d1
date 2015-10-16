<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="/html/productpublic.jsp" %><%!

private static String getErrorJSON(int error , long maxCount , HttpServletRequest request , HttpServletResponse response){
	String str = null;
	switch(error){
		case 1:
			//获得购物车总金额和总商品数量
			int totalCount = CartHelper.getTotalProductCount(request,response);
			float totalAmmount = CartHelper.getTotalPayMoney(request,response);
			
			str = "{\"code\":0,\"message\":\"\",\"totalCount\":"+totalCount+",\"totalAmount\":\""+Tools.getFormatMoney(totalAmmount)+"\"}";
			break;
		case -1:
			str = "{\"code\":1,message:\"找不到优惠信息。\"}";
			break;
		case -2:
			str = "{\"code\":1,message:\"参数错误。\"}";
			break;
		case -3:
			str = "{\"code\":1,message:\"找不到商品。\"}";
			break;
		case -4:
			str = "{\"code\":1,message:\"您选择的物品其中有不属于此类优惠的物品。\"}";
			break;
		case -5:
			str = "{\"code\":1,message:\"您已经加过了此类优惠商品。\"}";
			break;
		case -6:
			str = "{\"code\":1,message:\"您只能选择"+maxCount+"件商品！\"}";
			break;
		default:
			str = "{\"code\":1,message:\"加入购物车发生错误，请稍后再试！\"}";
	}
	return str;
}
public static int addXsYProductToCartNew(HttpServletRequest request,HttpServletResponse response,String code,HashMap<String,String> pmap) {
	ProductXsY pxy = (ProductXsY)Tools.getManager(ProductXsY.class).get(code);
	if(pxy==null)return -1;
	
	if(pmap==null)return -2;
	
	ArrayList<PromotionProduct> list=PromotionProductHelper.getPromotionProductByCode(code);
	if(list==null||list.size()==0)return -3;
	
	Iterator<String> it = pmap.keySet().iterator();
	int maxcount=0;
	while(it.hasNext()){
		String pid=it.next();
String[] arrpid = pid.split(",");
		
		String gdsid = arrpid[0];
 
			maxcount+=Tools.parseInt(arrpid[1]);

			
		boolean flag = false ;//是否合法
		for(PromotionProduct pp:list){
			if(gdsid.equals(pp.getSpgdsrcm_gdsid())){
				flag = true ;
				break ;
			}
		}
		if(!flag){
			return -4;
		}
	}
	//System.out.println(maxcount+"======="+pxy.getGdsmstxsy_maxcount());
	if(maxcount!=pxy.getGdsmstxsy_maxcount().intValue())return -6;
	
	Cart cartAdded = null ;//是否已经选过了
	ArrayList<Cart> cartList =CartHelper. getCartItems(request, response);
	
	if(cartList!=null&&cartList.size()>100)return -7;
	
	if(cartList!=null){
		for(Cart c123:cartList){
			//这里ProductId放入XsY的推荐位id
			if(c123.getType().longValue()==-2&&c123.getProductId().equals(code)){
				cartAdded = c123;
				break ;
			}
		}
	}
	
	if(cartAdded==null){
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
		pcart.setParentId("0");
		pcart.setPrice(new Float(0));//后面会修改price
		pcart.setTitle("【组合特惠】"+Tools.clearHTML(pxy.getGdsmstxsy_title()));
		pcart.setType(new Long(-2));//-2表示X元选Y件父节点
		pcart.setVipPrice(new Float(0));
		pcart.setUserId(CartHelper.getCartUserId(request,response));
		pcart.setProductId(code);//这里放入XsY的推荐位id
		
		Tools.getManager(Cart.class).create(pcart);
		
		Iterator<String> it2 = pmap.keySet().iterator();
		
		float total_money_pcart = Tools.getFloat(pxy.getGdsmstxsy_allmoney().floatValue(),2);//本次XsY套餐单价
		float total_old_money = 0f ;
		
		while(it2.hasNext()){
			String gid=it2.next();
			
			String[] arrgid = gid.split(",");
			
			String ppid =  arrgid[0];//商品id
			String sku="";
			String amount="";
	 
			amount= arrgid[1];
	           if (arrgid.length>2){
	        	   sku=arrgid[2];
	           }
			//创建套餐子项
			Product pc = (Product)Tools.getManager(Product.class).get(ppid);
			Cart ccart = new Cart();
			ccart.setAmount(new Long(amount));
			ccart.setProductId(pc.getId());
			ccart.setTitle(Tools.clearHTML(pc.getGdsmst_gdsname()));
			ccart.setCreateDate(new Date());
			ccart.setCookie(CartHelper. getCartCookieValue(request,response));
			ccart.setHasChild(new Long(0));
			ccart.setHasFather(new Long(1));
			ccart.setIp(request.getRemoteHost());
			ccart.setMoney(Tools.getFloat(pxy.getGdsmstxsy_allmoney().floatValue()/pxy.getGdsmstxsy_maxcount().longValue(),2));
			ccart.setOldPrice(Tools.getFloat(pc.getGdsmst_memberprice(), 2));
			ccart.setPoint(new Long(0));
			ccart.setSkuId(sku);
			ccart.setPrice(Tools.getFloat(pxy.getGdsmstxsy_allmoney().floatValue()/pxy.getGdsmstxsy_maxcount().longValue(),2));
			ccart.setType(new Long(4));//4表示XsY组合商品
			ccart.setVipPrice(Tools.getFloat(Const.PT_VIP_DISCOUNT*pc.getGdsmst_memberprice().floatValue(), 2));
			ccart.setUserId(CartHelper.getCartUserId(request,response));
			ccart.setParentId(pcart.getId());
			Tools.getManager(Cart.class).create(ccart);
			
			total_old_money+=pc.getGdsmst_memberprice().floatValue();
		}
		
		pcart.setPrice(Tools.getFloat(new Float(total_money_pcart),2));
		pcart.setOldPrice(Tools.getFloat(new Float(total_old_money),2));
		pcart.setMoney(Tools.getFloat(total_money_pcart*pcart.getAmount().longValue(), 2));
		Tools.getManager(Cart.class).update(pcart, false);//修改套餐单价
	}else{
		return -5;
	}
	
	CartHelper.updateAllCartItems(request,response);
	return 1;
}
%><%
String code = request.getParameter("code");
if(code == null || !Tools.isMath(code)){
	out.print("{\"code\":1,message:\"很抱歉，您输入的信息不正确，请确认后重试。\"}");
	return;
}

ProductXsY pxy=(ProductXsY)Tools.getManager(ProductXsY.class).get(code);
if(pxy == null){
	out.print("{\"code\":1,message:\"2很抱歉，您输入的信息不正确，请确认后重试。\"}");
	return;
}
long iValidFlag=Tools.longValue(pxy.getGdsmstxsy_validflag(),1);
if(iValidFlag == 1){
	out.print("{\"code\":1,message:\"活动已结束！\"}");
	return;
}
Date startdate=pxy.getGdsmstxsy_startdate();
if(System.currentTimeMillis() < Tools.dateValue(startdate)){
	out.print("{\"code\":1,message:\"活动还没开始！\"}");
	return;
}
long maxcount=Tools.longValue(pxy.getGdsmstxsy_maxcount());
if(maxcount <= 0){
	out.print("{\"code\":1,message:\"此活动有错误，请稍后再试！\"}");
	return;
}
String id = request.getParameter("id");
//System.out.println(id+"XXXXXXXXXXXXXXXXXXXXXXx");
if(Tools.isNull(id)){
	out.print("{\"code\":1,message:\"3很抱歉，您输入的信息不正确，请确认后重试。\"}");
	return;
}

ArrayList<PromotionProduct> promotionList = PromotionProductHelper.getPromotionProductByCode(code);
if(promotionList == null || promotionList.isEmpty()){
	out.print("{\"code\":1,message:\"找不到活动物品！\"}");
	return;
}
//System.out.println(id+"商品ID");
String[] ids = id.split(",");
if(ids == null){
	out.print("{\"code\":1,message:\"4很抱歉，您输入的信息不正确，请确认后重试。\"}");
	return;
}
long pnum=0;long pnum2=0;
List<Product> list = new ArrayList<Product>();
for(String gdsid : ids){

	pnum+=new Long(gdsid.substring(9));

	for(PromotionProduct pp : promotionList){
		if(gdsid.substring(0,8).equals(pp.getSpgdsrcm_gdsid())){
			pnum2+=new Long(gdsid.substring(9));
			Product product = ProductHelper.getById(gdsid.substring(0,8));
			if(ProductHelper.isShow(product)) list.add(product);
		}
	}
}

if(pnum!=maxcount){
	out.print("{\"code\":1,message:\"5很抱歉，您输入的信息不正确，请确认后重试。\"}");
	return;
}
int size = list.size();
if(list == null || pnum2 != maxcount){
	out.print("{\"code\":1,message:\"您选择的商品中有下架和缺货，请刷新页面重新选择！\"}");
	return;
}

//判断是否有SKU，如果有SKU则弹出SKU的选择层。
//存在SKU
String skuId = request.getParameter("skuId");
if(Tools.isNull(skuId)){//用户没有传递sku过来。则判断物品是否需要sku，如果不需要，则直接加入购物车，如果需要，则需要弹出sku选择框
	int isHaveSku = 0;
	float oldPrice = 0;//总会员价格
	List<Map<String,Object>> gdsList = new ArrayList<Map<String,Object>>();
	List<Map<String,Object>> gdsList2 = new ArrayList<Map<String,Object>>();
	HashMap<String,String> goodsMap = new HashMap<String,String>();
	//System.out.println("VVVVVVVVVVV"+size);
	for(int i=0;i<size;i++){
		Product product = list.get(i);
		oldPrice += Tools.floatValue(product.getGdsmst_memberprice());
		Map<String,Object> gdsMap =null;
		boolean hassku=ProductHelper.hasSku(product);
		String message = "";
		if(hassku){
			isHaveSku++;
			List<Sku> skuList = SkuHelper.getSkuListViaProductId(product.getId());
			if(skuList != null && !skuList.isEmpty()){
				for(Sku sku : skuList){
					message += sku.getId()+"_"+sku.getSkumst_sku1()+"#";
				}
			}
			if(message.endsWith("#")) message = message.substring(0,message.length()-1);
		}
		
		
		String num="1";
		
		for(String gdsid : ids){
			//System.out.println("FFFFFFFFFFFFFFFFFF"+gdsid);
			if(gdsid.length()>8 && gdsid.substring(0,8).equals(product.getId())){
				num=gdsid.substring(9);
				for(int j=0;j<new Long(num);j++){
					gdsMap = new HashMap<String,Object>();
				
					gdsMap.put("id",product.getId()+j);
					gdsMap.put("title",Tools.clearHTML(product.getGdsmst_gdsname()));
					gdsMap.put("pic",ProductHelper.getImageTo80(product));
					gdsMap.put("url",ProductHelper.getProductUrl(product));
					//System.out.println("FFFFFFFFFFFFFFFFFF"+gdsMap.get("id"));
					if(hassku){
						gdsMap.put("skuname",product.getGdsmst_skuname1());
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
				}
				break;
			}
			
		}
		//System.out.println("ZZZZZZZZZZZZZZZZZZZZ"+product.getId()+num);
		goodsMap.put(product.getId()+","+num,null);
	}
	
	/**for(int k=0;k<gdsList.size();k++){
		Map<String, Object> values =gdsList.get(k);  
	    for (Map.Entry entry : values.entrySet()) {  
	        Object key = entry.getValue();  
	        System.out.println("ZZZZZZZZZZZ"+key);
	    }
	}**/
	if(isHaveSku == 0){//则直接加入购物车。
		int error =addXsYProductToCartNew(request,response,code,goodsMap);
		out.print(getErrorJSON(error,maxcount,request,response));
		return;
	}else{
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("code",new Integer(4));
		map.put("list",gdsList);
		map.put("otherList",gdsList2);
		map.put("oldPrice",Tools.getFormatMoney(oldPrice));
		map.put("price" , Tools.getFormatMoney(pxy.getGdsmstxsy_allmoney()));
		map.put("title","请选择套餐商品属性：");
		out.print(JSONObject.fromObject(map));
		return;
	}	
}else{//用户传递了sku过来了。则需要判断多个条件。
	String[] skuArray = skuId.split(",");
//System.out.println("SSSSSSSSSSSS"+skuId);
	if(skuArray == null || skuArray.length != pnum2){
		out.print("{\"code\":1,message:\"传入参数错误，请重新再试！\"}");
		return;
	}
	int isHaveSku = 0;
	int skunum=0;
	HashMap<String,String> goodsMap = new HashMap<String,String>();
	for(int i=0;i<size;i++){
		Product product = list.get(i);
		String s = "";
		String num="1";
		boolean hassku=ProductHelper.hasSku(product);
		//System.out.println(i+"-----");
		//for(int k=0;k<ids.length;k++){
			if(ids[i].length()>8 && ids[i].substring(0,8).equals(product.getId())){
				num=ids[i].substring(9);
			}

			//System.out.println(product.getId()+"----"+num+"-----"+s);
			for(int j=0;j<new Long(num);j++){
				s = skuArray[skunum+j];
				if(Tools.isNull(s) || "#".equals(s)) s = null;
				if(hassku){
					//System.out.println(product.getId()+"-----"+s);
					if(!SkuHelper.hasInSkuList(product , s)){
						out.print("{\"code\":1,message:\"6很抱歉，您输入的信息不正确，请确认后重试。\"}");
						return;
					}
				}
				goodsMap.put(product.getId()+","+j+","+s,s);
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
		//}
			skunum=skunum+Tools.parseInt(num);
	
	}
	int error =addXsYProductToCartNew(request,response,code,goodsMap);
	out.print(getErrorJSON(error,maxcount,request,response));
	return;
}
%>