<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—我的优惠券</title>
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
			满足本单使用条件的优惠券 <br />
		</div>
		<%
    String ticketid = request.getParameter("ticketid");//优惠券ID
    String payid = "0";//支付方式ID
    String addressId = request.getParameter("addressid");//用户选择的地址ID
    String prepay=request.getParameter("prepay");//预付款
    String liuyan=request.getParameter("liuyan");//订单留言
    String payId = "0";
    String m_strTktid = null;//默认的优惠券ID
    boolean m_iHdtjMemoFlag = false;//是否有活动特价标志。
    float m_fltGdsAllMoney = CartHelper.getNormalProductMoney(request,response);//团购商品不参与优惠券的金额
    boolean m_iIfHaveTkt = false;//是否有优惠券。
    float m_fltBrdTktPrice = CartHelper.getBrandCutMoney(request,response);//品牌减免总金额。
    String url="&prepay="+prepay+"&addressid="+addressId+"&payid="+payid+"&liuyan="+liuyan;
    List<Ticket> list1 = TicketHelper.getAllLoginUserAvaiableTickets(request,response,payId);
    List<TicketCrd> list2 = TicketHelper.getAllLoginUserAvaiableTicketCrds(request,response,payId);
    if((list1 != null && !list1.isEmpty()) || (list2 != null && !list2.isEmpty()) || Tools.floatCompare(m_fltBrdTktPrice,0)==1){

%><table border="0" cellpadding="2" cellspacing="2">
			<%
		if(Tools.floatCompare(m_fltBrdTktPrice,0)==1){
			%><tr>
				<td class="t00">金额：<%=Tools.getFormatMoney(m_fltBrdTktPrice) %></td>
			</tr>
			<tr>
				<td class="t00">仅本次购物可用</td>
			</tr>
			<tr>
				<td class="t00"><a
					href="/wap/flowCheck1.jsp?ticketid=brdtkt<%=url %>>">使用该优惠券</a></td>
			</tr>
			<%
		}
		if(list1 != null && !list1.isEmpty()){
			for(Ticket ticket : list1){
				PayMethod pay = null;
				String shopcode=ticket.getTktmst_shopcodes();
				if(Tools.isNull(shopcode))shopcode="00000000";
				float cartMoney_2344 = 0f ;//可以打折的商品总金额
				if(!Tools.isNull(ticket.getTktmst_sprckcodeStr()))cartMoney_2344=CartHelper.getCartSprckcodePayMoney(request, response, ticket.getTktmst_sprckcodeStr());
				else if(Tools.isNull(ticket.getTktmst_rackcode())||"000".equals(ticket.getTktmst_rackcode()))cartMoney_2344=CartHelper.getNormalProductMoney(request,response);
				else cartMoney_2344=CartHelper.getTotalRackcodePayMoney2(request,response,ticket.getTktmst_rackcode(),shopcode);
				
				if(cartMoney_2344<ticket.getTktmst_gdsvalue())continue;
				
				if(Tools.longValue(ticket.getTktmst_payid()) != -1){
					pay = PayMethodHelper.getById(String.valueOf(ticket.getTktmst_payid()));
					if(pay == null) continue;
				}
				%><tr>

				<td class="t00">金额：<%=Tools.floatValue(ticket.getTktmst_value()) %></td>
			</tr>
			<tr>
				<td class="t00">有效期：<%=Tools.getDate(ticket.getTktmst_validates()) %>至<%=Tools.getDate(ticket.getTktmst_validatee()) %></td>
			</tr>
			<tr>
				<td class="t00"><a
					href="/wap/flowCheck1.jsp?ticketid=<%=ticket.getId()%>&ticketvalue=<%=Tools.floatValue(ticket.getTktmst_value()) %><%=url %>">使用该优惠券</a></td>
			</tr>
			<%
			}
		}
		if(list2 != null && !list2.isEmpty() && CartHelper.getNormalProductMoney(request, response)>0){
			for(TicketCrd ticket : list2){
				PayMethod pay = null;
				if(Tools.longValue(ticket.getTktcrd_payid()) != -1){
					pay = PayMethodHelper.getById(String.valueOf(ticket.getTktcrd_payid()));
					if(pay == null) continue;
				}
				float fltTktcrdDiscount = Tools.floatValue(ticket.getTktcrd_discount());
				long iTktCrdRealValue = Tools.longValue(ticket.getTktcrd_realvalue());
				float iTkt_value = Tools.getFloat(m_fltGdsAllMoney*fltTktcrdDiscount,2);
				
				if(ticket.getTktcrd_realvalue()!=null){
					if(iTkt_value>ticket.getTktcrd_realvalue().floatValue())iTkt_value=Tools.getFloat(ticket.getTktcrd_realvalue().floatValue(),2);
				}
				%><tr>


				<td class="t00">金额：<%=iTkt_value %></td>
			</tr>
			<tr>
				<td class="t00">有效期：<%=Tools.getDate(ticket.getTktcrd_validates()) %>至<%=Tools.getDate(ticket.getTktcrd_validatee()) %></td>
			</tr>
			<tr>
				<td class="t00"><a
					href="/wap/flowCheck1.jsp?ticketid=crd<%=ticket.getId()%>&ticketvalue=<%=iTkt_value %><%=url %>">使用该优惠券</a></td>
			</tr>
			<%
			}
		}
	%>

		</table>
		<%
}
%>

		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			激活新优惠券 <br />
		</div>
		<%
    String msg="";
    if ("post".equals(request.getMethod().toLowerCase())) {
    	if(!Tools.isNull(request.getParameter("ticketcode"))){
    		String pwd = "www.d1.com.cn";//密码
    		HashMap<String,Object> map2 = TicketHelper.drawTicket(request,response,request.getParameter("ticketcode"),pwd,payId);
    		if(map2.get("ticket") == null){
    			if(map2.get("failreason")!=null){
    				msg=map2.get("failreason").toString();
    			}else{
    				msg="优惠券码错误，请核对后再次输入！";
    			}
				//return;
    		}else{
    			msg="激活优惠券成功！";
    			//return;
    		}
    	}else{
    		msg="请输入优惠券号码!";
    	}
    }
    %>
		<span style="color: red;"><%=msg %></span><br />
		<form action="ticket.jsp" method="post">
			<input name="ticketid" type="hidden" value="<%=ticketid%>"></input>
			<input name="addressid" type="hidden" value="<%=addressId%>"></input>
			<input name="prepay" type="hidden" value="<%=prepay%>"></input>
			<input name="liuyan" type="hidden" value="<%=liuyan%>"></input> 优惠券码:
			<input type="text" id="ticketcode" name="ticketcode" />
			<br />
			<input type="submit" id="activetickets"
				style="width: 70px; height: 26px;" value="激活" />
		</form>

		<a href="/wap/flowCheck1.jsp?ticketid=<%=url%>">返回上一级>></a>
	</div>



	<!-- 尾部 -->
	<%@ include file="../inc/userfoot.jsp"%>
	<!-- 尾部结束 -->
</body>
</html>

