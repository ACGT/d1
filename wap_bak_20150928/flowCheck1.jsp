<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%><%@include file="/wap/inc/islogin.jsp"%><%!
static UserAddress getById(String userId,String addressid){
	
	if(userId==null||!StringUtils.isDigits(userId))return null;
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("mbrcst_mbrid", new Long(userId)));
	clist.add(Restrictions.eq("id", addressid));
	
	List<BaseEntity> list = Tools.getManager(UserAddress.class).getList(clist, null, 0, 100);
	if(list==null||list.size()==0)return null ;
	
	ArrayList<UserAddress> rlist = new ArrayList<UserAddress>();
	for(BaseEntity be:list){
		rlist.add((UserAddress)be);
	}
	if(rlist.size()>0){
		return rlist.get(0);
	}
	return null;
}
%><%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.setDateHeader("Expires", 0);
response.setHeader("Pragma","no-cache");
//查看购物车中是否有物品，没有则跳转
//CartHelper.checkCartError(request,response);

CartHelper.updateAllCartItems(request, response);

List<Cart> list = CartHelper.getCartItems(request,response);
if(list == null || list.isEmpty()){
	response.sendRedirect("/wap/flow.jsp");
	return;
}


%><!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>D1优尚网-提交订单！</title>

<style type="text/css">
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,hr,pre,form,fieldset,input,textarea,p,label,blockquote,th,td,button,span{padding:0;margin:0;}
body{ background:#fff;font:14px Arial,"微软雅黑";color:#4b4b4b; padding-bottom:15px; line-height:18px; padding-left:4px; }
ol,ul{list-style:none;}
a {text-decoration:none;color:#4169E1}
a:hover {color:#aa2e44}
.clear {clear:both;font-size:1px;line-height:0;height:0px;*zoom:1;}
img{ border:none;}
.top{ margin-top:3px; }
.top ul li{float:left;border-bottom:solid 1px #000;  }
.top ul li a{ color:#000;}
.top ul li a:hover{ color:#aa2e44;}
.newli{ padding-left:8px;}
.t14{color:red;}.t17{color:red;}.t01{height:20px;}
.t23{color:white;}.d2{background:#b43f5c; height:22px; width:100%;}

</style>
</head>

<body>
<%@ include file="/wap/inc/head.jsp" %>
<%
String tktid=null;
String ticket_type=null;
String addressid=null;
String IsUsePrepay =null;//是否使用预付款
String payid="";
String url=null;
String liuyan=null;
float iL_TktValue=0f;

if(!Tools.isNull(request.getParameter("ticketid")) && !"null".equals(request.getParameter("ticketid").toLowerCase())){
	tktid=request.getParameter("ticketid");
}
if(!Tools.isNull(request.getParameter("liuyan"))  && !"null".equals(request.getParameter("liuyan").toLowerCase())){
	liuyan=request.getParameter("liuyan");
}
if(!Tools.isNull(request.getParameter("addressid"))  && !"null".equals(request.getParameter("addressid").toLowerCase())){
	 addressid=request.getParameter("addressid");
}
if(!Tools.isNull(request.getParameter("payid"))  && !"null".equals(request.getParameter("payid").toLowerCase())){
	payid=request.getParameter("payid");
}
if(!Tools.isNull(request.getParameter("prepay"))  && !"null".equals(request.getParameter("prepay").toLowerCase())){
	IsUsePrepay="1";
}
if(!Tools.isNull(request.getParameter("cancelticket"))){
	tktid=null;
}
if(!Tools.isNull(request.getParameter("cancelprepay"))){
	IsUsePrepay=null;
}

//收获地址
ArrayList<UserAddress> addressList =addressList=UserAddressHelper.getUserAddressList(lUser.getId());
UserAddress uaddress=null;

//用户没有收获地址。
if(addressList == null || addressList.size()==0){
	response.sendRedirect("/wap/user/addressprovince.jsp?op=add&url='/wap/flowCheck1.jsp'");
	return;
}else{

	if(!Tools.isNull(addressid)){//如果未指定那个地址，默认为最新
		uaddress=getById(lUser.getId(),addressid);
	}else{
		uaddress=addressList.get(addressList.size()-1);
	}
}

if(uaddress==null){
	response.sendRedirect("/wap/user/addressprovince.jsp?op=add&url='/wap/flowCheck1.jsp'");
	return;
}

if(uaddress!=null){
	addressid=uaddress.getId();
	if(uaddress.getMbrcst_provinceid().intValue()!=1){
		payid="0";
	}
}
if(!Tools.isNull(tktid)){
	if(tktid.startsWith("crd")){//折扣券
		tktid = tktid.substring(3);
		ticket_type = "1";
	}else if("brdtkt".equals(tktid)){//品牌减免
		ticket_type = "2";
	}else{//减免券
		ticket_type = "0";
	}
}
boolean isexist=false;
//判断优惠券是否可用
if("0".equals(ticket_type)){
	Ticket t=TicketHelper.getById(tktid);
	boolean bl=TicketHelper.validTicket(request, response, "0", t);
	if(bl){
		isexist=true;
	}
}else if("1".equals(ticket_type)){
	TicketCrd t=TicketHelper.getCrdById(tktid);
	boolean bl=TicketHelper.validTicketCrd(request, response, "0", t);
	if(bl){
		isexist=true;
	}
}else if("2".equals(ticket_type)){//品牌减免
	float ticket_money = TicketHelper.getBrandCutMoney(request, response);//品牌减免最多能减多少
	if(ticket_money>0){//满足品牌减免
		float max_get_money = 0f ;
		isexist=true;
	}
}
//out.print(tktid);
url="addressid="+addressid+"&ticketid="+request.getParameter("ticketid")+"&liuyan="+liuyan+"&prepay="+IsUsePrepay;    	

String msg="";
String donemsg="";
String ship="";
String paymsg="";
if ("post".equals(request.getMethod().toLowerCase())) {
	if(Tools.isNull(request.getParameter("req_payid"))){
		paymsg="请选择支付方式！";

	}else{
		payid=request.getParameter("req_payid");
	}
	if(Tools.isNull(request.getParameter("shipTime"))){
		msg="请选择送货时间！";

		//response.sendRedirect("flowCheck1.jsp?"+url);
	}
	 if(!Tools.isNull(liuyan)){
		 if(!"null".equals(liuyan.toLowerCase())){
		 liuyan=URLDecoder.decode(liuyan,"utf-8");
		 }else{
			 liuyan=""; 
		 }
	 }else{
		 liuyan=""; 
	 }
if(!Tools.isNull(request.getParameter("req_payid")) && !Tools.isNull(request.getParameter("shipTime"))){
		 ship=request.getParameter("shipTime");
		boolean bl=true;
		 for(Cart cart_1:list){
				if(cart_1.getType().longValue()>=0){
					Product p_1 = (Product)Tools.getManager(Product.class).get(cart_1.getProductId());
					if(p_1!=null){
						//量少提醒和卖完就下的商品检查一下虚拟库存够不够
						if(p_1.getGdsmst_stocklinkty()!=null&&(p_1.getGdsmst_stocklinkty().longValue()==1||p_1.getGdsmst_stocklinkty().longValue()==2)){
							int countInCart_1239 = CartHelper.getCartProductCount(request, response, p_1, cart_1.getSkuId());//购物车里已经订购的数量
							if(countInCart_1239+CartItemHelper.getProductOccupyStock(p_1.getId(), cart_1.getSkuId())>ProductHelper.getVirtualStock(p_1.getId(), cart_1.getSkuId())){
								donemsg="您好！商品【"+StringUtils.clearHTML(p_1.getGdsmst_gdsname())+"】库存不足，请在购物车删除该商品后重新下单！";
								bl=false;
							}
						}
					}
				}
			}
		 if(bl){
			 boolean isUsePrepay2 = false;//是否使用预存款
			 if("1".equals(IsUsePrepay)){
			 	isUsePrepay2 = true;
			 }

			 OrderCache order = OrderHelper.createOrderFromCart(request,response,addressid,payid,ship,tktid,ticket_type,isUsePrepay2,liuyan);

			 if(order != null && order.getId() != null){
				OrderHelper.updateOdrmstCacheTemp(order.getId(),"手机下单");
			 	session.setAttribute("OrderCacheId" , order.getId());
			 	donemsg="下单成功！";
			 	response.sendRedirect("flowDone.jsp");
			 }else{
				 donemsg="下单失败，可能是兑换码已经使用过，请删除兑换码兑换的商品重试！如果没有使用兑换码，请稍后重试";
			 
			 } 
		 }

	}
}
%>
<span style="color:red;"><%=donemsg %></span>
<form action="flowCheck1.jsp" method="post">
<!-- Start:收货人信息头 -->
		    <table  border="0"  cellpadding="0" cellspacing="0"  width="100%">
			   <tr>
        			<td  class="d2"><span class="t23">&nbsp;收货人信息</span></td>
        			<td><span id="spanMbrcstMsg" style="display:none" class="t16"></span></td>
      			</tr>
      			<tr>
          			<td height="1px" style="background-color:#b43f5c" colspan="2"></td>
        		</tr>
      			<tr>
        			<td colspan="2" style="height:8px"></td>
      			</tr>
    		</table>
    		<!--End:收货人信息头--><%
    		//收获地址
    		
			if(uaddress!=null){
			%>
			 <table  border="0"  cellpadding="0" cellspacing="0"  width="100%">
			 <tr><td>收货人：<%=uaddress.getMbrcst_name() %></td></tr>
			  <tr><td>收货地址：<%=uaddress.getMbrcst_raddress() %>   邮编：<%=uaddress.getMbrcst_rzipcode() %> </td></tr>
			   <tr><td>联系方式：<%=uaddress.getMbrcst_rphone() %>   邮箱地址：<%=uaddress.getMbrcst_remail() %></td></tr>
			 <tr><td height="5px"></td></tr>
			  <tr><td><a href="/wap/flow/addresseelist.jsp?<%=url%>">修改>></a></td></tr>
			 </table>
    		<%} %>
				    
				    
				    <%
				    boolean isShowCanHF=true;
				    isShowCanHF = UserAddressHelper.supportPayAfterReceived(addressid);
			 
			ArrayList<ShpMst> shoplist=CartShopCodeHelper.getCartShopCode(request,response);
			for(ShpMst e:shoplist){
				if(!e.getId().equals("00000000")){
					isShowCanHF=false;
					break;
				}
			}
				    %>
			<!-- Start:支付方式 -->
		<table  border="0"  cellpadding="0" cellspacing="0" id="tblPayHead" width="100%">
            	
        		<tr>
          			<td  class="d2"><span class="t23">&nbsp;支付方式 (北京地区支持POS机刷卡)</span>
          			</td>
          			
        		</tr>
        		<tr>
          			<td height="1px" style="background-color:#b43f5c"></td>
        		</tr>
        		<tr>
          			<td ><span style="color:red;"><%=paymsg %></span></td>
        		</tr>
        		<%if(isShowCanHF){ %>
        		<tr>
          			<td><input type="radio" name="req_payid" value="0" <%if(payid.equals("0")){ %> checked="checked"<%} %>>现金支付（货到付款）</input></td>
        		</tr>
        		<%
        		//if(uaddress!=null && uaddress.getMbrcst_provinceid().intValue()==1){
        			%>	
        			<!--  <tr>
          			<td><input type="radio" name="req_payid" value="44" <%if(payid.equals("44")){ %> checked="checked"<%} %>>POS机刷卡（货到付款）</input></td>
        		</tr>-->
        		<%//}
        		}
        		%>
        		<tr>
          			<td><input type="radio" name="req_payid" value="20" <%if(payid.equals("20")){ %> checked="checked"<%} %>>支付宝支付(在线支付)</input></td>
        		</tr>
        		<!-- 
        		<tr>
          			<td><input type="radio" name="req_payid" value="33" <%if(payid.equals("33")){ %> checked="checked"<%} %>>中国移动手机支付(在线支付)</input></td>
        		</tr> -->
      		</table>
			<!-- End:支付方式 -->
			<table  border="0"  cellpadding="0" cellspacing="0" width="100%">
            	<%
            	// url="addressid="+addressid+"&payid="+payid+"&ticketid="+tktid+"&liuyan="+liuyan+"&prepay="+IsUsePrepay;    
            	if(!Tools.isNull(tktid)){
            		
            		if(isexist){
            			 iL_TktValue = TicketHelper.getMaxTicketSaveMoney(request,response,tktid+"",ticket_type+"",addressid+"",payid);//优惠券减免金额
            		%>	
            		<tr>
          			<td >&nbsp;已使用<%=iL_TktValue %>元优惠券
          			</td>
        		</tr>
        		<tr>
          			<td >&nbsp;<a href="/wap/flowCheck1.jsp?<%=url%>&cancelticket=1">取消使用该优惠券</a> 
          			</td>
          			
        		</tr>	
            		<%}else{%>	
            			<tr>
              			<td >&nbsp;该优惠券不可用。&nbsp;<a href="/wap/flow/ticket.jsp?<%=url%>">使用优惠券</a>
              			</td>	
              			</tr>
            		<%}
            		
            		
            	}else{%>	
            		<tr>
          			<td >&nbsp;<a href="/wap/flow/ticket.jsp?<%=url%>">使用优惠券</a> 
          			</td>
          			
        		</tr>
            	<%}
            	String payno=payid;
         		if(!Tools.isNull(payno)){
         			payno="0";
         		}
            	 float fltTotal = CartHelper.getTotalPayMoney(request,response);//商品总金额
            	 float ticket_save_money = TicketHelper.getMaxTicketSaveMoney(request, response, tktid, ticket_type, addressid, payno);
         		
            	 ticket_save_money=Tools.getFloat(ticket_save_money, 0);
            	    float fltL_ShipFee = OrderHelper.getExpressFee(request,response,addressid,payno,ticket_save_money);//商品运费
            	    float fltPrepay = PrepayHelper.getPrepayBalance(lUser.getId());//用户预存款金额
            	    float fltUsedPrepay = 0;//预存款金额
            	    String usemoney="--";
            	    float yingfu = fltTotal+fltL_ShipFee-iL_TktValue-fltUsedPrepay;//应付总金额
            	    
            	    if(!Tools.isNull(IsUsePrepay) && "1".equals(IsUsePrepay)){
            	    	fltUsedPrepay = PrepayHelper.getMaxPrepaySaveMoney(request,response,tktid,ticket_type,addressid,payno);
            	    	 usemoney=Tools.floatCompare(fltPrepay,yingfu)==1?Tools.getFormatMoney(yingfu):Tools.getFormatMoney(fltPrepay);	
            	    }
            	    yingfu = fltTotal+fltL_ShipFee-iL_TktValue-fltUsedPrepay;//应付总金额
            	    if(Tools.floatCompare(fltPrepay,0) == 1 ){
            	if(Tools.isNull(IsUsePrepay)){
            		
            		%>	
            		<tr>
          			<td>&nbsp;<a href="/wap/flow/prepay.jsp?<%=url %>">使用预存款支付</a> </td>
        		</tr>	
            	<%}else{%>
            		<tr>
          			<td>&nbsp;已使用<%=usemoney%>元预存款 </td>
        		</tr>
        		<tr>
          			<td>&nbsp;<a href="/wap/flowCheck1.jsp?<%=url%>&cancelprepay=1">取消使用预存款</a> </td>
        		</tr>		
            	<%}
            	}
            	%>
            
      		</table>	    

            <!-- Start:送货时间头 -->
           
      		<table  border="0"  cellpadding="0" cellspacing="0" id="tblShipTimeHead" width="100%">
            	
        		<tr>
          			<td  class="d2"><span class="t23">&nbsp;送货时间 </span></td>
          			
        		</tr>
        		<tr>
          			<td height="1px" style="background-color:#b43f5c" ></td>
        		</tr>
        		<tr>
          			<td  style="height:6px"><span style="color:red;"><%=msg %></span></td>
        		</tr>
      		</table>
			<!-- End:送货时间头 --> 
		    <!-- Start:送货时间头 -->
        		<table  border="0"  cellpadding="2" cellspacing="2" id="tblShipTime">
        		<tr>
          			<td >
          				<input type="radio" value="送货时间不限（周一至周日均可送货）" name="shipTime" <%if(ship.contains("送货时间不限")) {%>checked="checked"<%} %>/>
          			</td>
          			<td class="t00">送货时间不限（周一至周日均可送货）</td>
        		</tr>
        		<tr>
          			<td>
          				<input type="radio" value="周六日及节假日送货（工作日不送货）" name="shipTime" <%if(ship.contains("节假日送货")) {%>checked="checked"<%} %>/>
          			</td>
          			<td class="t00">周六日及节假日送货（工作日不送货）</td>
        		</tr>
        		<tr>
          			<td >
          				<input type="radio" value="周一至周五工作日送货" name="shipTime" <%if(ship.contains("工作日送货")) {%>checked="checked"<%} %>/>
          			</td>
          			<td class="t00">周一至周五工作日送货（写字楼/商用地址客户请选择此项）所有商品将通过快递方式发出。</td>
        		</tr>
        		
    		</table>
    		<!-- End:送货时间头 -->
		    <!--Start:商品清单头-->
    		<table border="0"  cellpadding="0" cellspacing="0" id="tblGdsListHead" width="100%">
            	
        		<tr>
          			<td  class="d2"><span class="t23">&nbsp;商品清单</span></td>
        		</tr>
        		<tr>
          			<td height="1px" style="background-color:#b43f5c" ></td>
        		</tr>
        		<tr>
          			<td style="height:6px"></td>
        		</tr>
      		</table>
      		<!-- End:商品清单头 -->
		    <!-- Start:返回购物车 -->
      		<table  border="0"  cellpadding="0" cellspacing="0" class="tb33" id="tblBackCart" style="margin-bottom:1px;margin-top:2px;">
        		<tr>
          			<td align="right"><span class="t00"> <a href="/wap/flow.jsp">&nbsp;返回购物车修改</a></span></td>
        		</tr>
      		</table>
      		<!-- End:返回购物车 -->
		    <!--Start:商品清单-->
            <table bgcolor="#f3f3f3"  border="0"  cellpadding="10" cellspacing="0" id="tblGdsList" style="margin-top:1px">
	           <%
	           float jifen=0f;
  			    if(list != null && !list.isEmpty()){
  			    	
  			    	int size = list.size();
  			    	for(Cart cart : list){
  			    		Product product = ProductHelper.getById(cart.getProductId());
  			    		if(product == null && cart.getType().longValue()!=-5 ) continue;
  			    		long type = Tools.longValue(cart.getType());
  			    		String goodsName = cart.getTitle();
  			    		Sku sku = SkuHelper.getById(cart.getSkuId());
  			    		long count = Tools.longValue(cart.getAmount());
  			    		float money = Tools.floatValue(cart.getMoney());
  			    		jifen+=money;
  			    %>
	            <tr class="GdsListItemRow">
    				
      				<td class="t00">&nbsp;<%=goodsName %><%if(Tools.longValue(product.getGdsmst_specialflag()) == 1){
      					%>	
      					&nbsp;<span style="color:red;">该商品不能使用优惠券</span>
      					
	 				<%}
      				if(type==6){//团购商品
      					%><img src="http://images.d1.com.cn/images2010/tuanbiao.gif" /><%
      				} %></td>
      				</tr>
      				<tr><td>&nbsp;尺码（规格）:<%
      				if(sku != null){
      					out.print("("+sku.getSkumst_sku1()+")");
      				}
      				%></td></tr>
      				<tr>
      				<td class="t00">&nbsp;小计：<%=Tools.getFormatMoney(money) %></td>
      				</tr>
      				<tr>
      				<td >&nbsp;数量：<%=count %></td>
      				</tr><%
    			}}
  			    if(UserHelper.isPtVip(lUser)){
  			    %>
	            <tr>
		            <td colspan="6" class="t00" style="padding:4px;background-color:#fff;">
			            <table border="0" cellpadding="0" cellspacing="0">
				            <tr id="trBj95">
			    	            <td height="25" align="left">白金VIP会员95折!(特价赠品除外)</td>
			                    <td></td>
			                </tr>
			            </table>
                    </td>
		        </tr><%
		        } %>
        	</table>
		    <!--End:商品清单-->
      			
      			
      			    
      		<!--Start:结算信息头-->
      		<table border="0"  cellpadding="0" cellspacing="0" id="tblAccountHead" width="100%">
            	
        		<tr>
          			<td  class="d2"><span class="t23">&nbsp;结算信息</span></td>
        		</tr>
        		<tr>
          			<td height="1px" style="background-color:#b43f5c" ></td>
        		</tr>
        		<tr>
          			<td style="height:6px"></td>
        		</tr>
      		</table>
      		<!--End:结算信息头-->
		   
   			<!--Start:结算信息-->
        	<table  border="0"  cellpadding="2" cellspacing="2" id="tblAccount">
        		<tr>
          			<td align="right">&nbsp;</td>
          			<td colspan="5" class="t00">
						<table width="200" border="0" cellpadding="0" cellspacing="0" class="tb13-b">
            				<tr>
              					<td height="80" align="center" class="t00">
									<table width="200" border="0" cellpadding="0" cellspacing="5">
                						<tr>
                  							<td align="right">商品金额：</td>
                  							<td align="left" class="t13-b"><span id="lblGdsFee"><%=fltTotal %></span>元</td>
                						</tr>
                						<tr>
                  							<td align="right">+ 运费：</td>
                  							<td align="left" class="t13-b"><span id="spanShipFee"><%=fltL_ShipFee %></span>元</td>
                						</tr>
                						<tr>
                  							<td align="right">- 优惠券：</td>
                  							<td align="left" class="t13-b"><span id="spanTktValue"><%=iL_TktValue %></span>元</td>
                						</tr>
                						<tr>
                  							<td align="right">-预存款：</td>
                  							<td align="left" class="t13-b"><span id="spanUsePrepay"><%=usemoney %></span>元</td>
                						</tr>
                						<tr>
                  							<td align="right"><span class="t55" style="color:#da0000">应付总额：</span></td>
                  							<td align="left"><span class="t66"><span id="lblTotal"><%=Tools.getFloat(yingfu,2) %></span>元</span></td>
                						</tr>
                						<tr>
                  							<td colspan="2"><span class="t55" style="color:#da0000">您将获得<span style="color:red;"><%=jifen %></span>积分</span></td>
                  							
                						</tr>
              						</table>
								</td>
            				</tr>
          				</table>
					</td>
        		</tr>
      		</table>
      		<!--End:结算信息-->
		    <!--Start:订单留言-->
      		<table  border="0" cellpadding="0" cellspacing="0" id="tblGestHead" width="100%">
            	
        		<tr>
          			<td valign="middle" class="d2"><span class="t23">&nbsp;订单留言</span></td>
        		</tr>
        		<tr>
          			<td height="1px" style="background-color:#b43f5c" ></td>
        		</tr>
        		
      		</table>
      		<table border="0"  cellpadding="10" cellspacing="0" id="tblGest">
        		<tr>
          			<td><a href="/wap/flow/liuyan.jsp?<%=url%>">填写订单留言>></a></td>
        		</tr>
        		<%
        		 if(!Tools.isNull(liuyan)){
        			 %>
        			 <tr>
          			<td><textarea name="liuyan"><%=liuyan %></textarea></td>
        		</tr>
        		<% }
        		%>
        		<tr>
          			<td style="height:6px"></td>
        		</tr>
    		</table>
      		<!--End:订单留言-->
		    <!--Start:提交订单-->
    		<table border="0"  cellpadding="5" cellspacing="0" id="tblOrder">
        		<tr>
          			<td  align="center">							    
						<div id="divBtnOrder" style="display:block;text-align:center;">
							&nbsp;<input type="submit" id="Submit33" name="Submit33" class="SubmitOrder"  value="提交订单"/>
						</div>
						
					</td>
        		</tr>
        		<tr>
        		<td height="10px">&nbsp;</td>
        		</tr>
        		<tr>
        		<td >&nbsp;<a href="/wap/flow.jsp">返回我的购物车&gt;&gt;</a></td>
        		</tr>
        		<tr>
        		<td height="10px">&nbsp;</td>
        		</tr>
    		</table>
      	 <input name="ticketid" type="hidden" value="<%=request.getParameter("ticketid")%>"></input>
     <input name="addressid" type="hidden" value="<%=addressid%>"></input>
      <input name="prepay" type="hidden" value="<%=IsUsePrepay%>"></input>
      <%if(Tools.isNull(liuyan)){
    	  %>
       <input name="liuyan" type="hidden" value="<%=liuyan%>"></input>
      <%} %>
    	</form>
    	<!--End:提交订单-->
	
<%@ include file="/wap/inc/userfoot.jsp" %>
</body>

</html>