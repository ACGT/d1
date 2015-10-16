<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
String productid=request.getParameter("productid");
if(Tools.isNull(productid)){
	out.print("0");
	return;
}
Product product=ProductHelper.getById(productid);


String strgdsidOne="01720623";
String strgdsidOne2="01720622";
if(!productid.equals(strgdsidOne) && !productid.equals(strgdsidOne2)){
	out.print("0");
	return;
}
/**
java.text.DateFormat df=new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
//String	nowtime= df.format(new Date());
String tttime ="2012/05/31/ 00:00:00";
//String tttime ="2011/12/20 00:00:00";
java.util.Calendar c1=java.util.Calendar.getInstance();
	java.util.Calendar c2=java.util.Calendar.getInstance();
	try
	{
	c1.setTime(df.parse(nowtime));
	c2.setTime(df.parse(tttime));
	}catch(java.text.ParseException e){
	System.err.println("格式不正确");
	}
	int result=c1.compareTo(c2);
	if(result>0){
		out.print("1");
		return;
	}
	//检查购物车
*/
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