<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*"%><%@include file="../../inc/header.jsp" %><%@include file="function.jsp" %>
<%
//点击结算的时候的检查。
ArrayList<Cart> cartList = CartHelper.getCartItemsOrder(request,response);
if(cartList == null || cartList.isEmpty()){//购物车为空
	Map<String,Object> map = new HashMap<String,Object>();
	map.put("error",new Integer(2));
	map.put("cart_goods_area",(lUser!=null?"您的购物车中没有商品，快去挑选商品吧&nbsp;&nbsp;<a href='/index.jsp'>回到首页&gt;&gt;</a>":"如果您上次退出时，购物车中有商品，那么商品已自动保存，<a href='/login.jsp'>请登录后查看&gt;&gt;</a>"));
	out.print(JSONObject.fromObject(map));
	return;
}
long totalGoods = 0;//物品总数
float totalPrice = 0f;//总金额
String parentId = null;//本次循环的父级ID
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date endDate4=null;
	Date ndate=new Date();
	try{
		endDate4 =fmt2.parse("2014-05-31 00:00:00");
		 }
	catch(Exception ex){
		ex.printStackTrace();
	}
StringBuilder sb = new StringBuilder();
ArrayList<ShpMst> shpmstlist=CartShopCodeHelper.getCartShopCode(request, response);
long allactmoney=0;
if(shpmstlist!=null){
	  int shpmstcount=1;
	 int smcount=shpmstlist.size();
	 float getshopactmoney=  CartHelper.getShopActCutMoney(request, response);
for(ShpMst shpmst:shpmstlist){

	  String shopcode=shpmst.getId();
		//System.out.println("商户数："+shopcode);
	  if(shopcode.equals("08102301"))shopcode="00000000";
	  long smtotalGoods = 0;//商户物品总数
	  float smtotalPrice = 0f;//商户总金额
	  ArrayList<Cart> cartList2 = CartShopCodeHelper.getCartItemsOrder(request, response, shopcode);
	  Collections.sort(cartList2,new ActComparator());
//sb.append("<input name=\"shopcode\" id=\"shopcode\" type=\"radio\" value=\""+shopcode +"\"");
//if (shpmstcount==1) {
//sb.append("checked=\"checked\"");
//} 
//sb.append("/>&nbsp;&nbsp;"+shpmst.getShpmst_shopname());
sb.append("&nbsp;&nbsp;如下商品，由&nbsp;"+shpmst.getShpmst_shopname()+"&nbsp;负责发货");
if(shopcode.equals("00000000")&&ndate.getTime()<endDate4.getTime()){
sb.append("<span style=\"color:red\">&nbsp;&nbsp;D1优尚自营产品满100元送五芳斋鲜肉粽（2只）</span>");
}
sb.append("<table width=\"885\" style=\"border-top:dashed 1px #ccc;\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
sb.append("<tr class=\"th\"><th width=\"158\" ></th><th width=\"300\" style=\"text-align:left;\">商品名称/编号</th><th width=\"100\">规格</th><th width=\"80\">会员价</th><th width=\"80\">成交价</th><th width=\"86\">数量</th><th width=\"81\">小计</th></tr>");
int havesku=0;
int actid=0;
int oldactid=0;
long shopactmoney=0;
for(Cart cart : cartList2){
	String id = cart.getId();
	 Product product = ProductHelper.getById(cart.getProductId());
	 String title = cart.getTitle();//物品名称
	 Sku sku = SkuHelper.getById(cart.getSkuId());
	 float oldPrice = Tools.floatValue(cart.getOldPrice());//会员价，单价
	 float price = Tools.floatValue(cart.getPrice());//成交单价
	 long amount = Tools.longValue(cart.getAmount());//数量
	 long type = Tools.longValue(cart.getType(),1);//类型
	 if(cart.getType().longValue()>=0){
		 totalGoods += amount;
		 smtotalGoods += amount;
	 }
	 float money = Tools.floatValue(cart.getMoney());//总计
	 if(type >= 0) {
		 totalPrice += money;
		 smtotalPrice += money;
	 }
	 float prefrePrice = oldPrice*amount-money;//优惠
	 if(prefrePrice < 0) prefrePrice = 0;
	 boolean hasFather = Tools.longValue(cart.getHasFather(),0)==1?true:false;//是否有父类
	 if(hasFather) parentId = cart.getParentId();
	 else parentId = null;
	 String rec_key = cart.getId()+"_0_"+(Tools.isNull(cart.getSkuId())?"0":cart.getSkuId());
	 
	 boolean isShowInfo = ((type==3||type==4||type==5|type==8||type==12||type==16)?false:true);//是否显示物品的详情
	 
	 //购物车ID_[0/1是否是积分换购的物品]_skuId
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
	if(actmoney >0)fxtxt="<span class=\"d1actttile\">减免："+actmoney+"元</span>";
	String acttxt="";
	String goshopurl="";
		if(d1act.getD1acttb_acttype().longValue()==0){
			acttxt="满减";

			if(shpmst!=null&&shpmst.getShpmst_index().longValue()==1&&
					!Tools.isNull(shpmst.getShpmst_shopsname())){
			goshopurl="http://www.d1.com.cn/shop/"+shpmst.getShpmst_shopsname();
			}
		}else if(d1act.getD1acttb_acttype().longValue()==1){
			acttxt="专区满减";
			goshopurl="http://www.d1.com.cn/html/result_rec.jsp?aid="+d1act.getD1acttb_ppcode();
		}else if(d1act.getD1acttb_acttype().longValue()==2){
			acttxt="品牌满减";
			goshopurl="http://www.d1.com.cn/shopbrand.jsp?sc="+d1act.getD1acttb_shopcode()+"&brand="+d1act.getD1acttb_brandcode();

		}else if(d1act.getD1acttb_acttype().longValue()==3){
			String ppcode=d1act.getD1acttb_ppcode();
			acttxt="";
			if("020".equals(ppcode))acttxt="女装满减";
			if("030".equals(ppcode))acttxt="男装满减";
			if("050".equals(ppcode))acttxt="箱包满减";
			if("012".equals(ppcode))acttxt="居家满减";
			if("015".equals(ppcode))acttxt="名品饰品满减";
			
			goshopurl="http://www.d1.com.cn/result.jsp?shopd1=1&productsort="+ppcode;

		}
 sb.append("<tr class=\"th\" ><th   bgcolor=\"#dbeefd\" colspan=\"7\"><div class=\"d1actt\"><span class=\"d1actttile\">满减</span><span class=\"deactspan\">&nbsp;"+showactt+"</span><span class=\"d1actmore\"><a href=\""+goshopurl+"\" target=\"_blank\">查看活动</a></span></div><div class=\"d1actp\"><span class=\"deactspan\">"+d1actpmoney+"</span>"+fxtxt+"</div> </th></tr>");
 }
 } 
	 
	 //购物车ID_[0/1是否是积分换购的物品]_skuId
	 sb.append("<tr type=\""+type+"\" id=\"cart_").append(rec_key).append("\"");
	 if(parentId != null) sb.append(" parentId=\"").append(parentId).append("\"").append(" class=\"suitTitle\"");
	 else sb.append(" style=\"background:#FFFDDD;\" ");
	 sb.append(" rec_key=\"").append(rec_key).append("\">");
	 if(product != null){
	 	sb.append("<td class=\"cartl\" height=\"100\">").append("<a href='"+ProductHelper.getProductUrl(product)+"' target=_blank><img src=\"").append(ProductHelper.getImageTo80(product)).append("\" alt=\"").append(title).append("\" /></a></td>");
	 	sb.append("<td class=\"othertd\">");
	 	if(Tools.longValue(product.getGdsmst_specialflag()) == 1){
	 		sb.append("<img src=\"http://images.d1.com.cn/images2012/New/flow/noticket.gif\" align=\"absmiddle\" alt=\"该商品不能使用优惠券\" />&nbsp;");
	 	}
	 	sb.append(title).append("<br/>").append(product.getId()).append("<br/>");
		if(!hasFather){
			sb.append("<a href=\"###\" id=\"del_").append(rec_key).append("\" class=\"del_link\" onclick=\"clickRemove(this,").append(type).append(",'").append(rec_key).append("','").append(Tools.longValue(cart.getHasChild())).append("');\">删除</a>&nbsp;&nbsp;");
		}
	 	sb.append("<a href=\"###\" onclick=\"addFavorite('").append(product.getId()).append("');\" class=\"fav_link\">加入收藏</a>");
	 	if(product.getGdsmst_ifhavegds()!=null&&product.getGdsmst_ifhavegds().longValue()==0)
        {
     	   if(product.getGdsmst_stocklinkty()!=null&&product.getGdsmst_stocklinkty().longValue()==0)
     	   {
     		   if(product.getGdsmst_ifhavedate()!=null&&product.getGdsmst_ifhavedate().after(new Date())){
     			   Date ifhaveDate=product.getGdsmst_ifhavedate();
     			   if(sku!=null)
	            	   {
	            		   if(sku.getSkumst_vstock()!=null&&sku.getSkumst_vstock().longValue()==0)
	            		   {
	            			   sb.append("<br/><font style=\"color:#f66500\">该商品预计"+(ifhaveDate.getMonth()+1)+"月"+ifhaveDate.getDate()+"日到货，建议您单独下单购买。</font>");
						   	
	            		   }
	            	   }
	            	   else
	            	   {			
	            		   if(product.getGdsmst_ifhavegds()!=null&&product.getGdsmst_ifhavegds().longValue()==0){
	            			   sb.append("<br/><font style=\"color:#f66500\">该商品预计"+(ifhaveDate.getMonth()+1)+"月"+ifhaveDate.getDate()+"日到货，建议您单独下单购买。</font>");
	            	       }
	            	   }
     		   }
     	   }
     	  
        }
	 	sb.append("</td>");
	 }else{
		 sb.append("<td class=\"othertd\" colspan=\"2\" height=\"40\" style=\"padding-left:20px;\">");
		 sb.append("<font style=\"color:#Be0404\">").append(title).append("</font>&nbsp;&nbsp;");
		 if(!hasFather){
			 sb.append("<a href=\"###\" id=\"del_"+rec_key +"\" class=\"del_link\" onclick=\"clickRemove(this,"+type+",'"+rec_key+"','"+Tools.longValue(cart.getHasChild())+"');\">删除</a>&nbsp;&nbsp;");
		 }
		 sb.append("</td>");		
	 }
	 
	 
	 sb.append("<td>");
	  if(cart.getHasChild().longValue()>0){
		  sb.append("");
	  }
	  else{
		if(sku!=null&&sku.getSkumst_sku1()!=null&&sku.getSkumst_sku1().length()>0)
		{
			sb.append(sku.getSkumst_sku1());
		}
		else{
			if(!Tools.isNull(product.getGdsmst_skuname1())){
				String skuname1=product.getGdsmst_skuname1();
				int showsku=1;
				if(product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==0||product.getGdsmst_stocklinkty().longValue()==3)){
					showsku=0;
				}
			    List<Sku> skuList = SkuHelper.getSkuListViaProductIdO(product.getId(),showsku);
			    if(skuList != null && !skuList.isEmpty()){
			    	havesku++;
			    	sb.append("<a href=\"javascript:void(0)\" onclick=\"rechoosesku('"+ product.getId()+"','"+id+"','"+ skuname1+"')\">请选择"+skuname1 +"></a>");
		        }
			    else{
			    	sb.append("无");
			    }
			}
			else{
				sb.append("无");
			}
		}
	  }	 
	 sb.append("</td>");
	 if(isShowInfo){
		 sb.append("<td><span>").append(Tools.getFormatMoney(cart.getOldPrice().floatValue()) ).append("</span>").append("</td>");
		 sb.append("<td><span id=\"price_"+rec_key+"\">"+(int)money/amount +"</span></td>");
		 //sb.append("<td><span id=\"prefrePrice_").append(rec_key).append("\">").append(Tools.getFormatMoney(prefrePrice)).append("</span></td>");
		 sb.append("<td>");
		 if(hasFather || type==0 || type==13 || type==-5 ||type==14|| type==2||type==18||(product!=null&&product.getGdsmst_buylimit()!=null&&product.getGdsmst_buylimit().intValue()>0)){
			 sb.append("<span id='num_span_").append(rec_key).append("'>").append(amount).append("</span>");
		 }else{
			 sb.append("<a href='###' title='减1' class=\"num_minus\" onclick=\"addorminus('minus','").append(id).append("','").append(rec_key).append("');\"><img src='http://images.d1.com.cn/images2012/New/flow/j_a.gif' /></a>");
			 sb.append("<input type='text' id='num_input_").append(rec_key).append("' objNum='").append(amount).append("' onkeyup=\"this.value=this.value.replace(/[^\\d]/g,'');\" onblur=\"updatecart('").append(id).append("','").append(rec_key).append("');\" onkeypress=\"if((arguments[0] || window.event).keyCode==13){updatecart('").append(id).append("','").append(rec_key).append("');$.addEvent();}\" name='txtChange").append(rec_key).append("' class=\"amount\" maxlength='4' value='").append(amount).append("' />");
			 sb.append("<a href='###' title='加1' class=\"num_add\" onclick=\"addorminus('add','").append(id).append("','").append(rec_key).append("');\"><img src='http://images.d1.com.cn/images2012/New/flow/a_j.gif' /></a>");
		 }
		 sb.append("</td>");
		 sb.append("<td><font color=\"#FF0000\" id=\"subtotal_").append(rec_key).append("\">").append(Tools.getFormatMoney(money)).append("</font></td>");
	 }else{
		 sb.append("<td>-</td><td>-</td><td>");
		 sb.append("<span id='num_span_").append(rec_key).append("'>").append(amount).append("</span>");
		 sb.append("</td><td><font color=\"#FF0000\">-</font></td>");
	 }
	 sb.append("</tr>");
	 if(cart.getActid()!=null){
		 oldactid=cart.getActid().intValue();
	 }else{
		 oldactid=0;
	 }
}
allactmoney+=shopactmoney;
sb.append("</table>");
if(smcount>1){
sb.append("<div class=\"goods_list tailtd\" id=\"total_area").append(shopcode).append("\">");
	
sb.append("商品总计：<font style=\"font-size:13px; font-weight:bold;\" id=\"total_Count\">").append(smtotalGoods).append("</font>件");
if(shopactmoney>0){ 
	sb.append("&nbsp;&nbsp;优惠金额："+shopactmoney +"元&nbsp;");
	} 
sb.append("<font style=\" color:#d80100; font-size:16px; font-weight:bold; margin-left:30px;\">应付总额：<span id=\"total_Price\">");
sb.append(Tools.getFormatMoney(smtotalPrice-shopactmoney)).append("</span>元</font></div>");
}
shpmstcount+=1;
}

}

Map<String,Object> goods_Map = new HashMap<String,Object>();

//总金额区域
StringBuilder totalMoneySb = new StringBuilder();
totalMoneySb.append("购物车商品总计：<font style=\"font-size:13px; font-weight:bold;\" id=\"total_Count\">").append(totalGoods).append("</font>件");
if(allactmoney>0){ 
	totalMoneySb.append("&nbsp;&nbsp;优惠金额："+allactmoney +"元&nbsp;");
	} 
totalMoneySb.append("<font style=\"color:#d80100; font-size:16px; font-weight:bold; margin-left:30px;\">应付总额：<span id=\"total_Price\">").append(Tools.getFormatMoney(totalPrice-allactmoney)).append("</span>元</font>");

goods_Map.put("total_area",totalMoneySb.toString());//总金额的HTML代码
goods_Map.put("totalPrice",new Float(totalPrice));//购物车总金额
goods_Map.put("total_Count",new Long(totalGoods));//物品数量
goods_Map.put("cart_goods_area",sb.toString());//物品数量


goods_Map.put("zengpin_area",zengpinArea2014(request,response));//赠品换购显示区域
goods_Map.put("favor_out_cart",new Integer(1));//赠品换购的数量


//生成json
Map<String,Object> map = new HashMap<String,Object>();
map.put("error",new Integer(0));
map.put("message","");
map.put("content",goods_Map);
out.print(JSONObject.fromObject(map));
%>