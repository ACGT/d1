<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="../islogin.jsp" %><%
String tktid = request.getParameter("tktid");//优惠券ID
String payid = request.getParameter("payid");//支付方式ID
String IsUsePrepay = request.getParameter("IsUsePrepay");//是否使用预付款
String addressId = request.getParameter("addId");//用户选择的地址ID

String ticket_type = null;

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

UserAddress address = UserAddressHelper.getById(addressId);
if(address == null){
	out.print("{\"success\":false,\"message\":\"找不到地址！\"}");
	return;
}

float fltTotal = CartHelper.getTotalPayMoney(request,response);//商品总金额
float iL_TktValue = TicketHelper.getMaxTicketSaveMoney(request,response,tktid+"",ticket_type+"",addressId+"",payid+"");//优惠券减免金额
iL_TktValue=Tools.getFloat(iL_TktValue, 0);
float fltL_ShipFee = OrderHelper.getExpressFee(request,response,addressId,payid,iL_TktValue);//商品运费
float fltPrepay = PrepayHelper.getPrepayBalance(lUser.getId());//用户预存款金额
float fltUsedPrepay = 0;//预存款金额
if("1".equals(IsUsePrepay)){
	fltUsedPrepay = PrepayHelper.getMaxPrepaySaveMoney(request,response,tktid,ticket_type,addressId,payid);
}

float yingfu = fltTotal+fltL_ShipFee-iL_TktValue-fltUsedPrepay;//应付总金额

Map<String,Object> map = new HashMap<String,Object>();
map.put("success",new Boolean(true));
map.put("tblPrePay" , Tools.getFormatMoney(fltPrepay));
map.put("ShipFee",Tools.getFormatMoney(fltL_ShipFee));
map.put("TktValue",Tools.getFormatMoney(iL_TktValue));
map.put("UsePrepay",Tools.getFormatMoney(fltUsedPrepay));
map.put("lblGdsFee" , Tools.getFormatMoney(fltTotal));
map.put("Total",Tools.getFormatMoney(yingfu));

if(Tools.floatCompare(fltPrepay,0) == 1){
	StringBuilder sb = new StringBuilder();
	sb.append("<table border=\"0\"  cellpadding=\"2\" cellspacing=\"2\">");
	sb.append("<tr><td colspan=2>&nbsp;预存款支付</td></tr>");
	sb.append("<tr><td width=20px>&nbsp;<input type=\"checkbox\" name=\"chkPrepay\" id=\"chkPrepay\"").append("1".equals(IsUsePrepay)?" checked":"").append(" onclick=\"loadprice();\" /></td>");
	sb.append("<td class=\"t00\">本次订单使用<span>").append("1".equals(IsUsePrepay)?Tools.getFormatMoney(fltUsedPrepay):(Tools.floatCompare(fltPrepay,yingfu)==1?Tools.getFormatMoney(yingfu):Tools.getFormatMoney(fltPrepay))).append("</span>元预存款</td>");
	sb.append("</tr></table>");
	
	map.put("litPrepay",sb.toString());
}else{
	map.put("litPrepay","");
}

out.print(JSONObject.fromObject(map));
return;
%>