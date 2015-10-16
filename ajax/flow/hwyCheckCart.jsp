<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
String productid=request.getParameter("productid");
if(Tools.isNull(productid)){
	out.print("0");
	return;
}
Product product=ProductHelper.getById(productid);


String strgdsidOne="01409033";
String strgdsidOne2="01409034";
if(!productid.equals(strgdsidOne) && !productid.equals(strgdsidOne2)){
	out.print("0");
	return;
}

	String productname="";
	float ftuanprice=0;
	
	    if(product!=null){
	    productname=product.getGdsmst_gdsname().trim();
	    }
   ArrayList<Cart> cartList = CartHelper.getCartItems(request, response);	

	boolean hasOne = false ;
	if(cartList!=null){
		for(Cart c123:cartList){
			if(c123.getType().longValue()==14&& (c123.getProductId().equals(strgdsidOne) || c123.getProductId().equals(strgdsidOne2))){
				hasOne = true ;
				break;
			}
		}
	}
	
	if(hasOne){
		out.print("2");
		return;
	}else{
		out.print("3");
		return;
	}
%>