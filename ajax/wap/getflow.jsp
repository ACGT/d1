<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.comp.*"%><%@include file="/html/header.jsp" %>
<%
JSONObject json = new JSONObject();

ArrayList<ShpMst> shpmstlist=CartShopCodeHelper.getCartShopCode(request, response);
if(shpmstlist==null){
	json.put("status", "0");
	out.print(json);
	return;
}
CartHelper.updateAllCartItems(request,response);
JSONArray jsonarr=new JSONArray();
     json.put("status", "1");
	  int shpmstcount=1;
	 int smcount=shpmstlist.size();
	 json.put("shopcount", smcount);
	 DecimalFormat df2 = new DecimalFormat("0.00");
	 float getshopactmoney=  CartHelper.getShopActCutMoney(request, response);
	
	 long totalGoods = 0;//物品总数
	 float totalPrice = 0f;//总金额
	 
     for(ShpMst shpmst:shpmstlist){

   	  String shopcode=shpmst.getId();
   	  if(shopcode.equals("08102301"))shopcode="00000000";
    	 
    	 JSONObject jsonitemshop = new JSONObject();
    	 JSONArray jsonitemshoparr = new JSONArray();
    	 JSONArray jsonitemshopactarr = new JSONArray();
    	 jsonitemshop.put("shopcode",shopcode);
    	 jsonitemshop.put("shopname",shpmst.getShpmst_shopname());
    	 ArrayList<Cart> cartList2 = CartShopCodeHelper.getCartItemsOrder(request, response, shopcode);
   	    Collections.sort(cartList2,new ActComparator());
   	    
   	    int actid=0;
   	    int oldactid=0;
   	    long shopactmoney=0;
   	    if(cartList2!=null&&cartList2.size()>0){
   	      // jsonitemshop.put("shopact",actflag);
   	        long smtotalGoods = 0;//商户物品总数
   	        float smtotalPrice = 0f;//商户总金额
   	       for(Cart cart : cartList2){
   	    	JSONObject jsonitemcart = new JSONObject();
   	    	JSONObject jsonitemact = new JSONObject();
   	        String id = cart.getId();
   	        String gdsid= cart.getProductId();
   		    Product product = ProductHelper.getById(gdsid);
   		    String title = cart.getTitle();//物品名称
   		    Sku sku = SkuHelper.getById(cart.getSkuId());
   		    float oldPrice = Tools.floatValue(cart.getOldPrice());//会员价，单价
   		    float price = Tools.floatValue(cart.getPrice());//成交单价
   		    long amount = Tools.longValue(cart.getAmount());//数量
   		    long type = Tools.longValue(cart.getType(),1);//类型
   		    float money = Tools.floatValue(cart.getMoney());//总计
   		     long haschild=  cart.getHasChild().longValue();
   		    String skuname="";
   		    if(sku!=null){
   		    	skuname=sku.getSkumst_sku1();
   		    }
   		    String rec_key = cart.getId()+"_0_"+(Tools.isNull(cart.getSkuId())?"0":cart.getSkuId());
   		    String img=ProductHelper.getImageTo80(product);
   		    if(type >= 0) {
   			   totalPrice += money;
   			   smtotalPrice += money;
			   totalGoods+=amount;
   			   smtotalGoods+=amount;
              }
   		    
   		    if(cart.getActid()!=null){
   			   actid=cart.getActid().intValue();
   		     }else{
   			   oldactid=0;
   		     }
   	     if(oldactid!=actid){
   		 D1ActTb d1act=CartHelper.getShopAct(cartList2, shopcode, actid+"");
   		 float d1actpmoney=CartHelper.getCartShopActPayMoney(request,response,d1act);
   		
   		 long actmoney=0;
   		 if(d1act!=null){

   			String showactt="活动商品购满"+d1act.getD1acttb_snum1()+"元，即可享受满减";
   			String showactt2="";
   			
   			 if(cart.getActmoney()!=null&&cart.getActmoney().longValue()>0){
   				 if(d1act.getD1acttb_snum3().floatValue()>0f&&d1actpmoney>=d1act.getD1acttb_snum3().floatValue()){
   					 actmoney=d1act.getD1acttb_enum3();
   					 showactt="活动商品已购满"+d1act.getD1acttb_snum3()+"元，已减"+actmoney+"元";
   					
   				    }else if(d1act.getD1acttb_snum2().floatValue()>0f&&d1actpmoney>=d1act.getD1acttb_snum2().floatValue()){
   				    	actmoney=d1act.getD1acttb_enum2();
   				    	showactt="活动商品已购满"+d1act.getD1acttb_snum2()+"元，已减"+actmoney+"元";
   					}else if(d1act.getD1acttb_snum1().floatValue()>0f&&d1actpmoney>=d1act.getD1acttb_snum1().floatValue()){
   						actmoney=d1act.getD1acttb_enum1();
   						showactt="活动商品已购满"+d1act.getD1acttb_snum1()+"元，已减"+actmoney+"元";
   					}
   				 showactt2	="减免：¥"+actmoney;
   				 shopactmoney+=actmoney;
   
   			 }
   		     String fxtxt="";
   		     if(actmoney >0)fxtxt="减免："+actmoney+"元";
   		     String acttxt="";
   		     String goshopurl="";
   			if(d1act.getD1acttb_acttype().longValue()==0){
   				acttxt="满减";

   				if(shpmst!=null&&shpmst.getShpmst_index().longValue()==1&&
   						!Tools.isNull(shpmst.getShpmst_shopsname())){
   				goshopurl="http://m.d1.cn/wap/shop.html?sc="+shpmst.getId();
   				}else{
					if(shpmst!=null)goshopurl="http://m.d1.cn/wap/shopbrand.html?sc="+shpmst.getId();
				}
   			}
   			
   			if(d1act.getD1acttb_acttype().longValue()==1){
   				acttxt="专区满减";
   				goshopurl="http://m.d1.cn/wap/rec.html?code="+d1act.getD1acttb_ppcode();
   			}
   			if(d1act.getD1acttb_acttype().longValue()==2){
   				acttxt="品牌满减";
				goshopurl="http://m.d1.cn/wap/shopbrand.html?sc="+d1act.getD1acttb_shopcode()+"&brand="+d1act.getD1acttb_brandcode();

			}
   			    jsonitemact.put("actid",actid);	 
             	jsonitemact.put("acttxt",acttxt);
   	   		    jsonitemact.put("showactt",showactt);
   	   		    jsonitemact.put("fxtxt",fxtxt);
   	   		    jsonitemact.put("goshopurl",goshopurl);
   	   		    jsonitemshopactarr.add(jsonitemact);
   		    }
   	        } 
   		    
   		    
   		    
   	    	jsonitemcart.put("cart_id",id);
   	    	jsonitemcart.put("cart_gdsid",gdsid);
   	    	jsonitemcart.put("cart_title",title);
   	    	jsonitemcart.put("cart_oldPrice",df2.format(oldPrice));
   	    	jsonitemcart.put("cart_price",df2.format(price));
   	    	jsonitemcart.put("cart_img",img);
   	    	jsonitemcart.put("cart_sku",skuname);
   	    	jsonitemcart.put("cart_gdscount",amount);
   	    	jsonitemcart.put("cart_type",type);
   	    	jsonitemcart.put("cart_actid",actid);
   	    	jsonitemcart.put("cart_reckey",rec_key);
   	    	boolean plimit=false;
   	        boolean hasFather = Tools.longValue(cart.getHasFather(),0)==1?true:false;//是否有父类
   	    	if(hasFather || type==0 || type==13 || type==15 || type==-5 ||type==14|| type==2||type==18||type==19||(product.getGdsmst_buylimit()!=null&&product.getGdsmst_buylimit().intValue()>0)){
   	    		plimit=true;
   	    	}
   	    	jsonitemcart.put("cart_plimit",plimit);
   	    	jsonitemcart.put("cart_haschild",haschild);
   	    	
   	    	oldactid=actid;
   	    	jsonitemshoparr.add(jsonitemcart);
   	       }
   	       jsonitemshop.put("shopmoney", df2.format(smtotalPrice));
   	       jsonitemshop.put("shopgdscount", smtotalGoods);
   	       jsonitemshop.put("shopactmoney", shopactmoney);	    
   	       jsonitemshop.put("shopactlist", jsonitemshopactarr);
   	       jsonitemshop.put("shopcartlist", jsonitemshoparr);
   	       jsonarr.add(jsonitemshop);
   	    
     }
     }
     json.put("allmoney", df2.format(totalPrice));
     json.put("allgdscount", totalGoods);
     json.put("allactmoney",df2.format(getshopactmoney) );
     json.put("cartlist",jsonarr);
     
     json.put("zpalltitle","全场赠品");
     JSONArray jsonzparr=new JSONArray();
     List<Gift> giftList000 = GiftHelper.getCartGift(request, response,0);
 	if(giftList000 != null && giftList000.size()>0){
 
 		 for(int i=0;i<giftList000.size();i++){
 			JSONObject jsonitemlist = new JSONObject();
 			JSONArray jsonzpitemarr=new JSONArray();
 			 Gift Gift_000 = giftList000.get(i);//购物车里正常的商品
 			  String gfshopcode=Gift_000.getGiftrckmst_shopcode();
               if(!gfshopcode.equals("11111111")){
              	int gfspcount=CartShopCodeHelper.getCartAllpCount(request,response,gfshopcode);
              	if(gfspcount==0)continue;
               }
 			 ArrayList<GiftItem> giftItemList = GiftHelper.getGiftItems(Gift_000.getId());
 			 if(giftItemList!=null&&giftItemList.size()>0){
 				jsonitemlist.put("itemlisttitle", Gift_000.getGiftrckmst_title());
 		
 		 int tdi=0;
 		     int counti=1;
 		      float limitmoney=0f;
 		      float cartallmoney=CartShopCodeHelper.getTotalPayMoneys(request,response,gfshopcode);
 		  for(int k=0;k<giftItemList.size();k++){
 			 JSONObject jsonitem = new JSONObject();
 				GiftItem gi_1 = giftItemList.get(k); 	
 				if(CartHelper.existsGiftidProductId(request, response,gi_1.getGiftrckdtl_gdsid(), gi_1.getGiftrckdtl_mstid().longValue())){
 					continue;
 				}
 				 				
 						  Product product = ProductHelper.getById(gi_1.getGiftrckdtl_gdsid());
 		
 						  String title =product.getGdsmst_gdsname();
 						  if (title.length()>20){
 							  title=title.substring(0,20);
 						  }
 						  int vituralstock=0;
 						  if(product.getGdsmst_skuname1()!=null&&product.getGdsmst_skuname1().length()>0)
 						  {
 							  ArrayList<Sku> skulist=SkuHelper. getSkuListViaProductId(product.getId());
 							  for(Sku sku:skulist){
 								 vituralstock+= ProductHelper.getVirtualStock(product.getId(),sku.getId());
 							  }
 						  }else{
 							  vituralstock+= ProductHelper.getVirtualStock(product.getId(),null); 
 						  }
 						 if((product.getGdsmst_stocklinkty().longValue()==1&&vituralstock+CartItemHelper.getProductOccupyStock(product.getId(), null)<=5) ||product.getGdsmst_validflag().longValue()!=1){
 								continue;
 							}
 						 String zptxt="";
			             float fltGiftRckDtl_Limitmoney = Tools.floatValue(gi_1.getGiftrckdtl_limitmoney());
							float fltGiftRckDtl_Addmoney = Tools.floatValue(gi_1.getGiftrckdtl_addmoney());
			             if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
								if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
									zptxt = "全场消费可免费获得";
								}else{
									zptxt = "全场消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元可免费获得";
								}
							}else{//消费满1314元即可免费获得     消费满999元加1元可换购
								if(Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
									zptxt = "全场消费加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
								}else{
									if (Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 1){
										zptxt = "全场消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
									}else{
										zptxt = "全场消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元直减" + Tools.getFormatMoney(-fltGiftRckDtl_Addmoney) + "元";
									}
								}
							}
 					 	
 						String	giftvalue=GiftHelper.getcreategiftaddstr(Gift_000, gi_1, product, cartallmoney);
 						jsonitem.put("zpitemtxt",zptxt);
 						jsonitem.put("zpitemid", gi_1.getId());
 						jsonitem.put("zpitemgdsid", gi_1.getGiftrckdtl_gdsid());
 						jsonitem.put("zpitemtitle", title);
 						jsonitem.put("zpitemimg",ProductHelper.getImageTo80(product));
 						jsonitem.put("zpitemsaleprice", Tools.getFormatMoney(product.getGdsmst_saleprice()));
 						jsonitem.put("zpitemdhprice", Tools.getFormatMoney(gi_1.getGiftrckdtl_addmoney()));
 						jsonitem.put("zpitemgiftvalue", giftvalue);
 						
 		              if(cartallmoney<gi_1.getGiftrckdtl_limitmoney()){  
 		            	 jsonitem.put("zpitemflag", 0); 		                        
 		               }else{  
 		            	  jsonitem.put("zpitemflag", 1); 		   
 		            	  }		              	          
 		             jsonzpitemarr.add(jsonitem);
       
 		       
 		        counti++;
 		        
 		        limitmoney=gi_1.getGiftrckdtl_addmoney().floatValue(); 
 		        
 		          }
 		 jsonitemlist.put("zplist",jsonzpitemarr);
 		 jsonzparr.add(jsonitemlist);
 		  }
 		}   
 		
 		 }  
 	json.put("zpallzplist",jsonzparr);
 		 //<!-- 全场赠品结束 -->
 		 
 		  json.put("zprcktitle","分类赠品");
     JSONArray jsonzparr2=new JSONArray();
 	List<Gift> Giftrck001 = GiftHelper.getCartGift(request, response,1);
 	if(Giftrck001 != null && Giftrck001.size()>0){

 		 for(int i=0;i<Giftrck001.size();i++){
 			JSONObject jsonitemlist = new JSONObject();
 			JSONArray jsonzpitemarr=new JSONArray();
 			 Gift Gift_001 = Giftrck001.get(i);//购物车里正常的商品
 			
 			String strRakmst_rackname ="";
		      String gfrck=Gift_001.getGiftrckmst_rackcode();
			if ("001".equals(gfrck)){
				strRakmst_rackname="服装饰品";
			}
			else{
				Directory dir = DirectoryHelper.getById(gfrck);
				 strRakmst_rackname = (dir != null ? dir.getRakmst_rackname():"");
				 if(!Tools.isNull(strRakmst_rackname)){
					 strRakmst_rackname="<a href=\"http://m.d1.cn/wap/result.html?rackcode="+gfrck+"\">"+strRakmst_rackname+"</a>";
				 }
		    }
 			 ArrayList<GiftItem> giftItemList001 = GiftHelper.getGiftItems(Gift_001.getId());
 			 if(giftItemList001!=null&&giftItemList001.size()>0){
  				jsonitemlist.put("itemlisttitle", strRakmst_rackname+":"+Gift_001.getGiftrckmst_title());
 		  int tdi=0;
 		     int counti=1;
 		      float limitmoney=0f;
 		      float cartallmoney=0f;
 		      if ("001".equals(Gift_001.getGiftrckmst_rackcode())){
 					cartallmoney=CartHelper.getTotalRackcodePayMoney(request,response,"015009",Gift_001.getGiftrckmst_shopcode());
 					cartallmoney+=CartHelper.getTotalRackcodePayMoney(request,response,"02",Gift_001.getGiftrckmst_shopcode());
 					cartallmoney+=CartHelper.getTotalRackcodePayMoney(request,response,"03",Gift_001.getGiftrckmst_shopcode());
 				}
 				else{
 					cartallmoney=CartHelper.getTotalRackcodePayMoney(request,response,Gift_001.getGiftrckmst_rackcode(),Gift_001.getGiftrckmst_shopcode());
 				}
 		  for(int k=0;k<giftItemList001.size();k++){
 			 JSONObject jsonitem = new JSONObject();
 				GiftItem gi_001 = giftItemList001.get(k); 	
 				if(CartHelper.existsGiftidProductId(request, response,gi_001.getGiftrckdtl_gdsid(), gi_001.getGiftrckdtl_mstid().longValue())){
 					continue;
 				}
 				  Product product = ProductHelper.getById(gi_001.getGiftrckdtl_gdsid());
 						  String title =product.getGdsmst_gdsname();
 						  if (title.length()>20){
 							  title=title.substring(0,20);
 						  }
 						  int vituralstock=0;
 						  if(product.getGdsmst_skuname1()!=null&&product.getGdsmst_skuname1().length()>0)
 						  {
 							  ArrayList<Sku> skulist=SkuHelper. getSkuListViaProductId(product.getId());
 							  for(Sku sku:skulist){
 								 vituralstock+= ProductHelper.getVirtualStock(product.getId(),sku.getId());
 							  }
 						  }else{
 							  vituralstock+= ProductHelper.getVirtualStock(product.getId(),null); 
 						  }
  						 if((product.getGdsmst_stocklinkty().longValue()==1&&vituralstock+CartItemHelper.getProductOccupyStock(product.getId(), null)<=5) ||product.getGdsmst_validflag().longValue()!=1){
 							  continue;
 							}
  						String zptxt="";
  						float fltGiftRckDtl_Limitmoney = Tools.floatValue(gi_001.getGiftrckdtl_limitmoney());
  							float fltGiftRckDtl_Addmoney = Tools.floatValue(gi_001.getGiftrckdtl_addmoney());
  						if ("001".equals(gfrck)){
  							if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
  								if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
  									zptxt = "服装饰品消费可免费获得";
  								}else{
  									zptxt = "服装饰品消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元可免费获得";
  								}
  							}else{
  								if(Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
  									zptxt = "服装饰品消费加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
  								}else{
  									if (Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 1){
  										zptxt = "服装饰品消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
  									}else{
  										zptxt = "服装饰品消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元直减" + Tools.getFormatMoney(-fltGiftRckDtl_Addmoney) + "元";
  									}
  								}
  							}
  							}else{
  								if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
  									if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
  										zptxt = strRakmst_rackname+"</a>消费可免费获得";
  									}else{
  										zptxt = strRakmst_rackname+"</a>消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元可免费获得";
  									}
  								}else{
  									if(Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
  										zptxt = strRakmst_rackname+"</a>消费加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
  									}else{
  										if (Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 1){
  											zptxt = strRakmst_rackname+"</a>消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
  										}else{
  											zptxt = strRakmst_rackname+"</a>消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元直减" + Tools.getFormatMoney(-fltGiftRckDtl_Addmoney) + "元";
  										}
  									}
  								}
  								zptxt="<a href=\"/result.jsp?productsort="+gfrck+"\" target=\"_blank\">"+zptxt;
  							}
 					 	
 						String	giftvalue=GiftHelper.getcreategiftaddstr(Gift_001, gi_001, product, cartallmoney);
 						jsonitem.put("zpitemtxt",zptxt);
 						jsonitem.put("zpitemid", gi_001.getId());
 						jsonitem.put("zpitemgdsid", gi_001.getGiftrckdtl_gdsid());
 						jsonitem.put("zpitemtitle", title);
 						jsonitem.put("zpitemimg",ProductHelper.getImageTo80(product));
 						jsonitem.put("zpitemsaleprice", Tools.getFormatMoney(product.getGdsmst_saleprice()));
 						jsonitem.put("zpitemdhprice", Tools.getFormatMoney(gi_001.getGiftrckdtl_addmoney()));
 						jsonitem.put("zpitemgiftvalue", giftvalue);

                   if(cartallmoney<gi_001.getGiftrckdtl_limitmoney()){ 
		            	 jsonitem.put("zpitemflag", 0); 		                        
 		               }else{  
 	 		            	 jsonitem.put("zpitemflag", 1); 		                        
 		              }	
		             jsonzpitemarr.add(jsonitem);

       
 		     
 		        counti++;
 		        limitmoney=gi_001.getGiftrckdtl_addmoney().floatValue();      
 		          }
 		 
 		 jsonitemlist.put("zplist",jsonzpitemarr);
 		jsonzparr2.add(jsonitemlist);
 		  }} 	   

 		 }  
 	json.put("zprckzplist",jsonzparr2);

 		// <!-- 服饰赠品结束 -->

 		json.put("zpbrandtitle","品牌赠品");
     JSONArray jsonzparr3=new JSONArray();
 	List<Gift> Giftrck002 = GiftHelper.getCartGift(request, response,2);
 	if(Giftrck002 != null && Giftrck002.size()>0){

 		  for(int i=0;i<Giftrck002.size();i++){
 			 JSONObject jsonitemlist = new JSONObject();
  			JSONArray jsonzpitemarr=new JSONArray();
 			 Gift Gift_002 = Giftrck002.get(i);//购物车里正常的商品

 			 ArrayList<GiftItem> giftItemList002 = GiftHelper.getGiftItems(Gift_002.getId());

 			 if(giftItemList002!=null&&giftItemList002.size()>0){
   				jsonitemlist.put("itemlisttitle", Gift_002.getGiftrckmst_title());
 		 int tdi=0;
 		     int counti=1;
 		      float limitmoney=0f;
 		      float cartallmoney=CartHelper.getCartBrandPayMoney(request,response,Gift_002.getGiftrckmst_brandname(),Gift_002.getGiftrckmst_shopcode());
 		     String strGiftrckmst_brandname = Gift_002.getGiftrckmst_brandname();
				if(strGiftrckmst_brandname!=null)strGiftrckmst_brandname=strGiftrckmst_brandname.replace("null", "");
 		      for(int k=0;k<giftItemList002.size();k++){
 			 JSONObject jsonitem = new JSONObject();
 				GiftItem gi_002 = giftItemList002.get(k); 	

 				if(CartHelper.existsGiftidProductId(request, response,gi_002.getGiftrckdtl_gdsid(), gi_002.getGiftrckdtl_mstid().longValue())){
 					continue;
 				}
 	  	 		

 						  Product product = ProductHelper.getById(gi_002.getGiftrckdtl_gdsid());

 						  String title =product.getGdsmst_gdsname();
 						  if (title.length()>20){
 							  title=title.substring(0,20);
 						  }
 						  int vituralstock=0;
 						  if(product.getGdsmst_skuname1()!=null&&product.getGdsmst_skuname1().length()>0)
 						  {
 							  ArrayList<Sku> skulist=SkuHelper. getSkuListViaProductId(product.getId());
 							  for(Sku sku:skulist){
 								 vituralstock+= ProductHelper.getVirtualStock(product.getId(),sku.getId());
 							  }
 						  }else{
 							  vituralstock+= ProductHelper.getVirtualStock(product.getId(),null); 
 						  }
  						 if((product.getGdsmst_stocklinkty().longValue()==1&&vituralstock+CartItemHelper.getProductOccupyStock(product.getId(), null)<=5) ||product.getGdsmst_validflag().longValue()!=1){
 							  continue;
 							}
  						String zptxt="";
  						float fltGiftRckDtl_Limitmoney = Tools.floatValue(gi_002.getGiftrckdtl_limitmoney());
  							float fltGiftRckDtl_Addmoney = Tools.floatValue(gi_002.getGiftrckdtl_addmoney());
  						if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
  							if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
  								zptxt = strGiftrckmst_brandname+"品牌消费可免费获得";
  							}else{
  								zptxt = strGiftrckmst_brandname+"品牌消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元可免费获得";
  							}
  						}else{
  							if(Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
  								zptxt = strGiftrckmst_brandname+"品牌消费加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
  							}else{
  								if (Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 1){
  									zptxt = strGiftrckmst_brandname+"品牌消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
  								}else{
  									zptxt = strGiftrckmst_brandname+"品牌消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元直减" + Tools.getFormatMoney(-fltGiftRckDtl_Addmoney) + "元";
  								}
  							}
  						}
 						String	giftvalue=GiftHelper.getcreategiftaddstr(Gift_002, gi_002, product, cartallmoney);
 						jsonitem.put("zpitemtxt",zptxt);
 						jsonitem.put("zpitemid", gi_002.getId());
 						jsonitem.put("zpitemgdsid", gi_002.getGiftrckdtl_gdsid());
 						jsonitem.put("zpitemtitle", title);
 						jsonitem.put("zpitemimg",ProductHelper.getImageTo80(product));
 						jsonitem.put("zpitemsaleprice", Tools.getFormatMoney(product.getGdsmst_saleprice()));
 						jsonitem.put("zpitemdhprice", Tools.getFormatMoney(gi_002.getGiftrckdtl_addmoney()));
 						jsonitem.put("zpitemgiftvalue", giftvalue);
 						 if(cartallmoney<gi_002.getGiftrckdtl_limitmoney()){ 
 			            	 jsonitem.put("zpitemflag", 0); 		                        
 		               }else{  
 			            	 jsonitem.put("zpitemflag", 1); 		                        
 		               }  
 		              	          
 			             jsonzpitemarr.add(jsonitem);
   
 		         counti++;
 		        limitmoney=gi_002.getGiftrckdtl_addmoney().floatValue();      
 		          }
 		 
 		 jsonitemlist.put("zplist",jsonzpitemarr);
 		jsonzparr3.add(jsonitemlist);
 		  }} 

 		 } 
     
 	json.put("zpbrandzplist",jsonzparr3);
     
     
out.print(json);
%>