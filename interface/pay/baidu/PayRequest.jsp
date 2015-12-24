<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@include file="/inc/header.jsp" %><%
	
	String strOdrID = request.getParameter("OdrID");
	OrderBase order = OrderHelper.getById(strOdrID);
	if(lUser==null){
		response.sendRedirect("/login.jsp");
	}
	if(order == null){
		out.print("查询订单出错！");
		return;
	}
	if(!lUser.getId().equals(String.valueOf(order.getOdrmst_mbrid()))){
		out.print("查询订单出错。");
		return;
	}
	if(Tools.longValue(order.getOdrmst_orderstatus()) != 0){
		out.print("您的订单不在未支付状态！");
		return;
	}
	String domainName = "www.d1.com.cn";
	String baiduPayUrl = "http://" + domainName + "/PayUnloginServlet?goods_category=1&goods_name="+strOdrID+"&goods_desc=goods"
			+ "&goods_url=http://www.d1.com.cn&unit_amount="
			+ Tools.getFormatMoney(Tools.doubleValue(order.getOdrmst_acturepaymoney())*100)
			+ "&unit_count=1&transport_amount=0&total_amount="
			+ Tools.getFormatMoney(Tools.doubleValue(order.getOdrmst_acturepaymoney())*100)
			+ "&buyer_sp_username=" + strOdrID + "&return_url=" 
			+ URLEncoder.encode("http://" + domainName + "/ReturnServlet")
			+ "&page_url="+ URLEncoder.encode("http://" + domainName + "/ReturnServlet") + "&pay_type=2&bank_no=201&sp_uno="+strOdrID+"&extra="+strOdrID;
	response.sendRedirect(baiduPayUrl);
	%><%=baiduPayUrl%>