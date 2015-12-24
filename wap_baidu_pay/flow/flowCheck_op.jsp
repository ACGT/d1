<%@page import="org.omg.CosNaming.NamingContextExtPackage.AddressHelper"%>
<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.setDateHeader("Expires", 0);
response.setHeader("Pragma","no-cache");


if(!Tools.isNull(request.getParameter("guid"))){//点击去结算，判断用户是否登录
	List<Cart> list = CartHelper.getCartItems(request,response);//购物车为空
	if(list == null || list.isEmpty()){
		response.sendRedirect("/wap/flow1.jsp");
		return;
	}
	if(lUser==null){
		response.sendRedirect("/wap/login.jsp?url='/wap/flow/flowCheck_op.jsp?guid=1'");
		return;
	}
	//判断是否有收获地址
	ArrayList<UserAddress> addressList = UserAddressHelper.getUserAddressList(lUser.getId());
	if(addressList==null || addressList.size()==0){
		response.sendRedirect("/wap/user/addaddress.jsp?url='/wap/flowCheck.jsp'");
	return;
	}
}


	String ticketid=request.getParameter("ticketid");
	String liuyan=request.getParameter("liuyan");
	String prepay=request.getParameter("prepay");
	String addressid=request.getParameter("addressid");
	if(!Tools.isNull(request.getParameter("cancelticket"))){//取消优惠券
		ticketid=null;
		request.setAttribute("ticketid", ticketid);
		request.setAttribute("addressid", addressid);
		request.setAttribute("prepay", prepay);
		request.setAttribute("liuyan", liuyan);
		request.getRequestDispatcher("/wap/flowCheck1.jsp").forward(request, response); 
	}
//取消使用预存款
if(!Tools.isNull(request.getParameter("cancelprepay"))){
	prepay=null;
	request.setAttribute("ticketid", ticketid);
	request.setAttribute("addressid", addressid);
	request.setAttribute("prepay", prepay);
	request.setAttribute("liuyan", liuyan);
	request.getRequestDispatcher("/wap/flowCheck1.jsp").forward(request, response); 
}

if(!Tools.isNull(request.getParameter("deladdress")) && !Tools.isNull(request.getParameter("addressid")) && !"null".equals(addressid.toLowerCase())){//删除地址
	Tools.getManager(UserAddress.class).delete(addressid);
	  String url="ticketid="+ticketid+"&prepay="+prepay+"&liuyan="+liuyan;
		response.sendRedirect("/wap/flow/addresseelist.jsp?"+url);
}
%>