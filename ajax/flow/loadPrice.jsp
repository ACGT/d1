<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="../islogin.jsp" %><%
String tktid = request.getParameter("tktid");//优惠券ID
String payid = request.getParameter("payid");//支付方式ID
String IsUsePrepay = request.getParameter("IsUsePrepay");//是否使用预付款
String addressId = request.getParameter("addId");//用户选择的地址ID


/*String cartshopcode="00000000";
if(session.getAttribute("Cart_ShopCode")!=null){
cartshopcode= session.getAttribute("Cart_ShopCode").toString();
}*/
String ticket_type = null;

if(!Tools.isNull(tktid)){
	if(tktid.startsWith("crd")){//折扣券
		tktid = tktid.substring(3);
		ticket_type = "1";
	}else if("brdtkt".equals(tktid)){//品牌减免
		ticket_type = "2";
	}
	else if("bjhdtkt".equals(tktid)){//半价活动
		ticket_type = "3";
	}else{//减免券
		ticket_type = "0";
	}
}


if(addressId==null)addressId="-1";
UserAddress address = UserAddressHelper.getById(addressId);
if(address == null){
	out.print("{\"success\":false,\"message\":\"找不到地址！\"}");
	return;
}

//float fltTotal = CartShopCodeHelper.getTotalPayMoney(request,response,cartshopcode);//商品总金额
//float fltL_ShipFee = OrderHelper.getSMExpressFee(request,response,addressId,payid,iL_TktValue,cartshopcode);//商品运费
//float normal_money = CartShopCodeHelper.getNormalProductMoney(request, response,cartshopcode);//最多能减多少钱用来计算全场活动折扣

float fltTotal = CartHelper.getTotalPayMoney(request,response);//商品总金额
float iL_TktValue = TicketHelper.getMaxTicketSaveMoney(request,response,tktid+"",ticket_type+"",addressId+"",payid+"");//优惠券减免金额
iL_TktValue=Tools.getFloat(iL_TktValue, 0);
float fltL_ShipFee = OrderHelper.getExpressFee(request,response,addressId,payid,iL_TktValue);//商品运费



float getshopactmoney=  CartHelper.getShopActCutMoney(request, response); //满减活动优惠金额

float fltPrepay = PrepayHelper.getPrepayBalance(lUser.getId());//用户预存款金额
float normal_money = CartHelper.getNormalProductMoney(request, response);//最多能减多少钱用来计算全场活动折扣
fltTotal=fltTotal+getshopactmoney;
float fltUsedPrepay = 0;//预存款金额
if("1".equals(IsUsePrepay)){
	fltUsedPrepay = PrepayHelper.getMaxPrepaySaveMoney(request,response,tktid,ticket_type,addressId,payid);
}

//计算券的最终金额，如果商品金额+运费>券值则，最终用券金额为券值，

if(fltTotal+fltL_ShipFee<iL_TktValue){
	iL_TktValue=fltTotal+fltL_ShipFee;
}

/*
float zhemoney=0;
long lzhetxt=0;
if (iL_TktValue==0){
if(normal_money>=200&& normal_money<500){
	zhemoney=Tools.getFloat( (float)((double)normal_money*0.1),1);
	lzhetxt=9;
}else if(normal_money>=500){
	zhemoney=Tools.getFloat( (float)((double)normal_money*0.2),1);
	lzhetxt=8;
}
}*/
float yingfu = fltTotal+fltL_ShipFee-iL_TktValue-getshopactmoney-fltUsedPrepay;//应付总金额

Map<String,Object> map = new HashMap<String,Object>();
map.put("success",new Boolean(true));
map.put("tblPrePay" , Tools.getFormatMoney(fltPrepay));
map.put("ShipFee",Tools.getFormatMoney(fltL_ShipFee));
map.put("TktValue",Tools.getFormatMoney(iL_TktValue));
map.put("D1ActValue",Tools.getFormatMoney(getshopactmoney));
map.put("UsePrepay",Tools.getFormatMoney(fltUsedPrepay));
map.put("lblGdsFee" , Tools.getFormatMoney(fltTotal));
map.put("Total",Tools.getFormatMoney(yingfu));


if(Tools.floatCompare(fltPrepay,0) == 1){
	StringBuilder sb = new StringBuilder();
	sb.append("<table width=\"861\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"2\">");
	sb.append("<tr><td width=\"50\"></td><td class=\"t55\">预存款支付</td></tr>");
	sb.append("<tr><td><input type=\"checkbox\" name=\"chkPrepay\" id=\"chkPrepay\"").append("1".equals(IsUsePrepay)?" checked":"").append(" onclick=\"loadprice();\" /></td>");
	sb.append("<td class=\"t00\">本次订单使用<span>").append("1".equals(IsUsePrepay)?Tools.getFormatMoney(fltUsedPrepay):(Tools.floatCompare(fltPrepay,yingfu)==1?Tools.getFormatMoney(yingfu):Tools.getFormatMoney(fltPrepay))).append("</span>元预存款</td>");
	sb.append("</tr></table>");
	
	map.put("litPrepay",sb.toString());
}else{
	map.put("litPrepay","");
}
/*map.put("ActZhe",Tools.getFormatMoney(zhemoney));
String zhetxt="";
if (lzhetxt==8){
	zhetxt="您已满足店庆满<span style=\"color:#ff0000\">500元8折</span>优惠活动的条件，<span style=\"color:#ff0000\">折扣与优惠券不能同时享用</span>";
}else if(lzhetxt==9){
	zhetxt="您已满足店庆满<span style=\"color:#ff0000\">200元9折</span>优惠活动的条件，<span style=\"color:#ff0000\">折扣与优惠券不能同时享用</span>";
}

map.put("actzhetxt",zhetxt);*/


out.print(JSONObject.fromObject(map));
return;
%>