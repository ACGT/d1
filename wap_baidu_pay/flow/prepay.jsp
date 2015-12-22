<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—我的预存款</title>
<link
	href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/wap.css")%>"
	rel="stylesheet" type="text/css" media="screen" />
</head>
<body>
	<!-- 头部 -->
	<%@ include file="../inc/head.jsp"%>
	<!-- 头部结束 -->
	<div style="margin-bottom: 15px;">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			预存款 <br />
		</div>
		<%
    String tktid = request.getParameter("ticketid");//优惠券ID
    String payid = "0";//支付方式ID
    String IsUsePrepay = "1";//是否使用预付款
    String addressId = request.getParameter("addressid");//用户选择的地址ID
    String time=request.getParameter("time");//收货时间
    String liuyan=request.getParameter("liuyan");//订单留言
    String ticket_type = null;

    if(!Tools.isNull(tktid) && !"null".equals(tktid.toLowerCase())){
    	if(tktid.startsWith("crd")){//折扣券
    		tktid = tktid.substring(3);
    		ticket_type = "1";
    	}else if("brdtkt".equals(tktid)){//品牌减免
    		ticket_type = "2";
    	}else{//减免券
    		ticket_type = "0";
    	}
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
    String usemoney="1".equals(IsUsePrepay)?Tools.getFormatMoney(fltUsedPrepay):(Tools.floatCompare(fltPrepay,yingfu)==1?Tools.getFormatMoney(yingfu):Tools.getFormatMoney(fltPrepay));
    String url="prepay="+usemoney+"&addressid="+addressId+"&payid="+payid+"&ticketid="+tktid+"&time="+time+"&liuyan="+liuyan;
    String url2="addressid="+addressId+"&payid="+payid+"&ticketid="+tktid+"&time="+time+"&liuyan="+liuyan;
    %>
		<table>
			<tr>
				<td>预存款余额：<%=fltPrepay %></td>
			</tr>
			<tr>
				<td>本次订单使用<%=usemoney %>元预存款
				</td>
			</tr>
			<tr>
				<td><a href="/wap/flowCheck1.jsp?<%=url %>">确定使用</a> <a
					href="/wap/flowCheck1.jsp?<%=url2 %>">取消使用</a></td>
			</tr>
		</table>
	</div>
	<!-- 尾部 -->
	<%@ include file="../inc/userfoot.jsp"%>
	<!-- 尾部结束 -->
</body>
</html>

