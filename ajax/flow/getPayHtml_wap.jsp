<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="../islogin.jsp" %><%
//得到支付方式
//收获地址
String addressId = request.getParameter("addressId");
UserAddress defaultAdd = UserAddressHelper.getById(addressId);//默认显示在前台的地址。
if(defaultAdd == null){
	out.print("{\"code\":-1,\"message\":\"找不到收货人！\"}");
	return;
}
if(!lUser.getId().equals(String.valueOf(defaultAdd.getMbrcst_mbrid()))){
	out.print("{\"code\":-1,\"message\":\"收货人地址错误！\"}");
	return;
}

//boolean istuan = CartHelper.hasGroupProduct(request,response);//购物车中是否有团购商品
boolean istuan = false ;//团购商品和其他一样，不用单独处理了，kk修改
boolean istuanDH = CartHelper.hasGroupDHProduct(request,response);//购物车中是否有团购兑换的物品
boolean iswyDH = CartHelper.hasWangyiProduct(request,response);//购物车中是否有网易兑换商品

float totalMoney = CartHelper.getTotalPayMoney(request,response);//购物车总金额

boolean isShowCanHF = true;//是否显示货到付款




String ckeHzly = Tools.getCookie(request,"HZLY");
String ckeYiBao = Tools.getCookie(request,"d1.com.cn.peoplercm.subad");//d1.com.cn.peoplercm.subad

if(istuanDH && Tools.floatCompare(totalMoney,0) == 0){//totalMoney==0
	//全部为团购兑换商品,则全额E券支付
	out.print("{\"code\":0,\"message\":\"全部为团购兑换商品,则全额E券支付！\"}");
	return;
}else if(istuanDH || iswyDH){//totalMoney>0
	//团购兑换商品+其它商品，则必须为在线支付
	
}else if(!Tools.isNull((String)session.getAttribute("AlipayToken"))){
	//支付宝支付
	PayMethod pay = PayMethodHelper.getById("20");
	if(pay == null){
		out.print("{\"code\":-1,\"message\":\"找不到支付宝支付方式！\"}");
		return;
	}
	
}else{
	//绑定网上支付
	//绑定货到付款
	if(istuan){
		isShowCanHF = false;//团购不能显示货到付款
	}else{
		isShowCanHF = UserAddressHelper.supportPayAfterReceived(defaultAdd.getId());
	}
}
ArrayList<ShpMst> shoplist=CartShopCodeHelper.getCartShopCode(request,response);
for(ShpMst e:shoplist){
	if(!e.getId().equals("00000000")){
		isShowCanHF=false;
		break;
	}
}

StringBuilder sb = new StringBuilder();
sb.append("<table bgcolor=\"#dce6ee\" width=\"861\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"2\">");
//货到付款
if(isShowCanHF){
	sb.append("<tr id=\"trPayID0\"").append(isShowCanHF?"":" style=\"display:none;\"").append(">");
		sb.append("<td align=\"right\" style=\"width:100px\">");
		sb.append("<input id=\"id_paykindr1\" type=\"radio\" name=\"req_payid\" value=\"0\" onclick=\"paykindrchange();HidePayNet();\">");
		sb.append("</td>");
		sb.append("<td class=\"t01\" style=\"width:100px\"><strong>货到付款</strong></td>");
		sb.append("<td class=\"t00\">请认准<span style=\"color:#f00\">D1优尚专用包装</span>，<span style=\"color:#f00\">商品正确再支付货款</span>，如有问题请当面拒收，立即联系客服。</td>");
		sb.append("<td class=\"t00\"><a href=\"http://www.zjs.com.cn/WS_Business/WS_Bussiness_CityArea.aspx?id=6\" target=\"_blank\">快速查看货到付款地区</a></td>");
	sb.append("</tr>");
}

sb.append("</table>");
Map<String,Object> map = new HashMap<String,Object>();
map.put("code",new Integer(1));
map.put("message",sb.toString());
out.print(JSONObject.fromObject(map));
%>