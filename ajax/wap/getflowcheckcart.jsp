 <%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.comp.*"%><%@include file="/html/header.jsp" %>
<%
JSONObject json = new JSONObject();
List<Cart> list = CartHelper.getCartItems(request,response);
if(list == null ||list.isEmpty()){
	json.put("status", "0");
	out.print(json);
	return;
}
json.put("status", "1");
 long allactmoney=0;
  			    String strsessionid="";
  			    	int size = list.size();
  			  	Collections.sort(list,new ActComparator());
  			  int actid=0;
  			int oldactid=0;
  			float totalPrice=0f;
  			DecimalFormat df2 = new DecimalFormat("0.00");
  			long shopactmoney=0;
  			JSONArray jsonitemactarr = new JSONArray();
  			JSONArray jsonitemarr = new JSONArray();
  			    	for(Cart cart : list){
 
  			    		JSONObject jsonitemcart = new JSONObject();
  			   	    	JSONObject jsonitemact = new JSONObject();

  			    		String goodsName = cart.getTitle();
  			    		String id = cart.getId();
  			   	        String gdsid= cart.getProductId();
  			   		    Product product = ProductHelper.getById(gdsid);
  			   		  if(product == null && cart.getType().longValue()!=-5 ) continue;
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
  			   		 if(type >= 0) {
  		   			   totalPrice += money;
  		              }
  			   		    
  			   		 String img=ProductHelper.getImageTo80(product);
  			    	  String shopcode=cart.getShopcode();
  			    	strsessionid=cart.getCookie();
  			    		 if(cart.getActid()!=null){
  			    			 actid=cart.getActid().intValue();
  			    		 }else{
  			    			 oldactid=0;
  			    		 }
  			    		if(oldactid!=actid){
  			    			 D1ActTb d1act=CartHelper.getShopAct(list, shopcode, actid+"");
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
  			    				ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(d1act.getD1acttb_shopcode());
  	  			    			if(shpmst!=null&&shpmst.getShpmst_index().longValue()==1&&
  	  			    					!Tools.isNull(shpmst.getShpmst_shopsname())){
  	  			    			goshopurl="http://www.d1.com.cn/shop/"+shpmst.getShpmst_shopsname();
  	  			    			}
  			    			}
  			    			
  			    			if(d1act.getD1acttb_acttype().longValue()==1){
  			    				acttxt="专区满减";
  			    				goshopurl="http://www.d1.com.cn/html/result_rec.jsp?aid="+d1act.getD1acttb_ppcode();
  			    			}
  			    	
  			    			

  			    			jsonitemact.put("actid",actid);	 
  			             	jsonitemact.put("acttxt",acttxt);
  			   	   		    jsonitemact.put("showactt",showactt);
  			   	   		    jsonitemact.put("fxtxt",fxtxt);
  			   	   		    jsonitemact.put("goshopurl",goshopurl);
  			   	   			jsonitemactarr.add(jsonitemact);
  			    	 }
  			    	 } 
  			    		
  			    		jsonitemcart.put("cart_id",id);
  			   	    	jsonitemcart.put("cart_gdsid",gdsid);
  			   	        jsonitemcart.put("cart_shopcode",shopcode);
  			   	    	jsonitemcart.put("cart_title",title);
  			   	    	jsonitemcart.put("cart_oldPrice",df2.format(oldPrice));
  			   	    	jsonitemcart.put("cart_price",df2.format(price));
  			   	    	jsonitemcart.put("cart_img",img);
  			   	    	jsonitemcart.put("cart_sku",skuname);
  			   	    	jsonitemcart.put("cart_gdscount",amount);
  			   	  		jsonitemcart.put("cart_money",df2.format(money));
  			   	    	jsonitemcart.put("cart_type",type);
  			   	    	jsonitemcart.put("cart_actid",actid);
  			   	    	jsonitemcart.put("cart_haschild",haschild);
  			   	    	
  			   	    	
  			   	    	jsonitemarr.add(jsonitemcart);	
  			   
    			if(cart.getActid()!=null){
					 oldactid=cart.getActid().intValue();
				 }else{
					 oldactid=0;
				 }	
    			}
  			      allactmoney+=shopactmoney; 
  			    	json.put("allmoney", df2.format(totalPrice));
  			    	json.put("allactmoney", df2.format(allactmoney));	    
  			    	json.put("actlist", jsonitemactarr);
  			    	json.put("cartlist", jsonitemarr);
  			     out.print(json);

  			    %>