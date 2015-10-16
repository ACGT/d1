<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/ajax/flow/function.jsp" %>
<%
//查看购物车中是否有物品，没有则跳转
//CartHelper.checkCartError(request,response);

CartHelper.updateAllCartItems(request, response);

//获得用户一级的商品
ArrayList<Cart> cartList = CartHelper.getCartItemsOrder(request,response);

int member = 0;//普通会员或者未登录会员
if(UserHelper.isPtVip(request, response)){//如果是白金会员，修改价格
	member = 2;
}else if(UserHelper.isVip(request, response)){//如果是VIP会员
	member = 1;
}
String infos="";
String act=request.getParameter("act");
if("post".equals(request.getMethod().toLowerCase())&&"u".equals(act))
{
   String gdsid=request.getParameter("pid");
   
   if(!Tools.isNull(gdsid)&&gdsid.length()>0)
   {
	   Product p=ProductHelper.getById(gdsid);
	   if(p==null)
	   {
		   infos="您要修改的商品信息不存在！";
	   }
	   else
	   {
		   String count=request.getParameter("c_"+gdsid);
		   if(!Tools.isNumber(count))
		   {
			   infos="您写入的数目格式不正确！";
		   }
		   else if(Tools.parseLong(count)<=0)
		   {
			   infos="输入格式错误！";
		   }
		   else
		   {
			   String buylimit="0";
			   if(p.getGdsmst_buylimit()!=null&&p.getGdsmst_buylimit().longValue()>0)
			   {
				   buylimit=p.getGdsmst_buylimit().toString() ;
			   }
			   if(Tools.parseLong(count)>Tools.parseLong(buylimit)&&Tools.parseLong(buylimit)>0)
			   {
				   infos="对不起，该商品限购"+buylimit+"个，清重新输入购买数量!";
			   }
			   else
			   {
				   String car_id = request.getParameter("carid");
				   String goods_number = count;
				   String rec_key = request.getParameter("rec_key");

				   Cart cart = CartHelper.getById(car_id);

				   if(cart == null){
				   	infos="该商品在购物车中不存在！";
				   }
				   else
				   {

					   Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
	
					   long type = Tools.longValue(cart.getType());
					   //赠品和套餐类物品，不能修改数量。
					   if(Tools.longValue(cart.getHasFather() , 0) == 1 || type==0 || type==13 ||type==14|| type==-5 || type==2||(product!=null&&product.getGdsmst_buylimit()!=null&&product.getGdsmst_buylimit().intValue()>0)){
					   	infos="该类商品不能修改数量！";
					   }
					   else if(!Tools.isMath(goods_number) || "0".equals(goods_number)){
					   	infos="数目格式不正确！";
					   }
					   else if(Tools.isNull(rec_key)){
							infos="不能为空";
						}
					   else
					   {
						   int number = Integer.parseInt(goods_number);
						   //最多购买限次
						   /* long buylimit = Tools.longValue(product.getGdsmst_buylimit(),0);
						   if((buylimit == 0 && number > 999) || (buylimit > 0 && number > buylimit)){
						   	out.print("{\"error\":-2,\"message\":\"此商品您最多只能购买"+(buylimit==0?999:buylimit)+"件！\",\"content\":\"\"}");
						   	return;
						   } */
		                    System.out.print("111");
						   //量少提醒和卖完就下的商品检查一下虚拟库存够不够
						   if(product!=null&&product.getGdsmst_stocklinkty()!=null&&(product.getGdsmst_stocklinkty().longValue()==1||product.getGdsmst_stocklinkty().longValue()==2)){
						   	if(number+CartItemHelper.getProductOccupyStock(product.getId(), cart.getSkuId())>ProductHelper.getVirtualStock(product.getId(), cart.getSkuId())){
						   		infos="该商品库存不足！修改失败！";
						   	}
						   }
						   if(!infos.equals("该商品库存不足！修改失败！"))
						   {
							   String[] keyArr = rec_key.split("_");
							   if(keyArr == null || keyArr.length!=3){
							   	infos="";
							   }
							   else
							   {
								   //再看库存,InCart.jsp
								   //更新数量
								   List<Cart> deleteCartList = CartHelper.updateCartAmount(request,response,car_id,number);
				
								   //删除的物品。
								   String deleteStr = "";
								   List<String> delete_list = new ArrayList<String>();
								   if(deleteCartList != null && !deleteCartList.isEmpty()){
								   	deleteStr +="自动删除物品：";
								   	for(Cart c : deleteCartList){
								   		delete_list.add(c.getId()+"_0_"+(Tools.isNull(c.getSkuId())?"0":c.getSkuId()));
								   		deleteStr += "["+c.getTitle()+"]&nbsp;&nbsp;";
								   	}
								   }
				
								   Map<String,Object> goods_Map = new HashMap<String,Object>();
				
								   //物品关联的子类
								   List<Map<String,Object>> child_List = new ArrayList<Map<String,Object>>();
								   //获取子cart列表
								   ArrayList<Cart> childCart = CartHelper.getCartItemsViaParentId(cart.getId());
								   //修改所有子节点数量，支付价在后面修改
								   if(childCart!=null&&!childCart.isEmpty()){
								   	for(Cart c : childCart){
								   		Map<String,Object> childMap = new HashMap<String,Object>();
								   		String c_rec_key = c.getId()+"_0_"+(Tools.isNull(c.getSkuId())?"0":c.getSkuId());
								   		childMap.put("goods_number" , c.getAmount());
								   		//会员价格
								   		float oldPrice = Tools.floatValue(c.getOldPrice())*Tools.longValue(c.getAmount());
								   		childMap.put("prefrePrice" , Tools.getFormatMoney(oldPrice - Tools.floatValue(c.getMoney())));//优惠价格
								   		childMap.put("subtotal",Tools.getFormatMoney(Tools.floatValue(c.getMoney())));//总价
								   		childMap.put("rec_key",c_rec_key);
								   		child_List.add(childMap);
								   		
								   		if(c.getType().longValue()>=0){
								   			Product p_9k = (Product)Tools.getManager(Product.class).get(c.getProductId());
								   			
								   			//量少提醒和卖完就下的商品检查一下虚拟库存够不够
								   			if(p_9k!=null&&p_9k.getGdsmst_stocklinkty()!=null&&(p_9k.getGdsmst_stocklinkty().longValue()==1||p_9k.getGdsmst_stocklinkty().longValue()==2)){
								   				if(cart.getAmount().intValue()+CartItemHelper.getProductOccupyStock(p_9k.getId(), c.getSkuId())>ProductHelper.getVirtualStock(p_9k.getId(), c.getSkuId())){
								   					infos="部分商品库存不足！修改失败！";
								   				}
								   			}
								   		}
								   	}
								   }
				                   if(!infos.equals("部分商品库存不足！修改失败！"))
				                   {
									   //总金额区域
									   float totalPrice = CartHelper.getTotalPayMoney(request,response);
									   StringBuilder totalMoneySb = new StringBuilder();
									   totalMoneySb.append("商品总计：<font style=\"font-size:13px; font-weight:bold;\" id=\"total_Count\">").append(CartHelper.getTotalProductCount(request,response)).append("</font>件");
									   totalMoneySb.append("<font style=\"color:#d80100; font-size:16px; font-weight:bold; margin-left:30px;\">应付总额：<span id=\"total_Price\">").append(Tools.getFormatMoney(totalPrice)).append("</span>元</font>");
					
									   //赠品
									   List<GiftHelper.GiftGoods> giftList = GiftHelper.getCartVisiableGiftProducts(request,response);
									   int giftCount = (giftList == null ? 0 : giftList.size());
					
									   //初始化数据
									   goods_Map.put("goods_number",cart.getAmount());//物品数量
									   goods_Map.put("subtotal",cart.getMoney());//总价
									   goods_Map.put("delete_goods_key",delete_list);//删除的物品
									   goods_Map.put("tishi_delete_favor",deleteStr);//自动删除物品的提示
									   goods_Map.put("child_goods",child_List);
									   goods_Map.put("total_area",totalMoneySb.toString());//总金额的HTML代码
									   goods_Map.put("zengpin_area",zengpinArea(request,response,giftList));//赠品换购显示区域
									   goods_Map.put("favor_out_cart",new Integer(giftCount));//赠品换购的数量
									   goods_Map.put("totalPrice",new Float(totalPrice));//购物车总金额
									   goods_Map.put("cart_type",cart.getType());
									   //会员价格
									   float oldPrice = Tools.floatValue(cart.getOldPrice())*Tools.longValue(cart.getAmount());
									   //goods_Map.put("oldPrice" , new Float(oldPrice));//会员价
									   //goods_Map.put("vipPrice" , new Float(Tools.floatValue(cart.getVipPrice())*Tools.longValue(cart.getAmount())));//VIP价
									   goods_Map.put("prefrePrice" , new Float(oldPrice - Tools.floatValue(cart.getMoney())));//优惠价格
					
									 response.sendRedirect("/wap/flow.jsp");
				                   }
						       }
						   }
					   }
				   }
			   }
		   }
	   }
   }
   else
   {
  
      infos="参数不正确！";
   }
   
}

if("post".equals(request.getMethod().toLowerCase())&&"del".equals(act)){
	
}


if ("post".equals(request.getMethod().toLowerCase())&&act.equals("js")) {
	
if(Tools.isNull(request.getParameter("guid"))){//点击去结算，判断用户是否登录
	if(UserHelper.getLoginUser(request,response) == null){
		response.sendRedirect("/wap/login.jsp?url=/wap/flowCheck1.jsp");
		return;
	}
	System.out.print("sss");
}else{
	response.sendRedirect("/wap/flowCheck1.jsp");
}
}

%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-购物车</title>
<style type="text/css">
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,hr,pre,form,fieldset,input,textarea,p,label,blockquote,th,td,button,span{padding:0;margin:0;}
body{ background:#fff;color:#4b4b4b; padding-bottom:15px; line-height:21px;  margin-left:5px;}
img{border:none;}

ul{list-style:none; padding:0px;}

a {text-decoration:none;color:#4169E1}
a:hover {color:#aa2e44}
.clear {clear:both;font-size:1px;line-height:0;height:0px;*zoom:1;}

.top{ margin-top:3px; }
.top ul li{float:left;border-bottom:solid 1px #000;  }
.top ul li a{ color:#000;}
.top ul li a:hover{ color:#aa2e44;}
#search{ width:160px; height:19px; float:left}
#search1{ width:160px; height:19px; float:left}
.search{ display:block; background:#a52a2a; color:#fff; width:51px; font-size:15px; float:left; }
.search:hover{ color:#fff;}
table tr td{ padding-top:2px; padding-bottom:2px; line-height:20px;}
.rmfl span{ display:block; width:70px; margin-left:3px; float:left; color:#aa2e44;}
.rmfl li{ float:left;}
.keyword{ background:#ffa07a; color:#f00; }
.keyword a{ color:#000;}
.keyword a:hover{ color:#aa2e44;}

.tip_box { height:auto; line-height:28px; border:1px solid #ffe2a6; background-color:#fffadc; color:#ffa00e; text-align:center; margin-bottom:15px;}

.sa0,.sa1,.sa2,.sa3,.sa4,.sa5,.sa6,.sa7,.sa8,.sa9,.sa10{width:100px;height:18px;background-image:url(http://images.d1.com.cn/images2011/commentimg/star.gif);background-repeat:no-repeat;overflow:hidden;  }
.sa0{background-position:0px 0px;}
.sa1{background-position:0px -119px;}/*半颗*/
.sa2{background-position:0px -21px;}
.sa3{background-position:0px -139px;}
.sa4{background-position:0px -40px;}
.sa5{background-position:0px -160px;}
.sa6{background-position:0px -58px;}
.sa7{background-position:0px -182px;}
.sa8{background-position:0px -77px;}
.sa9{background-position:0 -204px;}
.sa10{background-position:0px -97px;}
.old{ border:solid 1px #ccc; padding:2px;}
.current{ border:solid 2px #f00; padding:2px;}
</style>
</head>
<body>
<!-- 头部 -->
<%@ include file="inc/head.jsp" %>
<!-- 头部结束 -->

<div style=" margin-bottom:15px;">
   <div style=" background:#FFDEAD; padding:3px; width:100%;">
    <a href="/mindex.jsp">首页</a>>购物车
    <br/>
    </div>
    <span style="color:#f00"><%= infos %></span><br/>
    <div><font color='#ff0000'>注：如需修改商品数量，填写好数字后请点击“修改”按钮。</font></div>
      <font style="color:#f00">待结算商品：</font><br/>
      <div id="delete_favor" class="tip_box" style="display:none;"></div>
      
       
    <table id="all">
    <%
    long totalGoods = 0;//物品总数
	float totalPrice = 0f;//总金额
	String bfd_strgdsid2 = "";
	String bfd_strgdsid = "";
	if(cartList!=null&&cartList.size()>0)
	{
		for(Cart cart : cartList){
			 String id = cart.getId();
			 String title = cart.getTitle();//物品名称
			 
			 Product product = ProductHelper.getById(cart.getProductId());
			 
			 Sku sku = SkuHelper.getById(cart.getSkuId());
			 float oldPrice = Tools.floatValue(cart.getOldPrice());//会员价，单价
			 float price = Tools.floatValue(cart.getPrice());//成交单价
			 long amount = Tools.longValue(cart.getAmount());//数量
			 long type = Tools.longValue(cart.getType(),1);//类型
			 if(cart.getType().longValue()>=0||cart.getType().longValue()==-5)totalGoods += amount;
			 float money = Tools.floatValue(cart.getMoney());//总计
			 if(type >= 0) totalPrice += money;
			 float prefrePrice = oldPrice*amount-money;//优惠
			 if(prefrePrice < 0) prefrePrice = 0;
			 boolean hasFather = Tools.longValue(cart.getHasFather(),0)==1?true:false;//是否有父类
			 //if(hasFather) parentId = cart.getParentId();
			 //else parentId = null;
			 String rec_key = cart.getId()+"_0_"+(Tools.isNull(cart.getSkuId())?"0":cart.getSkuId());
			 String goodsId = null;
			 if(product != null){
				 goodsId = product.getId();
				 
			 }
			 
			 if(product!=null)
			 {%>
		       <tr id="cart_<%= rec_key%>"><td colspan="2">&nbsp;<a href="/wap/goods.jsp?productid=<%= product.getId() %>"><%= Tools.clearHTML(product.getGdsmst_gdsname()) %></a><%if(Tools.longValue(product.getGdsmst_specialflag()) == 1){
      					%>	
      					&nbsp;<span style="color:red;">该商品不能使用优惠券</span>
      					
	 				<%}%></td></tr>
		       <% if(product.getGdsmst_skuname1()!=null&&product.getGdsmst_skuname1().length()>0)
		       {%>
		    	   <tr id="cart1_<%= rec_key%>"><td>&nbsp;<%= product.getGdsmst_skuname1() %>：</td><td><%= sku!=null?sku.getSkumst_sku1():"无"  %></td></tr>		 
		       <%}
		       %>
		        <tr id="cart2_<%= rec_key%>"><td>&nbsp;会员价：</td><td><%= price %>元</td></tr>   
		        <tr id="cart3_<%= rec_key%>" style="border-bottom:solid 1px #333;">
		        <td>&nbsp;数量：</td>
		        
		        <td><%if(hasFather || type==0 || type==13 || type==-5 ||type==14|| type==2||(product!=null&&product.getGdsmst_buylimit()!=null&&product.getGdsmst_buylimit().intValue()>0)){
		              %><%=amount %>
		              <%}else{%>
		                <form id="u_<%= product.getId() %>" method="post" action="flow.jsp?act=u&pid=<%= product.getId() %>&carid=<%= id%>&rec_key=<%= rec_key%>">
		              <input type="hidden" id="p_<%= product.getId() %>" name="p_<%= product.getId() %>" value="<%= product.getId() %>"/>
		              <input type="text" style="width:50px;" value="<%= amount%>" attr="<% if(product.getGdsmst_buylimit()!=null&&product.getGdsmst_buylimit().longValue()>0){ out.print(product.getGdsmst_buylimit().longValue());} else
		        out.print("0");	       %>" id="c_<%= product.getId() %>" name="c_<%= product.getId() %>"/>
		        <input type="submit" value="修改"/>
		        <%}%>
		        <%if(!hasFather&&!(cart.getType().longValue()==0&&cart.getMoney().floatValue()==0)){%>
				   
				   &nbsp;&nbsp;<a href="updateflow.jsp?type=<%= type %>&rec_key=<%= rec_key%>&is_child=<%=Tools.longValue(cart.getHasChild()) %>" id="del_<%=rec_key %>"">删除</a>
                   
				   <%} %>
					</form>					  </td></tr> 
		      <%}
			 
		}
	
    %>
     <tr><td colspan="2">&nbsp;<span id="total" style="color:#f00"><font style="color:#d80100; font-size:16px; font-weight:bold;">应付总额：<%=Tools.getFormatMoney(totalPrice) %>元</span></td></tr>
      <tr><td colspan="2">&nbsp;<form method="post" action="flow.jsp?act=js"><input type="hidden" name="guid" value="<%if(lUser!=null){%> <%=lUser.getId()%><%}else{ %><%}%>"/>
      <input id="checkout" type="submit" value="去结算" style="padding:3px;"/>    </form></td></tr>
     <tr><td colspan="2">&nbsp;<a href="/mindex.jsp">继续购物>></a></td></tr>
     <%}
	else{
		out.print("<tr><td colspan=\"2\">&nbsp;购物车里还没有放入商品，<a href=\"/mindex.jsp\">去首页逛逛</a><br/></td></tr>");
	}
	%>
   
    </table>
    
    	  <%
    	  if(lUser != null){
			ArrayList<Cart> list_123 = CartHelper.getCartItemsViaUserId(lUser.getId());
			ArrayList<Cart> list = new ArrayList<Cart>();
			if(list_123!=null&&list_123.size()>0){
			for(Cart c7788:list_123){
				if(c7788.getType().longValue()!=1)continue;
				if(c7788.getCookie()!=null&&c7788.getCookie().equals(CartHelper.getCartCookieValue(request, response)))continue;
				Product product = ProductHelper.getById(c7788.getProductId());
				if(!ProductHelper.isShow(product)) continue;
					 list.add(c7788);
				}
			}
			 if(list != null && !list.isEmpty()){
					int size = list.size();
			%>
			 <table>
			 <tr><td>历史购物车</td></tr>
			<!--历史购物车-->
			<% for(int i=0,j=0;i<size&&j<5;i++){
					Cart c57 = list.get(i);
					Product product = ProductHelper.getById(c57.getProductId());
					String title = Tools.clearHTML(product.getGdsmst_gdsname());
					String id = product.getId();
								  %>
					<tr><td>
					<a href="/wap/goods.jsp?<%=product.getId()%>"><%=title %></a></td></tr>
					<%
					    if(c57.getSkuId()!=null&&c57.getSkuId().length()>0)
					    {
					    	Sku sku=SkuHelper.getById(c57.getSkuId());
					    	if(sku!=null&&sku.getSkumst_sku1().length()>0)
					    	{
					    %>
					    	<tr><td><%= product.getGdsmst_skuname1() %>：<%= sku.getSkumst_sku1() %></td></tr>
					    <%}
					    }
					%>
					<tr><td>会员价：￥<%= product.getGdsmst_memberprice().longValue()%></td></tr>
					<tr><td class="othertd">
					<a href="<%  
					if(product.getGdsmst_skuname1()==null||product.getGdsmst_skuname1().length()==0) 
						out.print("/wap/goodsend.jsp?gdsid="+ product.getId()); 
					else out.print("/wap/goodsend.jsp?gdsid="+product.getId()+"&skuId="+c57.getSkuId());%>"
					>加入购物车</a>
					</td></tr><%
									j++;
									} %>
									</table>
								 <%
			 }
			 } %>
    

    <div style=" background:#FFDEAD; padding:3px; width:100%;">
    <a href="/wap/user/index.jsp">我的优尚</a>&nbsp;&nbsp;<a href="/wap/user/favorite.jsp">我的收藏</a><br/>
     <a href="mindex.jsp">首页</a>&nbsp;&nbsp;<a href="/wap/html/help.jsp">帮助</a><br/>
	切换到<a href="http://www.d1.com.cn">电脑版</a>
	<br/>京ICP证030072号

    <br/>
    </div>
     
</div>
</body>
</html>

