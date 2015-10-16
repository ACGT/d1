<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="../islogin.jsp" %><%
String payId = request.getParameter("payId");
String m_strTktid = null;//默认的优惠券ID
boolean m_iHdtjMemoFlag = false;//是否有活动特价标志。
float m_fltGdsAllMoney = CartHelper.getNormalProductMoney(request,response);//团购商品不参与优惠券的金额
boolean m_iIfHaveTkt = false;//是否有优惠券。
float m_fltBrdTktPrice = CartHelper.getBrandCutMoney(request,response);//品牌减免总金额。

String ckePingAnLogin = request.getParameter("pingan.login");
%><%
List<Ticket> list1 = TicketHelper.getAllLoginUserAvaiableTickets(request,response,payId);
List<TicketCrd> list2 = TicketHelper.getAllLoginUserAvaiableTicketCrds(request,response,payId);
if((list1 != null && !list1.isEmpty()) || (list2 != null && !list2.isEmpty()) || Tools.floatCompare(m_fltBrdTktPrice,0)==1){
	%><table border="0"  cellpadding="2" cellspacing="2">
		<%
		if(Tools.floatCompare(m_fltBrdTktPrice,0)==1){
			%><tr>
				
				<td align="right" class="t00">
					<input type="radio" name="tktid" id="brdtkt" value="brdtkt" /><input type="hidden" id="tktpayid_brdtkt" value=''>
				</td>
				<td  class="t00">金额：<%=Tools.getFormatMoney(m_fltBrdTktPrice) %></td>
				</tr>
				<tr>
				<td colspan="2" class="t00">仅本次购物可用</td>
				
			</tr><%
		}
		if(list1 != null && !list1.isEmpty()){
			for(Ticket ticket : list1){
				PayMethod pay = null;
				
				float cartMoney_2344 = 0f ;//可以打折的商品总金额
				if(Tools.isNull(ticket.getTktmst_rackcode())||"000".equals(ticket.getTktmst_rackcode()))cartMoney_2344=CartHelper.getNormalProductMoney(request,response);
				else cartMoney_2344=CartHelper.getTotalRackcodePayMoney2(request,response,ticket.getTktmst_rackcode());
				
				if(cartMoney_2344<ticket.getTktmst_gdsvalue())continue;
				
				if(Tools.longValue(ticket.getTktmst_payid()) != -1){
					pay = PayMethodHelper.getById(String.valueOf(ticket.getTktmst_payid()));
					if(pay == null) continue;
				}
				%><tr>
					
					<td align="right" class="t00"><input type="radio" name="tktid" value="<%=ticket.getId() %>" payId="<%=ticket.getTktmst_payid() %>"  /></td>
					<td  class="t00">金额：<%=Tools.floatValue(ticket.getTktmst_value()) %></td>
				</tr>
				<tr>
					<td colspan="2" class="t00">有效期：<%=Tools.getDate(ticket.getTktmst_validates()) %>至<%=Tools.getDate(ticket.getTktmst_validatee()) %></td>
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
				if (ticket.getTktcrd_brandname()!=null&&ticket.getTktcrd_brandname().length()>0){
					if(CartHelper.getCartBrandPayMoney2(request, response, ticket.getTktcrd_brandname().trim())>0){
						m_fltGdsAllMoney=CartHelper.getCartBrandPayMoney2(request, response, ticket.getTktcrd_brandname().trim());
					}
					else{
						continue;
					}
				}
				float fltTktcrdDiscount = Tools.floatValue(ticket.getTktcrd_discount());
				long iTktCrdRealValue = Tools.longValue(ticket.getTktcrd_realvalue());
				float iTkt_value = Tools.getFloat(m_fltGdsAllMoney*fltTktcrdDiscount,2);
				
				if(ticket.getTktcrd_realvalue()!=null){
					if(iTkt_value>ticket.getTktcrd_realvalue().floatValue())iTkt_value=Tools.getFloat(ticket.getTktcrd_realvalue().floatValue(),2);
				}
				%><tr>
					
					<td align="right" class="t00"><input type="radio" name="tktid" value="crd<%=ticket.getId() %>" payId="<%=ticket.getTktcrd_payid() %>" /></td>
					<td  class="t00">金额：<%=iTkt_value %></td>
					</tr><tr>
					<td colspan="2" class="t00">有效期：<%=Tools.getDate(ticket.getTktcrd_validates()) %>至<%=Tools.getDate(ticket.getTktcrd_validatee()) %></td>
					</tr><%
			}
		}
	%>
	<tr><td colspan="2"><a href="javascript:useTicket();">使用该优惠券</a></td></tr>
	</table><%
}
%>
<table border="0"  cellpadding="2" cellspacing="2">
	<tr>
	  	
	  	<td colspan="6" valign="middle" class="t00" >
	   		<table border="0" cellpadding="0" cellspacing="2">
	   			<tr>
	   			<td>&nbsp;输入优惠券号码：</td>
	   		</tr>
	   		<tr>
	   				<td>&nbsp;<input type="text" name="req_tktpwd_cardno" id="txtCardNo"  style="border:solid 1px #759ebc; background-color:#f4f4f4"/></td>
	   	</tr>
	   			<tr>
	   			<td>&nbsp;<input type="button"  onclick="ActivateTkt(<%="1".equals(ckePingAnLogin)?1:0 %>)" id="btnActivate" class="ActivateEquan" value="激活"/>注：部分优惠券由于不满足条件不能使用！<br/><a href="/wap/user/ticket.jsp" target=_blank>查看我的所有优惠券</a></td>
	   			</tr>
	   		</table>
	   	</td>
	</tr>
</table>