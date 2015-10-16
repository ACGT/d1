<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,com.d1.helper.*,com.d1.bean.*,com.d1.util.*"%><%!

//赠品区域显示。
private static String zengpinArea2014(HttpServletRequest request, HttpServletResponse response){
	StringBuilder sb = new StringBuilder();
	StringBuilder sb0 = new StringBuilder();
	StringBuilder sb1 = new StringBuilder();
	StringBuilder sb2 = new StringBuilder();
	List<Gift> giftList000 = GiftHelper.getCartGift(request, response,0);
	int showflag=0;
	if(giftList000 != null && giftList000.size()>0){
	
		showflag=0;
		sb0.append("<table width=\"885\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
		sb0.append("<tr><td height=\"38\" class=\"zplisttit\">赠品换购区</td></tr>");
		String sb0html="";
		int showitemflag=0;
		 for(int i=0;i<giftList000.size();i++){
			 showitemflag=0;
			 Gift Gift_000 = giftList000.get(i);//购物车里正常的商品
			  String gfshopcode=Gift_000.getGiftrckmst_shopcode();
              if(!gfshopcode.equals("11111111")){
             	int gfspcount=CartShopCodeHelper.getCartAllpCount(request,response,gfshopcode);
             	if(gfspcount==0)continue;
              }
             
			 ArrayList<GiftItem> giftItemList = GiftHelper.getGiftItems(Gift_000.getId());
			 if(giftItemList!=null&&giftItemList.size()>0){
				long zpselected=Gift_000.getGiftrckmst_selecttype().longValue();
				sb0html="<tr><td class=\"subtitle\" >";
				String zptitle="";
				if(!gfshopcode.equals("11111111")){
					ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(gfshopcode);
					if(shpmst==null)return null;
					String shpname=shpmst.getShpmst_shopname();
				sb0html+="<a href=\"http://www.d1.com.cn/shopbrand.jsp?sc="+gfshopcode+"\" target=\"_blank\">"+shpname+"：";
				zptitle ="<a href=\"http://www.d1.com.cn/shopbrand.jsp?sc="+gfshopcode+"\" target=\"_blank\">在“"+ shpname+"”店铺</a><br>";

				}else{
					sb0html+="全场赠品：";	
					//zptitle="全场";
					
				}
				if(zpselected==0){
				 sb0html+=Gift_000.getGiftrckmst_title()+"<span style=\"color:red\">(如下赠品限换1个)</span>";
				 }else{
					 sb0html+=Gift_000.getGiftrckmst_title()+"<span style=\"color:red\">(如下赠品可选择多个)</span>";
					 }
				if(!gfshopcode.equals("11111111")){
				 sb0html+="</a>";
				 }
				 sb0html+="</td> </tr><tr><td style=\"border-bottom:dashed 1px #cdcdcd;text-align:left;\"> <ul class=\"zplist\">";

				 int tdi=0;
		     int counti=1;
		      float limitmoney=0f;
		      float cartallmoney=CartShopCodeHelper.getTotalPayMoneys(request,response,gfshopcode);
		  for(int k=0;k<giftItemList.size();k++){
			  
				GiftItem gi_1 = giftItemList.get(k); 	
				if(CartHelper.existsGiftidProductId(request, response,gi_1.getGiftrckdtl_gdsid(), gi_1.getGiftrckdtl_mstid().longValue())){
					continue;
				}
			

		       
						  Product product = ProductHelper.getById(gi_1.getGiftrckdtl_gdsid());
		                  if(product==null)continue;
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
					 	if(showflag==0)showflag=1;
					 	if(showitemflag==0)showitemflag=1;
						String	giftvalue=GiftHelper.getcreategiftaddstr(Gift_000, gi_1, product, cartallmoney);
				
			             sb0html+="<li> <p style=\"width:110px; text-align:center;\"><a href=\""+ProductHelper.getProductUrl(product)+"\" target=\"_blank\">";
			             sb0html+="<img src=\""+ProductHelper.getImageTo120(product)+"\" width=\"110\" height=\"110\"/></a>";
			             sb0html+="</p><p class=\"newp\"><a href=\""+ProductHelper.getProductUrl(product)+"\" style=\"color:#7F7F7F;text-decoration: none;\" title=\""+title+"\">"+title+"</a><br/>";
			             sb0html+="<span style=\"text-decoration: line-through;\">价值：￥"+Tools.getFormatMoney(product.getGdsmst_saleprice()) +"</span> <br/>";
			             sb0html+="<span class=\"cspan\">兑换价：￥"+Tools.getFormatMoney(gi_1.getGiftrckdtl_addmoney())+"</span></p> <div class=\"clear\"></div>";
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
			             
			             sb0html+="<span class=\"cspan2\">"+zptitle+zptxt +"</span>";
			             if (fltGiftRckDtl_Addmoney==0){ 
		              if(cartallmoney<fltGiftRckDtl_Limitmoney){  
		                sb0html+="<span class=\"cspan\">"+giftvalue+"</span><img src=\"http://images.d1.com.cn/images2014/flow/mfno.png\" style=\"margin-top:5px;\"/>";
		                        
		               }else{  
		            	 sb0html+="<span class=\"cspan3\">"+giftvalue +"</span><a href=\"#\" attr=\""+gi_1.getId()+"_0\" onclick=\"addGiftCart(this);\"><img src=\"http://images.d1.com.cn/images2014/flow/mfon.png\" style=\"margin-top:8px;\"/></a>";
		              }		
			             }else{
			            	 if(cartallmoney<fltGiftRckDtl_Limitmoney){  
					                sb0html+="<span class=\"cspan\">"+giftvalue+"</span><img src=\"http://images.d1.com.cn/images2014/flow/tjhgno.png\" style=\"margin-top:5px;\"/>";
					                        
					               }else{  
					            	 sb0html+="<span class=\"cspan3\">"+giftvalue +"</span><a href=\"#\" attr=\""+gi_1.getId()+"_0\" onclick=\"addGiftCart(this);\"><img src=\"http://images.d1.com.cn/images2014/flow/tjhgon.png\" style=\"margin-top:8px;\"/></a>";
					              }	
			             }
		              sb0html+="</li>";
      
		       
		        counti++;
		        
		        limitmoney=fltGiftRckDtl_Addmoney; 
		        
		          }
		     
		        
		  sb0html+="</ul>  </td></tr>";
		  if(showitemflag==1)sb0.append(sb0html);
		  }}   
		 
		 sb0.append("</table>");
		 }  
		 //<!-- 全场赠品结束 -->
		
		 if(showflag==1)sb.append(sb0.toString());
		
	List<Gift> Giftrck001 = GiftHelper.getCartGift(request, response,1);
	if(Giftrck001 != null && Giftrck001.size()>0){
		showflag=0;

		sb1.append("<table width=\"885\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
		//sb1.append("<tr><td height=\"38\" class=\"zplisttit\">分类赠品</td></tr>");
		String sb1html="";
		int showitemflag=0;
		 for(int i=0;i<Giftrck001.size();i++){
			 showitemflag=0;
			 Gift Gift_001 = Giftrck001.get(i);//购物车里正常的商品
			
			 //System.out.println(Gift_001.getId());
			 ArrayList<GiftItem> giftItemList001 = GiftHelper.getGiftItems(Gift_001.getId());
			 if(giftItemList001!=null&&giftItemList001.size()>0){
					long zpselected=Gift_001.getGiftrckmst_selecttype().longValue();
					String gfshopcode=Gift_001.getGiftrckmst_shopcode();
					String zptitle="";
					if(!gfshopcode.equals("11111111")){
						ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(gfshopcode);
						if(shpmst==null)return null;
						String shpname=shpmst.getShpmst_shopname();
						sb1html+="<a href=\"http://www.d1.com.cn/shopbrand.jsp?sc="+gfshopcode+"\" target=\"_blank\">"+shpname+"：";
					zptitle ="<a href=\"http://www.d1.com.cn/shopbrand.jsp?sc="+gfshopcode+"\" target=\"_blank\">在“"+ shpname+"”店铺</a><br>";

					}
					String strRakmst_rackname ="";
				      String gfrck=Gift_001.getGiftrckmst_rackcode();
					if ("001".equals(gfrck)){
						strRakmst_rackname="服装饰品";
					}
					else{
						Directory dir = DirectoryHelper.getById(gfrck);
						 strRakmst_rackname = (dir != null ? dir.getRakmst_rackname():"000");
				    }
					 
				    if(zpselected==0){
					 sb1html="<tr><td class=\"subtitle\" > <a href=\"/result.jsp?productsort="+(gfrck.equals("001")?"020,030,015009":gfrck)+"\" target=\"_blank\">"+strRakmst_rackname+"</a>"+Gift_001.getGiftrckmst_title()+"<span style=\"color:red\">(如下赠品限换1个)</span></td> </tr>";
					   }else{
						 sb1html="<tr><td class=\"subtitle\" > <a href=\"/result.jsp?productsort="+(gfrck.equals("001")?"020,030,015009":gfrck)+"\" target=\"_blank\">"+strRakmst_rackname+"</a>"+Gift_001.getGiftrckmst_title()+"<span style=\"color:red\">(如下赠品可选择多个)</span></td> </tr>";
					 } 
				 sb1html+="<tr><td style=\"border-bottom:dashed 1px #cdcdcd;text-align:left;\"> <ul class=\"zplist\">";

				 int tdi=0;
		     int counti=1;
		      float limitmoney=0f;
		      float cartallmoney=0f;
		      
		      if ("001".equals(gfrck)){
					cartallmoney=CartHelper.getTotalRackcodePayMoney(request,response,"015009",Gift_001.getGiftrckmst_shopcode());
					cartallmoney+=CartHelper.getTotalRackcodePayMoney(request,response,"02",Gift_001.getGiftrckmst_shopcode());
					cartallmoney+=CartHelper.getTotalRackcodePayMoney(request,response,"03",Gift_001.getGiftrckmst_shopcode());
				}
				else{
					
					cartallmoney=CartHelper.getTotalRackcodePayMoney(request,response,gfrck,Gift_001.getGiftrckmst_shopcode());
				}
		      
		  for(int k=0;k<giftItemList001.size();k++){
				GiftItem gi_001 = giftItemList001.get(k); 	
				
				if(CartHelper.existsGiftidProductId(request, response,gi_001.getGiftrckdtl_gdsid(), gi_001.getGiftrckdtl_mstid().longValue())){
					continue;
				}
				
				
			 	
						  Product product = ProductHelper.getById(gi_001.getGiftrckdtl_gdsid());
						  if(product==null)continue;
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
							 if(product.getGdsmst_stocklinkty().longValue()==1&&vituralstock+CartItemHelper.getProductOccupyStock(product.getId(), null)<=5 ){  
							  continue;
							}
					
						String	giftvalue=GiftHelper.getcreategiftaddstr(Gift_001, gi_001, product, cartallmoney);
						if(showflag==0)showflag=1;
						if(showitemflag==0)showitemflag=1;
		sb1html+="<li><p style=\"width:110px; text-align:center;\"><a href=\""+ProductHelper.getProductUrl(product)+"\" target=\"_blank\"><img src=\""+ProductHelper.getImageTo120(product)+"\" width=\"110\" height=\"110\"/></a>";
		sb1html+="</p><p class=\"newp\"><a href=\""+ProductHelper.getProductUrl(product)+"\" style=\"color:#7F7F7F;text-decoration: none;\" title=\""+title +"\">"+title +"</a><br/>";
		sb1html+="<span style=\"text-decoration: line-through;\">价值：￥"+Tools.getFormatMoney(product.getGdsmst_saleprice()) +"</span> <br/>";
		sb1html+="<span class=\"cspan\">兑换价：￥"+Tools.getFormatMoney(gi_001.getGiftrckdtl_addmoney()) +"</span></p><div class=\"clear\"></div>";
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
		sb1html+="<span class=\"cspan2\">"+zptitle+zptxt +"</span>";        
		if (fltGiftRckDtl_Addmoney==0){ 
            if(cartallmoney<fltGiftRckDtl_Limitmoney){  
            	sb1html+="<span class=\"cspan\">"+giftvalue+"</span><img src=\"http://images.d1.com.cn/images2014/flow/mfno.png\" style=\"margin-top:5px;\"/>";
                      
             }else{  
            	 sb1html+="<span class=\"cspan3\">"+giftvalue +"</span><a href=\"#\" attr=\""+gi_001.getId()+"_0\" onclick=\"addGiftCart(this);\"><img src=\"http://images.d1.com.cn/images2014/flow/mfon.png\" style=\"margin-top:8px;\"/></a>";
            }		
	             }else{
	            	 if(cartallmoney<fltGiftRckDtl_Limitmoney){  
	            		 sb1html+="<span class=\"cspan\">"+giftvalue+"</span><img src=\"http://images.d1.com.cn/images2014/flow/tjhgno.png\" style=\"margin-top:5px;\"/>";
			                        
			               }else{  
			            	   sb1html+="<span class=\"cspan3\">"+giftvalue +"</span><a href=\"#\" attr=\""+gi_001.getId()+"_0\" onclick=\"addGiftCart(this);\"><img src=\"http://images.d1.com.cn/images2014/flow/tjhgon.png\" style=\"margin-top:8px;\"/></a>";
			              }	
	             }
		              	          
                sb1html+="</li>";
      
		     
		        counti++;
		        limitmoney=gi_001.getGiftrckdtl_addmoney().floatValue();      
		          }
		 
		        
		  sb1html+="</ul>  </td></tr>";
		  if(showitemflag==1)sb1.append(sb1html);
		  }} 	   
		 sb1.append("</table>");
		 }  
		// <!-- 服饰赠品结束 -->
if(showflag==1)sb.append(sb1.toString());
	List<Gift> Giftrck002 = GiftHelper.getCartGift(request, response,2);
		
	if(Giftrck002 != null && Giftrck002.size()>0){
		showflag=0;
		String sb2html="";
		int showitemflag=0;
		sb2.append("<table width=\"885\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
		//sb2.append("<tr><td height=\"38\" class=\"zplisttit\">化妆品赠品</td></tr>");
		  for(int i=0;i<Giftrck002.size();i++){
			  showitemflag=0;
			 Gift Gift_002 = Giftrck002.get(i);//购物车里正常的商品

			 ArrayList<GiftItem> giftItemList002 = GiftHelper.getGiftItems(Gift_002.getId());
			 if(giftItemList002!=null&&giftItemList002.size()>0){
				 long zpselected=Gift_002.getGiftrckmst_selecttype().longValue();
				 String gfshopcode=Gift_002.getGiftrckmst_shopcode();
					String zptitle="";
					if(!gfshopcode.equals("11111111")){
						ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(gfshopcode);
						if(shpmst==null)return null;
						String shpname=shpmst.getShpmst_shopname();
						sb2html+="<a href=\"http://www.d1.com.cn/shopbrand.jsp?sc="+gfshopcode+"\" target=\"_blank\">"+shpname+"：";
					zptitle ="<a href=\"http://www.d1.com.cn/shopbrand.jsp?sc="+gfshopcode+"\" target=\"_blank\">在“"+ shpname+"”店铺</a><br>";

					}
				    if(zpselected==0){
				    	sb2html="<tr><td class=\"subtitle\" >"+Gift_002.getGiftrckmst_title()+"<span style=\"color:red\">(如下赠品限换1个)</span></td> </tr>";
					   }else{
						   sb2html="<tr><td class=\"subtitle\" >"+Gift_002.getGiftrckmst_title()+"<span style=\"color:red\">(如下赠品可选择多个)</span></td> </tr>";
					 } 
				    sb2html+="<tr><td style=\"border-bottom:dashed 1px #cdcdcd;text-align:left;\"> <ul class=\"zplist\">";

	    int tdi=0;
		     int counti=1;
		      float limitmoney=0f;
		      float cartallmoney=CartHelper.getCartBrandPayMoney(request,response,Gift_002.getGiftrckmst_brandname(),Gift_002.getGiftrckmst_shopcode());
		      String strGiftrckmst_brandname = Gift_002.getGiftrckmst_brandname();
				if(strGiftrckmst_brandname!=null)strGiftrckmst_brandname=strGiftrckmst_brandname.replace("null", "");
				
		      for(int k=0;k<giftItemList002.size();k++){
				GiftItem gi_002 = giftItemList002.get(k); 	
				if(CartHelper.existsGiftidProductId(request, response,gi_002.getGiftrckdtl_gdsid(), gi_002.getGiftrckdtl_mstid().longValue())){
					continue;
				}
				
						  Product product = ProductHelper.getById(gi_002.getGiftrckdtl_gdsid());
						  if(product==null)continue;
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
							 if(product.getGdsmst_stocklinkty().longValue()==1&&vituralstock+CartItemHelper.getProductOccupyStock(product.getId(), null)<=5 ){  
							  continue;
							}
								 	
						String	giftvalue=GiftHelper.getcreategiftaddstr(Gift_002, gi_002, product, cartallmoney);
						if(showflag==0)showflag=1;
						if(showitemflag==0)showitemflag=1;
				  sb2html+=" <li><p style=\"width:110px; text-align:center;\">";
				  sb2html+=" <a href=\""+ProductHelper.getProductUrl(product)+"\" target=\"_blank\"><img src=\""+ProductHelper.getImageTo120(product)+"\" width=\"110\" height=\"110\"/></a>";
				  sb2html+="</p><p class=\"newp\"> <a href=\""+ProductHelper.getProductUrl(product)+"\" style=\"color:#7F7F7F;text-decoration: none;\" title=\""+title +"\">"+title +"</a><br/>";
				  sb2html+="<span style=\"text-decoration: line-through;\">价值：￥"+Tools.getFormatMoney(product.getGdsmst_saleprice())+"</span> <br/>";
				  sb2html+="<span class=\"cspan\">兑换价：￥"+Tools.getFormatMoney(gi_002.getGiftrckdtl_addmoney())+" </span></p><div class=\"clear\"></div>";
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
				  sb2html+="<span class=\"cspan2\">"+zptitle+zptxt +"</span>";  
				  if (fltGiftRckDtl_Addmoney==0){ 
			            if(cartallmoney<fltGiftRckDtl_Limitmoney){  
			            	sb2html+="<span class=\"cspan\">"+giftvalue+"</span><img src=\"http://images.d1.com.cn/images2014/flow/mfno.png\" style=\"margin-top:5px;\"/>";
			                      
			             }else{  
			            	 sb2html+="<span class=\"cspan3\">"+giftvalue +"</span><a href=\"#\" attr=\""+gi_002.getId()+"_0\" onclick=\"addGiftCart(this);\"><img src=\"http://images.d1.com.cn/images2014/flow/mfon.png\" style=\"margin-top:8px;\"/></a>";
			            }		
				             }else{
				            	 if(cartallmoney<fltGiftRckDtl_Limitmoney){  
				            		 sb2html+="<span class=\"cspan\">"+giftvalue+"</span><img src=\"http://images.d1.com.cn/images2014/flow/tjhgno.png\" style=\"margin-top:5px;\"/>";
						                        
						               }else{  
						            	   sb2html+="<span class=\"cspan3\">"+giftvalue +"</span><a href=\"#\" attr=\""+gi_002.getId()+"_0\" onclick=\"addGiftCart(this);\"><img src=\"http://images.d1.com.cn/images2014/flow/tjhgon.png\" style=\"margin-top:8px;\"/></a>";
						              }	
				             }
		              	          
	                     sb2html+="</li>";
      
		       
		        counti++;
		        limitmoney=gi_002.getGiftrckdtl_addmoney().floatValue();      
		          }
		 
		        
		  sb2html+="</ul></td></tr>"; 
		  if(showitemflag==1)sb2.append(sb2html);
		  }} 
		  sb2.append("</table>"); 
		 } 
	if(showflag==1)sb.append(sb2.toString());
	return sb.toString();
}
//赠品区域显示。
private static String zengpinArea(HttpServletRequest request, HttpServletResponse response , List<GiftHelper.GiftGoods> giftList){
	if(giftList == null || giftList.isEmpty()) return "";
	boolean isgb=false;//是否含有赠品（庆祝改版活动）
	boolean isgq=false;//国庆
	boolean iszfqr=false;//绽放秋日
	String gdsidlist="02200096,02200097,02200095,02200094,03200050,03200049";
	String pid="";
	String pid2="";
	String gdsid="";
	ArrayList<Cart> cartList = CartShopCodeHelper.getCartItemsOrder(request,response,"00000000");
	  if(cartList != null && !cartList.isEmpty()){
		  for(Cart cart : cartList){
			  /**
			  String title = cart.getTitle();//物品名称
			  if(cart.getType().longValue()==14 && title.indexOf("改版")>=0){
					 isgb=true;
					break;
				 }
			  **/
			  if(cart.getType().longValue()==14 && ("02300190".equals(cart.getProductId()) || "02300189".equals(cart.getProductId()))){
					 pid=cart.getProductId();
					 if("02300190".equals(cart.getProductId())){
						 pid2="02300189";
					 }else if("02300189".equals(cart.getProductId())){
						 pid2="02300190";
					 }
					 isgq=true;
				 }
			  if(cart.getType().longValue()==14 && gdsidlist.indexOf(cart.getProductId())>=0){
				  gdsid=cart.getProductId();
				  iszfqr=true;
			  }
		  }
	  }
	StringBuilder sb = new StringBuilder();
	sb.append("<table width='885' border='0' cellpadding='0' cellspacing='0'>");
	sb.append("<tr><td colspan='7' class='subtitle'>赠品及换购</td></tr>");
	sb.append("<tr><td colspan='7'>");
	
	sb.append("<table width='885' cellspacing='0' cellpadding='0' class='subtable1'>");
	sb.append("<tr class='th'><th width='140'>商品说明</th><th width='382'>商品名称/编号</th><th width='90'>市场价</th><th width='90'>金额</th><th width='90'>数量</th><th width='90'>操作</th></tr>");
	for(GiftHelper.GiftGoods gg : giftList){
		  Product product = ProductHelper.getById(gg.getProductId());
		  String title = gg.getName();
		  if(isgb && ("03200001".equals(product.getId()) || "03200002".equals(product.getId()))){
			  break;
		  }else if(gg.getProductId().equals(pid2) || (!Tools.isNull(pid)&& gdsidlist.indexOf(gg.getProductId())>=0 && !gdsid.equals(gg.getProductId()))){
			  continue;
		  }else{
		  sb.append("<tr>");
		  sb.append("<td>").append(gg.getValue()).append("</td>");
		  sb.append("<td class=\"othertd\"><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" title=\"").append(title).append("\"><img src=\"").append(ProductHelper.getImageTo80(product)).append("\" class=\"img\" /></a><div class=\"title\"><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" title=\"").append(title).append("\">").append(title).append("</a><br/>").append(product.getId()).append("</div></td>");
		  sb.append("<td>").append(Tools.getFormatMoney(gg.getSalePrice())).append("</td>");
		  sb.append("<td><font color='#e96563' style='font-weight:bold;'>").append(Tools.getFormatMoney(gg.getPrice())).append("</font></td>");
		  sb.append("<td>1</td>");
		  if(gdsid.equals(gg.getProductId())){
			  sb.append("<td>您已领取过该商品</td>");
		  }  else{
		  sb.append("<td><a href=\"###\" attr=\"").append(gg.getGiftItemId()).append("_").append(gg.getType()).append("\" onclick=\"addGiftCart(this);\">放入购物车</a></td>");
		  }
		  sb.append("</tr>");
		  }
	}
	sb.append("</table>");

	sb.append("</td></tr></table>");
	
	return sb.toString();
}

%>