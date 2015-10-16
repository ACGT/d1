<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject"%><%@include file="/html/header.jsp" %>
<%!
public static boolean hasDHProduct(HttpServletRequest request,HttpServletResponse response){
	ArrayList<Cart> list = CartHelper.getCartItems(request,response);
	if(list == null || list.isEmpty()) return false;
	boolean b = false;
	for(Cart cart : list){
		if(Tools.longValue(cart.getType()) == 11
				||Tools.longValue(cart.getType()) == 13||Tools.longValue(cart.getType()) == 22){
			b = true;
			break;
		}
	}
	return b;
}
%>
<%
JSONObject json = new JSONObject();
if(lUser==null){
	json.put("status", "-1");
}else{
	boolean m_strShowCanHF = true;//是否输出显示货到付款
	ArrayList<ShpMst> shoplist=CartShopCodeHelper.getCartShopCode(request,response);
	if(shoplist!=null){
	for(ShpMst e:shoplist){
		if(!e.getId().equals("00000000")){
			m_strShowCanHF=false;
			break;
		}
	}
	}
boolean istuanDH =hasDHProduct(request,response);//购物车中是否有团购兑换的物品
 if(istuanDH){
		m_strShowCanHF = false;
	}
 float totalMoney = CartHelper.getTotalPayMoney(request,response);//购物车总金额
 if(totalMoney<100f)m_strShowCanHF = false;
		json.put("ifCanHF",m_strShowCanHF);
		json.put("status", "0");
 
}
	out.print(json);
%>